<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="EditPins.aspx.cs" Inherits="LPTCtrl.Web.EditPins" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="controls" runat="server" ContentPlaceHolderID="controls">
    <asp:Button ID="SaveButton" runat="server" OnClick="SaveButton_Click" Text="Save pins" />
</asp:Content>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="main">
<br />
<center>
    <table border="1" style="border-collapse:collapse;" width="70%">
        <tr style="color:White;background-color:#333399;">
            <td style="width: 50px; text-align: center; font-weight: bolder">Bit</td>
            <td style="width: 250px; text-align: center; font-weight: bolder">Name</td>
        </tr>
        <tr>
            <td align="center">0</td>
            <td><asp:TextBox ID="PIN0" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">1</td>
            <td><asp:TextBox ID="PIN1" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">2</td>
            <td><asp:TextBox ID="PIN2" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">3</td>
            <td><asp:TextBox ID="PIN3" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">4</td>
            <td><asp:TextBox ID="PIN4" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">5</td>
            <td><asp:TextBox ID="PIN5" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">6</td>
            <td><asp:TextBox ID="PIN6" runat="server" Width="99%" /></td>
        </tr>
        <tr>
            <td align="center">7</td>
            <td><asp:TextBox ID="PIN7" runat="server" Width="99%" /></td>
        </tr>
    </table>
</center>
<br />
</asp:Content>