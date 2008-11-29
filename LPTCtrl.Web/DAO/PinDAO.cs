﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using NHibernate;
using NHibernate.Criterion;
using NHibernate.Burrow.AppBlock.DAOBases;

using LPTCtrl.Data.Domain;

namespace LPTCtrl.Web.DAO {
	public class PinDAO : GenericDAO<Pin> {
		protected override Order DefaultOrder {
			get { return Order.Asc("Bit"); }
		}
	}
}
