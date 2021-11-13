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
    }
}