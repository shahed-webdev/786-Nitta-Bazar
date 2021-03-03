<%@ Page Title="Notice" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Notice.aspx.cs" Inherits="NittaBazar.Home.Notice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .n-image img { height: 100%; width: 100%; }
        .n-text { margin-top: 5px; font-size: 15px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="container">
        <h3>NOTICE</h3>
        <asp:Repeater ID="Notice_Repeater" runat="server" DataSourceID="NoticeSQL">
            <ItemTemplate>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><%# Eval("Notice_Title") %></h4>
                        <em style="color:#ed4055">View Date: <%# Eval("Start_Date","{0: d MMM yyyy}") %> - <%# Eval("End_Date","{0: d MMM yyyy}") %></em>
                    </div>

                    <div class="panel-body">
                        <div class="n-image">
                            <img alt="" src="/Handler/Notice_Image.ashx?Img=<%#Eval("Noticeboard_General_ID") %>" class="img-responsive" />
                        </div>
                        <div class="n-text">
                            <%# Eval("Notice") %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="NoticeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Noticeboard_General_ID, Notice_Title, Notice, Notice_Image, Start_Date, End_Date, Insert_Date FROM Noticeboard_General WHERE (GETDATE() BETWEEN Start_Date AND End_Date)"></asp:SqlDataSource>
    </div>
</asp:Content>
