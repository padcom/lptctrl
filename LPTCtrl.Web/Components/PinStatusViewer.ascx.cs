using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LPTCtrl.Web.Components {
	public partial class PinStatusViewer : System.Web.UI.UserControl {
		protected void Page_Load(object sender, EventArgs e) {

		}

		public string PinName {
			get { return PinNameLabel.Text; }
			set { PinNameLabel.Text = value; }
		}

		public string State {
			get { return StateLabel.Text; }
			set { StateLabel.Text = value; }
		}

		public event EventHandler TogglePin;

		protected void TogglePin_Click(object sender, EventArgs e) {
			if (TogglePin != null) {
				TogglePin(this, new EventArgs());
			}
		}

	}
}
