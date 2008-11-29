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
using LPTCtrl.Service.Properties;

namespace LPTCtrl.Service.UI {
    public partial class FormMain : Form {
        public FormMain() {
            InitializeComponent();
			ActionTimer.Interval = Settings.Default.EventPoolingInterval * 1000;
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
			new EventProcessor().ProcessEvents(ActionTimer.Interval);
        }
    }
}
