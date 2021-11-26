using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Negocio;

namespace AeroLinea.Forms
{
    public partial class FrmClientes : System.Web.UI.Page
    {

        private static ModosDeTecleo Modo;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView.SetActiveView(ViewFiltro);
                    Modo = ModosDeTecleo.Grabar;
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdBuscar_Click(object sender, EventArgs e)
        {
            Buscar();
        }

        private void Buscar()
        {
            try
            {
                Clientes cl = new Clientes();
                cl.Criterio = TxtCriterio.Text.Trim();
                GrdClientes.DataSource = cl.Buscar();
                GrdClientes.DataBind();
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                Clientes cl = new Clientes();
                cl.Nombres = TxtNombres.Text;
                cl.Apellidos = TxtApellidos.Text;
                cl.DPI = TxtDpi.Text;
                cl.Direccion = TxtDireccion.Text;
                cl.GrabarModificar();

                if(Modo == ModosDeTecleo.Grabar)
                {
                    Helper.Generica.Mensaje(this, "Registro grabado con éxito");
                    LimpiarCampos();
                }
                else
                {
                    Helper.Generica.Mensaje(this, "Registro modificado con éxito");
                    LimpiarCampos();
                    MultiView.SetActiveView(ViewFiltro);
                    Buscar();
                }
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void LimpiarCampos()
        {
            try
            {
                TxtNombres.Text = string.Empty;
                TxtApellidos.Text = string.Empty;
                TxtDpi.Text = string.Empty;
                TxtDireccion.Text = string.Empty;
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        enum ModosDeTecleo
        {
            Grabar = 1,
            Modificar = 2
        }

        protected void GrdClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Clientes cl = new Clientes();
                Clientes.IdCliente = Convert.ToInt32((((HiddenField)GrdClientes.Rows[e.RowIndex].Cells[4].FindControl("HdnCliente")).Value));
                cl.Eliminar();
                Buscar();
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Clientes cl = new Clientes();
                TxtNombres.Text = GrdClientes.SelectedRow.Cells[0].Text;
                TxtApellidos.Text = GrdClientes.SelectedRow.Cells[1].Text;
                TxtDpi.Text = GrdClientes.SelectedRow.Cells[2].Text;
                TxtDireccion.Text = GrdClientes.SelectedRow.Cells[3].Text;
                Clientes.IdCliente = Convert.ToInt32((((HiddenField)GrdClientes.SelectedRow.Cells[4].FindControl("HdnCliente")).Value));
                MultiView.SetActiveView(ViewTecleo);
                Modo = ModosDeTecleo.Modificar;
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                LimpiarCampos();
                MultiView.SetActiveView(ViewFiltro);
                Buscar();
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdExportar_Click(object sender, EventArgs e)
        {
            try
            {
                if (GrdClientes.Rows.Count > 0)
                {
                    Helper.Generica.ExportExcel(GrdClientes, Response);
                }
                else
                {
                    Helper.Generica.Mensaje(this, "No hay datos para Exportar");
                }
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }
    }
}