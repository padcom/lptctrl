using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LPTCtrl.Data.Domain {
	class Pin {
		public virtual int ID { get; set; }
		public virtual int Bit { get; set; }
		public virtual string Name { get; set; }
		public virtual Port Port { get; set; }
		public virtual List<Event> Events { get; set; }
	}
}
