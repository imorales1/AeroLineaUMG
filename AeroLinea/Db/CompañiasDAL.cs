using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class CompañiasDAL:CadenaDB
    {
        public DataTable Buscar(string Criterio, int? IdCompañia = null)
        {
            DataTable tbl = new DataTable();
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSCompañias", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdCompañia", IdCompañia == null ? null : IdCompañia);
                        cmd.Parameters.AddWithValue("PNombre", Criterio == "" ? null: Criterio);
                        MySqlDataReader rd = cmd.ExecuteReader();
                        tbl.Load(rd);
                    }

                    cn.Close();
                }
                catch (Exception)
                {
                    throw;
                }

                return tbl;
            }
        }

        public void GrabarModificar(string Nombre, string Direccion, string Correo, Int64 Telefono, int? IdCompañia)
        {
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpIuCompañias", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PNombre", Nombre);
                        cmd.Parameters.AddWithValue("PDireccion", Direccion);
                        cmd.Parameters.AddWithValue("PCorreo", Correo);
                        cmd.Parameters.AddWithValue("PTelefono", Telefono);
                        cmd.Parameters.AddWithValue("PIdCompañia", IdCompañia == 0 ? null : IdCompañia);
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }
    }
}