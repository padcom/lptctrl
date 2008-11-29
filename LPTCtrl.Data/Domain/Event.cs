using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LPTCtrl.Data.Domain {
	[Serializable]
	public class Event {
		public virtual int ID { get; set; }
		public virtual DateTime Timestamp { get; set; }
		public virtual int RepeatInterval { get; set; }
		public virtual bool State { get; set; }
		public virtual Pin Pin { get; set; }
	}
}
