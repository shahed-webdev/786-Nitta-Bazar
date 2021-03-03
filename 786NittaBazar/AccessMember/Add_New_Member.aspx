<%@ Page Title="Add Customer" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Add_New_Member.aspx.cs" Inherits="NittaBazar.AccessMember.Add_New_Member" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #Is_Position, #Is_Referral, #Is_LeftRight { color: #ff6a00; font-size: 16px; }
        .panel-success { border-color: #040768; }
            .panel-success > .panel-heading { color: #fff; background-color: #2D3091; border-color: #040768; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row" id="AF">
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
                <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Member(MemberRegistrationID, InstitutionID, Referral_MemberID, PositionMemberID, PositionType, Nominee_Name, Nominee_Relationship, Nominee_DOB,Nominee_Image, AccountNo, AccountName, Branch, Bank, Is_Identified, Identified_Date,Joined_By_RegistrationID) VALUES ((SELECT IDENT_CURRENT('Registration')), @InstitutionID, @Referral_MemberID, @PositionMemberID, @PositionType, @Nominee_Name, @Nominee_Relationship,@Nominee_DOB, CAST(N'' AS xml).value('xs:base64Binary(sql:variable(&quot;@Nominee_Image&quot;))', 'varbinary(max)'), @AccountNo, @AccountName, @Branch, @Bank,1,getdate(),@Joined_By_RegistrationID)" SelectCommand="SELECT * FROM [Member]" UpdateCommand="Add_Update_CarryMember" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter Name="Referral_MemberID" Type="Int32" />
                        <asp:Parameter Name="PositionMemberID" Type="Int32" />
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:ControlParameter ControlID="PositionTypeDropDownList" Name="PositionType" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="NomineeNameTextBox" Name="Nominee_Name" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="RelationWithNomineeTextBox" Name="Nominee_Relationship" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="AccountNumberTextBox" Name="AccountNo" PropertyName="Text" />
                        <asp:ControlParameter ControlID="AccountNameTextBox" Name="AccountName" PropertyName="Text" />
                        <asp:ControlParameter ControlID="BranchTextBox" Name="Branch" PropertyName="Text" />
                        <asp:ControlParameter ControlID="BankTextBox" Name="Bank" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Nominee_Photo_HF" Name="Nominee_Image" PropertyName="Value" />
                        <asp:ControlParameter ControlID="Nominee_DOB_TextBox" Name="Nominee_DOB" PropertyName="Text" />
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
                <asp:SqlDataSource ID="FeeJoinUpdateSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [FreeJoinLimit], [MemberID] FROM [Member]" UpdateCommand="UPDATE [Member] SET [FreeJoinLimit] = FreeJoinLimit -1 WHERE [MemberID] = @MemberID">
                    <UpdateParameters>
                        <asp:SessionParameter Name="MemberID" SessionField="MemberID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Button ID="SignupButton" runat="server" CssClass="btn btn-primary" Text="Submit" ValidationGroup="1" OnClick="SignupButton_Click" />
                <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorStar"></asp:Label>
                <asp:Label ID="ApprovedMSGLabel" runat="server" CssClass="EroorStar" Font-Size="Large"></asp:Label>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {
            //Link Active
            $("#Add_Customer").addClass('L_Active');

            //join limit
            if ($("[id*=JoinLimit_HF]").val() <= 0) {
                $("#AF").hide();
                $(location).prop('href', 'MemberProfile.aspx')
            }

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
                        url: "Add_New_Member.aspx/Get_Refarel_ID",
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
                        url: "Add_New_Member.aspx/Get_UserInfo_ID",
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
                        url: "Add_New_Member.aspx/Check_Left_Right",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ 'Position_MemberID': Position_MemberID, 'PositionType': PositionType}),
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
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
