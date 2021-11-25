using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using AeroLinea.Negocio;
using System.Data;

namespace AeroLinea.Forms
{
    public partial class FrmUsuarios : System.Web.UI.Page
    {
        private static ModosDeTecleo Modo;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView.SetActiveView(ViewFiltro);
                    Helper.Generica cbo = new Helper.Generica();
                    cbo.LLenarCombos(ref CboRoles);
                    Modo = ModosDeTecleo.Grabar;
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!CompararContraseñas(TxtContraseña.Text.Trim(), TxtConfContraseña.Text.Trim())) {
                    Helper.Generica.Mensaje(this, "Las contraseñas ingresadas no coinciden");
                    return;
                }

                Usuarios us = new Usuarios();
                int Tamanio = fuploadImagen.PostedFile.ContentLength;
                byte[] Imagen = new byte[Tamanio];

                fuploadImagen.PostedFile.InputStream.Read(Imagen, 0, Tamanio);
                Bitmap ImgBinary = new Bitmap(fuploadImagen.PostedFile.InputStream);
                string ImagenData64 = "data:image/jpg;base64," + Convert.ToBase64String(Imagen);
                Image1.ImageUrl = ImagenData64;

                us.Nombres = TxtNombres.Text.Trim();
                us.Apellidos = TxtApellidos.Text.Trim();
                us.Fotografia = Imagen;
                us.Usuario = TxtUsuario.Text.Trim();
                us.Contraseña = Helper.Generica.EncriptarContraseña(TxtContraseña.Text.Trim());
                us.IdRol = Convert.ToInt16(CboRoles.SelectedValue);
                us.Grabar();

                if(Modo == ModosDeTecleo.Grabar)
                {
                    Helper.Generica.Mensaje(this, "Usuario Grabado con éxito");
                }
                else
                {
                    Helper.Generica.Mensaje(this, "Usuario Modificado con éxito");
                }
                
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdBuscar_Click1(object sender, EventArgs e)
        {
            Buscar();
        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                //DataRow row;
                //Usuarios us = new Usuarios();

                //Usuarios.IdUsuario = 3;
                //row = us.Buscar().Rows[0];
                //byte[] obj = (byte[])row["Fotografia"];
                //Image1.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(obj);
                MultiView.SetActiveView(ViewFiltro);
                PnlContraseñas.Visible = true;

            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Usuarios.IdUsuario = Convert.ToInt32((((HiddenField)GrdUsuarios.SelectedRow.Cells[4].FindControl("HdnIdUsuario")).Value));
                Modo = ModosDeTecleo.Modificar;
                PnlContraseñas.Visible = false;
                ExecuteQuery();
                MultiView.SetActiveView(ViewTecleo);
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private bool CompararContraseñas(string contraseña1, string contraseña2)
        {
            bool respuesta = new bool();
            try
            {
                
                if(contraseña1 == contraseña2)
                {
                    respuesta = true;
                }
                else
                {
                    respuesta = false;
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }

            return respuesta;
        }

       private void Buscar()
        {
            try
            {
                Usuarios us = new Usuarios();
                us.CriterioBusqueda = TxtCriterio.Text.Trim();
                GrdUsuarios.DataSource = us.Buscar();
                GrdUsuarios.DataBind();
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void ExecuteQuery()
        {
            try
            {
                DataRow row;
                Usuarios us = new Usuarios();
                row = us.BuscarUsuario();

                TxtUsuario.Text = row["Usuario"].ToString();
                TxtNombres.Text = row["Nombres"].ToString();
                TxtApellidos.Text = row["Apellidos"].ToString();
                CboRoles.SelectedValue = row["IdRol"].ToString().Equals("")? "0" : row["IdRol"].ToString();
                byte[] obj = (byte[])row["Fotografia"];
                Image1.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(obj);
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        enum ModosDeTecleo
        {
            Grabar = 1,
            Modificar = 2
        }
    }
}