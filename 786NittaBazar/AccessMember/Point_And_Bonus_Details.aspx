<%@ Page Title="Point And Bonuses" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Point_And_Bonus_Details.aspx.cs" Inherits="NittaBazar.AccessMember.Point_And_Bonus_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Bonus.css?v=6.6" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="BonusFormView" runat="server" DataSourceID="BonusSQL" Width="100%">
        <ItemTemplate>
            <div class="banner">
                <strong>Available Balance: ৳<%#Eval("Available_Balance","{0:N}") %></strong>
                <a class="pull-right" href="Member_Binarytree.aspx?M=<%#Session["MemberID"].ToString() %>">
                    <i class="fa fa-users fa-2x" aria-hidden="true"></i>
                </a>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="widget bg4">
                        <div class="widget-stat-number"><%#Eval("AvailablePoint") %> <span title="Decimal carry point" class="curry-point">(<%#Eval("DecimalPoint_Carry") %>)</span> <i class="fa fa-star"></i></div>
                        <div class="widget-stat-text">Available Point</div>
                    </div>

                    <div class="widget bg2">
                        <div class="widget-stat-text">Package</div>
                        <div class="widget-stat-number"><%#Eval("Package_Name") %></div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="widget bg4">
                        <div class="widget-stat-number">৳<%#Eval("Load_Balance_Available") %></div>
                        <div class="widget-stat-text">Loaded Balance</div>
                    </div>

                    <div class="widget bg2">
                        <div class="widget-stat-text">Designation</div>
                        <div class="widget-stat-number"><%#Eval("Designation") %></div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="widget bg3">
                        <div class="widget-stat-number"><%#Eval("Left_Carry_Point") %> <i class="fa fa-star"></i></div>
                        <div class="widget-stat-text">Team-A Point</div>
                    </div>

                    <div class="widget bg3">
                        <div class="widget-stat-text">Team-A Member</div>
                        <div class="widget-stat-number"><%#Eval("TotalLeft_Member") %></div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="widget bg1">
                        <div class="widget-stat-number"><%#Eval("Right_Carry_Point") %> <i class="fa fa-star"></i></div>
                        <div class="widget-stat-text">Team-B Point</div>
                    </div>

                    <div class="widget bg1">
                        <div class="widget-stat-text">Team-B Member</div>
                        <div class="widget-stat-number"><%#Eval("TotalRight_Member") %></div>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 25px;">
                <div class="statistics col-md-6">
                    <div class="statistic d-flex align-items-center has-shadow">
                        <div class="icon bg-green"><i class="fas fa-box-open"></i></div>
                        <div class="text">
                            <strong>৳<%#Eval("Withdraw_Balance","{0:N}") %></strong><br>
                            <a href="Bonus_Details/Withdraw_Details.aspx">Withdraw Balance</a>
                        </div>
                    </div>
                    <div class="statistic d-flex align-items-center has-shadow">
                        <div class="icon bg-red"><i class="fas fa-paper-plane"></i></div>
                        <div class="text">
                            <strong>৳<%#Eval("Send_Balance","{0:N}") %></strong><br>
                            <a href="Bonus_Details/Send_Details.aspx">Send Balance</a>
                        </div>
                    </div>
                    <div class="statistic d-flex align-items-center has-shadow">
                        <div class="icon bg-sky"><i class="fas fa-download"></i></div>
                        <div class="text">
                            <strong>৳<%#Eval("Received__Balance","{0:N}") %></strong><br>
                            <a href="Bonus_Details/Received_Details.aspx">Received Balance</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h6>
                                <i class="fas fa-award"></i>
                                Total Income
                                <label id="TotalCom" class="pull-right"></label>
                            </h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-small list-group-flush">
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Referral_Bonus_Details.aspx" class="text-semibold text-fiord-blue">Referral Commission</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Referral_Bonus_Details.aspx">
                                        <span class="BCount"><%#Eval("Referral_Income","{0:0.##}") %></span>
                                    </a>
                                </li>
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Infinity_Bonus_Details.aspx" class="text-semibold text-fiord-blue">Duplex Commission</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Infinity_Bonus_Details.aspx">
                                        <span class="BCount"><%#Eval("Matching_Income","{0:0.##}") %></span></a>
                                </li>
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Generation_Bonus_Details.aspx" class="text-semibold text-fiord-blue">Generation Commission</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Generation_Bonus_Details.aspx">
                                        <span class="BCount"><%#Eval("Generation_Income","{0:0.##}") %></span></a>
                                </li>
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Cash_Back.aspx" class="text-semibold text-fiord-blue">Retail Profit Commission</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Cash_Back.aspx">
                                        <span class="BCount"><%#Eval("Instant_Cash_Back_Income","{0:0.##}") %></span></a>
                                </li>
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Executive_Bonus_Details.aspx" class="text-semibold text-fiord-blue">Executive Bonus</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Executive_Bonus_Details.aspx">
                                        <span class="BCount"><%#Eval("Executive_Bonus_Income","{0:0.##}") %></span></a>
                                </li>
                                <li class="list-group-item d-flex">
                                    <a href="Bonus_Details/Membership_Bonus_Details.aspx" class="text-semibold text-fiord-blue">Membership Bonus</a>
                                    <a class="ml-auto text-right text-semibold text-reagent-gray" href="Bonus_Details/Membership_Bonus_Details.aspx">
                                        <span class="BCount"><%#Eval("Auto_Income","{0:0.##}") %></span></a>
                                </li>
                                <%if (Session["CIP"].ToString() == "True")
                                    { %>
                                <li class="list-group-item d-flex">
                                    <span class="text-semibold text-fiord-blue">Weekly Income</span>
                                    <span class="ml-auto text-right text-semibold text-reagent-gray">
                                        <span class="BCount"><%#Eval("CIP_Income","{0:0.##}") %></span>
                                </li>
                                <%} %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="BonusSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member.Load_Balance_Available, Member.CIP_Income, Member.Auto_Income, Member.AvailablePoint, Member.Referral_Income, Member.Matching_Income, Member.Executive_Bonus_Income, Member.Instant_Cash_Back_Income, Member.Generation_Income, Member.Left_Carry_Point, Member.Right_Carry_Point, Member.TotalLeft_Member, Member.TotalRight_Member, Member.Available_Balance, Member.SignUpDate, Member.Total_Amount, Member.Withdraw_Balance, Member.Send_Balance, Member.Received__Balance, ISNULL(Member_Designation.Designation_ShortKey, 'N/A') AS Designation, ISNULL(Member_Package.Member_Package_Status, 'N/A') AS Package_Name, Member.DecimalPoint_Carry FROM Member LEFT OUTER JOIN Member_Designation ON Member.Designation_SN = Member_Designation.Designation_SN LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial WHERE (Member.MemberID = @MemberID)">
        <SelectParameters>
            <asp:SessionParameter Name="MemberID" SessionField="MemberID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script>
        $(function () {
            $("#Point").addClass('L_Active');

            var grandTotal = 0;
            $(".BCount").each(function () {
                grandTotal = grandTotal + parseFloat($(this).html());
            });
            $("#TotalCom").html("৳" + grandTotal.toFixed(2));
        });
    </script>
</asp:Content>
