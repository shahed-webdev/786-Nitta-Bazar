<%@ Page Title="Approve Balance" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Approve_Amount_by_Code.aspx.cs" Inherits="NittaBazar.AccessAdmin.Sub_Admin.Account.Approve_Amount_by_Code" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Approve Balance</h3>
    <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="AccountSQL" DataKeyNames="Recharge_AuthorizationID">
        <Columns>
            <asp:TemplateField HeaderText="Recharge For" SortExpression="Reg_For">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Reg_For") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reg_For") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Recharge_Balance" HeaderText="Balance" SortExpression="Recharge_Balance" DataFormatString="{0:N}" />
            <asp:BoundField DataField="Recharge_Date" HeaderText="Recharge Date" SortExpression="Recharge_Date" DataFormatString="{0:d MMM yyyy}" />
            <asp:BoundField DataField="Reg_By" HeaderText="Recharge by" SortExpression="Reg_By" />
            <asp:BoundField DataField="Name" HeaderText="Authorized Person" SortExpression="Name" />
            <asp:TemplateField HeaderText="Code" SortExpression="Approved_Code">
                <ItemTemplate>
                    <asp:HiddenField ID="Code_HF" runat="server" Value='<%#Eval("Approved_Code") %>' />
                    <asp:TextBox ID="Code_TextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="form-control"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Sub_Recharge_Authorization.Recharge_AuthorizationID, Sub_Recharge_Authorization.Approved_Code, Sub_Admin_RechargeRecord.Recharge_Balance, Sub_Admin_RechargeRecord.Recharge_Date, RegFor_T.Name AS Reg_For, RegFor_T.Phone AS Reg_For_Phone, RegBy_T.Name AS Reg_By, Registration.Name, Registration.UserName FROM Sub_Admin_Account INNER JOIN Sub_Recharge_Authorization INNER JOIN Sub_Admin_RechargeRecord ON Sub_Recharge_Authorization.Sub_Admin_RechargeRecordID = Sub_Admin_RechargeRecord.Sub_Admin_RechargeRecordID ON Sub_Admin_Account.SubAdminAccountID = Sub_Admin_RechargeRecord.SubAdminAccountID INNER JOIN Registration AS RegFor_T ON Sub_Admin_Account.SubAdmin_RegistrationID = RegFor_T.RegistrationID INNER JOIN Registration AS RegBy_T ON Sub_Admin_RechargeRecord.Recharge_By_RegID = RegBy_T.RegistrationID INNER JOIN Registration ON Sub_Recharge_Authorization.Authority_RegistrationID = Registration.RegistrationID WHERE (Sub_Recharge_Authorization.Is_Approved = 0)"
        UpdateCommand="UPDATE Sub_Recharge_Authorization SET Is_Approved = 1, Approved_Process = N'Code' WHERE (Recharge_AuthorizationID = @Recharge_AuthorizationID)">
        <UpdateParameters>
            <asp:Parameter Name="Recharge_AuthorizationID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <%if (AccountGridView.Rows.Count > 0)
        { %>
    <br />
    <asp:Button ID="Approve_Button" runat="server" Text="Approve" CssClass="btn btn-primary" OnClick="Approve_Button_Click" />
    <%} %>
    <script>
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
