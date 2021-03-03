<%@ Page Title="CIP Order List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="CIP_Order_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.CIP_Order_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mGrid table td { border: none; }
         .mGrid table td p { margin: 0; text-align: left; }
        .pDelivered { background-color: #9A9A9A; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>CIP Order List</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="ReceiptTextBox" placeholder="Receipt No." CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" Text="Find" CssClass="btn btn-default" OnClick="FindButton_Click" />
        </div>
    </div>
   
     <div class="alert alert-info">
        <asp:Label ID="Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
    </div>

    <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Product_DistributionID" DataSourceID="OrderSQL" AllowPaging="True" AllowSorting="True" PageSize="100">
        <Columns>
            <asp:BoundField DataField="Distribution_SN" HeaderText="Receipt" SortExpression="Distribution_SN" />
            <asp:TemplateField HeaderText="Details">
                <ItemTemplate>
                    <input type="hidden" class="IsDelivered" value="<%#Eval("Is_Delivered") %>" />
                    <asp:HiddenField ID="Product_DistributionIDhf" runat="server" Value='<%#Eval("Product_DistributionID") %>' />
                    <asp:FormView ID="ProductFormView" runat="server" Width="100%" DataSourceID="ProductSQL">
                        <ItemTemplate>
                            <p>Code: <b><%#Eval("Product_Code") %></b></p>
                            <p>P.Name: <b><%#Eval("Product_Name") %></b></p>
                            <p>Unit Price: <b>৳<%#Eval("SellingUnitPrice") %></b></p>
                            <p>Unit Point: <b><%#Eval("SellingUnitPoint") %></b></p>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="ProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Distribution_Records.SellingUnitPrice, Product_Distribution_Records.SellingUnitPoint FROM Product_Point_Code INNER JOIN Product_Distribution_Records ON Product_Point_Code.Product_PointID = Product_Distribution_Records.ProductID WHERE (Product_Distribution_Records.Product_DistributionID = @Product_DistributionID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Product_DistributionIDhf" Name="Product_DistributionID" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Buy_UserName" HeaderText="Buying Customer" SortExpression="Buy_UserName" />
            <asp:BoundField DataField="Sell_UserName" HeaderText="Selling Customer" SortExpression="Sell_UserName" />
            <asp:BoundField DataField="Product_Total_Amount" HeaderText="Total Amount" SortExpression="Product_Total_Amount" />
            <asp:BoundField DataField="Product_Total_Point" HeaderText="Total Point" SortExpression="Product_Total_Point" />
            <asp:BoundField DataField="Product_Distribution_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Product_Distribution_Date" />
            <asp:TemplateField HeaderText="Delivery" SortExpression="Is_Delivered">
                <ItemTemplate>
                    <asp:Button ID="DeliveryButton" runat="server" Text="Delivery" CssClass="btn btn-primary" OnClick="DeliveryButton_Click" />
                    <a style="margin-top:8px; color:#fff;" class="btn btn-warning Changed" href="Change_Product.aspx?Pdid=<%#Eval("Product_DistributionID") %>">Change</a>
                </ItemTemplate>
                <ItemStyle Width="80px" />
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            No Record
        </EmptyDataTemplate>
        <PagerStyle CssClass="pgr" />
    </asp:GridView>
    <asp:SqlDataSource ID="OrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Distribution.Product_DistributionID, Product_Distribution.Distribution_SN, Product_Distribution.Product_Total_Amount, Product_Distribution.Product_Total_Point, Product_Distribution.Product_Distribution_Date, Buy_Registration.UserName AS Buy_UserName, Product_Distribution.Is_Delivered, Sell_Reg.UserName AS Sell_UserName FROM Product_Distribution INNER JOIN Member AS Buy_Member ON Product_Distribution.Buy_MemberID = Buy_Member.MemberID INNER JOIN Registration AS Buy_Registration ON Buy_Member.MemberRegistrationID = Buy_Registration.RegistrationID INNER JOIN Member AS Sell_Member ON Product_Distribution.Sell_MemberID = Sell_Member.MemberID INNER JOIN Registration AS Sell_Reg ON Sell_Member.MemberRegistrationID = Sell_Reg.RegistrationID ORDER BY Product_Distribution.Is_Delivered"
        FilterExpression="Distribution_SN = {0}" CancelSelectOnNullParameter="False">
        <FilterParameters>
            <asp:ControlParameter ControlID="ReceiptTextBox" Name="Find" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DeliverySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Distribution.Product_Total_Point, Product_Distribution.Product_Distribution_Date, Product_Distribution.Distribution_SN, Product_Distribution.Commission_Amount, Product_Distribution.Net_Amount, Registration.UserName, Registration.Name, Product_Distribution.Product_Total_Amount, Product_Distribution.Product_DistributionID, Product_Distribution.SellerID FROM Product_Distribution INNER JOIN Seller ON Product_Distribution.SellerID = Seller.SellerID INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Product_Distribution.Is_Confirmed = 1) AND (Product_Distribution.Is_Delivered = 0)" UpdateCommand="UPDATE Product_Distribution SET Is_Delivered = 1, Delivery_Date = GETDATE(), Delivered_RegistrationID = @Delivered_RegistrationID WHERE (Product_DistributionID = @Product_DistributionID)">
        <UpdateParameters>
            <asp:SessionParameter Name="Delivered_RegistrationID" SessionField="RegistrationID" />
            <asp:Parameter Name="Product_DistributionID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Stock_UpdateSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Product_Point_Code]" UpdateCommand="UPDATE  Product_Point_Code SET Stock_Quantity -= @Stock_Quantity WHERE (Product_PointID = @Product_PointID)">
        <UpdateParameters>
            <asp:Parameter Name="Product_PointID" />
            <asp:Parameter Name="Stock_Quantity" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <script>
        $(function () {
            $('.mGrid .IsDelivered').each(function () {
                var val = $(this).val();
                if (val == "True") {
                    $(this).closest("tr").addClass("pDelivered");
                    $(this).closest('tr').find('input[type=submit]').removeClass("btn btn-primary").attr("disabled", "disabled").val('Delivered');
                    $(this).closest('tr').find('.Changed').hide();
                }
            });
        });
    </script>
</asp:Content>
