<%@ Page Title="Change Product" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Change_Product.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.Change_Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .B_Info { width: 100%; }
            .B_Info td { font-size: 16px; color: #000; font-weight: bold; }
        h5 { font-size: 16px; }
        #Net { border-top: 1px solid #333; font-weight: bold; padding-top: 5px; }

        #Product-info { display: none; }
            #Product-info label { margin: 0 !important; }
        .userid { font-size: 14px; padding: 13px 5px; margin-bottom: 7px; }
        .userid .fa { padding-left: 10px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Change Product</h3>

    <asp:FormView ID="MemberFormView" runat="server" DataSourceID="SellerInfoSQL" Width="100%">
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


            <asp:GridView ID="ReceiptGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                DataSourceID="ReceiptSQL" DataKeyNames="ProductID,SellingUnitPrice,SellingUnitPoint">
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
                SelectCommand="SELECT Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Distribution_Records.SellingQuantity, Product_Distribution_Records.SellingUnitPrice, Product_Distribution_Records.SellingUnitPoint, Product_Distribution_Records.SellingUnit_Commission, Product_Distribution_Records.ProductPrice, Product_Distribution_Records.TotalPoint, Product_Distribution_Records.Total_Commission, Product_Distribution_Records.ProductID FROM Product_Point_Code INNER JOIN Product_Distribution_Records ON Product_Point_Code.Product_PointID = Product_Distribution_Records.ProductID WHERE (Product_Distribution_Records.Product_DistributionID = @Product_DistributionID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="Pdid" />
                </SelectParameters>
            </asp:SqlDataSource>

            <table style="width: 100%">
                <tr>
                    <td class="text-right">
                        <h5 id="Point_GrandTotal"></h5>
                        <h5 id="Amount_GrandTotal"></h5>
                        <h5 id="Net"></h5>
                    </td>
                </tr>
                <tr>
                    <td>Served By:
                  <asp:Label ID="Admin_Name_NameLabel" runat="server" Text='<%# Bind("Seller_Username") %>' />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SellerInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Phone AS NewMember_Phone, Registration.UserName AS NewMemberId, Registration.Name AS NewMemberName, Seller_Registration.UserName AS Seller_Username, Product_Distribution.Product_Distribution_Date, Product_Distribution.Product_DistributionID, Product_Distribution.Distribution_SN FROM Registration AS Seller_Registration INNER JOIN Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Product_Distribution ON Member.MemberID = Product_Distribution.Buy_MemberID INNER JOIN Member AS Sell_Member ON Product_Distribution.Sell_MemberID = Sell_Member.MemberID ON Seller_Registration.RegistrationID = Sell_Member.MemberRegistrationID WHERE (Product_Distribution.Product_DistributionID = @Product_DistributionID) AND (Product_Distribution.Is_Delivered = 0)">
        <SelectParameters>
            <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="Pdid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="CIP_ProductDropDownList" runat="server" CssClass="form-control" DataSourceID="CIPProductSQL" DataTextField="Product_Code" DataValueField="Product_PointID" AppendDataBoundItems="True">
                <asp:ListItem Value="0">[ SELECT CIP PRODUCT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="CIPProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_PointID, Product_Code FROM Product_Point_Code WHERE (IsCIP = 1) AND (IsActive = 1) AND (Product_Point &gt;= @Product_Point) AND (Product_Price &gt;= @Product_Price) AND (Product_PointID &lt;&gt; @Product_PointID)" InsertCommand="INSERT INTO Product_Distribution_Change_Record(Product_DistributionID, ChangeBy_RegistrationID, ProductID, Product_Amount, Product_Point, Additional_Amount, Additional_Point) VALUES (@Product_DistributionID, @ChangeBy_RegistrationID, @ProductID, @Product_Amount, @Product_Point, @Additional_Amount, @Additional_Point)" UpdateCommand="UPDATE Product_Distribution SET Is_Delivered = 1, Delivery_Date = GETDATE(), Delivered_RegistrationID = @Delivered_RegistrationID WHERE (Product_DistributionID = @Product_DistributionID)">
                <InsertParameters>
                    <asp:SessionParameter Name="ChangeBy_RegistrationID" SessionField="RegistrationID" />
                    <asp:ControlParameter ControlID="CIP_ProductDropDownList" Name="ProductID" PropertyName="SelectedValue" />
                    <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="Pdid" />
                    <asp:ControlParameter ControlID="PriceHF" Name="Product_Amount" PropertyName="Value" />
                    <asp:ControlParameter ControlID="PointHF" Name="Product_Point" PropertyName="Value" />
                    <asp:Parameter Name="Additional_Amount" />
                    <asp:Parameter Name="Additional_Point" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="Product_Point" />
                    <asp:Parameter Name="Product_Price" />
                    <asp:Parameter Name="Product_PointID" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:SessionParameter Name="Delivered_RegistrationID" SessionField="RegistrationID" />
                    <asp:QueryStringParameter Name="Product_DistributionID" QueryStringField="Pdid" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CIP_ProductDropDownList" CssClass="EroorStar" ForeColor="Red" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="ChangeButton" CssClass="btn btn-primary" runat="server" Text="Change Product" ValidationGroup="1" OnClick="ChangeButton_Click" />
        </div>
    </div>

    <div id="Product-info" class="alert-success">
        <div class="userid">
            <i class="fa fa-shopping-bag"></i>
            <label id="ProductNameLabel"></label>

            <i class="fas fa-money-bill-alt"></i>
            Price: <label id="ProductPriceLabel"></label>
             <asp:HiddenField ID="PriceHF" runat="server" />

            <i class="fa fa-star"></i>
            Point: <label id="ProductPointLabel"></label>
             <asp:HiddenField ID="PointHF" runat="server" />
        </div>
    </div>

    <script>
        $(function () {
            var Amount_Total = 0;
            $(".TotalPrice").each(function () { Amount_Total = Amount_Total + parseFloat($(this).val()) });
            $("#Amount_GrandTotal").text("Total Amount: ৳" + Amount_Total.toFixed(2));

            var Point_Total = 0;
            $(".TotalPoint").each(function () { Point_Total = Point_Total + parseFloat($(this).val()) });
            $("#Point_GrandTotal").text("Total Point: " + Point_Total);

            //cip product
            $("[id*=CIP_ProductDropDownList]").on('change', function () {
                console.log("ok");
                var PID = $(this).find('option:selected').val();

                if (PID == 0) {
                    $("#Product-info").css("display", "none");
                    $("[id*=PriceHF]").val(0);
                    $("[id*=PointHF]").val(0);
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "Change_Product.aspx/GetProduct",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ 'pid': PID }),
                        dataType: "json",
                        success: function (response) {
                            var Data = $.parseJSON(response.d);

                            $.each(Data, function () {
                                $("#Product-info").css("display", "block");
                                $("#ProductNameLabel").text(this.Name);
                                $("#ProductPriceLabel").text(this.Price);
                                $("#ProductPointLabel").text(this.Point);

                                $("[id*=PriceHF]").val(this.Price);
                                $("[id*=PointHF]").val(this.Point);
                            });
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>
