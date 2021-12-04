<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmReportes.aspx.cs" Inherits="AeroLinea.Negocio.FrmReportes" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <center>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div style="width: 900px">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="900px">
            </rsweb:ReportViewer>
        </div>
    </form>
    </center>
</body>
</html>
