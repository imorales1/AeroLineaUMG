using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Negocio;
using AeroLinea.Helper;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Data;

namespace AeroLinea.Forms
{
    public partial class FrmVentaBoletosVuelo : System.Web.UI.Page
    {
        private static ModosDeTecleo Modo { get; set; }
        private static DataTable tabladatos;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if(Session["Usuario"] != null)
                {
                    MultiView.SetActiveView(ViewFiltro);
                    Generica combos = new Generica();
                    combos.LLenarCombos(ref CboVuelosProgramados);
                    combos.LLenarCombos(ref CboVuelosProgramadosT);
                    Modo = ModosDeTecleo.Grabar;
                    if (Session["Rol"].ToString() != "OPR")
                    {
                        GrdBoletos.Columns[9].Visible = false;
                        GrdBoletos.Columns[10].Visible = false;
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
            MultiView.SetActiveView(ViewTecleo);
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Generica.ValidarTextBox(ref TxtClaseT)) return;
                if (!Generica.ValidarTextBox(ref TxtAsientoT)) return;
                if (!Generica.ValidarTextBox(ref TxtCostoT)) return;
                if (!Generica.ValidarCombo(ref CboVuelosProgramadosT)) return;
                if (!Generica.ValidarTextBox(ref TxtCliente)) return;
                VentaBoletos vb = new VentaBoletos();
                vb.Clase = TxtClaseT.Text.Trim();
                vb.Asiento = Convert.ToInt32(TxtAsientoT.Text);
                vb.Costo = Convert.ToDecimal(TxtCostoT.Text);
                vb.IdVuelo = Convert.ToInt32(CboVuelosProgramadosT.SelectedValue);
                vb.IdCliente = Convert.ToInt32(TxtCliente.Text);
                vb.GrabarModificar();

                if(Modo == ModosDeTecleo.Grabar)
                {
                    Generica.Mensaje(this, "Registro grabado con éxito");
                    Response.Redirect("FrmBoletos.aspx");
                }
                else
                {
                    Generica.Mensaje(this, "Registro Modificado con éxito");
                    Modo = ModosDeTecleo.Grabar;
                    MultiView.SetActiveView(ViewFiltro);
                    Buscar();
                }

                LimpiarCampos();
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

        protected void GrdBoletos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                VentaBoletos boleto = new VentaBoletos();
                VentaBoletos.IdBoleto = Convert.ToInt32(((HiddenField)GrdBoletos.Rows[e.RowIndex].Cells[8].FindControl("HdnBoleto")).Value);
                boleto.Eliminar();
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdBoletos_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                VentaBoletos boleto = new VentaBoletos();
                VentaBoletos.IdBoleto = Convert.ToInt32(((HiddenField)GrdBoletos.SelectedRow.Cells[9].FindControl("HdnBoleto")).Value);
                TxtClaseT.Text = GrdBoletos.SelectedRow.Cells[3].Text.Trim();
                TxtAsientoT.Text = GrdBoletos.SelectedRow.Cells[6].Text.Trim();
                TxtCostoT.Text = GrdBoletos.SelectedRow.Cells[8].Text.Trim();
                CboVuelosProgramadosT.SelectedValue = ((HiddenField)GrdBoletos.SelectedRow.Cells[9].FindControl("HdnVuelo")).Value.ToString();
                TxtCliente.Text = ((HiddenField)GrdBoletos.SelectedRow.Cells[9].FindControl("HdnCliente")).Value.ToString();
                TxtCliente_TextChanged1(TxtCliente, e);
                Modo = ModosDeTecleo.Modificar;
                MultiView.SetActiveView(ViewTecleo);
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        public void Buscar()
        {
            try
            {
                VentaBoletos vb = new VentaBoletos();
                VentaBoletos.IdBoleto = TxtBoleto.Text.Equals("") ? 0 : Convert.ToInt32(TxtBoleto.Text);
                if(TxtFechaInicial.Text != "")
                {
                    vb.FechaInicial = Convert.ToDateTime(TxtFechaInicial.Text);
                    if(TxtFechaInicial.Text == "")
                    {
                        Generica.Mensaje(this, "El campo fecha final es necesario para continuar con el proceo!");
                        return;
                    }
                    else
                    {
                        vb.FechaFinal = Convert.ToDateTime(TxtFechaFinal.Text);
                    }
                }
                else
                {
                    vb.FechaInicial = null;
                    vb.FechaFinal = null;
                }

                vb.Clase = TxtClase.Text.Trim();
                vb.IdVuelo = Convert.ToInt32(CboVuelosProgramados.SelectedValue);
                tabladatos = vb.Buscar();
                GrdBoletos.DataSource = tabladatos;
                GrdBoletos.DataBind();
                VentaBoletos.tblreporte = tabladatos;
                VentaBoletos.IdBoleto = 0;
                LblRegistros.Text = "Registros encontrados: " + GrdBoletos.Rows.Count.ToString();
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        private void LimpiarCampos()
        {
            try
            {
                TxtAsientoT.Text = string.Empty;
                TxtClaseT.Text = string.Empty;
                TxtCostoT.Text = string.Empty;
                CboVuelosProgramadosT.SelectedValue = "0";
                TxtCliente.Text = string.Empty;
            }catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        enum ModosDeTecleo
        {
            Grabar = 1,
            Modificar =2
        }

        protected void TxtCliente_TextChanged1(object sender, EventArgs e)
        {
            try
            {
                DataRow row;
                Clientes cl = new Clientes();
                Clientes.IdCliente = Convert.ToInt32(TxtCliente.Text);

                row = cl.ConsultarClienteCreado();
                Clientes.IdCliente = 0;

                if (row != null)
                {
                    TxtNombreCLiente.Text = row["Cliente"].ToString();
                }
                else
                {
                    TxtNombreCLiente.Text = "Cliente no encontrado";
                }
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdReporte_Click(object sender, EventArgs e)
        {
            try
            {
                if (GrdBoletos.Rows.Count > 0)
                {
                    VentaBoletos.tblreporte = tabladatos;
                    Response.Redirect("FrmReportes.aspx");
                }
                else
                {
                    Generica.Mensaje(this, "No hay datos para generar reporte");
                }
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }
    }
}