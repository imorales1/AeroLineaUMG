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
    }
}