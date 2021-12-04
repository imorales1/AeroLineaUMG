<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmBoletos.aspx.cs" Inherits="AeroLinea.Forms.FrmBoletos" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <center>
        <br /><br /><br />
        <br /><br /><br />
        <form id="form1" runat="server">
        <div style="width: 800px">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="750px">
            </rsweb:ReportViewer>
        </div>
    </form>
    </center>
</body>
</html>
