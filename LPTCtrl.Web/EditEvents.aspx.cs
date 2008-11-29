using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using NHibernate.Burrow.WebUtil.Attributes;

using LPTCtrl.Data.Domain;
using LPTCtrl.Web.DAO;


namespace LPTCtrl.Web {
	public partial class EditEvents : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
			}
		}

		protected void EventsList_SelectedIndexChanged(object sender, EventArgs e) {
			Response.Redirect("~/EditEvent.aspx?id=" + (int)EventsList.SelectedValue);
		}
	}
}
