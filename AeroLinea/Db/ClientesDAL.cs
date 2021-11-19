using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class ClientesDAL:CadenaDB
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

        public void GrabarModificar(string Nombre, string Apellido, string DPI, string Direccion, int IdCliente)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpIUClientes", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PCriterio", Nombre == "" ? null : Nombre);
                        cmd.Parameters.AddWithValue("PCriterio", Apellido == "" ? null : Apellido);
                        cmd.Parameters.AddWithValue("PCriterio", DPI == "" ? null : DPI);
                        cmd.Parameters.AddWithValue("PCriterio", Direccion == "" ? null : Direccion);
                        cmd.Parameters.AddWithValue("PCriterio", IdCliente);
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