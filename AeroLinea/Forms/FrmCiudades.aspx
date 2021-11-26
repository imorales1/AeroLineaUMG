<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmCiudades.aspx.cs" Inherits="AeroLinea.Forms.FrmPaises" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="PanelPrincipal" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>Ciudades</h1>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="box-body">
                    <asp:MultiView id="MultiView" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">
                            <div class="row">
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="Ciudad" runat="server" />
                                        <asp:TextBox ID="TxtCiudadF" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="País" runat="server" />
                                        <asp:DropDownList ID="CboPaisesF" runat="server" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%" OnClick="CmdBuscar_Click"><li class="fa fa-search">Buscar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdExportar" Text="text" runat="server" CssClass="btn btn-success" Width="100%" OnClick="CmdExportar_Click" ><li class="fa fa-file-excel">Exportar</li></asp:LinkButton>
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
                                            <h3 class="card-title">Ciudades</h3>
                                        </div>
                                        <div class="card-body table-responsive">
                                            <asp:GridView ID="GrdCiudades" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnSelectedIndexChanged="GrdCiudades_SelectedIndexChanged" OnRowDeleting="GrdCiudades_RowDeleting">
                                                <Columns>
                                                    <asp:BoundField DataField="Pais" HeaderText="País" SortExpression="Pais" />
                                                    <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" SortExpression="Ciudad" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnCiudad" runat="server" Value='<%# Eval("IdCiudad") %>' />
                                                            <asp:HiddenField ID="HdnPais" runat="server" Value='<%# Eval("IdPais") %>' />
                                                            <asp:LinkButton ID="CmdPais" runat="server" CommandName="Select" CssClass="btn btn-primary btn-xs"><li class="fas fa-edit"></li></asp:LinkButton>
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
                            <div class="col-md-12">
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <center>
                                            <h3 class="card-title">Registro de Ciudades</h3>
                                        </center>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class=" form-group">
                                                    <asp:Label Text="Nombre" runat="server" />
                                                    <asp:TextBox ID="TxtCiudadT" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class=" form-group">
                                                    <asp:Label Text="País" runat="server" />
                                                    <asp:DropDownList ID="CboPaisesT" runat="server" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>                          
                                    </div>
                                    <div class="card-footer">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <asp:LinkButton ID="CmdGrabarModificar" runat="server" CssClass="btn btn-primary" Width="100%" OnClick="CmdGrabarModificar_Click" ><li class="fa fa-save">Grabar</li></asp:LinkButton>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <asp:LinkButton ID="CmdCancelar" runat="server" CssClass="btn btn-danger" Width="100%" OnClick="CmdCancelar_Click" >Cancelar</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </asp:View>
                    </asp:MultiView>
                </div>
                </div>
            </section>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="CmdExportar" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
</asp:Content>
