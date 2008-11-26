using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;

using NHibernate;
using log4net;
using log4net.Config;

using LPTCtrl.Data.Domain;
using LPTCtrl.Hardware;
using LPTCtrl.Service.Core;

namespace LPTCtrl.Service {
    static class Program {

        [STAThread]
        static void Main() {
			log4net.Config.XmlConfigurator.Configure();

            ChannelServices.RegisterChannel(new HttpChannel(9998), false);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(LPTPort), "LPTPort", WellKnownObjectMode.SingleCall);

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new LPTCtrl.Service.UI.FormMain());
        }
    }
}
