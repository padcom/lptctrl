using System;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using LPTCtrl.Data.Domain;
using LPTCtrl.Service.Data;

namespace LPTCtrl.Service.Core {
	public class EventProcessor {
		/// <summary>
		/// Process events
		/// </summary>
		/// <param name="interval">Probing interval (in milliseconds)</param>
		public void ProcessEvents(int interval) {
			IList<Event> events = RetrieveEvents(interval);
			foreach (Event e in events) {
				if (e.RepeatInterval == 0) {
					ProcessSingleEvent(e);
				} else {
					ProcessRepeatedEvent(interval, e);
				}
				Thread.Sleep(1);
			}
		}

		/// <summary>
		/// Retrieve all events suited for current processing
		/// </summary>
		/// <param name="interval">Probing interval (in milliseconds)</param>
		/// <returns></returns>
		private IList<Event> RetrieveEvents(int interval) {
			IList<Event> events = DataProvider.GetEvents(
				DateTime.Now.AddMilliseconds(-interval / 2),
				DateTime.Now.AddMilliseconds(interval / 2)
			);
			return events;
		}

		/// <summary>
		/// Process single event
		/// </summary>
		/// <param name="e">Event to process</param>
		private static void ProcessSingleEvent(Event e) {
			LPTPort.LPT1.SetBit(e.Pin.Bit, e.State);
		}

		/// <summary>
		/// Process a repeatable event.
		/// </summary>
		/// <param name="interval">Probing interval (in milliseconds)</param>
		/// <param name="e">Event to process</param>
		private static void ProcessRepeatedEvent(int interval, Event e) {
			DateTime ts = e.Timestamp;
			DateTime now1 = DateTime.Now.AddMilliseconds(-interval / 2);
			DateTime now2 = DateTime.Now.AddMilliseconds(interval / 2);
			while (ts < now2) {
				if (ts > now1 & ts < now2) {
					LPTPort.LPT1.SetBit(e.Pin.Bit, e.State);
					e.Timestamp = ts;
					DataProvider.SaveEvent(e);
					break;
				} else {
					ts = ts.AddDays(e.RepeatInterval);
				}
			}
		}
	}
}
