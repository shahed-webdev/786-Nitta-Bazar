﻿<%@ Page Title="Customer Details" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Member_Details.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.Member_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/Member_details.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <a class="Bak" href="Member_List.aspx"><< Back To Customer List</a>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Customers_Info">Customer Info</a></li>
                <li><a data-toggle="tab" href="#Left_Tree">Team A Customers</a></li>
                <li><a data-toggle="tab" href="#Right_Tree">Team B Customers</a></li>
                <li><a data-toggle="tab" href="#Free_Join">Joining Limit</a></li>
                <li><a data-toggle="tab" href="#ReferralID">Change Referral Id</a></li>
                <li><a data-toggle="tab" href="#tabPlacementID">Change Placement Id</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Customers_Info" class="tab-pane active">
                    <asp:FormView ID="MemberDetailsFormView" DefaultMode="Edit" runat="server" DataKeyNames="MemberID,PositionMemberID,RegistrationID,P_UserName,Default_MemberStatus,PositionType" DataSourceID="MemberDetailsSQL" Width="100%" OnItemUpdated="MemberDetailsFormView_ItemUpdated">
                        <EditItemTemplate>
                            <input id="QueryMemberID" type="hidden" value="<%#Eval("MemberID") %>" />
                            <div class="col-md-6 well">
                                <h3><%#Eval("Name") %></h3>

                                <div class="alert alert-success text-center">
                                    <label>User ID</label>
                                    <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />.

                                    <label>Placement User ID</label>
                                    <asp:Label ID="Placement_Label" runat="server" Text='<%# Bind("P_UserName") %>' />.

                                    <label>Referral User ID</label>
                                    <asp:Label ID="Referral_Label" runat="server" Text='<%# Bind("R_UserName") %>' />.
                                </div>

                                 <div class="form-group">
                                    <label>Customer Photo</label>
                                    <asp:FileUpload ID="CustomerFileUpload" runat="server" />
                                </div>
                                <img alt="" src="/Handler/AllUserPhoto.ashx?Img=<%#Eval("RegistrationID") %>" class="img-responsive img-circle Photo" />


                                <div class="form-group">
                                    <label>Name</label>
                                    <asp:TextBox ID="NameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Name") %>' />
                                </div>

                                <div class="form-group">
                                    <label>Father's Name</label>
                                    <asp:TextBox ID="FatherNameLabel" CssClass="form-control" runat="server" Text='<%# Bind("FatherName") %>' />
                                </div>

                                <div class="form-group">
                                    <label>Mother's Name</label>
                                    <asp:TextBox ID="MotherNameLabel" CssClass="form-control" runat="server" Text='<%# Bind("MotherName") %>' />
                                </div>

                                <div class="form-group">
                                    <asp:RadioButtonList ID="GenderRadioButtonList" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Gender") %>'>
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <div class="form-group">
                                    <label>National ID</label>
                                    <asp:TextBox ID="NationalIDLabel" CssClass="form-control" runat="server" Text='<%# Bind("NationalID") %>' />
                                </div>

                                <div class="form-group">
                                    <label>Present Address</label>
                                    <asp:TextBox ID="Present_AddressLabel" CssClass="form-control" runat="server" Text='<%# Bind("Present_Address") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Permanent Address</label>
                                    <asp:TextBox ID="Permanent_AddressLabel" CssClass="form-control" runat="server" Text='<%# Bind("Permanent_Address") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Phone</label>
                                    <asp:TextBox ID="PhoneLabel" CssClass="form-control" runat="server" Text='<%# Bind("Phone") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <asp:TextBox ID="EmailLabel" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
                                </div>
                                <div class="form-group">
                                    <label>SignUp Date</label>
                                    <asp:Label ID="SignUpDateLabel" runat="server" Text='<%# Bind("SignUpDate","{0:d MMM yyyy}") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Date of Birth</label>
                                    <asp:TextBox ID="DateofBirthLabel" CssClass="form-control datepicker" runat="server" Text='<%# Bind("DateofBirth") %>' />
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
                                    <label>Nominee Name</label>
                                    <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("Nominee_Name") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Nominee Relationship</label>
                                    <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("Nominee_Relationship") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Nominee Date Of Birth</label>
                                    <asp:TextBox ID="TextBox7" CssClass="form-control datepicker" runat="server" Text='<%# Bind("Nominee_DOB") %>' />
                                </div>
                                <img alt="" src="/Handler/Nominee_Image.ashx?Img=<%#Eval("MemberID") %>" class="img-responsive img-circle Photo" />

                                <div class="form-group">
                                    <label>Bank</label>
                                    <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" Text='<%# Bind("Bank") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Branch</label>
                                    <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" Text='<%# Bind("Branch") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Account Name</label>
                                    <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server" Text='<%# Bind("AccountName") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Account No.</label>
                                    <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" Text='<%# Bind("AccountNo") %>' />
                                </div>
                                <div class="form-group">
                                    <label>Upload/Change Doc.</label>
                                    <asp:FileUpload ID="ImageFileUpload" runat="server" />
                                </div>

                                <div class="form-group">
                                    <img alt="" src="/Handler/Document_Image.ashx?Img=<%#Eval("MemberID") %>" class="img-responsive img-thumbnail Doc" />
                                </div>

                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" CssClass="btn btn-primary" Text="Update" />
                            </div>
                        </EditItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="MemberDetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Name, Registration.FatherName, Registration.Gender, Registration.NationalID, Registration.Present_Address, Registration.Permanent_Address, Registration.Phone, Registration.Email, Registration.MotherName, Registration.UserName, Member.Is_Identified, Member.SignUpDate, Member.MemberID, Registration.RegistrationID, Registration.DateofBirth, Registration.BloodGroup, P_Registration.UserName AS P_UserName, R_Registration.UserName AS R_UserName, Member.PositionMemberID, Member.Default_MemberStatus, Member.PositionType, Member.MemberRegistrationID, Member.Nominee_Name, Member.Nominee_Relationship,Member.Nominee_DOB, Member.Bank, Member.Branch, Member.AccountName, Member.AccountNo FROM Registration AS R_Registration INNER JOIN Member AS R_Member ON R_Registration.RegistrationID = R_Member.MemberRegistrationID RIGHT OUTER JOIN Registration AS P_Registration INNER JOIN Member AS P_Member ON P_Registration.RegistrationID = P_Member.MemberRegistrationID RIGHT OUTER JOIN Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID ON P_Member.MemberID = Member.PositionMemberID ON R_Member.MemberID = Member.Referral_MemberID WHERE (Registration.Category = N'Member') AND (Member.MemberID = @MemberID)"
                        UpdateCommand="UPDATE  Registration SET  Name = @Name, FatherName = @FatherName, MotherName = @MotherName, DateofBirth = @DateofBirth, BloodGroup = @BloodGroup, Gender = @Gender, NationalID = @NationalID,Present_Address = @Present_Address, Permanent_Address = @Permanent_Address, Phone = @Phone, Email = @Email FROM  Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID
