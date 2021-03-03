<%@ Page Title="" Language="C#" MasterPageFile="~/Design.Master" AutoEventWireup="true" CodeBehind="Contact_US.aspx.cs" Inherits="NittaBazar.Home.Contact_US" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .map iframe { height: 265px; width: 100%; border: none; }
        .header { background-color: #F5F5F5; color: #cc590c; height: 60px; font-size: 25px; padding: 10px; }
        .contact-banner { margin-bottom: 30px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="container">
        <h3>Contact US</h3>
        <%--<div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="text-center header">Send E-mail</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <input id="fname" name="name" type="text" placeholder="First Name" class="form-control" />
                        </div>
                        <div class="form-group">
                            <input id="lname" name="name" type="text" placeholder="Last Name" class="form-control" />
                        </div>

                        <div class="form-group">
                            <input id="email" name="email" type="text" placeholder="Email Address" class="form-control" />
                        </div>

                        <div class="form-group">
                            <input id="phone" name="phone" type="text" placeholder="Phone" class="form-control" />
                        </div>

                        <div class="form-group">
                            <textarea class="form-control" id="message" name="message" placeholder="Enter your massage for us here. We will get back to you within 2 business days." rows="7"></textarea>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="text-center header">Our Office</div>
                    <div class="panel-body text-center">
                        <h4>Head office</h4>
                        <div>
                            8  Shahid Sangbadik Selina Pervin Sarak,  Gulfeshan Plaza, 12-M, Moghbazar,

                            <br />
                            Ramna, Dhaka-1217<br />
                            Hotline# 01979960786, 01979970786<br />
                            info@nittabazar.xyz<br />
                        </div>
                        <hr />
                        <div id="map1" class="map">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3651.9293128992663!2d90.40596981537156!3d23.749899994711434!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755b888b181f9ab%3A0x526e483d9e0d3901!2sWireless+Railgate+Bara+Moghbazar%2C+Dhaka!5e0!3m2!1sen!2sbd!4v1490793387709"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>

</asp:Content>
