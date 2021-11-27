using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

namespace AeroLinea.Db
{
    public class VuelosDAL:CadenaDB
    {
        public DataTable Buscar(int? IdVuelo, DateTime? Fecha)
        {
            DataTable tbl = new DataTable() ;
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using(MySqlCommand cmd = new MySqlCommand("UpSVuelos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdVuelo", IdVuelo == 0? null : IdVuelo);
                        cmd.Parameters.AddWithValue("PFecha", Fecha < Convert.ToDateTime("01/01/2000")? null : Fecha );
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

        public void Grabar(DateTime Fecha, int IdAvion, int Origen, int Destino, int? IdVuelo = null)
        {
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using(MySqlCommand cmd = new MySqlCommand("UpIUVuelos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PFecha", Fecha);
                        cmd.Parameters.AddWithValue("PIdAvion", IdAvion);
                        cmd.Parameters.AddWithValue("PCiudadOrigen", Origen);
                        cmd.Parameters.AddWithValue("PCiudadDestino", Destino);
                        cmd.Parameters.AddWithValue("PIdVuelo", IdVuelo);
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

        public void Eliminar(int? IdVuelo)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpDVuelos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdVuelo", IdVuelo);
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