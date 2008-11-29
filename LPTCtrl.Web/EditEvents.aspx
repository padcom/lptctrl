<%@ Page MasterPageFile="~/MasterPage.Master" Language="C#" AutoEventWireup="true" CodeBehind="EditEvents.aspx.cs" Inherits="LPTCtrl.Web.EditEvents" %>

<asp:Content ID="controls" runat="server" ContentPlaceHolderID="controls">
    <asp:Button ID="EventNew" runat="server" PostBackUrl="~/EditEvent.aspx" Text="New event" />
</asp:Content>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="main">
<center>
<br />
<div>
    <asp:GridView ID="EventsList" runat="server" Width="90%"
        DataSourceID="EventsDataSource" DataKeyNames="ID"
        AutoGenerateColumns="false"
        HeaderStyle-BackColor="#333399" HeaderStyle-ForeColor="White" 
        OnSelectedIndexChanged="EventsList_SelectedIndexChanged"
    ><Columns>
        <asp:TemplateField ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Bottom">
            <HeaderTemplate>
                Actions
            </HeaderTemplate>
            <ItemTemplate>
                <asp:ImageButton ID="DeleteEventButton" runat="server" ImageUrl="~/Images/delete.png" AlternateText="Delete this event"
                   CommandName="delete" 
                />
                &nbsp;
                <asp:ImageButton ID="EditEventButton" runat="server" ImageUrl="~/Images/edit.png" AlternateText="Edit this event"
                   CommandName="select"
                />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
            <HeaderTemplate>
                Timestamp
            </HeaderTemplate>
            <ItemTemplate>
                <asp:Label ID="EventTimestampLabel" runat="server" Text='<%# Eval("Timestamp") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
            <HeaderTemplate>
                Output
            </HeaderTemplate>
            <ItemTemplate>
                <asp:Label ID="EventPinLabel" runat="server" Text='<%# Eval("Pin.Name") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
            <HeaderTemplate>
                State
            </HeaderTemplate>
            <ItemTemplate>
                <asp:Label ID="EventStateLabel" runat="server" Text='<%# ((bool)Eval("State")) ? "ON" : "OFF" %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
            <HeaderTemplate>
                Repeat
            </HeaderTemplate>
            <ItemTemplate>
                <asp:Label ID="EventRepeatIntervalLabel" runat="server" Text='<%# Eval("RepeatInterval") %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns></asp:GridView>
    
    <asp:ObjectDataSource ID="EventsDataSource" runat="server"
        TypeName="LPTCtrl.Web.DAO.EventDAO" DataObjectTypeName="LPTCtrl.Data.Domain.Event" 
        EnablePaging="True" 
        SelectMethod="FindAll" MaximumRowsParameterName="pageSize" StartRowIndexParameterName="startRow" SortParameterName="sortExpression"
        SelectCountMethod="CountAll" 
        DeleteMethod="Delete"
    >
    </asp:ObjectDataSource>
</div>
<br />
</center>

</asp:Content>