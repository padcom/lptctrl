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
using LPTCtrl.Service.Core;

namespace LPTCtrl.Service {
    static class Program {

		private static void GenerateTestEvent() {
			Event e = new Event();
			e.Pin = LPTCtrl.Data.Utilities.DefaultSession.CreateQuery("select pin from Pin as pin where pin.ID=1").UniqueResult<Pin>();
			e.State = false;
			e.Timestamp = DateTime.Now.AddSeconds(5);
			LPTCtrl.Data.Utilities.DefaultSession.Save(e);
			LPTCtrl.Data.Utilities.DefaultSession.Flush();
		}

        [STAThread]
        static void Main() {
			log4net.Config.XmlConfigurator.Configure();
			//GenerateTestEvent();

            ChannelServices.RegisterChannel(new HttpChannel(9998), false);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(LPTPort), "LPTPort", WellKnownObjectMode.SingleCall);

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new LPTCtrl.Service.UI.FormMain());
        }
    }
}
