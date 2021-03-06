<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmVuelosProgramados.aspx.cs" Inherits="AeroLinea.Forms.FrmVuelosProgramados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="PanelPrincipal" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>Vuelos Programados</h1>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="box-body">
                    <asp:MultiView id="MultiView" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">  
                            <div class="row">
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="No. Vuelo" runat="server" />
                                        <asp:TextBox ID="TxtIdVuelo" runat="server" CssClass="form-control input-sm" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="Fecha" runat="server" />
                                        <asp:TextBox ID="TxtFecha" runat="server" CssClass="form-control input-sm" Width="100%" AutoPostBack="True" TextMode="Date"></asp:TextBox>
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
                                            <asp:GridView ID="GrdVuelos" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnSelectedIndexChanged="GrdVuelos_SelectedIndexChanged" OnRowDeleting="GrdVuelos_RowDeleting">
                                                <Columns> 
                                                    <asp:BoundField DataField="NoVuelo" HeaderText="No. Vuelo" SortExpression="NoVuelo" />
                                                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                                                    <asp:BoundField DataField="Origen" HeaderText="Origen" SortExpression="Origen" />
                                                    <asp:BoundField DataField="Destino" HeaderText="Destino" SortExpression="Destino" />
                                                    <asp:BoundField DataField="Modelo" HeaderText="Modelo" SortExpression="Modelo" />
                                                    <asp:BoundField DataField="Boletos" HeaderText="Boletos Disponibles" SortExpression="Boletos" />
                                                    <asp:BoundField DataField="Compañia" HeaderText="Compañia" SortExpression="Compañia" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnVuelo" runat="server" Value='<%# Eval("IdVuelo") %>' />
                                                            <asp:HiddenField ID="HdnAvion" runat="server" Value='<%# Eval("IdAvion") %>' />
                                                            <asp:HiddenField ID="HdnOrigen" runat="server" Value='<%# Eval("IdOrigen") %>' />
                                                            <asp:HiddenField ID="HdnDestino" runat="server" Value='<%# Eval("IdDestino") %>' />
                                                            <asp:LinkButton ID="CmdVuelo" runat="server" CommandName="Select" CssClass="btn btn-primary btn-xs"><li class="fas fa-edit"></li></asp:LinkButton>
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
                                            <h3 class="card-title">Registro de Vuelos</h3>
                                        </center>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class=" form-group">
                                                    <asp:Label Text="Fecha" runat="server" />
                                                    <asp:TextBox ID="TxtFechaT" runat="server" CssClass="form-control input-sm" Width="100%" TextMode="Date" AutoPostBack="True" BackColor="#FFFF99"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class=" form-group">
                                                    <asp:Label Text="Avión" runat="server" />
                                                    <asp:DropDownList ID="CboAviones" runat="server" CssClass="form-control select2" Width="100%" BackColor="#FFFF99"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class=" form-group">
                                                    <asp:Label Text="Ciudad Origen" runat="server" />
                                                    <asp:DropDownList ID="CboCiudadesO" runat="server" CssClass="form-control select2" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="CboCiudadesO_SelectedIndexChanged" BackColor="#FFFF99"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class=" form-group">
                                                    <asp:Label Text="Ciudad Destino" runat="server" />
                                                    <asp:DropDownList ID="CboCiudadesD" runat="server" CssClass="form-control select2" Width="100%" BackColor="#FFFF99"></asp:DropDownList>
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
