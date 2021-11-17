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
                <div class="container-fluid">
                    <div class="box-body">
                    <asp:MultiView id="MultiView" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="Compañia" runat="server" />
                                        <asp:DropDownList ID="CboCompañiasF" runat="server" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="No. Turbinas" runat="server" />
                                        <asp:TextBox ID="TxtNoTurbinas" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label Text="Modelo" runat="server" />
                                        <asp:TextBox ID="TxtModelo" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <%--<div class="col-md-1"></div>--%>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%" OnClick="CmdBuscar_Click"><li class="fa fa-search">Buscar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdExportar" Text="text" runat="server" CssClass="btn btn-success" Width="100%" OnClick="CmdExportar_Click"><li class="fa fa-file-excel">Exportar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdAgregar" runat="server" CssClass="btn btn-primary" Width="100%" OnClick="CmdAgregar_Click">Grabar Nuevo</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h3 class="card-title">Compañías</h3>
                                        </div>
                                        <div class="card-body table-responsive">
                                            <asp:GridView ID="GrdAeroNaves" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="Compañia" HeaderText="Compañia" SortExpression="Compañia" />
                                                    <asp:BoundField DataField="Turbinas" HeaderText="No. Turbinas" SortExpression="Turbinas" />
                                                    <asp:BoundField DataField="Pasajeros" HeaderText="No. Pasajeros" SortExpression="Pasajeros" />
                                                    <asp:BoundField DataField="Peso" HeaderText="Peso" SortExpression="Peso" />
                                                    <asp:BoundField DataField="Modelo" HeaderText="Modelo" SortExpression="Modelo" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnIdAvion" runat="server" Value='<%# Eval("IdCompañia") %>' />
                                                            <asp:LinkButton ID="CmdCompañia" runat="server" CommandName="Select" CssClass="btn btn-primary btn-xs"><li class="fas fa-edit"></li></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="CmdEliminar" runat="server" CausesValidation="false" CssClass="btn btn-danger btn-xs" CommandName="Delete"><li class="fa fa-trash"></li></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="card-footer clearfix">
                                        <asp:Label ID="LblRegistros" Text="" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="ViewTecleo" runat="server">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class=" form-group">
                                        <asp:Label Text="Compañia" runat="server" />
                                        <asp:DropDownList ID="CboCompañiasT" runat="server" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class=" form-group">
                                        <asp:Label Text="Turbinas" runat="server" />
                                        <asp:TextBox ID="TxtTurbinas" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class=" form-group">
                                        <asp:Label Text="Asientos" runat="server" />
                                        <asp:TextBox ID="TxtAsientos" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class=" form-group">
                                        <asp:Label Text="Peso" runat="server" />
                                        <asp:TextBox ID="TxtPeso" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class=" form-group">
                                        <asp:Label Text="Modelo" runat="server" />
                                        <asp:TextBox ID="TxtModeloT" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdGrabarModificar" runat="server" CssClass="btn btn-primary" Width="100%" OnClick="CmdGrabarModificar_Click"><li class="fa fa-save">Grabar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdCancelar" runat="server" CssClass="btn btn-danger" Width="100%" OnClick="CmdCancelar_Click">Cancelar</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
</asp:Content>
