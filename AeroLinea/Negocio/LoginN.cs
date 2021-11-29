using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AeroLinea.Db;
using System.Data;

namespace AeroLinea.Negocio
{
    public class LoginN
    {
        public string Usuario { get; set; }
        public string Contraseña { get; set; }

        public DataRow IniciarSesion()
        {
            try
            {
                DataRow row;
                LoginDAL log = new LoginDAL();
                row = log.IniciarSesion(Usuario, Contraseña);
                return row;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}