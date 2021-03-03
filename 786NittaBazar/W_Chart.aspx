<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="W_Chart.aspx.cs" Inherits="NittaBazar.W_Chart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/Default.css?v=3" rel="stylesheet" />
    <link href="/Home/CSS/Slider.css?v=2" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="page-header">
        <div style="float: right; cursor: pointer;">
            <span class="glyphicon glyphicon-shopping-cart my-cart-icon"><span class="badge badge-notify my-cart-badge"></span></span>
        </div>
    </div>

    <div class="container t-space">
        <asp:Repeater ID="Category_Repeater" runat="server" DataSourceID="Product_CategorySQL">
            <ItemTemplate>
                <asp:HiddenField ID="CategoryIDHF" Value='<%#Bind("Product_CategoryID") %>' runat="server" />
                <div class="box-heading">
                    <h3><%#Eval("Product_Category") %></h3>
                </div>

                <div class="row">
                    <asp:Repeater ID="Product_Repeater" runat="server" DataSourceID="ProductSQL">
                        <ItemTemplate>
                            <div class="col-md-3 col-sm-4">
                                <div class="Card">
                                    <div class="card-img">
                                        <img src='/Handler/Home_Products.ashx?Img=<%#Eval("ProductID") %>' class="img-responsive" />
                                    </div>
                                    
                                    <h4><%#Eval("Product_Title") %></h4>
                                    <h5><%#Eval("Product_Price") %></h5>

                                    <button data-id="<%#Eval("ProductID") %>" data-stock="3" data-commission="2" data-name="<%#Eval("Product_Title") %>" data-summary="" data-price="<%#Eval("Product_Price") %>" data-quantity="1" data-image="/Handler/Home_Products.ashx?Img=<%#Eval("ProductID") %>" type="button" class="btn btn-danger my-cart-btn">Add to Cart</button>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:SqlDataSource ID="ProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                        SelectCommand="SELECT * FROM Home_Product WHERE (Product_CategoryID = @Product_CategoryID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="CategoryIDHF" Name="Product_CategoryID" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="clearfix"></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="Product_CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM Home_Product_Category ORDER BY Ascending"></asp:SqlDataSource>
    </div>


    <script src="JS/cart/jquery-2.2.3.min.js"></script>
    <script src="/Bootstrap/js/bootstrap.min.js"></script>
    <script src="JS/cart/jquery.mycart.js"></script>


    <script type="text/javascript">
        $(function () {
            var goToCartIcon = function ($addTocartBtn) {
                var $cartIcon = $(".my-cart-icon");
                var $image = $('<img width="250px" height="250px" src="' + $addTocartBtn.data("image") + '"/>').css({ "position": "fixed", "z-index": "999" });
                $addTocartBtn.prepend($image);
                var position = $cartIcon.position();
                $image.animate({
                    top: position.top,
                    left: position.left
                }, 1000, "linear", function () {
                    $image.remove();
                });
            }

            $('.my-cart-btn').myCart({
                classCartIcon: 'my-cart-icon',
                classCartBadge: 'my-cart-badge',
                affixCartIcon: true,
                checkoutCart: function (products) {
                    var Get_All_Products = new Array();
                    $.each(products, function () {
                        var add = {};
                        add.id = this.id;
                        add.name = this.name;
                        add.price = this.price;
                        add.quantity = this.quantity;
                        Get_All_Products.push(add);
                    });

                    $.ajax({
                        type: "Post",
                        url: "W_Chart.aspx/Set_Product",
                        data: JSON.stringify({ List_Product: Get_All_Products }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function () { alert("complete") },
                        error: function (err) { alert(err) }
                    });
                },
                clickOnAddToCart: function ($addTocart) {
                    goToCartIcon($addTocart);
                },
                getDiscountPrice: function (products) {
                    var total = 0;
                    $.each(products, function () {
                        total += this.quantity * this.price;
                    });
                    return total * 0.5;
                }
            });
        });
  </script>
</asp:Content>
