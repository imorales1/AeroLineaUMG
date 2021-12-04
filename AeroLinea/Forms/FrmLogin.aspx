<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmLogin.aspx.cs" Inherits="AeroLinea.Forms.FrmLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="Content/AdminLTE-master/plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="../Content/AdminLTE-master/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="../Content/AdminLTE-master/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="../AdminLTE-master/plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../Content/AdminLTE-master/dist/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="Content/AdminLTE-master/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="../Content/AdminLTE-master/plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="../Content/AdminLTE-master/plugins/summernote/summernote-bs4.min.css">
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="https://jeremyfagis.github.io/dropify/dist/css/dropify.min.css">
</head>
<title></title>
</head>
<body class="login-page backbody">
    <div class="login-box">
        <form id="form1" runat="server">
            <div class="card card-outline card-primary">
                <div class="card-header text-center">
                    <h2>Inicio de sesión</h2>
                </div>
                <div class="card-body">
                    <div class="login-card-body">
                            <center><p>Registrese para iniciar sesión</p></center>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group input-sm">
                                    <asp:TextBox ID="TxtUsuario" runat="server" CssClass="form-control input-sm" PlaceHolder="Usuario"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="TxtContraseña" runat="server" CssClass="form-control input-sm" PlaceHolder="Contraseña" TextMode="Password" MaxLength="10"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblError" runat="server" CssClass="danger" ForeColor="#FF3300"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:LinkButton ID="CmdIngresar" runat="server" CssClass="btn btn-block btn-primary" OnClick="CmdIngresar_Click">Iniciar Sesión</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:LinkButton ID="CmdCancelar" runat="server" CssClass="btn btn-block btn-danger">Cancelar</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- jQuery -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/jquery/jquery.min.js") %>'></script>
            <!-- jQuery UI 1.11.4 -->
            <script src='<%= ResolveClientUrl("Content/AdminLTE-master/plugins/jquery-ui/jquery-ui.min.js") %>'></script>
            <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
            <script>
                $.widget.bridge('uibutton', $.ui.button)
            </script>
            <!-- Bootstrap 4 -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/bootstrap/js/bootstrap.bundle.min.js") %>'></script>
            <!-- ChartJS -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/chart.js/Chart.min.js") %>'></script>
            <!-- Sparkline -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/sparklines/sparkline.js") %>'></script>
            <!-- JQVMap -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/jqvmap/jquery.vmap.min.js") %>'></script>

            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/jqvmap/maps/jquery.vmap.usa.js") %>'></script>
            <!-- jQuery Knob Chart -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/jquery-knob/jquery.knob.min.js") %>'></script>
            <!-- daterangepicker -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/moment/moment.min.js") %>'></script>

            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/daterangepicker/daterangepicker.js") %>'></script>
            <!-- Tempusdominus Bootstrap 4 -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js") %>'></script>
            <!-- Summernote -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/summernote/summernote-bs4.min.js") %>'></script>
            <!-- overlayScrollbars -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js") %>'></script>
            <!-- AdminLTE App -->
            <script src='<%= ResolveClientUrl("~/Content/AdminLTE-master/dist/js/adminlte.js") %>'></script>
            
            <script src='<%= ResolveClientUrl("~/Scripts/bootbox.js") %>'></script>
            <script src='<%= ResolveClientUrl("~/Scripts/bootbox.locales.min.js") %>'></script>
            <script src='<%= ResolveClientUrl("~/Scripts/bootbox.min.js") %>'></script>
            <script src='<%= ResolveClientUrl("Scripts/toastr.min.js") %>'></script> 
            <script src='<%= ResolveClientUrl("https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js") %>'></script> 
            <script src='<%= ResolveClientUrl("https://jeremyfagis.github.io/dropify/dist/js/dropify.min.js") %>'></script>

            </div>
            </form>
    </div>
</body>
</html>
