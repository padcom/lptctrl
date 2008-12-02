<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PinStatusViewer.ascx.cs" Inherits="LPTCtrl.Web.Components.PinStatusViewer" %>

<tr>
    <td align="center"><asp:Label ID="BitLabel" runat="server" /></td>
    <td><asp:Label ID="PinNameLabel" runat="server" Width="99%" /></td>
    <td align="center"><asp:Label ID="StateLabel" runat="server" Text="(...)"/></td>
    <td align="center"><asp:Button ID="Toggle" runat="server" OnClick="TogglePin_Click" Text="Toggle" /></td>
</tr>
