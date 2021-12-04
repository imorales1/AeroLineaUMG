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
    public partial class FrmBoletos : System.Web.UI.Page
    {
        public int IdBoleto { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GenerarBoleto();
            }
        }

        public void GenerarBoleto()
        {
            try
            {
                VentaBoletos vb = new VentaBoletos();

                string Path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
                string Fullpath = Path + "\\Reportes\\RptBoletoVuelo.rdlc";
                if (!File.Exists(Fullpath))
                {
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reportes/RptBoletoVuelo.rdlc");
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportDataSource rp = new ReportDataSource("DataSet1", vb.Buscar());
                    ReportViewer1.LocalReport.DataSources.Add(rp);
                    ReportViewer1.DataBind();
                    ReportViewer1.LocalReport.Refresh();
                    ReportViewer1.Visible = true;
                }
                VentaBoletos.IdBoleto = 0;
            }
            catch (Exception ex)
            {
                Generica.Mensaje(this, ex.Message);
            }
        }
    }
}