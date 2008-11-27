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

		[EntityField] Event editedEvent;

		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void DeleteEventButton_Click(object sender, DataListCommandEventArgs e) {
			EventDAO dao = new EventDAO();
			Event ev = dao.Get((int)e.Item.DataItem);
			dao.Delete(ev);
			DataBind();
		}

		protected void EditEventButton_Click(object sender, CommandEventArgs e) {
			EventDAO dao = new EventDAO();
			int id = int.Parse((String)e.CommandArgument);
			this.editedEvent = dao.Get(id);
			EventsList.SelectedItemTemplate = EventsList.EditItemTemplate;
		}
	}
}