WHERE   (Member.MemberID = @MemberID)


UPDATE Member SET Nominee_Name = @Nominee_Name, Nominee_Relationship = @Nominee_Relationship,Nominee_DOB = @Nominee_DOB, Bank = @Bank, Branch = @Branch, AccountName = @AccountName, AccountNo = @AccountNo WHERE(MemberID = @MemberID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
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
                            <asp:Parameter Name="MemberID" />
                            <asp:Parameter Name="Nominee_Name" />
                            <asp:Parameter Name="Nominee_Relationship" />
                            <asp:Parameter Name="Bank" />
                            <asp:Parameter Name="Branch" />
                            <asp:Parameter Name="AccountName" />
                            <asp:Parameter Name="AccountNo" />
                            <asp:Parameter Name="Nominee_DOB" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Left_Tree" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">

                                <div class="form-group">
                                    <asp:DropDownList ID="L_Designation_DropDownList" runat="server" CssClass="form-control" AppendDataBoundItems="True" DataSourceID="DesignationSQL" DataTextField="Designation_ShortKey" DataValueField="Designation_ShortKey">
                                        <asp:ListItem Value="%">All Designation</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="DesignationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [Designation_ShortKey] FROM [Member_Designation]"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="L_PackageDropDownList" runat="server" CssClass="form-control" AppendDataBoundItems="True" DataSourceID="PackageSQL" DataTextField="Member_Package_Status" DataValueField="Member_Package_Short_Key">
                                        <asp:ListItem Value="%">All Package</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="PackageSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [Member_Package_Short_Key], [Member_Package_Status] FROM [Member_Package]"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="L_UserIDTextBox" placeholder="User ID" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="L_FindButton" runat="server" CssClass="btn btn-primary" Text="Find" OnClick="L_FindButton_Click" />
                                </div>
                            </div>

                            <div class="alert alert-info">
                                <asp:Label ID="L_Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
                            </div>
                            <asp:GridView ID="LeftGridView" runat="server" CssClass="mGrid" DataSourceID="LeftSQL" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" PageSize="20">
                                <Columns>
                                    <asp:BoundField HeaderText="User ID" DataField="UserID" SortExpression="UserID" />
                                    <asp:BoundField HeaderText="Name" DataField="Name" SortExpression="Name" />
                                    <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" />
                                    <asp:BoundField HeaderText="Designation" DataField="Designation" SortExpression="Designation" />
                                    <asp:BoundField HeaderText="Refarrel ID" DataField="Refarrel_ID" SortExpression="Refarrel_ID" />
                                    <asp:BoundField HeaderText="Package" DataField="Package" SortExpression="Package" />
                                    <asp:BoundField HeaderText="Available Point" DataField="AvailablePoint" SortExpression="AvailablePoint" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No Records Found !
                                </EmptyDataTemplate>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="LeftSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="WITH DirectReports (PositionMemberID, MemberID,PositionType)
AS
(SELECT e.PositionMemberID, e.MemberID, e.PositionType
    FROM dbo.Member AS e
    WHERE PositionMemberID = @MemberID and PositionType = 'Left'
    UNION ALL SELECT e.PositionMemberID, e.MemberID,e.PositionType
    FROM dbo.Member AS e
  INNER JOIN DirectReports AS d ON e.PositionMemberID = d.MemberID
)
SELECT Registration.UserName AS UserID, Registration.Name,Registration.Phone,Refarrel_Registration.UserName AS Refarrel_ID, Member_Package.Member_Package_Short_Key AS Package,Member.AvailablePoint, Member.Member_Incentive_Designation AS Designation
FROM DirectReports
INNER JOIN dbo.Member ON DirectReports.MemberID = Member.MemberID 
INNER JOIN dbo.Registration ON Member.MemberRegistrationID  = Registration.RegistrationID
INNER JOIN Member AS Refarrel_Member ON Member.Referral_MemberID = Refarrel_Member.MemberID 
INNER JOIN Registration AS Refarrel_Registration ON Refarrel_Member.MemberRegistrationID = Refarrel_Registration.RegistrationID
LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial
WHERE Registration.UserName like @UserID +'%' and ISNULL(Member_Package.Member_Package_Short_Key,'') like @Package and ISNULL(Member.Member_Incentive_Designation,'') like @Designation
option (maxrecursion 800)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
                                    <asp:ControlParameter ControlID="L_UserIDTextBox" DefaultValue="%" Name="UserID" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="L_PackageDropDownList" DefaultValue="" Name="Package" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="L_Designation_DropDownList" Name="Designation" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="Right_Tree" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="R_Designation_DropDownList" runat="server" CssClass="form-control" AppendDataBoundItems="True" DataSourceID="DesignationSQL" DataTextField="Designation_ShortKey" DataValueField="Designation_ShortKey">
                                        <asp:ListItem Value="%">All Designation</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="R_PackageDropDownList" runat="server" CssClass="form-control" AppendDataBoundItems="True" DataSourceID="PackageSQL" DataTextField="Member_Package_Status" DataValueField="Member_Package_Short_Key">
                                        <asp:ListItem Value="%">All Package</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="R_UserIDTextBox" runat="server" placeholder="User ID" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="R_Find_Button" runat="server" CssClass="btn btn-primary" Text="Find" OnClick="R_Find_Button_Click" />
                                </div>
                            </div>

                            <div class="alert alert-info">
                                <asp:Label ID="R_Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
                            </div>
                            <asp:GridView ID="RightGridView" runat="server" CssClass="mGrid" DataSourceID="RightSQL" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" PageSize="20">
                                <Columns>
                                    <asp:BoundField HeaderText="User ID" DataField="UserID" SortExpression="UserID" />
                                    <asp:BoundField HeaderText="Name" DataField="Name" SortExpression="Name" />
                                    <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" />
                                    <asp:BoundField HeaderText="Designation" DataField="Designation" SortExpression="Designation" />
                                    <asp:BoundField HeaderText="Refarrel ID" DataField="Refarrel_ID" SortExpression="Refarrel_ID" />
                                    <asp:BoundField HeaderText="Package" DataField="Package" SortExpression="Package" />
                                    <asp:BoundField HeaderText="Available Point" DataField="AvailablePoint" SortExpression="AvailablePoint" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No Records Found !
                                </EmptyDataTemplate>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="RightSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="WITH DirectReports (PositionMemberID, MemberID,PositionType)
AS (SELECT e.PositionMemberID, e.MemberID, e.PositionType
    FROM dbo.Member AS e
    WHERE PositionMemberID = @MemberID and PositionType = 'Right'
    UNION ALL
    SELECT e.PositionMemberID, e.MemberID,e.PositionType
    FROM dbo.Member AS e
  INNER JOIN DirectReports AS d ON e.PositionMemberID = d.MemberID)

SELECT Registration.UserName AS UserID, Registration.Name,Registration.Phone,Refarrel_Registration.UserName AS Refarrel_ID, Member_Package.Member_Package_Short_Key AS Package,Member.AvailablePoint, Member.Member_Incentive_Designation AS Designation
FROM DirectReports
INNER JOIN dbo.Member ON DirectReports.MemberID = Member.MemberID 
INNER JOIN dbo.Registration ON Member.MemberRegistrationID  = Registration.RegistrationID
INNER JOIN Member AS Refarrel_Member ON Member.Referral_MemberID = Refarrel_Member.MemberID 
INNER JOIN Registration AS Refarrel_Registration ON Refarrel_Member.MemberRegistrationID = Refarrel_Registration.RegistrationID
LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial
WHERE Registration.UserName like @UserID +'%' and ISNULL(Member_Package.Member_Package_Short_Key,'') like @Package and ISNULL(Member.Member_Incentive_Designation,'') like @Designation
option (maxrecursion 800)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
                                    <asp:ControlParameter ControlID="R_UserIDTextBox" DefaultValue="%" Name="UserID" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="R_PackageDropDownList" Name="Package" PropertyName="SelectedValue" DefaultValue="" />
                                    <asp:ControlParameter ControlID="R_Designation_DropDownList" Name="Designation" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="Free_Join" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="Joining_Limit_TextBox" placeholder="Joining Limit" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RF" runat="server" ErrorMessage="*" CssClass="EroorStar" ControlToValidate="Joining_Limit_TextBox" ValidationGroup="JL"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="Joining_LimitButton" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="Joining_LimitButton_Click" ValidationGroup="JL" />
                                </div>
                            </div>

                            <asp:GridView ID="Joining_Limit_GridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="Joining_LimitSQL">
                                <Columns>
                                    <asp:BoundField DataField="FreeJoinLimit" HeaderText="Free Joining Limit" SortExpression="FreeJoinLimit" />
                                    <asp:CommandField ShowEditButton="True" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Joining_LimitSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT FreeJoinLimit FROM Member WHERE (MemberID = @MemberID)" UpdateCommand="UPDATE [Member] SET [FreeJoinLimit] = @FreeJoinLimit WHERE [MemberID] = @MemberID">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="Joining_Limit_TextBox" Name="FreeJoinLimit" PropertyName="Text" Type="Int32" />
                                    <asp:QueryStringParameter Name="MemberID" QueryStringField="member" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="ReferralID" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="alert alert-info">
                                <strong>Current Referral Id:
                                    <label id="Referral_id"></label>
                                </strong>
                            </div>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="ReferralID_TextBox" autocomplete="off" placeholder="Enter Referral Id" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="Change_Referral_Button" CssClass="btn btn-primary" runat="server" Text="Change Referral Id" OnClick="Change_Referral_Button_Click" />
                                    <asp:SqlDataSource ID="Change_ReferralSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT MemberID FROM Member WHERE (MemberID = @MemberID)" UpdateCommand="UPDATE Member SET Referral_MemberID = @Referral_MemberID WHERE (MemberID = @MemberID) AND (MemberID &lt;&gt; @Referral_MemberID)">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:ControlParameter ControlID="Referral_MemberidHF" Name="Referral_MemberID" PropertyName="Value" />
                                            <asp:QueryStringParameter Name="MemberID" QueryStringField="member" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                            <div id="R_info" class="alert alert-success" style="display: none;">
                                <i class="fas fa-user-circle" aria-hidden="true"></i>
                                <label id="R_Name_Label"></label>
                                <i class="fa fa-phone-square" aria-hidden="true"></i>
                                <label id="R_Phone_Label"></label>
                                <asp:HiddenField ID="Referral_MemberidHF" runat="server" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="tabPlacementID" class="tab-pane">
                    <div class="alert alert-info">
                        <strong>Current Placement Id:
                           <label id="Current_Plc_ID"></label>
                        </strong>
                    </div>

                    <div class="form-inline">
                        <div class="form-group">
                            <asp:TextBox ID="PositionMemberUserNameTextBox" autocomplete="off" runat="server" CssClass="form-control" placeholder="Placement ID"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="Required3" runat="server" ControlToValidate="PositionMemberUserNameTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:DropDownList ID="PositionTypeDropDownList" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">[ POSITION TYPE ]</asp:ListItem>
                                <asp:ListItem>Left</asp:ListItem>
                                <asp:ListItem>Right</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="Required4" runat="server" ControlToValidate="PositionTypeDropDownList" CssClass="EroorStar" ForeColor="Red" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="ChangeIDButton" runat="server" CssClass="btn btn-primary" Text="Change Placement" ValidationGroup="1" OnClick="ChangeIDButton_Click" />
                            <asp:Label ID="PositionTypeLabel" runat="server" CssClass="Error"></asp:Label>
                            <asp:Label ID="PositionLabel" runat="server" CssClass="Error"></asp:Label>
                            <label id="Is_P_Position"></label>
                        </div>
                    </div>

                    <div id="P_info" class="alert alert-success" style="display: none;">
                        <i class="fa fa-user-circle"></i>
                        <label id="P_Name_Label"></label>
                        <i class="fa fa-phone-square"></i>
                        <label id="P_Phone_Label"></label>
                    </div>

                    <asp:SqlDataSource ID="UpdatePlacementSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Member]" UpdateCommand="UPDATE Member SET PositionMemberID = @PositionMemberID, PositionType =@PositionType WHERE (MemberID = @MemberID)" InsertCommand="Add_Update_CarryMember" InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="MemberID" PropertyName="DataKey[0]" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="PositionMemberID" />
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="MemberID" PropertyName="DataKey[0]" Type="Int32" />
                            <asp:ControlParameter ControlID="PositionTypeDropDownList" Name="PositionType" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="UpdateOldPlacementSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="Add_Update_CarryMember" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [Member] ">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="MemberID" PropertyName="DataKey[1]" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="Position_Change_RecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Member_Position_Change_Record(MemberID, Old_PositionMemberID, New_PositionMemberID, Admin_RegistrationID, Old_PositionType, New_PositionType) VALUES (@MemberID, @Old_PositionMemberID, @New_PositionMemberID, @Admin_RegistrationID, @Old_PositionType, @New_PositionType)" SelectCommand="SELECT * FROM [Member_Position_Change_Record]">
                        <InsertParameters>
                            <asp:SessionParameter Name="Admin_RegistrationID" SessionField="RegistrationID" Type="Int32" />
                            <asp:QueryStringParameter Name="MemberID" QueryStringField="member" Type="Int32" />
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="Old_PositionMemberID" PropertyName="DataKey[1]" Type="Int32" />
                            <asp:ControlParameter ControlID="PositionTypeDropDownList" Name="New_PositionType" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="Old_PositionType" PropertyName="DataKey[5]" Type="String" />
                            <asp:Parameter Name="New_PositionMemberID" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="Update_Old_M_Position_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT MemberID FROM Member" UpdateCommand="IF(@Position ='Left')
BEGIN
UPDATE Member SET Left_Status = 0 Where (MemberID = @PositionMemberID)
END
IF(@Position ='Right')
BEGIN
UPDATE Member SET Right_Status = 0 Where (MemberID = @PositionMemberID)
END">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="Position" PropertyName="DataKey[5]" />
                            <asp:ControlParameter ControlID="MemberDetailsFormView" Name="PositionMemberID" PropertyName="DataKey[1]" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="Update_M_PositionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT MemberID FROM Member" UpdateCommand="IF(@Position ='Left')
BEGIN
UPDATE Member SET Left_Status = 1 Where (MemberID = @MemberID)
END
IF(@Position ='Right')
BEGIN
UPDATE Member SET Right_Status = 1 Where (MemberID = @MemberID)
END">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="PositionTypeDropDownList" Name="Position" PropertyName="SelectedValue" />
                            <asp:Parameter Name="MemberID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>


    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <div id="progress_BG"></div>
            <div id="progress">
                <img src="/CSS/Image/loading.gif" alt="Loading..." />
                <br />
                <b>Loading...</b>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <script>
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            $('#Referral_id').text($('[id*=Referral_Label]').text());

            //Autocomplete... User ID
            $('[id*=ReferralID_TextBox]').typeahead({
                minLength: 4,
                source: function (request, result) {
                    $.ajax({
                        url: "Member_Details.aspx/Get_UserInfo_ID",
                        data: JSON.stringify({ 'prefix': request }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            label = [];
                            map = {};
                            $.map(JSON.parse(response.d), function (item) {
                                label.push(item.Username);
                                map[item.Username] = item;
                            });
                            result(label);
                        }
                    });
                },
                updater: function (item) {
                    $("#R_info").css("display", "block");
                    $("#R_Name_Label").text(map[item].Name);
                    $("#R_Phone_Label").text(map[item].Phone);
                    $("[id*=Referral_MemberidHF]").val(map[item].MemberID);
                    return item;
                }
            });


            $('#Current_Plc_ID').text($('[id*=Placement_Label]').text());

            //Autocomplete... User ID
            $('[id*=PositionMemberUserNameTextBox]').typeahead({
                minLength: 4,
                source: function (request, result) {
                    $.ajax({
                        url: "Member_Details.aspx/Get_UserInfo_ID",
                        data: JSON.stringify({ 'prefix': request }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            label = [];
                            map = {};
                            $.map(JSON.parse(response.d), function (item) {
                                label.push(item.Username);
                                map[item.Username] = item;
                            });
                            result(label);
                        }
                    });
                },
                updater: function (item) {
                    $("#P_info").css("display", "block");
                    $("#P_Name_Label").text(map[item].Name);
                    $("#P_Phone_Label").text(map[item].Phone);
                    $("[id*=PositionTypeDropDownList]")[0].selectedIndex = 0;
                    return item;
                }
            });

            $("[id*=PositionTypeDropDownList]").on('change', function () {
                var PositionType = $(this).find('option:selected').text();
                var memberID = $("#QueryMemberID").val();
                var Pmuser = $('[id*=PositionMemberUserNameTextBox]').val();

                if ($("[id*=PositionTypeDropDownList] option:selected").val() != "0") {
                    $.ajax({
                        type: "POST",
                        url: "Member_Details.aspx/Check_PositionMemberUserName",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ 'MemberID': memberID, 'PositionMemberUserName': Pmuser, 'PositionType': PositionType }),
                        dataType: "json",
                        success: function (response) {
                            $("#Is_P_Position").text(response.d);

                            if (response.d != "") {
                                $("[id*=ChangeIDButton]").prop("disabled", true);
                            }
                            else {

                                $("[id*=ChangeIDButton]").prop("disabled", false);
                            }
                        }
                    });
                }
            });
        });

        //For Update Pannel
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {
            $('[id*=ReferralID_TextBox]').typeahead({
                minLength: 4,
                source: function (request, result) {
                    $.ajax({
                        url: "Member_Details.aspx/Get_UserInfo_ID",
                        data: JSON.stringify({ 'prefix': request }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            label = [];
                            map = {};
                            $.map(JSON.parse(response.d), function (item) {
                                label.push(item.Username);
                                map[item.Username] = item;
                            });
                            result(label);
                        }
                    });
                },
                updater: function (item) {
                    $("#R_info").css("display", "block");
                    $("#R_Name_Label").text(map[item].Name);
                    $("#R_Phone_Label").text(map[item].Phone);
                    $("[id*=Referral_MemberidHF]").val(map[item].MemberID);
                    return item;
                }
            });
        });
    </script>
</asp:Content>
