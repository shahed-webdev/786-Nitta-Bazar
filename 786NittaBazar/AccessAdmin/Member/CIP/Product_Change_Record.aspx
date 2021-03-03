<%@ Page Title="Product Change Record" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Product_Change_Record.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.Product_Change_Record" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Product Change Record</h3>
    <asp:GridView ID="RecordGridView" CssClass="mGrid" runat="server" AllowPaging="true" PageSize="100" AllowSorting="True" AutoGenerateColumns="False" PagerStyle-CssClass="pgr" DataSourceID="ChangeRecordSQL">
        <Columns>
            <asp:BoundField DataField="Distribution_SN" HeaderText="Receipt No" SortExpression="Distribution_SN" />
            <asp:BoundField DataField="UserName" HeaderText="User Id" SortExpression="UserName" />
            <asp:BoundField DataField="Product_Amount" HeaderText="Old Price" SortExpression="Product_Amount" />
            <asp:BoundField DataField="Product_Point" HeaderText="Old Point" SortExpression="Product_Point" />
            <asp:BoundField DataField="Product_Distribution_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Buying Date" SortExpression="Product_Distribution_Date" />
            <asp:BoundField DataField="Product_Name" HeaderText="New Product Code" SortExpression="Product_Name" />
            <asp:BoundField DataField="Additional_Amount" HeaderText="Additional Price" SortExpression="Additional_Amount" />
            <asp:BoundField DataField="Additional_Point" HeaderText="Additional Point" SortExpression="Additional_Point" />
            <asp:BoundField DataField="Product_Change_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Change Date" SortExpression="Product_Change_Date" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="ChangeRecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Distribution_Change_Record.Product_Amount, Product_Distribution_Change_Record.Product_Point, Product_Distribution_Change_Record.Additional_Amount, Product_Distribution_Change_Record.Additional_Point, Product_Distribution_Change_Record.Product_Change_Date, Product_Point_Code.Product_Name, Product_Distribution.Distribution_SN, Product_Distribution.Product_Distribution_Date, Registration.UserName FROM Product_Distribution_Change_Record INNER JOIN Product_Point_Code ON Product_Distribution_Change_Record.ProductID = Product_Point_Code.Product_PointID INNER JOIN Product_Distribution ON Product_Distribution_Change_Record.Product_DistributionID = Product_Distribution.Product_DistributionID INNER JOIN Member ON Product_Distribution.Buy_MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
</asp:Content>
