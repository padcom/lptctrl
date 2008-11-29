using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LPTCtrl.Web {
	public partial class Login : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void LoginButton_Click(object sender, EventArgs e) {
			if (FormsAuthentication.Authenticate(Username.Text, Password.Text)) {
				FormsAuthentication.RedirectFromLoginPage(Username.Text, false);
			} else {
				MessageLabel.Text = "Login failed. Please check your user name and password and try again.";
			}
		}
	}
}
