<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditEvents.aspx.cs" Inherits="LPTCtrl.Web.EditEvents" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>LPTCtrl - an intelligent home system</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="1">
            <asp:DataList ID="EventsList" runat="server" 
                DataSourceID="EventsDataSource" DataKeyField="ID"
                OnDeleteCommand="DeleteEventButton_Click"
            >
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="DeleteEventButton" runat="server" Text="delete" Command="delete" />
                        </td>
                        <td>
                            <asp:LinkButton ID="EditEventButton" runat="server" Text="edit" 
                                OnCommand="EditEventButton_Click" CommandArgument='<%# Eval("ID") %>' 
                            />
                        </td>
                        <td>          
                            <asp:Label ID="EventTimestampLabel" runat="server" Text='<%# Eval("Timestamp") %>' />
                        </td>
                        <td>
                            <asp:Label ID="EventPinLabel" runat="server" Text='<%# Eval("Pin.Name") %>' />
                        <td>
                        <td>
                            <asp:Label ID="EventRepeatIntervalLabel" runat="server" Text='<%# Eval("RepeatInterval") %>' />
                        <td>
                    </tr>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EventStateTextBox" runat="server" Text='<%# Bind("State") %>' />
                </EditItemTemplate>
            </asp:DataList>
        </table>
    </div>
    <asp:ObjectDataSource ID="EventsDataSource" runat="server"
        TypeName="LPTCtrl.Web.DAO.EventDAO" DataObjectTypeName="LPTCtrl.Data.Domain.Event" 
        SelectMethod="FindAll"
        SelectCountMethod="CountAll" 
        EnablePaging="True" MaximumRowsParameterName="pageSize" StartRowIndexParameterName="startRow" SortParameterName="sortExpression"
    >
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PinDataSource" runat="server"
        TypeName="LPTCtrl.Web.DAO.PinDAO" DataObjectTypeName="LPTCtrl.Data.Domain.Pin" 
        SelectMethod="FindAll"
        SelectCountMethod="CountAll" 
        EnablePaging="True" MaximumRowsParameterName="pageSize" StartRowIndexParameterName="startRow" SortParameterName="sortExpression"
    >
    </asp:ObjectDataSource>
    </form>
</body>
</html>
