using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Helper;
using AeroLinea.Negocio;

namespace AeroLinea.Forms
{
    public partial class FrmVuelosProgramados : System.Web.UI.Page
    {
        private static ModosDeTecleo Modo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if(Session["Usuario"] != null)
                    {
                        MultiView.SetActiveView(ViewFiltro);
                        Modo = ModosDeTecleo.Grabar;
                        Generica combos = new Generica();
                        combos.LLenarCombos(ref CboAviones);
                        combos.LLenarCombos(ref CboCiudadesO);
                        combos.LLenarCombos(ref CboCiudadesD);

                        if (Session["Rol"].ToString() != "OPR")
                        {
                            GrdVuelos.Columns[7].Visible = false;
                            GrdVuelos.Columns[8].Visible = false;
                            CmdAgregar.Enabled = false;
                        }
                    }
                    else
                    {
                        Response.Redirect("FrmLogin.aspx");
                    }
                }
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdBuscar_Click(object sender, EventArgs e)
        {
            Buscar();
        }

        protected void CmdExportar_Click(object sender, EventArgs e)
        {
            try
            {
                if(GrdVuelos.Rows.Count > 0)
                {
                    Generica.ExportExcel(GrdVuelos, Response);
                }
                else
                {
                    Generica.Mensaje(this, "No hay datos para exportar");
                }
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Generica.ValidarTextBox(ref TxtFechaT)) return;
                if (!Generica.ValidarCombo(ref CboAviones)) return;
                if (!Generica.ValidarCombo(ref CboCiudadesO)) return;
                if (!Generica.ValidarCombo(ref CboCiudadesD)) return;

                Vuelos vuelo = new Vuelos();
                vuelo.Fecha = TxtFechaT.Text.Equals("") ? Convert.ToDateTime("01/01/1999") : Convert.ToDateTime(TxtFechaT.Text);
                vuelo.IdAvion = Convert.ToInt32(CboAviones.SelectedValue);
                vuelo.COrigen = Convert.ToInt32(CboCiudadesO.SelectedValue);
                vuelo.CDestino = Convert.ToInt32(CboCiudadesD.SelectedValue);
                vuelo.GrabarModificar();

                if(Modo == ModosDeTecleo.Grabar)
                {
                    Generica.Mensaje(this, "Registro grabado con éxito");
                    LimpiarCampos();
                }
                else
                {
                    Generica.Mensaje(this, "Registro Modificado con éxito");
                    Modo = ModosDeTecleo.Grabar;
                    Vuelos.IdVuelo = 0;
                    LimpiarCampos();
                    MultiView.SetActiveView(ViewFiltro);
                }
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewFiltro);
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdVuelos_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Vuelos.IdVuelo = Convert.ToInt32((((HiddenField)GrdVuelos.SelectedRow.Cells[6].FindControl("HdnVuelo")).Value));
                TxtFechaT.Text = GrdVuelos.SelectedRow.Cells[0].Text.Trim();
                CboAviones.SelectedValue = (((HiddenField)GrdVuelos.SelectedRow.Cells[6].FindControl("HdnAvion")).Value).ToString();
                CboCiudadesO.SelectedValue = (((HiddenField)GrdVuelos.SelectedRow.Cells[6].FindControl("HdnOrigen")).Value).ToString();
                CboCiudadesD.SelectedValue = (((HiddenField)GrdVuelos.SelectedRow.Cells[6].FindControl("HdnDestino")).Value).ToString();
                MultiView.SetActiveView(ViewTecleo);
                Modo = ModosDeTecleo.Modificar;
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdVuelos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Vuelos vuelo = new Vuelos();
                Vuelos.IdVuelo = Convert.ToInt32((((HiddenField)GrdVuelos.Rows[e.RowIndex].Cells[6].FindControl("HdnVuelo")).Value));
                vuelo.Eliminar();
                Vuelos.IdVuelo = 0;
                Buscar();
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CboCiudadesO_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Generica cbo = new Generica();
                cbo.LLenarCombos(ref CboCiudadesD, Convert.ToInt32(CboCiudadesO.SelectedValue));
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        private void Buscar()
        {
            try
            {
                Vuelos vuelo = new Vuelos();
                Vuelos.IdVuelo = TxtIdVuelo.Text.Equals("") ? 0 : Convert.ToInt32(TxtIdVuelo.Text);
                vuelo.Fecha = TxtFecha.Text.Equals("") ? Convert.ToDateTime("01/01/1999") : Convert.ToDateTime(TxtFecha.Text);
                GrdVuelos.DataSource = vuelo.Buscar();
                GrdVuelos.DataBind();
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        private void LimpiarCampos()
        {
            try
            {
                TxtFechaT.Text = string.Empty;
                CboAviones.SelectedValue = "0";
                CboCiudadesO.SelectedValue = "0";
                CboCiudadesD.SelectedValue = "0";
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }
        enum ModosDeTecleo
        {
            Grabar = 1,
            Modificar = 2
        }
    }
}