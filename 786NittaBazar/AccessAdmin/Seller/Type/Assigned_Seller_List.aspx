<%@ Page Title="Assigned Distributor" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Assigned_Seller_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Type.Assigned_Seller_List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Assigned h4 { margin-bottom: 5px; margin-top:25px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Assigned Distributor List</h3>
    <div class="Assigned">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">ZONE <small>SD</small></div>
            </div>
            <div class="panel-body">
                <asp:GridView ID="ZoneGridView" runat="server" DataKeyNames="ZoneID" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Zone_SQL">
                    <Columns>
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <asp:Button ID="zButton" runat="server" CssClass="btn btn-default" CausesValidation="False" CommandName="Select" Text="Select"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Zone" HeaderText="Zone" SortExpression="Zone" />
                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Present_Address" HeaderText="Address" SortExpression="Present_Address" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Data
                    </EmptyDataTemplate>
                    <SelectedRowStyle CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="Zone_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Seller_Zone.Zone, Registration.UserName, Seller.Shop_Name, Seller.Proprietor, Registration.Phone, Seller_Zone.ZoneID, Registration.Present_Address FROM Seller_Zone INNER JOIN Seller ON Seller_Zone.SellerID = Seller.SellerID INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
            </div>
        </div>

        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">DISTRICT <small>MB</small></div>
            </div>
            <div class="panel-body">
                <asp:GridView ID="District_GridView" DataKeyNames="DistrictID" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="DistrictSQL">
                    <Columns>
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <asp:Button ID="zButton" runat="server" CssClass="btn btn-default" CausesValidation="False" CommandName="Select" Text="Select"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Present_Address" HeaderText="Address" SortExpression="Present_Address" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Data
                    </EmptyDataTemplate>
                    <SelectedRowStyle CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Seller.Shop_Name, Seller.Proprietor, Registration.Phone, Registration.Present_Address, Seller_District.District, Seller_District.DistrictID FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID INNER JOIN Seller_District ON Seller.SellerID = Seller_District.SellerID WHERE (CAST(Seller_District.ZoneID AS varchar(10)) LIKE @ZoneID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ZoneGridView" DefaultValue="%" Name="ZoneID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>

        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">THANA <small>SB</small></div>
            </div>
            <div class="panel-body">
                <asp:GridView ID="Thana_GridView" DataKeyNames="ThanaID" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="ThanaSQL">
                    <Columns>
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <asp:Button ID="zButton" runat="server" CssClass="btn btn-default" CausesValidation="False" CommandName="Select" Text="Select"></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Thana" HeaderText="Thana" SortExpression="Thana" />
                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Present_Address" HeaderText="Address" SortExpression="Present_Address" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Data
                    </EmptyDataTemplate>
                    <SelectedRowStyle CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="ThanaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Present_Address, Seller.Shop_Name, Seller.Proprietor, Registration.Phone, Seller_Thana.Thana, Seller_Thana.ThanaID FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID INNER JOIN Seller_Thana ON Seller.SellerID = Seller_Thana.SellerID WHERE (CAST(Seller_Thana.DistrictID AS varchar(10)) LIKE @DistrictID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="District_GridView" DefaultValue="%" Name="DistrictID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>

        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="panel-title">UNION <small>MNB</small></div>
            </div>
            <div class="panel-body">
                <asp:GridView ID="Union_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="UnionSQL">
                    <Columns>
                        <asp:BoundField DataField="Seller_Union" HeaderText="Union" SortExpression="Seller_Union" />
                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Present_Address" HeaderText="Address" SortExpression="Present_Address" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Data
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="UnionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Present_Address, Seller.Shop_Name, Seller.Proprietor, Registration.Phone, Seller_Union.Seller_Union, Seller_Union.ThanaID FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID INNER JOIN Seller_Union ON Seller.SellerID = Seller_Union.SellerID WHERE (CAST(Seller_Union.ThanaID AS varchar(10)) LIKE @ThanaID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Thana_GridView" DefaultValue="%" Name="ThanaID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
