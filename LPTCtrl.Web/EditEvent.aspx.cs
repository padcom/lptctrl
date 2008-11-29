using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using NHibernate.Burrow.WebUtil.Attributes;

using LPTCtrl.Web.DAO;
using LPTCtrl.Data.Domain;

namespace LPTCtrl.Web {
	public partial class EditEvent : System.Web.UI.Page {
		[StatefulField]
		protected Event data;

		EventDAO eventDAO = new EventDAO();
		PinDAO pinDAO = new PinDAO();

		private void FillEventOutputDropDownList() {
			EventOutput.DataSource = pinDAO.FindAll();
			EventOutput.DataTextField = "Name";
			EventOutput.DataValueField = "ID";
			EventOutput.DataBind();
		}

		private void InitializeData() {
			if (Request.Params["id"] != null) {
				int id = int.Parse(Request.Params["id"]);
				data = eventDAO.Get(id);
			} else {
				data = eventDAO.NewEvent();
			}
			DataToScreen();
		}

		private void DataToScreen() {
			EventOutput.SelectedValue = data.Pin.ID.ToString();
			EventTimestamp.Text = data.Timestamp.ToString();
			EventState.SelectedValue = data.State.ToString().ToLower();
			EventRepeatInterval.SelectedValue = data.RepeatInterval.ToString();
		}

		private void DataFromScreen() {
			data.Timestamp = DateTime.Parse(EventTimestamp.Text);
			data.Pin = pinDAO.Get(int.Parse(EventOutput.SelectedValue));
			data.State = Boolean.Parse(EventState.SelectedValue);
			data.RepeatInterval = int.Parse(EventRepeatInterval.SelectedValue);
		}

		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				FillEventOutputDropDownList();
				InitializeData();
			}
		}

		protected void EventSave_Click(object sender, EventArgs e) {
			DataFromScreen();
			eventDAO.SaveOrUpdate(data);
			Response.Redirect("~/EditEvents.aspx");
		}

		protected void EventCancel_Click(object sender, EventArgs e) {
			Response.Redirect("~/EditEvents.aspx");
		}
	}
}
