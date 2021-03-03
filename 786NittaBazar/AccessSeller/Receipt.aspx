<%@ Page Title="Receipt" Language="C#" MasterPageFile="~/Seller.Master" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="NittaBazar.AccessSeller.Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .B_Info { width: 100%; }
        .B_Info td { font-size: 16px; color: #000; font-weight: bold; }
        @page { margin: 5mm; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="Contain">
        <asp:Repeater ID="MemberRepeater" runat="server" DataSourceID="MemberInfoSQL">
            <ItemTemplate>
                <table class="B_Info">
                    <tr>
                        <td><%# Eval("Shop_Name") %></td>
                        <td class="text-right"><%# Eval("Name") %></td>
                    </tr>
                    <tr>
                        <td>Invoice: #<%# Eval("Shopping_SN") %></td>
                        <td class="text-right"><%# Eval("UserName") %></td>
                    </tr>
                    <tr>
                        <td>Date: <%# Eval("ShoppingDate","{0:d MMM yyyy}") %></td>
                        <td class="text-right"><%# Eval("Phone") %></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                </table>

                <asp:GridView ID="ReceiptGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="ReceiptSQL">
                    <Columns>
                        <asp:BoundField DataField="Product_Code" HeaderText="Code" SortExpression="Product_Code" />
                        <asp:BoundField DataField="Product_Name" HeaderText="P.Name" SortExpression="Product_Name" />
                        <asp:BoundField DataField="SellingQuantity" HeaderText="Quantity" SortExpression="SellingQuantity">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SellingUnitPrice" HeaderText="Unit Price" SortExpression="SellingUnitPrice">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SellingUnitPoint" HeaderText="Unit Point" SortExpression="SellingUnitPoint">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Total Price" SortExpression="ProductPrice">
                            <ItemTemplate>
                                <asp:Label ID="TotalPriceLabel" runat="server" Text='<%# Bind("ProductPrice") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="130px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Point" SortExpression="TotalPoint">
                            <ItemTemplate>
                                <asp:Label ID="TotalPointLabel" runat="server" Text='<%# Bind("TotalPoint") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="130px" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="ReceiptSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Selling_Records.SellingQuantity, Product_Selling_Records.SellingUnitPrice, Product_Selling_Records.SellingUnitPoint, Product_Selling_Records.ProductPrice, Product_Selling_Records.TotalPoint FROM Product_Selling_Records INNER JOIN Product_Point_Code ON Product_Selling_Records.ProductID = Product_Point_Code.Product_PointID WHERE (Product_Selling_Records.ShoppingID = @ShoppingID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ShoppingID" QueryStringField="ShoppingID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <div>
                    <img src="/CSS/Image/Paid_Sill.jpg" style="width: 80px; margin: 10px 0" />
                    <p>Served By: <%# Eval("Seller_Name") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="MemberInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Shopping.ShoppingAmount, Shopping.ShoppingPoint, Shopping.ShoppingDate, Registration.Name, Registration.UserName, Registration.Phone, Registration_1.Name AS Seller_Name, Shopping.Shopping_SN, Seller.Shop_Name, Shopping.Join_SN FROM Shopping INNER JOIN Member ON Shopping.MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN Seller ON Shopping.SellerID = Seller.SellerID INNER JOIN Registration AS Registration_1 ON Seller.SellerRegistrationID = Registration_1.RegistrationID WHERE (Shopping.Join_SN = @ShoppingID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ShoppingID" QueryStringField="ShoppingID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="text-right" style="font-size:20px">
            <label id="Amount_GrandTotal"></label><br />
            <label id="Point_GrandTotal"></label>
        </div>

        <a class="btn btn-primary hidden-print" href="Sell_Product.aspx">
            <i class="fa fa-caret-left"></i> Sell Again</a>
        <button type="button" class="btn btn-primary hidden-print" onclick="window.print();">
            <span class="glyphicon glyphicon-print"></span> Print</button>

    </div>

    <script>
        $(function () {
            var Amount_Total = 0;
            $("[id*=TotalPriceLabel]").each(function () { Amount_Total = Amount_Total + parseFloat($(this).text()) });
            $("#Amount_GrandTotal").text("Total Amount: " + Amount_Total.toFixed(2)+" Tk");

            var Point_Total = 0;
            $("[id*=TotalPointLabel]").each(function () { Point_Total = Point_Total + parseFloat($(this).text()) });
            $("#Point_GrandTotal").text("Total Point: " + Point_Total.toFixed(2));
        });
    </script>
</asp:Content>
