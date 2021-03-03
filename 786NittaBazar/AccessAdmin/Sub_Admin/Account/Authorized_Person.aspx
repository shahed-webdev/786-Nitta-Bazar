<%@ Page Title="Authorized Person" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Authorized_Person.aspx.cs" Inherits="NittaBazar.AccessAdmin.Sub_Admin.Account.Authorized_Person" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Account authorized person</h3>

    <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="AccountSQL" DataKeyNames="RegistrationID">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
            <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:TemplateField HeaderText="Authority" SortExpression="IS_Authority">
                <ItemTemplate>
                    <asp:CheckBox ID="Authority_CheckBox" runat="server" Checked='<%# Bind("IS_Authority") %>' Text=" " AutoPostBack="True" OnCheckedChanged="Authority_CheckBox_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
           Empty
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.RegistrationID,Registration.Name + '(' + Registration.UserName + ')' AS Name, Registration.UserName,Registration.Phone,Registration.Email,cast(case when Sub_Recharge_Authority_List.Recharge_Authority_ListID IS NULL then 0 else 1 end as bit) as IS_Authority FROM Registration LEFT OUTER JOIN Sub_Recharge_Authority_List ON Registration.RegistrationID = Sub_Recharge_Authority_List.Authority_RegistrationID WHERE (Registration.Category = 'Sub-Admin') AND (Registration.Validation = 'Valid') AND (Registration.RegistrationID NOT IN (SELECT SubAdmin_RegistrationID FROM Sub_Admin_Account))" DeleteCommand="DELETE FROM Sub_Recharge_Authority_List WHERE (Authority_RegistrationID = @Authority_RegistrationID)" InsertCommand="INSERT INTO Sub_Recharge_Authority_List(Authority_RegistrationID) VALUES (@Authority_RegistrationID)">
        <DeleteParameters>
            <asp:Parameter Name="Authority_RegistrationID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Authority_RegistrationID" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
