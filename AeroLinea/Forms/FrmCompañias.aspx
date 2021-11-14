<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmCompañias.aspx.cs" Inherits="AeroLinea.Forms.FrmCompañias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpPrincipal" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>Compañías</h1>
            </section>
            <section class="content">
                <div class="box-body">
                    <asp:MultiView ID="MultiView" runat="server">
                        <asp:View ID="ViewBusqueda" runat="server">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label runat="server">Criterio de Busqueda</asp:Label>
                                        <asp:TextBox runat="server" ID="TxtCriterioBusqueda" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4"></div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%" OnClick="CmdBuscar_Click"><li class="fa fa-search">Buscar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdExportar" runat="server" CssClass="btn btn-primary" Width="100%">Grabar Nuevo</asp:LinkButton>
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
                                            <asp:GridView ID="GrdCompañias" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                                                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" SortExpression="Direccion" />
                                                    <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Corre" />
                                                    <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnCompañia" runat="server" Value='<%Eval("IdCompañia") %>' />
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

                        </asp:View>
                    </asp:MultiView>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
</asp:Content>
