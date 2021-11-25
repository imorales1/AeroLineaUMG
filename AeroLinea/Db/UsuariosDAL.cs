using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace AeroLinea.Db
{
    public class UsuariosDAL:CadenaDB
    {
        public void GuardarImagen(byte[] imagen, string nombres, string apellidos, string Usuario, string contraseña
                                  , int IdRol, int? IdUsuario = 0)
        {
            using (MySqlConnection cn = new MySqlConnection(cadena))
            { 
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpIuUsuarios", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PNombres", nombres);
                        cmd.Parameters.AddWithValue("PApellidos", apellidos);
                        cmd.Parameters.AddWithValue("PFoto", imagen);
                        cmd.Parameters.AddWithValue("PUsuario", Usuario);
                        cmd.Parameters.AddWithValue("PContraseña", contraseña);
                        cmd.Parameters.AddWithValue("PIdRol", IdRol);
                        cmd.Parameters.AddWithValue("PIdUsuario", IdUsuario);
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

        public DataTable Buscar(string Criterio, int? Id = 0)
        {
            DataTable tbl = new DataTable();
            using(MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using(MySqlCommand cmd = new MySqlCommand("UpsUsuarios", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PCriterio", Criterio == ""? null : Criterio);
                        cmd.Parameters.AddWithValue("PId", Id == 0? null : Id);
                        MySqlDataReader rd = cmd.ExecuteReader();
                        tbl.Load(rd);
                    }
                    cn.Close();
                }catch(Exception ex)
                {
                    throw;
                }
            }

            return tbl;
        }

        public DataTable BuscarDatosEmpleado(int ID)
        {
            DataTable tbl = new DataTable();
            using (MySqlConnection cn = new MySqlConnection(cadena))
            {
                try
                {
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand("UpsUsuarioDatos", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("PId", ID);
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