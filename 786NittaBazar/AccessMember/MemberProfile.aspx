<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="MemberProfile.aspx.cs" Inherits="NittaBazar.AccessMember.MemberProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Member_Profile.css?v=2.3" rel="stylesheet" />
    <style>
        .mGrid tr td p { font-weight: bold; margin: 0; text-align: right; }
            .mGrid tr td p span { color: #b200ff; margin-left: 5px; }
        .box { background-color: #50a000; padding: 10px; text-align: center; color: #fff; }
        .box h5{font-weight:700;font-size:20px; }
        .box small{font-size:15px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="well Member-info">
        <asp:FormView ID="MemberFormView" runat="server" DataKeyNames="RegistrationID" DataSourceID="MemberSQL" OnItemUpdated="MemberFormView_ItemUpdated" Width="100%">
            <EditItemTemplate>
                <h3>Update Information</h3>
                <div class="col-md-6 col-sm-12">
                    <div class="form-group">
                        <label>Name</label>
                        <asp:TextBox ID="NameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Name") %>' />
                    </div>
                    <div class="form-group">
                        <label>Father&#39;s Name</label>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("FatherName") %>' />
                    </div>
                    <div class="form-group">
                        <label>Mother's Name</label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text='<%# Bind("MotherName") %>' />
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <asp:TextBox ID="PhoneLabel" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' />
                    </div>
                    <div class="form-group">
                        <label>Present Address</label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" Text='<%# Bind("Present_Address") %>' TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <label>Permanent Address</label>
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" Text='<%# Bind("Permanent_Address") %>' TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <asp:TextBox ID="DateofBirth" CssClass="form-control datepicker" runat="server" Text='<%# Bind("DateofBirth") %>' />
                    </div>
                    <div class="form-group">
                        <label>Blood Group</label>
                        <asp:DropDownList ID="BloodGroupDropDownList" runat="server" CssClass="form-control" SelectedValue='<%# Bind("BloodGroup") %>'>
                            <asp:ListItem Value=" ">[ SELECT ]</asp:ListItem>
                            <asp:ListItem>A+</asp:ListItem>
                            <asp:ListItem>A-</asp:ListItem>
                            <asp:ListItem>B+</asp:ListItem>
                            <asp:ListItem>B-</asp:ListItem>
                            <asp:ListItem>AB+</asp:ListItem>
                            <asp:ListItem>AB-</asp:ListItem>
                            <asp:ListItem>O+</asp:ListItem>
                            <asp:ListItem>O-</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <asp:RadioButtonList ID="GenderRadioButtonList" CssClass="form-control" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Gender") %>'>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>
                    <div class="form-group">
                        <label>Nominee Name</label>
                        <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("Nominee_Name") %>' />
                    </div>
                    <div class="form-group">
                        <label>Nominee Relationship</label>
                        <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" Text='<%# Bind("Nominee_Relationship") %>' />
                    </div>
                    <div class="form-group">
                        <label>Nominee Date Of Birth</label>
                        <asp:TextBox ID="TextBox8" CssClass="form-control datepicker" runat="server" Text='<%# Bind("Nominee_DOB","{0:d MMM yyyy}") %>' />
                    </div>
                    <div class="form-group">
                        <label>Bank</label>
                        <asp:TextBox ID="TextBox9" CssClass="form-control" runat="server" Text='<%# Bind("Bank") %>' />
                    </div>
                    <div class="form-group">
                        <label>Branch</label>
                        <asp:TextBox ID="TextBox10" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>' />
                    </div>
                    <div class="form-group">
                        <label>Account Name</label>
                        <asp:TextBox ID="TextBox11" CssClass="form-control" runat="server" Text='<%# Bind("AccountName") %>' />
                    </div>
                    <div class="form-group">
                        <label>Account No.</label>
                        <asp:TextBox ID="TextBox12" CssClass="form-control" runat="server" Text='<%# Bind("AccountNo") %>' />
                    </div>
                    <div class="form-group">
                        <label>Applicant Photo</label>
                        <asp:FileUpload ID="MemberFileUpload" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>National ID</label>
                        <asp:TextBox ID="NationalIDLabel" CssClass="form-control" runat="server" Text='<%# Bind("NationalID") %>' />
                    </div>
                    <div class="form-group">
                        <label>N. ID Image</label>
                        <asp:FileUpload ID="N_IDFileUpload" runat="server" />
                    </div>

                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                </div>
            </EditItemTemplate>

            <ItemTemplate>
                <div class="CIP_Msg">
                    <i class="fas fa-exclamation-triangle"></i><span id="IsCip"><%#Eval("CIP_Msg") %></span>
                </div>

                <div class="Info col-md-12">
                    <h3>
                        <i class="glyphicon glyphicon-user rest-userico"></i>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Name") %>' />
                        <asp:FormView ID="StatusFormView" runat="server" DataSourceID="PakStatusSQL" Width="100%">
                            <EmptyDataTemplate>
                                <small>
                                    <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                                    No Package
                                </small>
                            </EmptyDataTemplate>
                            <ItemTemplate>

                                <%if (Session["CIP"].ToString() == "True")
                                    { %>
                                <i class="fas fa-star cip"></i>
                                <%}
                                    else
                                    { %>
                                <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                                <%} %>
                                <small>
                                    <%#Eval("Member_Package_Status") %>
                                </small>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="PakStatusSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Package.Member_Package_Status FROM Member_Package INNER JOIN Member ON Member_Package.Package_Serial = Member.Member_Package_Serial WHERE (Member.MemberID = @MemberID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </h3>
                    <ul>
                        <li>
                            <span class="glyphicon glyphicon-earphone"></span>
                            <b>Mobile:</b>
                            <asp:Label ID="PhoneLabel1" runat="server" Text='<%# Bind("Phone") %>' />
                        </li>
                        <li>
                            <span class="glyphicon glyphicon-envelope"></span>
                            <b>Email: </b>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Email") %>' />
                        </li>
                        <li>
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <b>Address: </b>
                            <asp:Label ID="AddressLabel" runat="server" Text='<%# Bind("Present_Address") %>' />
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-user rest-userico"></i>
                            <b>Referral ID:</b>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Refarel_UserName") %>' />
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-calendar"></i>
                            <b>Signup Date:</b>
                            <asp:Label ID="SignUpDateLabel" runat="server" Text='<%# Bind("SignUpDate","{0:d MMMM yyyy}") %>' />
                        </li>
                    </ul>
                </div>

              <%--  <div class="col-md-12">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Edit" Text="Update" />
                </div>--%>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Name, Registration.Phone, Registration.Email, Member.MemberID, Member.SignUpDate, Registration.RegistrationID, Refarel_Registration.UserName AS Refarel_UserName, Registration.FatherName, Registration.MotherName, Registration.Present_Address, Registration.Permanent_Address, Registration.DateofBirth, Registration.Gender, Registration.BloodGroup, Registration.NationalID, Member.Nominee_Name, Member.Nominee_Relationship, Member.Bank, Member.Branch, Member.AccountName, Member.AccountNo, Member.Nominee_DOB, CASE WHEN Member.CIP_IncomeLimit &lt;= 0 AND Member.IsCIP = 1 THEN 'Weekly profit sharing limit expired, Please buy product.' ELSE '' END AS CIP_Msg FROM Registration AS Refarel_Registration INNER JOIN Member AS Refarel_Member ON Refarel_Registration.RegistrationID = Refarel_Member.MemberRegistrationID RIGHT OUTER JOIN Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID ON Refarel_Member.MemberID = Member.Referral_MemberID WHERE (Member.InstitutionID = @InstitutionID) AND (Registration.RegistrationID = @RegistrationID)" UpdateCommand="UPDATE  Registration SET  Name = @Name, FatherName = @FatherName, MotherName = @MotherName, DateofBirth = @DateofBirth, BloodGroup = @BloodGroup, Gender = @Gender, NationalID = @NationalID,Present_Address = @Present_Address, Permanent_Address = @Permanent_Address, Phone = @Phone, Email = @Email FROM  Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID
WHERE   (Member.MemberID = @MemberID)


UPDATE Member SET Nominee_Name = @Nominee_Name, Nominee_Relationship = @Nominee_Relationship,Nominee_DOB = @Nominee_DOB, Bank = @Bank, Branch = @Branch, AccountName = @AccountName, AccountNo = @AccountNo WHERE(MemberID = @MemberID)">
            <SelectParameters>
                <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" />
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="FatherName" />
                <asp:Parameter Name="MotherName" />
                <asp:Parameter Name="DateofBirth" />
                <asp:Parameter Name="BloodGroup" />
                <asp:Parameter Name="Gender" />
                <asp:Parameter Name="NationalID" />
                <asp:Parameter Name="Present_Address" />
                <asp:Parameter Name="Permanent_Address" />
                <asp:Parameter Name="Phone" />
                <asp:Parameter Name="Email" />
                <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
                <asp:Parameter Name="Nominee_Name" />
                <asp:Parameter Name="Nominee_Relationship" />
                <asp:Parameter Name="Nominee_DOB" />
                <asp:Parameter Name="Bank" />
                <asp:Parameter Name="Branch" />
                <asp:Parameter Name="AccountName" />
                <asp:Parameter Name="AccountNo" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <asp:FormView ID="CIP_FormView" runat="server" DataSourceID="CIP_CountSQL" Width="100%">
        <ItemTemplate>
            <div class="row" style="margin-bottom:20px;">
                <div class="col-sm-6">
                    <div class="box">
                        <small>Total CIP Customer</small>
                        <h5><%# Eval("Total") %></h5>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="box">
                        <small>Join This Week CIP Customer</small>
                        <h5><%# Eval("Weekly_Total") %></h5>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="CIP_CountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand=" -- Tuesday is first day of week
set datefirst 2;
Select (SELECT COUNT(MemberID)  FROM Member WHERE (IsCIP = 1))AS Total,
(SELECT COUNT(MemberID) FROM Member WHERE (IsCIP = 1) and YEAR(getdate()) = YEAR(SignUpDate) and DATEPART(WEEK,SignUpDate) = DATEPART(WEEK,getdate())) AS Weekly_Total

"></asp:SqlDataSource>

    <%if (OrderGridView.Rows.Count > 0)
        { %>
    <div class="well">
        <h4>Joining Product</h4>
        <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Product_DistributionID" DataSourceID="OrderSQL">
            <Columns>
                <asp:TemplateField HeaderText="Receipt" SortExpression="Distribution_SN">
                    <ItemTemplate>
                        <%# Eval("Distribution_SN") %>
                        <a class="PR" href="CIP_Receipt.aspx?P=<%#Eval("Product_DistributionID") %>">Print</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Details">
                    <ItemTemplate>
                        <asp:HiddenField ID="DistributionIDhf" runat="server" Value='<%#Eval("Product_DistributionID") %>' />
                        <p>Code:<span><%# Eval("Product_Code") %></span></p>
                        <p>Point:<span><%# Eval("Product_Point") %></span></p>
                        <p>Price:<span><%# Eval("Product_Price") %></span></p>
                        <asp:FormView ID="PDetailsFormView" runat="server" DataSourceID="PDetailsSQL" Width="100%">
                            <ItemTemplate>
                                <p>Code:<span><%# Eval("Product_Code") %></span></p>
                                <p>Point:<span><%# Eval("Product_Point") %></span></p>
                                <p>Price:<span><%# Eval("Product_Price") %></span></p>
                                <p>Additional Amount:<span><%# Eval("Additional_Amount") %></span></p>
                                <p>Additional Point:<span><%# Eval("Additional_Point") %></span></p>
                                <p>Change_Date:<span><%# Eval("Product_Change_Date","{0:d MMM yyyy}") %></span></p>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="PDetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Distribution_Change_Record.Product_Change_Date, Product_Distribution_Change_Record.Additional_Amount, Product_Distribution_Change_Record.Additional_Point, Product_Point_Code.Product_Code, Product_Point_Code.Product_Point, Product_Point_Code.Product_Price FROM Product_Distribution_Change_Record INNER JOIN Product_Point_Code ON Product_Distribution_Change_Record.ProductID = Product_Point_Code.Product_PointID WHERE (Product_Distribution_Change_Record.Product_DistributionID = @Product_DistributionID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DistributionIDhf" Name="Product_DistributionID" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Product_Distribution_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Joining Date" SortExpression="Product_Distribution_Date" />
                <asp:TemplateField HeaderText="Status" SortExpression="Is_Delivered">
                    <ItemTemplate>
                        <label class="IsDelivered"><%# Eval("Is_Delivered") %></label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="OrderSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_Distribution.Product_DistributionID, Product_Distribution.Distribution_SN, Product_Distribution.Net_Amount, Product_Distribution.Product_Distribution_Date,  IIF(Product_Distribution.Is_Delivered = 1, 'Delivered', 'Pending') AS Is_Delivered, Product_Point_Code.Product_Code, Product_Point_Code.Product_Point, Product_Point_Code.Product_Price FROM Product_Distribution INNER JOIN Product_Distribution_Records ON Product_Distribution.Product_DistributionID = Product_Distribution_Records.Product_DistributionID INNER JOIN Product_Point_Code ON Product_Distribution_Records.ProductID = Product_Point_Code.Product_PointID WHERE (Product_Distribution.Buy_MemberID = @Buy_MemberID)">
            <SelectParameters>
                <asp:SessionParameter Name="Buy_MemberID" SessionField="MemberID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <%} %>

    <div class="well">
        <h4>Membership Bonus</h4>
        <asp:FormView ID="My_Auto_Plan_FormView" runat="server" DataSourceID="My_AutoSQL" Width="100%">
            <ItemTemplate>
                <div class="row text-center">
                    <div class="col-sm-4">
                        <div class="SN Box">
                            <h5><%#Eval("Auto_Member_SN") %></h5>
                            <small>SN</small>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="Plan Box">
                            <h5><%#Eval("AutoPlan") %></h5>
                            <small>MEMBERSHIP PLAN</small>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="Date Box">
                            <h5><%#Eval("Date","{0:d MMM yyyy}") %></h5>
                            <small>PLAN DATE</small>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <h5>No Bonus</h5>
            </EmptyDataTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="My_AutoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_AutoPlan_Record.Date, Member.Auto_Member_SN, Member_AutoPlan_Policy.AutoPlan, Member_AutoPlan_Record.MemberID FROM Member_AutoPlan_Record INNER JOIN Member ON Member_AutoPlan_Record.MemberID = Member.MemberID INNER JOIN Member_AutoPlan_Policy ON Member_AutoPlan_Record.AutoPlan_No = Member_AutoPlan_Policy.AutoPlan_No WHERE (Member_AutoPlan_Record.Current_Plan_Status = 1) AND (Member_AutoPlan_Record.MemberID = @MemberID)">
            <SelectParameters>
                <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="AutoBonusGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="AutoBonusSQL">
            <Columns>
                <asp:BoundField DataField="AutoPlan" HeaderText="Membership Plan" SortExpression="AutoPlan" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="Tax_Service_Charge" HeaderText="Tax &amp; Charge" SortExpression="Tax_Service_Charge" />
                <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" />
                <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Insert_Date" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="AutoBonusSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Member_AutoPlan_Bonus_Record.MemberID, Member_AutoPlan_Policy.AutoPlan, Member_AutoPlan_Bonus_Record.Amount, Member_AutoPlan_Bonus_Record.Tax_Service_Charge, 
                         Member_AutoPlan_Bonus_Record.Net_Amount, Member_AutoPlan_Bonus_Record.Insert_Date
FROM            Member_AutoPlan_Bonus_Record INNER JOIN
                         Member_AutoPlan_Policy ON Member_AutoPlan_Bonus_Record.AutoPlan_No = Member_AutoPlan_Policy.AutoPlan_No
WHERE        (Member_AutoPlan_Bonus_Record.MemberID = @MemberID)">
            <SelectParameters>
                <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>


    <%if (Notice_Repeater.Items.Count > 0)
        { %>
    <h4>NOTICE</h4>
    <div class="row">
        <asp:Repeater ID="Notice_Repeater" runat="server" DataSourceID="NoticeSQL">
            <ItemTemplate>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4><%# Eval("Notice_Title") %></h4>
                            <em style="color: #ed4055">View Date: <%# Eval("Start_Date","{0: d MMM yyyy}") %> - <%# Eval("End_Date","{0: d MMM yyyy}") %></em>
                        </div>

                        <div class="panel-body">
                            <div class="n-image">
                                <img alt="" src="/Handler/Notice_Image.ashx?Img=<%#Eval("Noticeboard_General_ID") %>" class="img-responsive" />
                            </div>
                            <div class="n-text">
                                <asp:Label ID="NoticeLabel" runat="server" Text='<%# Eval("Notice") %>' />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="NoticeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Noticeboard_General_ID, Notice_Title, Notice, Notice_Image, Start_Date, End_Date, Insert_Date FROM Noticeboard_General WHERE (GETDATE() BETWEEN Start_Date AND End_Date)"></asp:SqlDataSource>
    </div>
    <%} %>

    <script>
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            if ($("#IsCip").text() != "") {
                $(".CIP_Msg").show();
            }


            $('.mGrid .IsDelivered').each(function () {
                var val = $(this).text().trim();
                if (val == "Delivered") {
                    $(this).closest('tr').find('.PR').hide();
                }
            });
        });
    </script>
</asp:Content>
