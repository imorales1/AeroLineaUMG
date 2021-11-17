using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AeroLinea.Db;

namespace AeroLinea.Negocio
{
    public class AeroNaves
    {
        public static int? IdAvion { get; set; }
        public int? Turbinas { get; set; }
        public int Pasajeros { get; set; }
        public Decimal Peso { get; set; }
        public string Modelo { get; set; }
        public int IdCompañia { get; set; }

        public DataTable Buscar()
        {
            try
            {
                DataTable tbl;
                AeroNavesDAL an = new AeroNavesDAL();
                tbl = an.Buscar(IdCompañia, Turbinas, Modelo);
                return tbl;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void GrabarModificar()
        {
            try
            {
                AeroNavesDAL an = new AeroNavesDAL();
                an.GrabarModificar(Turbinas, Pasajeros, Peso, Modelo, IdCompañia, IdAvion);
            }
            catch (Exception)
            {
                throw;
            }
        } 
    }
}