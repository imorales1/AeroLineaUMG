<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmUsuarios.aspx.cs" Inherits="AeroLinea.Forms.FrmUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <%--<asp:UpdatePanel ID="PanelPrincipal" runat="server">
        <ContentTemplate>--%>
            <section class="content-header">
                <h1 ><b>Usuarios</b> </h1>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="box-body">
                    <asp:MultiView id="MultiView" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label Text="Criterio de Busqueda" runat="server" />
                                        <asp:TextBox ID="TxtCriterio" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%" OnClick="CmdBuscar_Click1"><li class="fa fa-search">Buscar</li></asp:LinkButton>
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
                                            <asp:GridView ID="GrdUsuarios" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnRowDeleting="GrdUsuarios_RowDeleting" OnSelectedIndexChanged="GrdUsuarios_SelectedIndexChanged" >
                                                <Columns>
                                                    <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                                                    <asp:BoundField DataField="Nombres" HeaderText="Nombre" SortExpression="Nombre" />
                                                    <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" SortExpression="Apellidos" />
                                                    <asp:BoundField DataField="Rol" HeaderText="Rol" SortExpression="Rol" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnIdUsuario" runat="server" Value='<%# Eval("IdUsuario") %>' />
                                                            <asp:LinkButton ID="CmdUsuario" runat="server" CommandName="Select" CssClass="btn btn-primary btn-xs"><li class="fas fa-edit"></li></asp:LinkButton>
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
                            <div class="register-page">
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <%--<div class="col-md-4">--%>
                                        <div class="card card-outline card-primary">
                                            <div class="card-header text-center">
                                                <h2><b>Registro de Usuarios</b></h2>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <%--<div class="col-md-3"></div>--%>
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <center>
                                                                <asp:Image ID="Image1" Cssclass="img-circle elevation-5" runat="server" Width="200"/>
                                                            </center>
                                                            <%--<br />--%>
                                                            <asp:Label Text="Elegir fotografia:" runat="server" />
                                                            <asp:FileUpload ID="fuploadImagen" accept=".jpg" runat="server" CssClass="form-control"/>
                                                            <%--<asp:Label runat="server" CssClass="form-control" />--%>
                                                            <%--<asp:TextBox ID="TxtNombreArchivo" runat="server" CssClass="form-control" Width="100"></asp:TextBox>--%>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4"></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class=" form-group">
                                                            <asp:Label Text="Nombres" runat="server" />
                                                            <asp:TextBox ID="TxtNombres" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class=" form-group">
                                                            <asp:Label Text="Apellidos" runat="server" />
                                                            <asp:TextBox ID="TxtApellidos" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class=" form-group">
                                                            <asp:Label Text="Usuario" runat="server" />
                                                            <asp:TextBox ID="TxtUsuario" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class=" form-group">
                                                            <asp:Label Text="Rol" runat="server" />
                                                            <asp:DropDownList ID="CboRoles" runat="server" CssClass="form-control" Width="100%"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:Panel ID="PnlContraseñas" runat="server">
                                                    <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <asp:Label Text="Contraseña" runat="server" />
                                                            <asp:TextBox ID="TxtContraseña" runat="server" CssClass="form-control input-sm" Width="100%" TextMode="Password" MaxLength="10"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <asp:Label Text="ConfirmarContraseña" runat="server" />
                                                            <asp:TextBox ID="TxtConfContraseña" runat="server" CssClass="form-control input-sm" Width="100%" TextMode="Password"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                </asp:Panel>
                                            </div>
                                            <div class="card-footer">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <asp:LinkButton ID="CmdGrabarModificar" runat="server" CssClass="btn btn-primary" Width="100%" OnClick="CmdGrabarModificar_Click"><li class="fa fa-save"> <b>Grabar</b></li></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <asp:LinkButton ID="CmdCancelar" runat="server" CssClass="btn btn-danger" Width="100%" OnClick="CmdCancelar_Click"> <b>Cancelar</b></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <%--</div>--%>
                                </div>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
                </div>
            </section>
        <%--</ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="CmdGrabarModificar"/>
        </Triggers>
    </asp:UpdatePanel>--%>
    <script type="text/javascript">
        $('.dropify').dropify();
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
</asp:Content>

