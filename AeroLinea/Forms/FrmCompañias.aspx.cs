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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                MultiView.SetActiveView(ViewBusqueda);
            }
        }

        protected void CmdBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                Compañias comp = new Compañias();
                comp.CriterioBusqueda = TxtCriterioBusqueda.Text;
                GrdCompañias.DataSource = comp.Buscar();
                GrdCompañias.DataBind();
            }catch(Exception ex)
            {

            }
        }

        protected void CmdAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                MultiView.SetActiveView(ViewTecleo);
            }
            catch (Exception ex)
            {
                throw;
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
    }
}