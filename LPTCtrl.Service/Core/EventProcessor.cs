using System;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using LPTCtrl.Data.Domain;
using LPTCtrl.Service.Data;

namespace LPTCtrl.Service.Core {
	public class EventProcessor {
		public void ProcessEvents(int interval) {
			IList<Event> events = DataProvider.GetEvents(
				DateTime.Now.AddSeconds(-interval / 1000),
				DateTime.Now.AddSeconds(interval / 1000)
			);
			foreach (Event e in events) {
				LPTPort.LPT1.SetBit(e.Pin.Bit, e.State);
				Thread.Sleep(50);
			}
		}
	}
}
