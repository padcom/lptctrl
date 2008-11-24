using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LPTCtrl.Data.Domain {
	class Port {
		public virtual int ID { get; set; }
		public virtual int Address { get; set; }
		public virtual string Name { get; set; }
		public virtual List<Pin> Pins { get; set; }
	}
}
