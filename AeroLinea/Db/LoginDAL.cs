using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

namespace AeroLinea.Db
{
    public class LoginDAL:CadenaDB
    {
        public DataRow IniciarSesion(string Usuario, string Contraseña)
        {
            DataTable Datos = new DataTable();
            DataRow row;
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using(MySqlCommand cmd = new MySqlCommand("UpsInicioSesion", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PUsuario", Usuario);
                        cmd.Parameters.AddWithValue("PContraseña", Contraseña);
                        MySqlDataReader rd = cmd.ExecuteReader();
                        Datos.Load(rd);

                        if(Datos.Rows.Count > 0)
                        {
                            row = Datos.Rows[0];
                        }
                        else
                        {
                            row = null;
                        }
                    }

                    cn.Close();
                }
                catch (Exception)
                {
                    throw;
                }
            }

            return row;
        }
    }
}