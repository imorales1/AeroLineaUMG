using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using AeroLinea.Db;

namespace AeroLinea.Negocio
{
    public class Ciudades
    {
        public static int IdCiudad { get; set; }
        public string Nombre { get; set; }
        public int IdPais { get; set; }

        public DataTable Buscar()
        {
            try
            {
                DataTable table;
                CiudadesDAL cd = new CiudadesDAL();
                table = cd.Buscar(IdPais, Nombre);

                return table;
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
                CiudadesDAL cd = new CiudadesDAL();
                cd.GrabarModificar(Nombre, IdPais, IdCiudad);
            }catch(Exception)
            {
                throw;
            }
        }

        public void Eliminar()
        {
            try
            {
                CiudadesDAL cd = new CiudadesDAL();
                cd.Eliminar(IdCiudad);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}