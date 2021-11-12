using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace AeroLinea.Negocio
{
    public class Compañias
    {
        public static int IdCompañia { get; set; }
        public string Nombre { get; set; }

        public DataTable Buscar()
        {
            try
            {
                DataTable tbl;


                return tbl;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}