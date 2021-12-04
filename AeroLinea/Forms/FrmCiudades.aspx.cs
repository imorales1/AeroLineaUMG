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
                    if(Session["Usuario"] != null)
                    {
                        Modo = ModoDeTecleo.Grabar;
                        MultiView.SetActiveView(ViewFiltro);
                        LlenarCombos();

                        if (Session["Rol"].ToString() != "OPR")
                        {
                            GrdCiudades.Columns[2].Visible = false;
                            GrdCiudades.Columns[3].Visible = false;
                            CmdAgregar.Enabled = false;
                        }
                    }
                    else
                    {
                        Response.Redirect("FrmLogin.aspx");
                    }
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
                LimpiarCampos();
                Modo = ModoDeTecleo.Grabar;
                Ciudades.IdCiudad = 0;
                Buscar();
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

        protected void GrdCiudades_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string[] DescripcionCiudad;
                DescripcionCiudad = GrdCiudades.SelectedRow.Cells[1].Text.Split('-');
                TxtCiudadT.Text = DescripcionCiudad[1];
                CboPaisesT.SelectedValue = ((HiddenField)GrdCiudades.SelectedRow.Cells[2].FindControl("HdnPais")).Value.ToString();
                Ciudades.IdCiudad = Convert.ToInt32(((HiddenField)GrdCiudades.SelectedRow.Cells[2].FindControl("HdnPais")).Value);
                Modo = ModoDeTecleo.Modificar;
                MultiView.SetActiveView(ViewTecleo);
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void GrdCiudades_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Ciudades cd = new Ciudades();
                Ciudades.IdCiudad = Convert.ToInt32(((HiddenField)GrdCiudades.Rows[e.RowIndex].Cells[2].FindControl("HdnCiudad")).Value);
                cd.Eliminar();
                Buscar();
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdGrabarModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Generica.ValidarTextBox(ref TxtCiudadT)) return;
                if (!Generica.ValidarCombo(ref CboPaisesT)) return;
                Ciudades cd = new Ciudades();
                cd.Nombre = TxtCiudadT.Text.Trim();
                cd.IdPais = Convert.ToInt32(CboPaisesT.SelectedValue);
                cd.GrabarModificar();
                
                if(Modo == ModoDeTecleo.Grabar)
                {
                    Helper.Generica.Mensaje(this, "Registro grabado con éxito");
                   
                }
                else
                {
                    Helper.Generica.Mensaje(this, "Registro modificaco con éxito");
                    Ciudades.IdCiudad = 0;
                    MultiView.SetActiveView(ViewFiltro);
                    Buscar();
                    Modo = ModoDeTecleo.Grabar;
                }

                LimpiarCampos();
            }
            catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        private void LimpiarCampos()
        {
            try
            {
                CboPaisesT.SelectedValue = "0";
                TxtCiudadT.Text = string.Empty;
            }catch(Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }

        protected void CmdExportar_Click(object sender, EventArgs e)
        {
            try
            {
                if (GrdCiudades.Rows.Count > 0)
                {
                    Helper.Generica.ExportExcel(GrdCiudades, Response);
                }
                else
                {
                    Helper.Generica.Mensaje(this, "No hay datos para Exportar");
                }
            }
            catch (Exception ex)
            {
                Helper.Generica.Mensaje(this, ex.Message);
            }
        }
    }
}