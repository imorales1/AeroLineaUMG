using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Negocio;

namespace AeroLinea.Forms
{
    public partial class FrmCompañias : System.Web.UI.Page
    {
        private static ModoDeTecleo Modo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if(Session["Usuario"] != null)
                {
                    MultiView.SetActiveView(ViewBusqueda);
                    Modo = ModoDeTecleo.Grabar;

                    if (Session["Rol"].ToString() != "OPR")
                    {
                        GrdCompañias.Columns[4].Visible = false;
                        GrdCompañias.Columns[5].Visible = false;
                        CmdAgregar.Enabled = false;
                    }
                }
                else
                {
                    Response.Redirect("FrmLogin.aspx");
                }
            }
        }

        protected void CmdBuscar_Click(object sender, EventArgs e)
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
                Helper.Generica.Mensaje(this, "Agregar");
            }
        }

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewBusqueda);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try {

                if(!Helper.Generica.ValidarTextBox(ref TxtNombre)) return;
                if (!Helper.Generica.ValidarTextBox(ref TxtDireccion)) return;
                if (!Helper.Generica.ValidarTextBox(ref TxtCorreo)) return;
                if (Helper.Generica.ValidarTextBox(ref TxtTelefono)) return;

                Compañias comp = new Compañias();
                comp.Nombre = TxtNombre.Text;
                comp.Direccion = TxtDireccion.Text;
                comp.Correo = TxtCorreo.Text;
                comp.Telefono = Convert.ToInt64(TxtTelefono.Text);
                comp.GrabarModificar();
                if(Modo == ModoDeTecleo.Grabar)
                {
                    Helper.Generica.MensajeGrabar(this);
                    Helper.Generica.Mensaje(this, "Registro Grabado con Éxito");
                }
                {
                    Helper.Generica.Mensaje(this, "Registro Modificado con Éxito");
                    Modo = ModoDeTecleo.Grabar;
                    MultiView.SetActiveView(ViewBusqueda);
                    Buscar();
                }
                
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdCompañias_SelectedIndexChanged1(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
                Compañias.IdCompañia = Convert.ToInt32(((HiddenField)GrdCompañias.SelectedRow.FindControl("HdnCompañia")).Value);
                TxtNombre.Text = GrdCompañias.SelectedRow.Cells[0].Text.Equals("&nbsp;")? null : GrdCompañias.SelectedRow.Cells[0].Text;
                TxtDireccion.Text = GrdCompañias.SelectedRow.Cells[1].Text.Equals("&nbsp;")? null : GrdCompañias.SelectedRow.Cells[1].Text;
                TxtCorreo.Text = GrdCompañias.SelectedRow.Cells[2].Text.Equals("&nbsp;")? null: GrdCompañias.SelectedRow.Cells[2].Text;
                TxtTelefono.Text = GrdCompañias.SelectedRow.Cells[3].Text.Equals("&nbsp;")? null : GrdCompañias.SelectedRow.Cells[3].Text;
                Modo = ModoDeTecleo.Modificar;
            }
            catch (Exception)
            {

            }
        }

        protected void GrdCompañias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Compañias comp = new Compañias();
                Compañias.IdCompañia = Convert.ToInt32(((HiddenField)GrdCompañias.Rows[e.RowIndex].Cells[0].FindControl("HdnCompañia")).Value);
                comp.Eliminar();
                Buscar();
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void Buscar()
        {
            try
            {
                Compañias comp = new Compañias();
                comp.CriterioBusqueda = TxtCriterioBusqueda.Text;
                GrdCompañias.DataSource = comp.Buscar();
                GrdCompañias.DataBind();
                LblRegistros.Text = "Registros: " + GrdCompañias.Rows.Count.ToString();
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }
        enum ModoDeTecleo
        {
            Grabar = 1,
            Modificar = 2
        }

    }
}