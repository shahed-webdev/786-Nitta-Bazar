<%@ Page Title="Distributor List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Seller_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Seller_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Distributor List</h3>
    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="FindTextBox" runat="server" CssClass="form-control" placeholder="User ID, Name, Phone, Shop Address"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="SellerTypeDropDownList" OnSelectedIndexChanged="SellerTypeDropDownList_SelectedIndexChanged" CssClass="form-control" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">General</asp:ListItem>
                <asp:ListItem Value="1">CIP</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" OnClick="FindButton_Click" />
        </div>
    </div>

    <div class="alert alert-info">
        <asp:Label ID="Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="SellerGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="SellerSQL" AllowPaging="True" AllowSorting="True" PageSize="150" DataKeyNames="SellerID">
            <Columns>
                <asp:HyperLinkField DataTextField="UserName" DataNavigateUrlFields="SellerID" DataNavigateUrlFormatString="Seller_Products_Stock_Details.aspx?d={0}" HeaderText="User ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="SellingPoint" HeaderText="Point" SortExpression="SellingPoint" />
                <asp:BoundField DataField="Load_Balance" HeaderText="Current Balance" SortExpression="Load_Balance" />
                <asp:BoundField DataField="Present_Address" HeaderText="Shop Address" SortExpression="Present_Address" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Registration.Email, Seller.SellingPoint, Seller.Selling_Income, Registration.Present_Address, Registration.CreateDate, Seller.SellerID, Seller.Load_Balance FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.IsCIP = @IsCIP)"
            FilterExpression="UserName LIKE '{0}%' or Name LIKE '{0}%' or Phone LIKE '{0}%' or Present_Address LIKE '{0}%'" CancelSelectOnNullParameter="False">
            <FilterParameters>
                <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
            </FilterParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SellerTypeDropDownList" Name="IsCIP" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
