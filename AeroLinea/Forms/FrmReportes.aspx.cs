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
using System.Data;

namespace AeroLinea.Negocio
{
    public partial class FrmReportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GenerarReporte();
            } 
        }

        public void GenerarReporte()
        {
            try
            {
                VentaBoletos vb = new VentaBoletos();
                DataTable tbl;

                string Path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
                string Fullpath = Path + "\\Reportes\\RptBoletosVendidos.rdlc";
                if (!File.Exists(Fullpath))
                {
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reportes/RptBoletosVendidos.rdlc");
                    ReportViewer1.LocalReport.DataSources.Clear();
                    tbl = vb.RptBoletos();
                    ReportDataSource rp = new ReportDataSource("DtBoletos", tbl);
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