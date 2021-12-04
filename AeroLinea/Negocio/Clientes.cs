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
        public static int IdCliente { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string DPI { get; set; }
        public string Direccion { get; set; }
        public string Criterio { get; set; }

        public DataTable Buscar()
        {
            try
            {
                ClientesDAL cl = new ClientesDAL();
                return cl.Buscar(Criterio, IdCliente);
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
                ClientesDAL cl = new ClientesDAL();
                cl.GrabarModificar(Nombres, Apellidos, DPI, Direccion, IdCliente);
            }catch(Exception)
            {
                throw;
            }
        }


        public void Eliminar()
        {
            try
            {
                ClientesDAL cl = new ClientesDAL();
                cl.Eliminar(IdCliente);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public DataRow ConsultarClienteCreado()
        {
            try
            {
                ClientesDAL cl = new ClientesDAL();
                return cl.ConsultarClienteCreado(IdCliente);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}