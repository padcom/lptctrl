<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LPTCtrl.Web._Default" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="main">
    <br />
<center><asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
    <asp:Timer ID="UpdateTimer" runat="server" OnTick="UpdateTimer_Tick" Interval="10000" />
    
    <table border="1" style="border-collapse:collapse;" width="90%">
        <tr style="color:White;background-color:#333399;">
            <td style="width: 50px; text-align: center; font-weight: bolder">Bit</td>
            <td style="width: 350px; text-align: center; font-weight: bolder">Name</td>
            <td style="text-align: center; font-weight: bolder">Status</td>
            <td style="text-align: center; font-weight: bolder">Action</td>
        </tr>
        <tr>
            <td align="center">0</td>
            <td><asp:Label ID="PIN0" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN0Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN0Toggle" runat="server" OnClick="TogglePin0" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">1</td>
            <td><asp:Label ID="PIN1" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN1Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN1Toggle" runat="server" OnClick="TogglePin1" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">2</td>
            <td><asp:Label ID="PIN2" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN2Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN2Toggle" runat="server" OnClick="TogglePin2" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">3</td>
            <td><asp:Label ID="PIN3" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN3Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN3Toggle" runat="server" OnClick="TogglePin3" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">4</td>
            <td><asp:Label ID="PIN4" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN4Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN4Toggle" runat="server" OnClick="TogglePin4" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">5</td>
            <td><asp:Label ID="PIN5" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN5Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN5Toggle" runat="server" OnClick="TogglePin5" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">6</td>
            <td><asp:Label ID="PIN6" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN6Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN6Toggle" runat="server" OnClick="TogglePin6" Text="Toggle" /></td>
        </tr>
        <tr>
            <td align="center">7</td>
            <td><asp:Label ID="PIN7" runat="server" Width="99%" /></td>
            <td align="center"><asp:Label ID="PIN7Status" runat="server" Text="(...)"/></td>
            <td align="center"><asp:Button ID="PIN7Toggle" runat="server" OnClick="TogglePin7" Text="Toggle" /></td>
        </tr>
    </table>
</ContentTemplate></asp:UpdatePanel></center>
<br />
</asp:Content>
