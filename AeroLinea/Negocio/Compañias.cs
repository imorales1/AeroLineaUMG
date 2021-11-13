using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AeroLinea.Db;

namespace AeroLinea.Negocio
{
    public class Compañias
    {
        public static int IdCompañia { get; set; }
        public string CriterioBusqueda { get; set; }

        public DataTable Buscar()
        {
            try
            {
                DataTable tbl;
                CompañiasDAL comp = new CompañiasDAL();
                tbl = comp.Buscar(CriterioBusqueda);

                return tbl;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}