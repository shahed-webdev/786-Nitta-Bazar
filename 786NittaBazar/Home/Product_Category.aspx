<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Product_Category.aspx.cs" Inherits="NittaBazar.Home.Product_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Product_Category.css?v=2" rel="stylesheet" />
        <style>
        .img-responsive { margin:auto;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="container-fluid">
        <asp:FormView ID="CategoryFormView" runat="server" DataKeyNames="Product_CategoryID" DataSourceID="CategorySQL" Width="100%">
            <ItemTemplate>
                <h3 id="CN"><%# Eval("Product_Category") %></h3>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Home_Product_Category] WHERE ([Product_CategoryID] = @Product_CategoryID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="Product_CategoryID" QueryStringField="cid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="row">
            <asp:Repeater ID="Product_Repeater" runat="server" DataSourceID="ProductSQL">
                <ItemTemplate>
                    <div class="col-lg-2 col-md-3 col-sm-4 col-xs-6">
                        <div class="Card">
                            <div class="card-img">
                                <img data-src='/Handler/Home_Products.ashx?Img=<%#Eval("ProductID") %>' src="../CSS/Image/loading.gif?v=1" class="img-responsive lazy" />
                            </div>
                            <h4><%#Eval("Product_Title") %></h4>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:SqlDataSource ID="ProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            SelectCommand="SELECT * FROM Home_Product WHERE (Product_CategoryID = @Product_CategoryID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="Product_CategoryID" QueryStringField="cid" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <!-- cdnjs -->
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.plugins.min.js"></script>
    <script>
        $(document).ready(function () {
            $("img.lazy").Lazy();

            $('#bootstrap-touch-slider').find('.item').first().addClass('active');
            $('.blink').blink({ delay: 800 });

            $(document).attr("title", $("#CN").text());
        });
    </script>
</asp:Content>
