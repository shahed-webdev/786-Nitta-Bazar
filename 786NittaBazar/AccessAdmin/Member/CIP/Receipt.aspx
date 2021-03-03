<%@ Page Title="" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .B_Info { width: 100%; }
            .B_Info td { font-size: 16px; color: #000; font-weight: bold; }
        h5 { font-size: 16px; }
        #Net { border-top: 1px solid #333; font-weight: bold; padding-top: 5px; }
        .Delivered-status { color: #1b8d00; font-weight: 700; font-size: 25px; }
        .DB { width:100%;margin:10px 0}
         .DB tr{background-color:#ddd}
        .DB tr td { padding:3px 10px;}
        @page { margin: 5mm}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Invoice</h3>
    <a class="NoPrint" href="CIP_Order_List.aspx">Back To Order List</a>

    <asp:FormView ID="MemberFormView" runat="server" DataSourceID="SellerInfoSQL" Width="100%">
        <ItemTemplate>
            <table class="B_Info">
                <tr>
                    <td>Customer ID: <%# Eval("NewMemberId") %></td>
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

            <asp:GridView ID="ReceiptGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="ReceiptSQL">
                <Columns>
                    <asp:BoundField DataField="Product_Code" HeaderText="Code" SortExpression="Product_Code" />
                    <asp:BoundField DataField="Product_Name" HeaderText="P.Name" SortExpression="Product_Name">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SellingQuantity" HeaderText="Quantity" SortExpression="SellingQuantity" />
                    <asp:TemplateField HeaderText="Total Price" SortExpression="ProductPrice">
                        <ItemTemplate>
                            <asp:Label ID="TotalPriceLabel" runat="server" Text='<%# Bind("ProductPrice","{0:N}") %>'></asp:Label>
                            <input class="TotalPrice" type="hidden" value="<%# Eval("ProductPrice") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Point" SortExpression="TotalPoint">
                        <ItemTemplate>
                            <asp:Label ID="TotalPointLabel" runat="server" Text='<%# Bind("TotalPoint") %>'></asp:Label>
                            <input class="TotalPoint" type="hidden" value="<%# Eval("TotalPoint") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle CssClass="GridFooter" />
            </asp:GridView>
            <asp:SqlDataSource ID="ReceiptSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                SelectCommand="SELECT Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Distribution_Records.ProductPrice, Product_Distribution_Records.TotalPoint, Product_Distribution_Records.SellingQuantity FROM Product_Point_Code INNER JOIN Product_Distribution_Records ON Product_Point_Code.Product_PointID = Product_Distribution_Records.ProductID WHERE (Product_Distribution_Records.Product_DistributionID = @Product_DistributionID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="P" />
                </SelectParameters>
            </asp:SqlDataSource>


            <table style="width: 100%; margin-top:40px;"">
                <tr>
                    <td class="Delivered-status">Delivered</td>
                    <td style="text-align: right;">Customer Signature</td>
                </tr>
            </table>

            <table class="DB">
                <tr>
                    <td>Join By: <%#Eval("Seller_Username") %></td>
                    <td style="text-align: right;">Delivered By: <%# User.Identity.Name %> (<%#Eval("Delivery_Date","{0:d MMM yyyy}") %>)</td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SellerInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Phone AS NewMember_Phone, Registration.UserName AS NewMemberId, Seller_Registration.UserName AS Seller_Username, Product_Distribution.Product_Distribution_Date, Product_Distribution.Product_DistributionID, Product_Distribution.Distribution_SN, Product_Distribution.Delivery_Date FROM Registration AS Seller_Registration INNER JOIN Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Product_Distribution ON Member.MemberID = Product_Distribution.Buy_MemberID INNER JOIN Member AS Sell_Member ON Product_Distribution.Sell_MemberID = Sell_Member.MemberID ON Seller_Registration.RegistrationID = Sell_Member.MemberRegistrationID WHERE (Product_Distribution.Product_DistributionID = @Product_DistributionID) AND (Product_Distribution.Is_Delivered = 1)">
        <SelectParameters>
            <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="P" />
        </SelectParameters>
    </asp:SqlDataSource>

    <button type="button" class="btn btn-primary hidden-print" onclick="window.print();">Print</button>
</asp:Content>
