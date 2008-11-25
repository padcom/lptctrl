using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LPTCtrl.Data.Domain {
	class RepeatedEvent :Event {
		public virtual int RepeatInterval { get; set; }
	}
}
