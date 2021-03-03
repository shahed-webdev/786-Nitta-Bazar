<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NittaBazar.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/Default.css?v=6.0" rel="stylesheet" />
    <link href="/Home/CSS/Slider.css?v=2.1" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div id="bootstrap-touch-slider" class="carousel bs-slider fade control-round indicators-line" data-ride="carousel" data-pause="hover" data-interval="5000">
        <div class="carousel-inner" role="listbox">
            <asp:Repeater ID="Slider_Repeater" runat="server" DataSourceID="Home_SliderSQL">
                <ItemTemplate>
                    <div class="item">
                        <img data-src='/Handler/Home_Slider.ashx?Img=<%#Eval("SliderID") %>' src='' class="lazy img-responsive" />
                        <%--  <div class="bs-slider-overlay"></div>
                         <div class="slide-text slide_style_center">
                            <h1 data-animation="animated flipInX"><%#Eval("Description") %></h1>
                            <p data-animation="animated lightSpeedIn">Seven86 Nitta Bazar.</p>
                        </div>--%>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Left Control -->
        <a class="left carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="prev">
            <span class="fa fa-angle-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>

        <!-- Right Control -->
        <a class="right carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="next">
            <span class="fa fa-angle-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <asp:SqlDataSource ID="Home_SliderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Home_Slider]"></asp:SqlDataSource>

    <div class="blink">
        Home Delivery Available
    </div>

    <div class="container t-space">
        <asp:Repeater ID="Category_Repeater" runat="server" DataSourceID="Product_CategorySQL">
            <ItemTemplate>
                <asp:HiddenField ID="CategoryIDHF" Value='<%#Bind("Product_CategoryID") %>' runat="server" />
                <div class="box-heading">
                    <div class="row">
                        <div class="col-sm-8 col-xs-8">
                            <h3><%#Eval("Product_Category") %></h3>
                        </div>
                        <div class="col-sm-4 col-xs-4 text-right">
                            <a target="_blank" href="Home/Product_Category.aspx?cid=<%#Eval("Product_CategoryID") %>">View All</a>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 30px">
                    <asp:Repeater ID="Product_Repeater" runat="server" DataSourceID="ProductSQL">
                        <ItemTemplate>
                            <div class="col-md-3 col-sm-4 col-xs-6">
                                <div class="Card">
                                    <div class="card-img">
                                         <img data-src='/Handler/Home_Products.ashx?Img=<%#Eval("ProductID") %>' src='CSS/Image/loading.gif?v=1' class="img-responsive lazy" />
                                    </div>
                                    <h4><%#Eval("Product_Title") %></h4>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="ProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                        SelectCommand="SELECT top(4) Product_Title,ProductID FROM Home_Product WHERE (Product_CategoryID = @Product_CategoryID)">
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


    <script src="/Home/js/Slider.js"></script>
    <script src="/JS/Blink_Text.js"></script>
    <!-- cdnjs -->
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.plugins.min.js"></script>
    <script>
        $(function () {
            $("img.lazy").Lazy();

            $('#bootstrap-touch-slider').find('.item').first().addClass('active');
            $('.blink').blink({ delay: 800 });
        });
    </script>
</asp:Content>
