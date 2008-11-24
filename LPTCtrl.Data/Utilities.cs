using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using NHibernate;
using NHibernate.Cfg;

namespace LPTCtrl.Data {
	public class Utilities {
		private static ISessionFactory sessionFactory;
		private static ISession session;

		public static ISessionFactory SessionFactory {
			get {
				if (sessionFactory == null) {
					InitializeSessionFactory();
				}
				return sessionFactory;
			}
		}

		private static void InitializeSessionFactory() {
			sessionFactory = new Configuration()
				.AddAssembly(System.Reflection.Assembly.GetExecutingAssembly())
				.BuildSessionFactory();
		}

		public static ISession DefaultSession {
			get {
				if (session == null || !session.IsOpen) {
					InitializeSession();
				}
				return session;
			}
		}

		private static void InitializeSession() {
			session = SessionFactory.OpenSession();
		}
	}
}
