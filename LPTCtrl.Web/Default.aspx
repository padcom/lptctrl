<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LPTCtrl.Web._Default" %>

<%@ Register src="Components/PinStatusViewer.ascx" tagname="PinStatusViewer" tagprefix="lptctrl" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="main">
    <br />
    <center>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="UpdateTimer" runat="server" OnTick="UpdateTimer_Tick" Interval="10000" />
                <table border="1" style="border-collapse:collapse;" width="90%">
                    <tr style="color:White;background-color:#333399;">
                        <td style="width: 50px; text-align: center; font-weight: bolder">Bit</td>
                        <td style="width: 350px; text-align: center; font-weight: bolder">Name</td>
                        <td style="text-align: center; font-weight: bolder">Status</td>
                        <td style="text-align: center; font-weight: bolder">Action</td>
                    </tr>
                    <lptctrl:PinStatusViewer ID="Pin0" runat="server" OnTogglePin="TogglePin0" />
                    <lptctrl:PinStatusViewer ID="Pin1" runat="server" OnTogglePin="TogglePin1" />
                    <lptctrl:PinStatusViewer ID="Pin2" runat="server" OnTogglePin="TogglePin2" />
                    <lptctrl:PinStatusViewer ID="Pin3" runat="server" OnTogglePin="TogglePin3" />
                    <lptctrl:PinStatusViewer ID="Pin4" runat="server" OnTogglePin="TogglePin4" />
                    <lptctrl:PinStatusViewer ID="Pin5" runat="server" OnTogglePin="TogglePin5" />
                    <lptctrl:PinStatusViewer ID="Pin6" runat="server" OnTogglePin="TogglePin6" />
                    <lptctrl:PinStatusViewer ID="Pin7" runat="server" OnTogglePin="TogglePin7" />
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </center>
    <br />
</asp:Content>
