using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;

using LPTCtrl.Service.Core;

namespace LPTCtrl.Service {
    static class Program {

        [STAThread]
        static void Main() {
            ChannelServices.RegisterChannel(new HttpChannel(9998), false);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(LPTPort), "LPTPort", WellKnownObjectMode.SingleCall);

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new LPTCtrl.Service.UI.FormMain());
        }
    }
}
