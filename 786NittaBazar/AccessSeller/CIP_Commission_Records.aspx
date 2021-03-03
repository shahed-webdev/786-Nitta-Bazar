<%@ Page Title="CIP Commission Records" Language="C#" MasterPageFile="~/Seller.Master" AutoEventWireup="true" CodeBehind="CIP_Commission_Records.aspx.cs" Inherits="NittaBazar.AccessSeller.CIP_Commission_Records" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>CIP Commission Records</h3>
    <asp:GridView ID="CIPGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="CIPSQL">
        <Columns>
            <asp:BoundField DataField="Shopping_SN" HeaderText="SN" SortExpression="Shopping_SN" />
            <asp:BoundField DataField="UserName" HeaderText="Userid" SortExpression="UserName" />
            <asp:BoundField DataField="ShoppingAmount" HeaderText="Amount" SortExpression="ShoppingAmount" />
            <asp:BoundField DataField="ShoppingPoint" HeaderText="Point" SortExpression="ShoppingPoint" />
            <asp:TemplateField HeaderText="Commi%" SortExpression="ComPercentage">
                <ItemTemplate>
                    <%#Eval("ComPercentage") %>%
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Amount" HeaderText="Commission" SortExpression="Amount" />
            <asp:BoundField DataField="Tax_Service_Charge" HeaderText="Tax/Service Charge" SortExpression="Tax_Service_Charge" />
            <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" />
            <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Insert_Date" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="CIPSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Seller_CIP_Commission_Record.ShoppingAmount, Seller_CIP_Commission_Record.ShoppingPoint, Seller_CIP_Commission_Record.ComPercentage, Seller_CIP_Commission_Record.Amount, 
                         Seller_CIP_Commission_Record.Tax_Service_Charge, Seller_CIP_Commission_Record.Net_Amount, Seller_CIP_Commission_Record.Insert_Date, Shopping.Shopping_SN, Registration.UserName
FROM            Seller_CIP_Commission_Record INNER JOIN
                         Shopping ON Seller_CIP_Commission_Record.ShoppingID = Shopping.ShoppingID INNER JOIN
                         Member ON Shopping.MemberID = Member.MemberID INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID
WHERE        (Seller_CIP_Commission_Record.SellerID = @SellerID)">
        <SelectParameters>
            <asp:SessionParameter Name="SellerID" SessionField="SellerID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
