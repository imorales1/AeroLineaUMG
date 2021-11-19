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
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView.SetActiveView(ViewFiltro);
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
    }
}