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
                                    <asp:Label ID="lblError" runat="server" />
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
            </div>
            </form>
    </div>
</body>
</html>
