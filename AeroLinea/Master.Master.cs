using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using AeroLinea.Helper;
using AeroLinea.Negocio;
using System.Data;

namespace AeroLinea
{
    public partial class Master : System.Web.UI.MasterPage
    {
        public static byte[] Foto { get; set; }
        public static string Nombre { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if(Session["Usuario"].ToString() != null)
                    {
                        CargarFotografia();
                    }
                }
            }catch(Exception)
            {
                throw;
            }
        }

        private void CargarFotografia()
        {
            try
            {
                LoginN log = new LoginN();
                DataRow row;
                log.Usuario = Session["Usuario"].ToString() ;
                row = log.IniciarSesion();
                Image1.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String((byte[])row["Fotografia"]);
                LblUsuario.Text = row["Nombre"].ToString();

                if(Session["Rol"].ToString() != "ADM")
                {
                    PnlAdministrador.Visible = false;
                }
            }
            catch(Exception)
            {
                throw;
            }
        }

        protected void CmdCerrarSesion_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Usuario"] = null;
                Session["Rol"] = null;
                Response.Redirect("FrmLogin.aspx");
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}