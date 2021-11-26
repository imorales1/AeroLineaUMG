using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Negocio;

namespace AeroLinea.Forms
{
    public partial class FrmAviones : System.Web.UI.Page
    {
        private static ModoDeTecleo Modo;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    Modo = ModoDeTecleo.Grabar;
                    MultiView.SetActiveView(ViewFiltro);
                    LLenarCombos();
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

        protected void CmdExportar_Click(object sender, EventArgs e)
        {
            try
            {
                if(GrdAeroNaves.Rows.Count > 0)
                {
                    Helper.Generica.ExportExcel(GrdAeroNaves, Response);
                }
                else
                {
                    Helper.Generica.Mensaje(this, "No hay datos para Exportar");
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, "Agregar");
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                AeroNaves an = new AeroNaves();
                an.Turbinas = Convert.ToInt32(TxtTurbinas.Text);
                an.Pasajeros = Convert.ToInt32(TxtAsientos.Text);
                an.Peso = Convert.ToDecimal(TxtPeso.Text);
                an.Modelo = TxtModeloT.Text;
                an.IdCompañia = Convert.ToInt32(CboCompañiasT.SelectedValue);
                an.GrabarModificar();

                if(Modo == ModoDeTecleo.Grabar)
                {
                    Helper.Generica.Mensaje(this, "Registro Grabado con Éxito");
                    LimpiarControles();
                }
                else
                {
                    Helper.Generica.Mensaje(this, "Registro Modificado con Éxito");
                    LimpiarControles();
                    AeroNaves.IdAvion = 0;
                    MultiView.SetActiveView(ViewFiltro);
                }
                
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            LimpiarControles();
            MultiView.SetActiveView(ViewFiltro);
        }

        private void LLenarCombos()
        {
            Helper.Generica combo = new Helper.Generica();
            combo.LLenarCombos(ref CboCompañiasF);
            combo.LLenarCombos(ref CboCompañiasT);
        }
        private void Buscar()
        {
            try
            {
                AeroNaves an = new AeroNaves();
                an.IdCompañia = Convert.ToInt32(CboCompañiasF.SelectedValue);
                an.Turbinas = TxtTurbinas.Text.Equals("")? 0 : Convert.ToInt32(TxtTurbinas.Text);
                an.Modelo = TxtModelo.Text;
                GrdAeroNaves.DataSource = an.Buscar();
                GrdAeroNaves.DataBind();
                LblRegistros.Text = "Registros Encontrados:" + GrdAeroNaves.Rows.Count.ToString();
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void LimpiarControles()
        {
            try
            {
                CboCompañiasT.SelectedValue = "0";
                TxtTurbinas.Text = string.Empty;
                TxtAsientos.Text = string.Empty;
                TxtPeso.Text = string.Empty;
                TxtModeloT.Text = string.Empty;
                Buscar();
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, "Limpiar Campos");
            }
        }

        protected void GrdAeroNaves_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                CboCompañiasT.SelectedValue = ((HiddenField)GrdAeroNaves.SelectedRow.Cells[5].FindControl("HdnIdCompañia")).Value.ToString();
                TxtTurbinas.Text = GrdAeroNaves.SelectedRow.Cells[1].Text;
                TxtAsientos.Text = GrdAeroNaves.SelectedRow.Cells[2].Text;
                TxtPeso.Text = GrdAeroNaves.SelectedRow.Cells[3].Text;
                TxtModeloT.Text = GrdAeroNaves.SelectedRow.Cells[4].Text.Equals("&nbsp;")? string.Empty : GrdAeroNaves.SelectedRow.Cells[4].Text;
                AeroNaves.IdAvion = Convert.ToInt32(((HiddenField)GrdAeroNaves.SelectedRow.Cells[5].FindControl("HdnIdAvion")).Value);
                Modo = ModoDeTecleo.Modificar;
                MultiView.SetActiveView(ViewTecleo);
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, "SELECT");
            }
        }

        protected void GrdAeroNaves_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                AeroNaves an = new AeroNaves();
                AeroNaves.IdAvion = Convert.ToInt32(((HiddenField)GrdAeroNaves.Rows[e.RowIndex].Cells[5].FindControl("HdnIdAvion")).Value);
                an.Eliminar();
                Buscar();
                AeroNaves.IdAvion = 0;
            }catch(Exception ex)
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