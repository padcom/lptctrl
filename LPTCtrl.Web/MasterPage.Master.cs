using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LPTCtrl.Web {
	public partial class MasterPage : System.Web.UI.MasterPage {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void LogoutButton_Click(object sender, EventArgs e) {
			FormsAuthentication.SignOut();
			FormsAuthentication.RedirectToLoginPage();
		}

		public String StatusMsg {
			get { return StatusMsgLabel.Text; }
			set { StatusMsgLabel.Text = value; }
		}
	}
}
