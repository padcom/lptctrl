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
	public partial class EditPins : System.Web.UI.Page {
		[StatefulField]
		protected Port port;

		PortDAO portDAO = new PortDAO();

		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				port = portDAO.Get(1);
				PIN0.Text = port.Pins[0].Name;
				PIN1.Text = port.Pins[1].Name;
				PIN2.Text = port.Pins[2].Name;
				PIN3.Text = port.Pins[3].Name;
				PIN4.Text = port.Pins[4].Name;
				PIN5.Text = port.Pins[5].Name;
				PIN6.Text = port.Pins[6].Name;
				PIN7.Text = port.Pins[7].Name;
			}
		}

		protected void SaveButton_Click(object sender, EventArgs e) {
			port.Pins[0].Name = PIN0.Text;
			port.Pins[1].Name = PIN1.Text;
			port.Pins[2].Name = PIN2.Text;
			port.Pins[3].Name = PIN3.Text;
			port.Pins[4].Name = PIN4.Text;
			port.Pins[5].Name = PIN5.Text;
			port.Pins[6].Name = PIN6.Text;
			port.Pins[7].Name = PIN7.Text;
			foreach (Pin pin in port.Pins)
				new PinDAO().SaveOrUpdate(pin);
			Master.StatusMsg = "Saved...";
		}
	}
}
