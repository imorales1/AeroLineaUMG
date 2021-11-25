using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AeroLinea.Db;
using System.Data;

namespace AeroLinea.Negocio
{
    public class Usuarios
    {
        public static int IdUsuario { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public byte[] Fotografia { get; set; }
        public string Usuario { get; set; }
        public string Contraseña { get; set; }
        public int IdRol { get; set; }
        public string CriterioBusqueda { get; set; }

        public void Grabar()
        {
            try
            {
                UsuariosDAL usuario = new UsuariosDAL();
                usuario.GuardarImagen(Fotografia, Nombres, Apellidos, Usuario, Contraseña, IdUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public DataTable Buscar()
        {
            try
            {
                UsuariosDAL usuario = new UsuariosDAL();
                
                return usuario.Buscar(CriterioBusqueda, IdUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}