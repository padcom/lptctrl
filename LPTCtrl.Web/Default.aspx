<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LPTCtrl.Web._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ObjectDataSource ID="EventsDataSource" runat="server"
            TypeName="LPTCtrl.Web.DAO.EventDAO" DataObjectTypeName="LPTCtrl.Data.Domain.Event" 
            SelectMethod="FindAll"
            SelectCountMethod="CountAll" 
            InsertMethod="Save" 
            UpdateMethod="SaveOrUpdate"
            DeleteMethod="Delete" 
        >
        </asp:ObjectDataSource>
        <asp:GridView ID="GridView1" runat="server"
            DataSourceID="EventsDataSource" AutoGenerateColumns="False"
        >
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                <asp:BoundField DataField="Timestamp" HeaderText="Timestamp" SortExpression="Timestamp" />
                <asp:BoundField DataField="RepeatInterval" HeaderText="RepeatInterval" SortExpression="RepeatInterval" />
                <asp:CheckBoxField DataField="State" HeaderText="State" SortExpression="State" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
