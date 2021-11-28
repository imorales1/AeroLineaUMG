using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

namespace AeroLinea.Db
{
    public class CombosDal : CadenaDB
    {
        public DataTable ObtenerCompañias()
        {
            DataTable tbl = new DataTable();
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpsCompañiasCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
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

        public DataTable ObtenerPaises()
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSPaisesCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
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

        public DataTable ObtenerRoles()
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSRolesCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
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

        public DataTable ObtenerAviones()
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSAvionesCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
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

        public DataTable ObtenerCiduades(int? Parametro)
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSCiudadesCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PIdCiudad", Parametro == 0? null : Parametro);
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

        public DataTable ObtenerVuelosProgramados()
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpSVuelosCombo", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
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
    }
}