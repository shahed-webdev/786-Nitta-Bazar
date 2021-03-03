<%@ Page Title="Receipt" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="CIP_Receipt.aspx.cs" Inherits="NittaBazar.AccessMember.CIP_Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .B_Info { width: 100%; }
        .B_Info td { font-size: 16px; color: #000; font-weight: bold; }
        h5 { font-size: 16px; }
        #Net { border-top: 1px solid #333; font-weight: bold; padding-top: 5px; }

        @page { margin: 5mm 8mm; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Invoice</h3>
    <asp:Repeater ID="ReceiptRepeater" runat="server" DataSourceID="SellerInfoSQL">
      <ItemTemplate>
            <table class="B_Info">
                <tr>
                    <td>Customer: <%# Eval("NewMemberName") %> (<%# Eval("NewMemberId") %>)</td>
                    <td class="text-right">Phone: <%# Eval("NewMember_Phone") %></td>
                </tr>
                <tr>
                    <td>Receipts# <%#Eval("Distribution_SN") %></td>
                    <td class="text-right">Date: <%#Eval("Product_Distribution_Date","{0:d MMM yyyy}") %></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
            </table>

            <div class="alert alert-danger text-center">N:B: Collect product within 60 days from (<%#Eval("Product_Distribution_Date","{0:d MMM yyyy}") %>) order date otherwise order will be canceled</div>

            <asp:GridView ID="ReceiptGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="ReceiptSQL">
                <Columns>
                    <asp:BoundField DataField="Product_Code" HeaderText="Code" SortExpression="Product_Code" />
                    <asp:BoundField DataField="Product_Name" HeaderText="P.Name" SortExpression="Product_Name">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SellingQuantity" HeaderText="Quantity" SortExpression="SellingQuantity" />
                    <asp:TemplateField HeaderText="Price" SortExpression="ProductPrice">
                        <ItemTemplate>
                            <asp:Label ID="TotalPriceLabel" runat="server" Text='<%# Bind("ProductPrice","{0:N}") %>'></asp:Label>
                            <input class="TotalPrice" type="hidden" value="<%# Eval("ProductPrice") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Point" SortExpression="TotalPoint">
                        <ItemTemplate>
                            <asp:Label ID="TotalPointLabel" runat="server" Text='<%# Bind("TotalPoint") %>'></asp:Label>
                            <input class="TotalPoint" type="hidden" value="<%# Eval("TotalPoint") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle CssClass="GridFooter" />
            </asp:GridView>
            <asp:SqlDataSource ID="ReceiptSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                SelectCommand="SELECT Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Distribution_Records.SellingQuantity, Product_Distribution_Records.SellingUnitPrice, Product_Distribution_Records.SellingUnitPoint,Product_Distribution_Records.SellingUnit_Commission, Product_Distribution_Records.ProductPrice, Product_Distribution_Records.TotalPoint, Product_Distribution_Records.Total_Commission FROM Product_Point_Code INNER JOIN Product_Distribution_Records ON Product_Point_Code.Product_PointID = Product_Distribution_Records.ProductID WHERE (Product_Distribution_Records.Product_DistributionID = @Product_DistributionID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="P" />
                </SelectParameters>
            </asp:SqlDataSource>

            <table style="width: 100%">
                <tr>
                    <td>Served By:
                  <asp:Label ID="Admin_Name_NameLabel" runat="server" Text='<%# Bind("Seller_Username") %>' />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </Itemtemplate>
   </asp:Repeater>

    <asp:SqlDataSource ID="SellerInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Phone AS NewMember_Phone, Registration.UserName AS NewMemberId, Registration.Name AS NewMemberName, Seller_Registration.UserName AS Seller_Username, Product_Distribution.Product_Distribution_Date, Product_Distribution.Product_DistributionID, Product_Distribution.Distribution_SN FROM Registration AS Seller_Registration INNER JOIN Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Product_Distribution ON Member.MemberID = Product_Distribution.Buy_MemberID INNER JOIN Member AS Sell_Member ON Product_Distribution.Sell_MemberID = Sell_Member.MemberID ON Seller_Registration.RegistrationID = Sell_Member.MemberRegistrationID WHERE (Product_Distribution.Join_SN = @Product_DistributionID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="P" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="text-right">
        <h5 id="Point_GrandTotal"></h5>
        <h5 id="Amount_GrandTotal"></h5>
    </div>

    <button type="button" class="btn btn-primary hidden-print" onclick="window.print();">Print</button>

    <script>
        $(function () {
            var Amount_Total = 0;
            $(".TotalPrice").each(function () { Amount_Total = Amount_Total + parseFloat($(this).val()) });
            $("#Amount_GrandTotal").text("Total Amount: ৳" + Amount_Total.toFixed(2));

            var Point_Total = 0;
            $(".TotalPoint").each(function () { Point_Total = Point_Total + parseFloat($(this).val()) });
            $("#Point_GrandTotal").text("Total Point: " + Point_Total.toFixed(2));
        });
    </script>
</asp:Content>
