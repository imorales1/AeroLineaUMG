using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace AeroLinea.Db
{
    public class CadenaDB
    {
        public String cadena { get; set; }

        public CadenaDB()
        {
            cadena = ConfigurationManager.ConnectionStrings["cn"].ConnectionString;
        }
    }
}