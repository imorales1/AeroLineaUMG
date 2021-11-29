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

namespace AeroLinea.Forms
{
    public partial class FrmVentaBoletosVuelo : System.Web.UI.Page
    {
        private static ModosDeTecleo Modo { get; set; }
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
                        GrdBoletos.Columns[7].Visible = false;
                        GrdBoletos.Columns[8].Visible = false;
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

        protected void CmdExportar_Click(object sender, EventArgs e)
        {

        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            MultiView.SetActiveView(ViewTecleo);
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                VentaBoletos vb = new VentaBoletos();
                vb.Clase = TxtClaseT.Text.Trim();
                vb.Asiento = Convert.ToInt32(TxtAsientoT.Text);
                vb.Costo = Convert.ToInt32(TxtCostoT.Text);
                vb.IdVuelo = Convert.ToInt32(CboVuelosProgramadosT.SelectedValue);
                vb.IdCliente = Convert.ToInt32(TxtCliente.Text);
                vb.GrabarModificar();

                if(Modo == ModosDeTecleo.Grabar)
                {
                    Generica.Mensaje(this, "Registro grabado con éxito");
                    LimpiarCampos();
                    FrmBoletos frm = new FrmBoletos();
                    frm.IdBoleto = 2;
                    Response.Redirect("FrmBoletos.aspx");
                }
                else
                {
                    Generica.Mensaje(this, "Registro Modificado con éxito");
                    Modo = ModosDeTecleo.Grabar;
                }

            }catch(Exception ex)
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

        }

        protected void GrdBoletos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        public void Buscar()
        {
            try
            {
                VentaBoletos vb = new VentaBoletos();
                VentaBoletos.IdBoleto = TxtBoleto.Text.Equals("") ? 0 : Convert.ToInt32(TxtBoleto.Text);
                vb.Clase = TxtClase.Text.Trim();
                vb.IdVuelo = Convert.ToInt32(CboVuelosProgramados.SelectedValue);
                GrdBoletos.DataSource = vb.Buscar();
                GrdBoletos.DataBind();
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
    }
}