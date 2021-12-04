using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AeroLinea.Db;

namespace AeroLinea.Negocio
{
    public class VentaBoletos
    {
        public static int IdBoleto { get; set; }
        public string Clase { get; set; }
        public int Asiento { get; set; }
        public decimal Costo { get; set; }
        public int IdVuelo { get; set; }
        public int IdCliente { get; set; }
        public DateTime? FechaInicial { get; set; }
        public DateTime? FechaFinal { get; set; }

        public DataTable Buscar()
        {
            try
            {
                BoletosDAL bl = new BoletosDAL();
                return bl.Buscar(FechaInicial, FechaFinal, IdBoleto, Clase, IdVuelo);
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
                BoletosDAL bl = new BoletosDAL();
                bl.GrabarModificar(Clase, Asiento, Costo, IdVuelo, IdCliente, IdBoleto);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}