<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FrmVentaBoletosVuelo.aspx.cs" Inherits="AeroLinea.Forms.FrmVentaBoletosVuelo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    r<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="PanelPrincipal" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>Boletos Vendidos</h1>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="box-body">
                    <asp:MultiView id="MultiView" runat="server">
                        <asp:View ID="ViewFiltro" runat="server">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="Fecha Inicial" runat="server" />
                                        <asp:TextBox ID="TxtFechaInicial" runat="server" CssClass="form-control input-sm" Width="100%" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="Fecha Final" runat="server" />
                                        <asp:TextBox ID="TxtFechaFinal" runat="server" CssClass="form-control input-sm" Width="100%" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="No. Boleto" runat="server" />
                                        <asp:TextBox ID="TxtBoleto" runat="server" CssClass="form-control input-sm" Width="100%" ></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <asp:Label Text="Clase" runat="server" />
                                        <asp:TextBox ID="TxtClase" runat="server" CssClass="form-control input-sm" Width="100%" ></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label Text="No. Vuelo" runat="server" />
                                        <asp:DropDownList ID="CboVuelosProgramados" runat="server" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label Text="Boletos Disponibles" runat="server" />
                                        <asp:TextBox ID="TxtCantidadBoletos" runat="server" CssClass="form-control input-sm" Width="100%" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6"></div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdBuscar" runat="server" CssClass="btn btn-default" Width="100%" OnClick="CmdBuscar_Click"><li class="fa fa-search">Buscar</li></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <asp:LinkButton ID="CmdReporte" Text="text" runat="server" CssClass="btn btn-success" Width="100%" OnClick="CmdReporte_Click"><li class="far fa-file-pdf"> Generar Reporte</li></asp:LinkButton>
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
                                            <h3 class="card-title">Boletos</h3>
                                        </div>
                                        <div class="card-body table-responsive">
                                            <asp:GridView ID="GrdBoletos" runat="server" CssClass="table table-bordered table-condensed" AutoGenerateColumns="False" OnRowDeleting="GrdBoletos_RowDeleting" OnSelectedIndexChanged="GrdBoletos_SelectedIndexChanged">
                                                <Columns> 
                                                    <asp:BoundField DataField="NoVuelo" HeaderText="No. Vuelo" SortExpression="NoVuelo" />
                                                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                                                    <asp:BoundField DataField="Boleto" HeaderText="Boleto" SortExpression="Boleto" />
                                                    <asp:BoundField DataField="Clase" HeaderText="Clase" SortExpression="Clase" />
                                                    <asp:BoundField DataField="Compañia" HeaderText="Compañia" SortExpression="Compañia" />
                                                    <asp:BoundField DataField="Modelo" HeaderText="Avión" SortExpression="Modelo" />
                                                    <asp:BoundField DataField="Asiento" HeaderText="No. Asiento" SortExpression="Asiento" />
                                                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                                                    <asp:BoundField DataField="Costo" HeaderText="Costo" SortExpression="Vuelo" />
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HdnBoleto" runat="server" Value='<%# Eval("IdBoleto") %>' />
                                                            <asp:HiddenField ID="HdnVuelo" runat="server" Value='<%# Eval("IdVuelo") %>' />
                                                            <asp:HiddenField ID="HdnCliente" runat="server" Value='<%# Eval("IdCliente") %>' />
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
                                        <div class="card-footer clearfix">
                                        <asp:Label ID="LblRegistros" Text="" runat="server" />
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="ViewTecleo" runat="server">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card card-primary">
                                        <div class="card-header">
                                            <center>
                                            <h3 class="card-title">Registro de Vuelos</h3>
                                        </center>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <div class=" form-group">
                                                        <asp:Label Text="Clase" runat="server" />
                                                        <asp:TextBox ID="TxtClaseT" runat="server" CssClass="form-control input-sm" Width="100%" BackColor="#FFFFCC"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class=" form-group">
                                                        <asp:Label Text="No. Asiento" runat="server" />
                                                        <asp:TextBox ID="TxtAsientoT" runat="server" CssClass="form-control input-sm" Width="100%" BackColor="#FFFFCC" MaxLength="2" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class=" form-group">
                                                        <asp:Label Text="Costo" runat="server" />
                                                        <asp:TextBox ID="TxtCostoT" runat="server" CssClass="form-control input-sm" Width="100%" BackColor="#FFFFCC" MaxLength="5" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class=" form-group">
                                                        <asp:Label Text="Vuelo" runat="server" />
                                                        <asp:DropDownList ID="CboVuelosProgramadosT" runat="server" CssClass="form-control select2" Width="100%" BackColor="#FFFFCC"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class=" form-group">
                                                        <asp:Label Text="Cliente" runat="server" />
                                                        <asp:TextBox ID="TxtCliente" runat="server" CssClass="form-control select2" Width="100%" BackColor="#FFFFCC" AutoPostBack="true" OnTextChanged="TxtCliente_TextChanged1" MaxLength="3" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class=" form-group">
                                                        <asp:Label Text="Nombre" runat="server" />
                                                        <asp:TextBox ID="TxtNombreCLiente" runat="server" CssClass="form-control select2" Width="100%" Enabled="false" BackColor="#99FFCC"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <asp:LinkButton ID="CmdGrabarModificar" runat="server" CssClass="btn btn-primary" Width="100%" OnClick="CmdGrabarModificar_Click"><li class="fa fa-save">Grabar</li></asp:LinkButton>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <asp:LinkButton ID="CmdCancelar" runat="server" CssClass="btn btn-danger" Width="100%" OnClick="CmdCancelar_Click">Cancelar</asp:LinkButton>
                                                    </div>
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
        <%--<Triggers>
            <asp:PostBackTrigger ControlID="CmdReporte" />
        </Triggers>--%>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContenScriptBody" runat="server">
    
</asp:Content>
