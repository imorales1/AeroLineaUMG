using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    Multiview.SetActiveView(ViewFiltro);
                }
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }
    }
}