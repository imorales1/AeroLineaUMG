using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class BoletosDAL:CadenaDB
    {
        public DataTable Buscar(DateTime? FechaInicial, DateTime? FechaFinal, int? IdBoleto, string Clase, int? IdVuelo)
        {
            DataTable tbl = new DataTable();
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSBoletos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PFechaInicial", FechaInicial);
                        cmd.Parameters.AddWithValue("PFechaFinal", FechaFinal);
                        cmd.Parameters.AddWithValue("PIdBoleto", IdBoleto == 0 ? null : IdBoleto);
                        cmd.Parameters.AddWithValue("PClase", Clase == ""? null : Clase);
                        cmd.Parameters.AddWithValue("PIdVuelo", IdVuelo == 0 ? null : IdVuelo);
                        MySqlDataReader rd = cmd.ExecuteReader();
                        tbl.Load(rd);
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

        public void GrabarModificar(string Clase, int Asiento, decimal Costo, int IdVuelo, int IdCliente, int IdBoleto)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpIUBoletos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PClase", Clase);
                        cmd.Parameters.AddWithValue("PAsiento", Asiento);
                        cmd.Parameters.AddWithValue("PCosto", Costo);
                        cmd.Parameters.AddWithValue("PIdVuelo", IdVuelo);
                        cmd.Parameters.AddWithValue("PIdCliente", IdCliente);
                        cmd.Parameters.AddWithValue("PIdBoleto", IdBoleto);
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

        public void Eliminar(int IdBoleto)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpDBoletos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdBoleto", IdBoleto);
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