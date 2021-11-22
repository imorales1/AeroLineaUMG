using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class ClientesDAL : CadenaDB
    {
        public DataTable Buscar(string Criterio)
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSClientes", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PCriterio", Criterio == "" ? null : Criterio);
                        MySqlDataReader Rd = cmd.ExecuteReader();
                        tbl.Load(Rd);
                    }
                    cn.Close();
                }
                catch (Exception)
                {
                    throw;
                }
            }

            return tbl;
        }

        public void GrabarModificar(string Nombre, string Apellido, string DPI, string Direccion, int? IdCliente)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpIUClientes", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PNombres", Nombre == "" ? null : Nombre);
                        cmd.Parameters.AddWithValue("PApellidos", Apellido == "" ? null : Apellido);
                        cmd.Parameters.AddWithValue("PDPI", DPI == "" ? null : DPI);
                        cmd.Parameters.AddWithValue("PDireccion", Direccion == "" ? null : Direccion);
                        cmd.Parameters.AddWithValue("PIdCliente", IdCliente);
                        cmd.ExecuteNonQuery();
                    }
                    cn.Close();
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }

        public void Eliminar(int Id)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpDClientes", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdCliente", Id);
                        cmd.ExecuteNonQuery();
                    }
                    cn.Close();
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }
    }
}