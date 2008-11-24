using System;
using System.Threading;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using LPTCtrl.Service.Core;
using LPTCtrl.Service.Data;

namespace LPTCtrl.Service.UI {
    public partial class FormMain : Form {
        public FormMain() {
            InitializeComponent();
        }

		private void FormMain_VisibleChanged(object sender, EventArgs e) {
			Hide();
		}

        private bool ShouldClose = false;

		private void FormMain_FormClosing(object sender, FormClosingEventArgs e) {
            e.Cancel = !ShouldClose;
        }

        private void CloseMenuItem_Click(object sender, EventArgs e) {
            ShouldClose = true;
            Close();
        }

        private void ActionTimer_Tick(object sender, EventArgs e) {
            DataSet events = DataProvider.GetEvents(
                DateTime.Now.AddSeconds(-ActionTimer.Interval / 1000),
                DateTime.Now.AddSeconds(ActionTimer.Interval / 1000)
            );
            foreach (DataRow row in events.Tables[0].Rows) {
                int bit = row.Field<int>("BIT");
                int state = row.Field<int>("STATE");
                LPTPort.Default.SetBit(bit, state == 1);
                Thread.Sleep(50);
            }
        }
    }
}
