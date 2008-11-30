using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using LPTCtrl.Data.Domain;
using LPTCtrl.Web.DAO;

namespace LPTCtrl.Web {
	public partial class _Default : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			UpdateStatuses();
		}

		private void UpdateStatuses() {
			Port port = new PortDAO().Get(1);
			Pin0.PinName = port.Pins[0].Name;
			Pin1.PinName = port.Pins[1].Name;
			Pin2.PinName = port.Pins[2].Name;
			Pin3.PinName = port.Pins[3].Name;
			Pin4.PinName = port.Pins[4].Name;
			Pin5.PinName = port.Pins[5].Name;
			Pin6.PinName = port.Pins[6].Name;
			Pin7.PinName = port.Pins[7].Name;
			Pin0.State = GetPinState(port.Pins[0].Bit) ? "ON" : "OFF";
			Pin1.State = GetPinState(port.Pins[1].Bit) ? "ON" : "OFF";
			Pin2.State = GetPinState(port.Pins[2].Bit) ? "ON" : "OFF";
			Pin3.State = GetPinState(port.Pins[3].Bit) ? "ON" : "OFF";
			Pin4.State = GetPinState(port.Pins[4].Bit) ? "ON" : "OFF";
			Pin5.State = GetPinState(port.Pins[5].Bit) ? "ON" : "OFF";
			Pin6.State = GetPinState(port.Pins[6].Bit) ? "ON" : "OFF";
			Pin7.State = GetPinState(port.Pins[7].Bit) ? "ON" : "OFF";
		}

		private bool GetPinState(int bit) {
			return new WebService.LPTPortService().GetBit(bit);
		}

		protected void UpdateTimer_Tick(object sender, EventArgs e) {
			UpdateStatuses();
		}

		protected void TogglePin0(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(0);
			UpdateStatuses();
		}

		protected void TogglePin1(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(1);
			UpdateStatuses();
		}

		protected void TogglePin2(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(2);
			UpdateStatuses();
		}

		protected void TogglePin3(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(3);
			UpdateStatuses();
		}

		protected void TogglePin4(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(4);
			UpdateStatuses();
		}

		protected void TogglePin5(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(5);
			UpdateStatuses();
		}

		protected void TogglePin6(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(6);
			UpdateStatuses();
		}

		protected void TogglePin7(object sender, EventArgs e) {
			new WebService.LPTPortService().ToggleBit(7);
			UpdateStatuses();
		}
	}
}
