using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AeroLinea.Db;

namespace AeroLinea.Negocio
{
    public class Clientes
    {
        public static int dCliente { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public long MyProperty { get; set; }
        public string Direccion { get; set; }
        public string Criterio { get; set; }

        public DataTable Buscar()
        {
            try
            {
                ClientesDAL cl = new ClientesDAL();
                return cl.Buscar(Criterio);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}