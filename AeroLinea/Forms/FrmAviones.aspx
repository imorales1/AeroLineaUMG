<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmAviones.aspx.cs" Inherits="AeroLinea.Forms.FrmAviones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="PanelPrincipal" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>Aero Naves</h1>
            </section>
            <section class="content">
                <div class="box-body">
                    <asp:MultiView id="Multiview" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">
                            <div class="row">
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="No. Turbinas" runat="server" />
                                        <asp:TextBox ID="TxtNoTurbinas" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="No. Pasajeros" runat="server" />
                                        <asp:TextBox ID="TxtPasajeros" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="Peso" runat="server" />
                                        <asp:TextBox ID="TxtPeso" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label Text="Modelo" runat="server" />
                                        <asp:TextBox ID="TxtModelo" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%"><li class="fa fa-search">Buscar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdAgregar" runat="server" CssClass="btn btn-primary" Width="100%">Grabar Nuevo</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
</asp:Content>
