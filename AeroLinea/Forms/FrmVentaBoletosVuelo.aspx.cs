using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AeroLinea.Forms
{
    public partial class FrmVentaBoletosVuelo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                MultiView.SetActiveView(ViewFiltro);
            }
        }
    }
}