<%@ Page Title="Add CIP Customer" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Add_cip_Customer.aspx.cs" Inherits="NittaBazar.AccessMember.Add_cip_Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #Is_Position, #Is_Referral, #Is_LeftRight { color: #ff6a00; font-size: 16px; }
        .panel-success { border-color: #f3b300; }
        .panel-success > .panel-heading { color: #fff; background-color: #e2a205; border-color: #f3b300; }

        #Product-info { display: none; }
        #Product-info label { margin: 0 !important; }
        .userid { font-size: 14px; padding: 13px 5px; margin-bottom: 7px; }
        .userid .fa { padding-left: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="ABFormView" runat="server" DataSourceID="AvilAbleBalanceSQL" DataKeyNames="Load_Balance_Available" OnDataBound="ABFormView_DataBound" Width="100%">
        <ItemTemplate>
            <input type="hidden" id="AvaiableBalance" value="<%#Eval("Load_Balance_Available") %>" />
            <h3>
                <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
                Add CIP Customer<br />
                <small class="Available_amt">
                    <i class="fas fa-money-bill-alt" aria-hidden="true"></i>
                    Available Loaded Balance:
                    <strong>৳<%#Eval("Load_Balance_Available","{0:N}") %></strong></small></h3>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="AvilAbleBalanceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Load_Balance_Available FROM Member WHERE (MemberID = @MemberID)">
        <SelectParameters>
            <asp:SessionParameter Name="MemberID" SessionField="MemberID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="row">
        <div class="col-md-8 col-sm-12 well">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h2 class="panel-title">Applicant Info</h2>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Name*<asp:RequiredFieldValidator ID="Required1" runat="server" ControlToValidate="NameTextBox" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="NameTextBox" placeholder="Input Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Father's Name</label>
                        <asp:TextBox ID="FatherNameTextBox" placeholder="Input Father's Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Mother's Name</label>
                        <asp:TextBox ID="MotherNameTextBox" placeholder="Input Mother's Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <asp:TextBox ID="DateofBirthTextBox" placeholder="Input Date of Birth" runat="server" CssClass="form-control datepicker"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Blood Group</label>
                        <asp:DropDownList ID="BloodGroupDropDownList" runat="server" CssClass="form-control">
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
                        <asp:RadioButtonList ID="GenderRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="form-control">
                            <asp:ListItem Selected="True">Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="form-group">
                        <label>National ID/Smart Card/PP No.</label>
                        <asp:TextBox ID="NationalIDTextBox" placeholder="Input National ID/Smart Card ID/PP No." runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Present Address</label>
                        <asp:TextBox ID="Present_AddressTextBox" placeholder="Input Present Address" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Permanent Address</label>
                        <asp:TextBox ID="PermanentTextBox" placeholder="Input Permanent Address" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>
                            Phone*
                <asp:RequiredFieldValidator ID="Required" runat="server" ControlToValidate="PhoneTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="PhoneTextBox" CssClass="EroorStar" ErrorMessage="Invalid Mobile No. " ValidationExpression="(88)?((011)|(015)|(016)|(017)|(018)|(019)|(013)|(014))\d{8,8}" ValidationGroup="1"></asp:RegularExpressionValidator>
                        </label>
                        <asp:TextBox ID="PhoneTextBox" onkeypress="return isNumberKey(event)" runat="server" CssClass="form-control" placeholder="Input Phone number"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>
                            E-mail
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Email" ErrorMessage="Email not valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="1" CssClass="EroorStar"></asp:RegularExpressionValidator>
                        </label>
                        <asp:TextBox ID="Email" runat="server" CssClass="form-control mail_Check" placeholder="Write@mail.com"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Applicant Photo</label>
                        <input id="Applicant_Photo" name="Applicant_Photo" type="file" accept="image/*" />
                        <asp:HiddenField ID="Applicant_Photo_HF" runat="server" />
                    </div>
                </div>
            </div>

            <div class="panel panel-success">
                <div class="panel-heading">
                    <h2 class="panel-title">Nominee Info</h2>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Nominee Name</label>
                        <asp:TextBox ID="NomineeNameTextBox" placeholder="Input Nominee Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Relation With Nominee</label>
                        <asp:TextBox ID="RelationWithNomineeTextBox" placeholder="Input Relation With Nominee" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Nominee Date Of Birth</label>
                        <asp:TextBox ID="Nominee_DOB_TextBox" placeholder="Input Relation With Nominee" runat="server" CssClass="form-control datepicker"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Nominee Photo</label>
                        <input id="Nominee_Photo" name="Nominee_Photo" type="file" accept="image/*" />
                        <asp:HiddenField ID="Nominee_Photo_HF" runat="server" />
                    </div>
                </div>
            </div>

            <div class="panel panel-success">
                <div class="panel-heading">
                    <h2 class="panel-title">Applicant Bank Info</h2>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Bank Name</label>
                        <asp:TextBox ID="BankTextBox" placeholder="Bank Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Branch Name</label>
                        <asp:TextBox ID="BranchTextBox" placeholder="Branch Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Account Name</label>
                        <asp:TextBox ID="AccountNameTextBox" placeholder="Account Name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Account Number</label>
                        <asp:TextBox ID="AccountNumberTextBox" placeholder="Account Number" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="panel panel-success">
                <div class="panel-heading">
                    <h2 class="panel-title">Referral & Sponsor Info</h2>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>
                            Reference ID*
                            <asp:RegularExpressionValidator ID="Re1" runat="server" ControlToValidate="ReferralIDTextBox" ErrorMessage="*" CssClass="EroorStar" ValidationGroup="1" ValidationExpression="^[a-zA-Z0-9]{9,9}$" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ReferralIDTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
                            <asp:Label ID="ReferralIDLabel" runat="server" ForeColor="#FF3300"></asp:Label>
                            <label id="Is_Referral"></label>
                        </label>
                        <asp:TextBox ID="ReferralIDTextBox" autocomplete="off" placeholder="Referral ID" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div id="R_info" class="alert alert-info" style="display: none;">
                        <i class="fas fa-user-circle" aria-hidden="true"></i>
                        <label id="R_Name_Label"></label>
                        <i class="fa fa-phone-square" aria-hidden="true"></i>
                        <label id="R_Phone_Label"></label>
                    </div>

                    <div class="form-group">
                        <label>
                            Placement ID*
                          <asp:RequiredFieldValidator ID="Required3" runat="server" ControlToValidate="PositionMemberUserNameTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="Re2" runat="server" ControlToValidate="PositionMemberUserNameTextBox" ErrorMessage="*" CssClass="EroorStar" ValidationGroup="1" ValidationExpression="^[a-zA-Z0-9]{9,9}$" />
                            <asp:Label ID="PositionLabel" runat="server" ForeColor="#FF3300"></asp:Label>
                            <label id="Is_Position"></label>
                        </label>
                        <asp:TextBox ID="PositionMemberUserNameTextBox" autocomplete="off" placeholder="Placement ID" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div id="P_info" class="alert alert-info" style="display: none;">
                        <i class="fas fa-user-circle"></i>
                        <label id="P_Name_Label"></label>
                        <i class="fa fa-phone-square"></i>
                        <label id="P_Phone_Label"></label>
                        <input id="MemberIDhf" type="hidden" />
                    </div>

                    <div class="form-group">
                        <label>
                            Position Type*<label id="Is_LeftRight"></label>
                            <asp:RequiredFieldValidator ID="Required4" runat="server" ControlToValidate="PositionTypeDropDownList" CssClass="EroorStar" ForeColor="Red" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                            <asp:Label ID="PositionTypeLabel" runat="server" ForeColor="#FF3300"></asp:Label>
                        </label>

                        <asp:DropDownList ID="PositionTypeDropDownList" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                            <asp:ListItem Value="Left">Team A</asp:ListItem>
                            <asp:ListItem Value="Right">Team B</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>
                            Add CIP Product*<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CIP_ProductDropDownList" CssClass="EroorStar" ForeColor="Red" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                        </label>
                        <asp:DropDownList ID="CIP_ProductDropDownList" runat="server" CssClass="form-control" DataSourceID="CIPProductSQL" DataTextField="Product_Code" DataValueField="Product_PointID" AppendDataBoundItems="True">
                            <asp:ListItem Value="0">[ SELECT CIP PRODUCT ]</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="CIPProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Product_PointID, Product_Code FROM Product_Point_Code WHERE (IsCIP = 1) AND (IsActive = 1)"></asp:SqlDataSource>
                    </div>

                    <div id="Product-info" class="alert-success">
                        <div class="userid">
                            <i class="fa fa-shopping-bag"></i>
                            <label id="ProductNameLabel"></label>

                            <i class="fas fa-money-bill-alt"></i>
                            Price:
                           <label id="ProductPriceLabel"></label>
                            <asp:HiddenField ID="PriceHF" runat="server" />

                            <i class="fa fa-star"></i>
                            Point:
                           <label id="ProductPointLabel"></label>
                            <asp:HiddenField ID="PointHF" runat="server" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Number of Joining</label>
                        <asp:DropDownList ID="SignupCount_DropDownList" CssClass="form-control" runat="server">
                            <asp:ListItem Value="1">1 ID</asp:ListItem>
                            <asp:ListItem Value="3">3 IDs</asp:ListItem>
                            <asp:ListItem Value="7">7 IDs</asp:ListItem>
                            <asp:ListItem Value="15">15 IDs</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <asp:SqlDataSource ID="RegistrationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Registration(InstitutionID, UserName, Validation, Category, Name, FatherName, MotherName, DateofBirth, BloodGroup, Gender, NationalID, Present_Address, Permanent_Address, Phone, Email, Image) VALUES (@InstitutionID, @UserName, 'Valid', N'Member', @Name, @FatherName, @MotherName, @DateofBirth, @BloodGroup, @Gender, @NationalID, @Present_Address, @Permanent_Address, @Phone, @Email, CAST(N'' AS xml).value('xs:base64Binary(sql:variable(&quot;@Image&quot;))', 'varbinary(max)'))" SelectCommand="SELECT * FROM [Registration]" UpdateCommand="UPDATE Institution SET Member_SN =Member_SN +1">
                    <InsertParameters>
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" />
                        <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
                        <asp:ControlParameter ControlID="FatherNameTextBox" Name="FatherName" PropertyName="Text" />
                        <asp:ControlParameter ControlID="MotherNameTextBox" Name="MotherName" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DateofBirthTextBox" Name="DateofBirth" PropertyName="Text" />
                        <asp:ControlParameter ControlID="BloodGroupDropDownList" Name="BloodGroup" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="GenderRadioButtonList" Name="Gender" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="NationalIDTextBox" Name="NationalID" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Present_AddressTextBox" Name="Present_Address" PropertyName="Text" />
                        <asp:ControlParameter ControlID="PermanentTextBox" Name="Permanent_Address" PropertyName="Text" />
                        <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Email" Name="Email" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Applicant_Photo_HF" Name="Image" PropertyName="Value" />
                        <asp:Parameter Name="UserName" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Member(MemberRegistrationID, InstitutionID, Referral_MemberID, PositionMemberID, PositionType, Nominee_Name, Nominee_Relationship, Nominee_DOB, Nominee_Image, AccountNo, AccountName, Branch, Bank, Is_Identified, Identified_Date, IsCIP, Member_Package_Serial,CIP_IncomeLimit,Joined_By_RegistrationID,MemberOfficeAreaID,DecimalPoint_Carry) 
VALUES ((SELECT IDENT_CURRENT('Registration')),@InstitutionID,@Referral_MemberID,@PositionMemberID,@PositionType,@Nominee_Name,@Nominee_Relationship,@Nominee_DOB,CAST(N'' AS xml).value('xs:base64Binary(sql:variable(&quot;@Nominee_Image&quot;))', 'varbinary(max)'),@AccountNo,@AccountName,@Branch,@Bank, 1, GETDATE(), 1, 4,IIF(1.5 * @CIP_IncomeLimit &gt; 9000,9000,1.5 * @CIP_IncomeLimit),@Joined_By_RegistrationID,@MemberOfficeAreaID,@DecimalPoint_Carry)"
                    SelectCommand="SELECT * FROM [Member]" UpdateCommand="Add_Update_CarryMember" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter Name="Referral_MemberID" Type="Int32" />
                        <asp:Parameter Name="PositionMemberID" Type="Int32" />
                        <asp:Parameter Name="MemberOfficeAreaID" />
                        <asp:Parameter Name="DecimalPoint_Carry" />
                        <asp:Parameter Name="PositionType" Type="String" />
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:ControlParameter ControlID="NomineeNameTextBox" Name="Nominee_Name" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="RelationWithNomineeTextBox" Name="Nominee_Relationship" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="AccountNumberTextBox" Name="AccountNo" PropertyName="Text" />
                        <asp:ControlParameter ControlID="AccountNameTextBox" Name="AccountName" PropertyName="Text" />
                        <asp:ControlParameter ControlID="BranchTextBox" Name="Branch" PropertyName="Text" />
                        <asp:ControlParameter ControlID="BankTextBox" Name="Bank" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Nominee_Photo_HF" Name="Nominee_Image" PropertyName="Value" />
                        <asp:ControlParameter ControlID="Nominee_DOB_TextBox" Name="Nominee_DOB" PropertyName="Text" />
                        <asp:ControlParameter ControlID="PriceHF" Name="CIP_IncomeLimit" PropertyName="Value" Type="Double" />
                        <asp:SessionParameter Name="Joined_By_RegistrationID" SessionField="RegistrationID" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="MemberID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="UserLoginSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO [User_Login_Info] ([UserName], [Password], [Email]) VALUES (@UserName, @Password, @Email)" SelectCommand="SELECT * FROM [User_Login_Info]">
                    <InsertParameters>
                        <asp:Parameter Name="UserName" Type="String" />
                        <asp:Parameter Name="Password" Type="String" />
                        <asp:ControlParameter ControlID="Email" Name="Email" PropertyName="Text" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SMS_OtherInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO SMS_OtherInfo(SMS_Send_ID, MemberID, RegistrationID) VALUES (@SMS_Send_ID, @MemberID, @RegistrationID)" SelectCommand="SELECT * FROM [SMS_OtherInfo]">
                    <InsertParameters>
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:Parameter DbType="Guid" Name="SMS_Send_ID" />
                        <asp:Parameter Name="MemberID" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="Product_DistributionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Product_Distribution(Product_Total_Amount, Product_Total_Point, Distribution_SN, Is_Confirmed, Confirm_Date, Sell_MemberID, Buy_MemberID) VALUES (@Product_Total_Amount, @Product_Total_Point, dbo.Distribution_SerialNumber(), 1, GETDATE(), @Sell_MemberID, @Buy_MemberID)
SELECT @Product_DistributionID = Scope_identity()
IF(@Join_SN = 0)
UPDATE  Product_Distribution SET  Join_SN = @Product_DistributionID WHERE (Product_DistributionID = @Product_DistributionID)
ELSE
UPDATE  Product_Distribution SET  Join_SN = @Join_SN WHERE (Product_DistributionID = @Product_DistributionID)"
                    SelectCommand="SELECT * FROM [Product_Distribution]" OnInserted="Product_DistributionSQL_Inserted" UpdateCommand="UPDATE Member SET Joined_Member_Amount = Joined_Member_Amount + @Joined_Member_Amount WHERE (MemberID = @MemberID)">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="PriceHF" Name="Product_Total_Amount" PropertyName="Value" />
                        <asp:ControlParameter ControlID="PointHF" Name="Product_Total_Point" PropertyName="Value" />
                        <asp:SessionParameter Name="Sell_MemberID" SessionField="MemberID" />
                        <asp:Parameter Name="Buy_MemberID" />
                        <asp:Parameter Direction="Output" Name="Product_DistributionID" Size="50" />
                        <asp:Parameter Name="Join_SN" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Joined_Member_Amount" />
                        <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="Product_Distribution_RecordsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Product_Distribution_Records(Product_DistributionID, ProductID, SellingQuantity, SellingUnitPrice, SellingUnitPoint) VALUES (@Product_DistributionID, @ProductID, @SellingQuantity, @SellingUnitPrice, @SellingUnitPoint)" SelectCommand="SELECT * FROM [Product_Distribution_Records]">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="CIP_ProductDropDownList" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="SellingQuantity" Type="Int32" DefaultValue="1" />
                        <asp:ControlParameter ControlID="PriceHF" DefaultValue="" Name="SellingUnitPrice" PropertyName="Value" Type="Double" />
                        <asp:ControlParameter ControlID="PointHF" Name="SellingUnitPoint" PropertyName="Value" Type="Double" />
                        <asp:Parameter Name="Product_DistributionID" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="A_PointSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="Add_Point" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM Member " UpdateCommand="Add_Referral_Bonus" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter Name="Point" />
                        <asp:Parameter Name="MemberID" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="MemberID" Type="Int32" />
                        <asp:Parameter Name="Point" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="Update_Designation_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                    SelectCommand="SELECT * FROM [Member_AutoPlan]" UpdateCommand="Add_Designation_Loop" UpdateCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="GenerationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Generation_UniLevel_ID FROM Generation_Uni_Level" UpdateCommand="Add_Generation_UniLevel" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:Parameter Name="MemberID" Type="Int32" />
                        <asp:Parameter Name="Point" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="WeeklyLimitSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Member_CIP_Weekly_Limit_Record(MemberID, LimitAmount, Product_DistributionID) VALUES (@MemberID, 1.5 * @LimitAmount, @Product_DistributionID)" SelectCommand="SELECT * FROM [Member_CIP_Weekly_Limit_Record]">
                    <InsertParameters>
                        <asp:Parameter Name="MemberID" Type="Int32" />
                        <asp:ControlParameter ControlID="PriceHF" Name="LimitAmount" PropertyName="Value" Type="Double" />
                        <asp:Parameter Name="Product_DistributionID" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:Button ID="SignupButton" runat="server" CssClass="btn btn-warning" Text="Submit" ValidationGroup="1" OnClick="SignupButton_Click" />
                <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorStar"></asp:Label>
                <asp:Label ID="ApprovedMSGLabel" runat="server" CssClass="EroorStar" Font-Size="Large"></asp:Label>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {
            //Link Active
            $("#CIP_Customer").addClass('L_Active');

            //Applicant_Photo
            $('input[name=Applicant_Photo]').change(function (e) {
                var file = e.target.files[0];
                canvasResize(file, {
                    width: 200,
                    height: 0,
                    crop: false,
                    quality: 30,
                    callback: function (data) {
                        data.split(",")[1]
                        $("[id*=Applicant_Photo_HF]").val(data.split(",")[1]);
                    }
                });
            });

            //Nominee_Photo
            $('input[name=Nominee_Photo]').change(function (e) {
                var file = e.target.files[0];
                canvasResize(file, {
                    width: 200,
                    height: 0,
                    crop: false,
                    quality: 30,
                    callback: function (data) {
                        data.split(",")[1]
                        $("[id*=Nominee_Photo_HF]").val(data.split(",")[1]);
                    }
                });
            });

            //Date picker
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            //Get Referral Member
            $('[id*=ReferralIDTextBox]').typeahead({
                minLength: 4,
                source: function (request, result) {
                    $.ajax({
                        url: "Add_cip_Customer.aspx/Get_Refarel_ID",
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

                            if (label == "") {
                                $("[id*=SignupButton]").prop("disabled", true);
                                $("#Is_Referral").text("Referral ID is not valid");
                            }
                            else {
                                $("#Is_Referral").text("");
                            }
                        }
                    });
                },
                updater: function (item) {
                    $("#R_info").css("display", "block");
                    $("#R_Name_Label").text(map[item].Name);
                    $("#R_Phone_Label").text(map[item].Phone);
                    return item;
                }
            });

            //Get Position Member
            $('[id*=PositionMemberUserNameTextBox]').typeahead({
                minLength: 4,
                source: function (request, result) {
                    $.ajax({
                        url: "Add_cip_Customer.aspx/Get_Position_ID",
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

                            $("#MemberIDhf").val("");
                            if (label == "") {
                                $("[id*=SignupButton]").prop("disabled", true);
                                $("[id*=PositionTypeDropDownList]").prop("disabled", true);
                                $("[id*=PositionTypeDropDownList]")[0].selectedIndex = 0;
                                $("#Is_Position").text("Placement ID is not valid");
                            }
                            else {
                                $("#Is_Position").text("");
                                $("[id*=PositionTypeDropDownList]").prop("disabled", false);
                            }
                        }
                    });
                },
                updater: function (item) {
                    $("#P_info").css("display", "block");
                    $("#P_Name_Label").text(map[item].Name);
                    $("#P_Phone_Label").text(map[item].Phone);
                    $("#MemberIDhf").val(map[item].MemberID);
                    $("[id*=PositionTypeDropDownList]")[0].selectedIndex = 0;
                    $("#Is_LeftRight").text('');
                    return item;
                }
            });


            //Check Left right
            $("[id*=PositionTypeDropDownList]").prop("disabled", true);

            $("[id*=PositionTypeDropDownList]").on('change', function () {
                var Position_MemberID = $("#MemberIDhf").val();
                var PositionType = $(this).find('option:selected').text();

                if (Position_MemberID != "" && $("[id*=PositionTypeDropDownList] option:selected").val() != "0") {
                    $.ajax({
                        type: "POST",
                        url: "Add_cip_Customer.aspx/Check_Left_Right",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ 'Position_MemberID': Position_MemberID, 'PositionType': PositionType }),
                        dataType: "json",
                        success: function (response) {
                            $("#Is_LeftRight").text(response.d);

                            if (response.d != "") {
                                $("[id*=SignupButton]").prop("disabled", true);
                            }
                            else {
                                if ($("#Is_Position").text() == "" && $("#Is_Referral").text() == "" && $("#Is_LeftRight").text() == "") {
                                    $("[id*=SignupButton]").prop("disabled", false);
                                }
                            }
                        }
                    });
                }

                if (Position_MemberID == "") {
                    $("[id*=PositionMemberUserNameTextBox]").val("");
                }
            });

            //cip product
            $("[id*=CIP_ProductDropDownList]").on('change', function () {
                var PID = $(this).find('option:selected').val();

                if (PID == 0) {
                    $("#Product-info").css("display", "none");
                    $("[id*=PriceHF]").val(0);
                    $("[id*=PointHF]").val(0);
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "Add_cip_Customer.aspx/GetProduct",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ 'pid': PID }),
                        dataType: "json",
                        success: function (response) {
                            var Data = $.parseJSON(response.d);
                            var Price = 0;

                            $.each(Data, function () {
                                $("#Product-info").css("display", "block");
                                $("#ProductNameLabel").text(this.Name);
                                $("#ProductPriceLabel").text(this.Price);
                                $("#ProductPointLabel").text(this.Point);

                                $("[id*=PriceHF]").val(this.Price);
                                $("[id*=PointHF]").val(this.Point);
                                Price = parseFloat(this.Price);
                            });

                            var Balance = parseFloat($("#AvaiableBalance").val());

                            if (Balance >= Price) {
                                $("[id*=SignupButton]").prop("disabled", false);
                                $("[id*=ErrorLabel]").text("");
                            } else {
                                $("[id*=SignupButton]").prop("disabled", true);
                                $("[id*=ErrorLabel]").text("You Don't Have Enough Balance. Your Current Balance: ৳" + Balance.toFixed(2));
                            }
                        }
                    });
                }
            });
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
