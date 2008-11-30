<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="EditEvent.aspx.cs" Inherits="LPTCtrl.Web.EditEvent" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="main">
    <br />
    <center><div>
        <table border="0">
            <tr>
                <td style="width: 150px">Output</td>
                <td>
                    <asp:DropDownList ID="EventOutput" runat="server" Width="174px" />
                </td>
            </tr>
            <tr>
                <td>Timestamp</td>
                <td>
                    <asp:TextBox ID="EventTimestamp" runat="server" Width="170px"/>
                    <asp:CustomValidator ID="TimestampValidator" runat="server" ControlToValidate="EventTimestamp" Enabled="true" OnServerValidate="TimestampValidator_Validate" ValidateEmptyText="true" Text="Invalid date/time" />
                </td>
            </tr>
            <tr>
                <td>State</td>
                <td>
                    <asp:DropDownList ID="EventState" runat="server" Width="174px">
                        <asp:ListItem Text="ON" Value="true" />
                        <asp:ListItem Text="OFF" Value="false" />
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Repeat interval</td>
                <td>
                    <asp:DropDownList ID="EventRepeatInterval" runat="server" Width="174px">
                        <asp:ListItem Text="One time event" Value="0" />
                        <asp:ListItem Text="Every day" Value="1" />
                        <asp:ListItem Text="Every two days" Value="2" />
                        <asp:ListItem Text="Every week" Value="7" />
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="EventSave" runat="server" OnClick="EventSave_Click" Text="Save" />
        <asp:Button ID="EventCancel" runat="server" OnClick="EventCancel_Click" Text="Cancel" />
    </div></center>
<br />
</asp:Content>
