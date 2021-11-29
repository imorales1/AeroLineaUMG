using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Helper;
using AeroLinea.Negocio;
using System.Data;

namespace AeroLinea.Forms
{
    public partial class FrmLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["Usuario"] != null)
                    {
                        //Response.Redirect("FrmGeneracionQuejas.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                string pass = string.Empty;
                LoginN log = new LoginN();
                DataRow datos;

                log.Usuario = TxtUsuario.Text;
                log.Contraseña = Generica.EncriptarContraseña(TxtContraseña.Text);
                datos = log.IniciarSesion();

                if (datos == null)
                {
                    Generica.Mensaje(this, "'El usuario o contraseña no coinciden");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "Mensaje('" + "fgfdgdfgd" + "');", true);
                    lblError.Text = "El usuario o contraseña no coinciden";
                }
                else
                {
                    Master m = new Master();
                    Session["Usuario"] = datos["Usuario"].ToString();
                    Session["Rol"] = datos["Iniciales"].ToString();

                    Response.Redirect("FrmVentaBoletosVuelo.aspx");
                }
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }
    }
}