using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AeroLinea.Db;
using System.Data;

namespace AeroLinea.Negocio
{
    public class Vuelos
    {
        public static int? IdVuelo { get; set; }
        public DateTime Fecha { get; set; }
        public int IdAvion { get; set; }
        public int COrigen { get; set; }
        public int CDestino { get; set; }

        public DataTable Buscar()
        {
            try
            {
                VuelosDAL vuelo = new VuelosDAL();
                return vuelo.Buscar(IdVuelo, Fecha);
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
                VuelosDAL vuelos = new VuelosDAL();
                vuelos.Grabar(Fecha, IdAvion, COrigen, CDestino, IdVuelo);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void Eliminar()
        {
            try
            {
                VuelosDAL vuelos = new VuelosDAL();
                vuelos.Eliminar(IdVuelo);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}