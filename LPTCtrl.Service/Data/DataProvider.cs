using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using FirebirdSql.Data.FirebirdClient;
using LPTCtrl.Service.Properties;

using LPTCtrl.Data;
using LPTCtrl.Data.Domain;

namespace LPTCtrl.Service.Data {
    class DataProvider {
        public static IList<Event> GetEvents(DateTime from, DateTime to) {
			return Utilities.DefaultSession.CreateQuery(
				"from Event as event where event.Timestamp between :from and :to or event.RepeatInterval > 0")
				.SetTimestamp("from", from)
				.SetTimestamp("to", to)
				.List<Event>();
        }

		public static void SaveEvent(Event e) {
			Utilities.DefaultSession.Save(e);
			Utilities.DefaultSession.Flush();
		}
	}
}
