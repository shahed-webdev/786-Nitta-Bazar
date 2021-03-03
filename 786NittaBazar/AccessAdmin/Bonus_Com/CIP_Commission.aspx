<%@ Page Title="CIP Commission" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="CIP_Commission.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.CIP_Commission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>CIP Distributor Commission</h3>

    <asp:FormView ID="CIPFormView" DefaultMode="Edit" runat="server" DataSourceID="CIPUpdate" Width="100%">
        <EditItemTemplate>
            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="CIP_CommTextBox" placeholder="Enter Commission %" CssClass="form-control" runat="server" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" Text='<%# Bind("CIP_Distributor_Com") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="EroorStar" ValidationGroup="1" ControlToValidate="CIP_CommTextBox" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Button ID="UpdateButton" CausesValidation="True" CommandName="Update" ValidationGroup="1" runat="server" CssClass="btn btn-default" Text="Update" />
                </div>
            </div>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="CIPUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [CIP_Distributor_Com] FROM [Institution]" UpdateCommand="UPDATE Institution SET CIP_Distributor_Com = @CIP_Distributor_Com">
        <UpdateParameters>
            <asp:Parameter Name="CIP_Distributor_Com" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="RecordGridView" CssClass="mGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="RecordSQL" PageSize="80">
        <Columns>
            <asp:BoundField DataField="Shopping_SN" HeaderText="Receipt" SortExpression="Shopping_SN" />
            <asp:BoundField DataField="UserName" HeaderText="Distributor id" SortExpression="UserName" />
            <asp:BoundField DataField="Customerid" HeaderText="Customer id" SortExpression="Customerid" />
            <asp:BoundField DataField="ShoppingAmount" HeaderText="Amount" SortExpression="ShoppingAmount" DataFormatString="{0:N}" />
            <asp:BoundField DataField="ShoppingPoint" HeaderText="Point" SortExpression="ShoppingPoint" />
            <asp:BoundField DataField="ComPercentage" HeaderText="Commission%" SortExpression="ComPercentage" />
            <asp:BoundField DataField="Amount" HeaderText="Commission Amount" SortExpression="Amount" DataFormatString="{0:N}" />
            <asp:BoundField DataField="Tax_Service_Charge" HeaderText="Tax/Service" SortExpression="Tax_Service_Charge" DataFormatString="{0:N}" />
            <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" DataFormatString="{0:N}" />
            <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Insert_Date" />
        </Columns>
        <EmptyDataTemplate>
            No Record
        </EmptyDataTemplate>
        <PagerStyle CssClass="pgr" />
    </asp:GridView>

    <asp:SqlDataSource ID="RecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Shopping.Shopping_SN, Registration.UserName, Registration.Name, Seller_CIP_Commission_Record.ShoppingAmount, Seller_CIP_Commission_Record.ShoppingPoint, Seller_CIP_Commission_Record.ComPercentage, Seller_CIP_Commission_Record.Amount, Seller_CIP_Commission_Record.Tax_Service_Charge, Seller_CIP_Commission_Record.Net_Amount, Seller_CIP_Commission_Record.Insert_Date, Registration_Member.UserName AS CustomerId FROM Seller_CIP_Commission_Record INNER JOIN Seller ON Seller_CIP_Commission_Record.SellerID = Seller.SellerID INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID INNER JOIN Shopping ON Seller_CIP_Commission_Record.ShoppingID = Shopping.ShoppingID INNER JOIN Member ON Shopping.MemberID = Member.MemberID INNER JOIN Registration AS Registration_Member ON Member.MemberRegistrationID = Registration_Member.RegistrationID"></asp:SqlDataSource>

    <script>
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
