using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class CiudadesDAL:CadenaDB
    {
        public DataTable Buscar(int? IdPais, string Nombre)
        {
            DataTable tbl = new DataTable();
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using(MySqlCommand cmd = new MySqlCommand("UpSCiudades",cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PPais", IdPais == 0 ? null : IdPais);
                        cmd.Parameters.AddWithValue("PNombre", Nombre == "" ? null : Nombre);
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
    }
}