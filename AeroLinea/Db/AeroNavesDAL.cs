using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class AeroNavesDAL:CadenaDB
    {
        public DataTable Buscar(int? IdCompañia, int? Turbinas, string Modelo)
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSAeroNavesCompañias", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdCompañia", IdCompañia == 0? null : IdCompañia);
                        cmd.Parameters.AddWithValue("PTurbinas", Turbinas == 0? null : Turbinas);
                        cmd.Parameters.AddWithValue("PModelo", Modelo == ""? null : Modelo);
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

        public void GrabarModificar(int? Turbinas, int Asientos, decimal Peso, string Modelo, int IdCompañia, int? IdAvion)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                cn.Open();
                try
                {
                    using (MySqlCommand cmd = new MySqlCommand("UpIuAeroNavesCompañias", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PTurbinas", Turbinas);
                        cmd.Parameters.AddWithValue("PAsientos", Asientos);
                        cmd.Parameters.AddWithValue("PPeso", Peso);
                        cmd.Parameters.AddWithValue("PModelo", Modelo);
                        cmd.Parameters.AddWithValue("PIdCompañia", IdCompañia);
                        cmd.Parameters.AddWithValue("PIdAvion", IdAvion == 0? null : IdAvion);
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