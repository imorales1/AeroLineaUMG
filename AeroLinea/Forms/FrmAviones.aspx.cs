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
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
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
                an.Modelo = TxtModelo.Text;
                an.IdCompañia = Convert.ToInt32(CboCompañiasT.SelectedValue);
                an.GrabarModificar();
                Helper.Generica.Mensaje(this, "Registro Grabado con Éxito");
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
                
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, "Limpiar Campos");
            }
        }
    }
}