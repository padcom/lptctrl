using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using FirebirdSql.Data.FirebirdClient;
using LPTCtrl.Service.Properties;

namespace LPTCtrl.Service.Data {
    class DataProvider {
        private static FbConnection connection = new FbConnection(Settings.Default.ConnectionString);

        public static DataSet GetEvents(DateTime from, DateTime to) {
            if (connection.State == ConnectionState.Closed) {
                connection.Open();
            }
            FbCommand cmd = connection.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = String.Format("select EVENT.ID as ID, EVENT.TS as TS, EVENT.STATE as STATE, PIN.BIT as BIT from EVENT, PIN where EVENT.PINID=PIN.ID and EVENT.TS between '{0}' and '{1}'", 
                from.ToString("yyyy-MM-dd HH:mm:ss"),
                to.ToString("yyyy-MM-dd HH:mm:ss")
            );
            DataSet Result = new DataSet();
            Result.Load(cmd.ExecuteReader(), LoadOption.Upsert, new string[] {"EVENT"});
            return Result;
        }
    }
}
