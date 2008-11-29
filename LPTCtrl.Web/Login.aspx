<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LPTCtrl.Web.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div><center>
        <br /><br />
        <table>
            <tr>
                <td>Username:</td>
                <td><asp:TextBox ID="Username" runat="server" Text="" /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><asp:TextBox ID="Password" runat="server" Text="" TextMode="Password" /></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="LoginButton" runat="server" OnClick="LoginButton_Click" Text="Login" />
                </td>
            </tr>
            <tr>
                <td colspan="2"><asp:Label ID="MessageLabel" runat="server" Text="" /></td>
            </tr>
        </table>
    </center></div>
    </form>
</body>
</html>
