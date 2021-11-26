using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AeroLinea.Helper;

namespace AeroLinea.Forms
{
    public partial class FrmVuelosProgramados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView.SetActiveView(ViewFiltro);
                }
            }
            catch(Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void CmdExportar_Click(object sender, EventArgs e)
        {

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

        protected void GrdCiudades_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GrdCiudades_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}