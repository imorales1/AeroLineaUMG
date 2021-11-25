using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClosedXML.Excel;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI;
using AeroLinea.Db;
using System.Security.Cryptography;
using System.Text;

namespace AeroLinea.Helper
{
    public class Generica
    {
        public static void ExportExcel(GridView gridView, HttpResponse response)
        {
            try
            {
                string SpaceBlankHtml = "&nbsp;";

                DataTable dt = new DataTable();
                int NCol = gridView.HeaderRow.Cells.Count;
                int NRow = gridView.Rows.Count;
                int NColDt = 0;
                for (int i = 0; i < NCol; i++)
                {
                    if (gridView.HeaderRow.Cells[i].Text != SpaceBlankHtml)
                    {
                        dt.Columns.Add(HttpUtility.HtmlDecode(gridView.HeaderRow.Cells[i].Text));
                    }
                }
                NColDt = dt.Columns.Count;
                for (int fila = 0; fila < NRow; fila++)
                {
                    DataRow row = dt.NewRow();
                    for (int col = 0; col < NColDt; col++)
                    {
                        if (gridView.Rows[fila].Cells[col].Controls.Count == 0)
                        {
                            if (gridView.Rows[fila].Cells[col].Text != SpaceBlankHtml)
                            {
                                row[col] = HttpUtility.HtmlDecode(gridView.Rows[fila].Cells[col].Text);
                            }
                            else
                            {
                                row[col] = "";
                            }

                        }
                        else
                        {
                            row[col] = "";
                        }
                    }
                    dt.Rows.Add(row);
                }

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt, "Datos");

                    response.Clear();
                    response.Buffer = true;
                    response.Charset = "";
                    response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    response.AddHeader("content-disposition", "attachment;filename=Reporte.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(response.OutputStream);
                        response.Flush();
                        response.End();
                    }

                }

            }
            catch (Exception)
            {
                throw;
            }
        }

        public enum ModoDeTecleo
        {
            Grabar = 1,
            Modificar = 2
        }

        public static void MensajeGrabar(Page pagina)
        {
            try
            {
                ScriptManager.RegisterStartupScript(pagina, pagina.GetType(), "Pop", "RegistroGrabadoToasTR();", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static void Mensaje(Page pagina, string Mensaje)
        {
            try
            {
                ScriptManager.RegisterStartupScript(pagina, pagina.GetType(), "Pop", "Mensaje('" + Mensaje + "');", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static bool ValidarTextBox(ref TextBox control)
        {
            try
            {
                if (control.Text.Equals(""))
                {
                    control.Focus();
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void LLenarCombos(ref DropDownList control)
        {
            try
            {
                DataTable table;
                CombosDal combo = new CombosDal();

                switch (control.ID.ToString())
                {
                    case "CboCompañiasF":
                    case "CboCompañiasT":
                        table = combo.ObtenerCompañias();
                        break;
                    case "CboPaisesF":
                    case "CboPaisesT":
                        table = combo.ObtenerPaises();
                        break;
                    case "CboRoles":
                        table = combo.ObtenerRoles();
                        break;
                    default:
                        table = null;
                        break;
                }

                control.DataSource = table;
                control.DataTextField = "Descripcion";
                control.DataValueField = "ID";
                control.DataBind();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static string EncriptarContraseña(string pass)
        {
            try
            {
                SHA256 cifrar = SHA256Managed.Create();
                ASCIIEncoding encoding = new ASCIIEncoding();
                byte[] stream = null;
                StringBuilder sb = new StringBuilder();
                stream = cifrar.ComputeHash(encoding.GetBytes(pass));
                for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
                return sb.ToString();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}