<%@ Page Title="SMS Setting" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="SMS_Setting.aspx.cs" Inherits="NittaBazar.AccessAdmin.SMS.SMS_Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>SMS Setting</h3>
    <asp:FormView ID="SMSGridView" DefaultMode="Edit" runat="server" AutoGenerateColumns="False" DataSourceID="InstitutionSQL" Width="100%" DataKeyNames="InstitutionID">
        <EditItemTemplate>
            <div class="well">
                <table class="table table-bordered">
                    <tr>
                        <th>Option</th>
                        <th>On/Off</th>
                    </tr>
                    <tr>
                        <td>Withdraw SMS</td>
                        <td>
                            <asp:CheckBox ID="Is_Withdraw_SMSCheckBox" Text=" " runat="server" Checked='<%#Bind("Is_Withdraw_SMS") %>' /></td>
                    </tr>
                    <tr>
                        <td>Balance Transfer SMS</td>
                        <td>
                            <asp:CheckBox ID="Is_BalanceTransffer_SMSCheckBox" Text=" " runat="server" Checked='<%#Bind("Is_BalanceTransffer_SMS") %>'/></td>
                    </tr>
                    <tr>
                        <td>Load Balance SMS</td>
                        <td>
                            <asp:CheckBox ID="Is_LoadBalance_SMSCheckBox" Text=" " runat="server" Checked='<%#Bind("Is_LoadBalance_SMS") %>'/></td>
                    </tr>
                </table>

                <asp:Button ID="UpdateButton" CssClass="btn btn-primary" CommandName="Update" runat="server" Text="Change" />
            </div>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="InstitutionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Is_Withdraw_SMS, Is_BalanceTransffer_SMS, Is_LoadBalance_SMS, InstitutionID FROM Institution" UpdateCommand="UPDATE Institution SET Is_Withdraw_SMS = @Is_Withdraw_SMS, Is_BalanceTransffer_SMS = @Is_BalanceTransffer_SMS, Is_LoadBalance_SMS = @Is_LoadBalance_SMS WHERE (InstitutionID = @InstitutionID)">
        <UpdateParameters>
            <asp:Parameter Name="Is_Withdraw_SMS" />
            <asp:Parameter Name="Is_BalanceTransffer_SMS" />
            <asp:Parameter Name="Is_LoadBalance_SMS" />
            <asp:Parameter Name="InstitutionID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
