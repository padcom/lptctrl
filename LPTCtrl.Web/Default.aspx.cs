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
			PIN0.Text = port.Pins[0].Name;
			PIN1.Text = port.Pins[1].Name;
			PIN2.Text = port.Pins[2].Name;
			PIN3.Text = port.Pins[3].Name;
			PIN4.Text = port.Pins[4].Name;
			PIN5.Text = port.Pins[5].Name;
			PIN6.Text = port.Pins[6].Name;
			PIN7.Text = port.Pins[7].Name;
			PIN0Status.Text = GetPinState(port.Pins[0].Bit) ? "ON" : "OFF";
			PIN1Status.Text = GetPinState(port.Pins[1].Bit) ? "ON" : "OFF";
			PIN2Status.Text = GetPinState(port.Pins[2].Bit) ? "ON" : "OFF";
			PIN3Status.Text = GetPinState(port.Pins[3].Bit) ? "ON" : "OFF";
			PIN4Status.Text = GetPinState(port.Pins[4].Bit) ? "ON" : "OFF";
			PIN5Status.Text = GetPinState(port.Pins[5].Bit) ? "ON" : "OFF";
			PIN6Status.Text = GetPinState(port.Pins[6].Bit) ? "ON" : "OFF";
			PIN7Status.Text = GetPinState(port.Pins[7].Bit) ? "ON" : "OFF";
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
