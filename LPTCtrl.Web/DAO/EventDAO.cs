using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using NHibernate;
using NHibernate.Criterion;
using NHibernate.Burrow.AppBlock.DAOBases;

using LPTCtrl.Data.Domain;

namespace LPTCtrl.Web.DAO {
	public class EventDAO : GenericDAO<Event> {
		protected override Order DefaultOrder {
			get { return Order.Desc("Timestamp"); }
		}

		public Event NewEvent() {
			Event data = new Event();
			data.Pin = new PinDAO().Get(1);
			data.State = true;
			data.RepeatInterval = 0;
			data.Timestamp = DateTime.Now.AddSeconds(20);
			return data;
		}

		public override void Delete(Event t) {
			t = Get(t.ID);
			base.Delete(t);
		}
	}
}
