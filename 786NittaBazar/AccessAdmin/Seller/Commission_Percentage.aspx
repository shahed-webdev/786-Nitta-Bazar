<%@ Page Title="Commission Percentage" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Commission_Percentage.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Commission_Percentage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-control { display: inline-block; width: 94%; height: 29px; padding: 0 4px; font-size: 13px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Distributor Commission</h3>
    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="TypeDropDownList" runat="server" AutoPostBack="True" CssClass="form-control">
                <asp:ListItem Value="%">All Type</asp:ListItem>
                <asp:ListItem>Zone</asp:ListItem>
                <asp:ListItem>District</asp:ListItem>
                <asp:ListItem>Thana</asp:ListItem>
                <asp:ListItem>Union</asp:ListItem>
                <asp:ListItem>Not Assign</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="SellerGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SellerID" DataSourceID="SellerSQL">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="User id" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:TemplateField>
                    <HeaderTemplate>
                        Commission %
                    <input type="text" id="SetAllValue" placeholder="% For All" class="form-control" onkeypress="return isNumberKey(event)" autocomplete="off" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="Commission_TextBox" onkeypress="return isNumberKey(event)" autocomplete="off" runat="server" Text='<%# Bind("CommissionPercentage") %>' CssClass="form-control set"></asp:TextBox>
                        <asp:RegularExpressionValidator ValidationGroup="1" SetFocusOnError="true" ControlToValidate="Commission_TextBox" ValidationExpression="^100$|^\d{0,2}(\.\d{1,2})? *%?$" ID="Rex" runat="server" ErrorMessage="*" CssClass="EroorStar"></asp:RegularExpressionValidator>
                    </ItemTemplate>
                    <ItemStyle Width="180px" />
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Seller.SellerID, 
       Registration.UserName,Registration.Name,Registration.Phone,Seller.Shop_Name, Seller.Proprietor, Seller.CommissionPercentage,
	   CASE WHEN Seller_Zone.ZoneID IS NOT NULL THEN 'Zone'WHEN Seller_District.DistrictID IS NOT NULL THEN 'District'	WHEN Seller_Thana.ThanaID IS NOT NULL THEN 'Thana'  WHEN Seller_Union.UnionID IS NOT NULL THEN 'Union' ELSE 'Not Assign' END AS [Type]
       FROM  Seller INNER JOIN
                         Registration ON Seller.SellerRegistrationID = Registration.RegistrationID LEFT OUTER JOIN
                         Seller_Union ON Seller.SellerID = Seller_Union.SellerID LEFT OUTER JOIN
                         Seller_Thana ON Seller.SellerID = Seller_Thana.SellerID LEFT OUTER JOIN
                         Seller_District ON Seller.SellerID = Seller_District.SellerID LEFT OUTER JOIN
                         Seller_Zone ON Seller.SellerID = Seller_Zone.SellerID"
            FilterExpression="Type like '{0}'" UpdateCommand="UPDATE Seller SET CommissionPercentage = @CommissionPercentage WHERE (SellerID = @SellerID)">
            <FilterParameters>
                <asp:ControlParameter ControlID="TypeDropDownList" Name="Find" PropertyName="SelectedValue" />
            </FilterParameters>
            <UpdateParameters>
                <asp:Parameter Name="CommissionPercentage" />
                <asp:Parameter Name="SellerID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <asp:Button ID="SubmitButton" ValidationGroup="1" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="SubmitButton_Click" />

    <script>
        $(function () {
            $('#SetAllValue').on('keyup', function () {
                $(".set").val($(this).val());
            });
        });
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
