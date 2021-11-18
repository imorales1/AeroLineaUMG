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
    public partial class FrmPaises : System.Web.UI.Page
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
                    LlenarCombos();
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void LlenarCombos()
        {
            try
            {
                Generica combo = new Generica();
                combo.LLenarCombos(ref CboPaisesF);
                combo.LLenarCombos(ref CboPaisesT);
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

        protected void CmdBuscar_Click(object sender, EventArgs e)
        {
            Buscar();
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

        protected void CmdCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewFiltro);
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
                Ciudades cd = new Ciudades();
                cd.IdPais = Convert.ToInt32(CboPaisesF.SelectedValue);
                cd.Nombre = TxtCiudadF.Text;
                GrdCiudades.DataSource = cd.Buscar();
                GrdCiudades.DataBind();
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

    }
}