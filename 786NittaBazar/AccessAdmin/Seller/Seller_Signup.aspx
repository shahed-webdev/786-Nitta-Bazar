<%@ Page Title="Registration For Distributor" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Seller_Signup.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Seller_Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Registration For Distributor</h3>

    <div class="col-md-6 well">
         <div class="form-group">
            <label>Distributor Type*<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" InitialValue="S" ControlToValidate="DistributorType_DropDownList" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator></label>
             <asp:DropDownList ID="DistributorType_DropDownList" CssClass="form-control" runat="server">
                 <asp:ListItem Value="S">[ SELECT ]</asp:ListItem>
                 <asp:ListItem Value="0">General</asp:ListItem>
                 <asp:ListItem Value="1">CIP</asp:ListItem>
             </asp:DropDownList>
        </div>
        <div class="form-group">
            <label>Shop Name*<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Shop_Name_TextBox" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator></label>
            <asp:TextBox ID="Shop_Name_TextBox" placeholder="Shop Name" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
         <div class="form-group">
            <label>Proprietor Name*<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Proprietor_TextBox" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator></label>
            <asp:TextBox ID="Proprietor_TextBox" placeholder="Proprietor" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Father's Name*
            <asp:RequiredFieldValidator ID="Required7" runat="server" ControlToValidate="FatherNameTextBox" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="FatherNameTextBox" placeholder="Input Father's Name" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Mother's Name*
            <asp:RequiredFieldValidator ID="Required8" runat="server" ControlToValidate="MotherNameTextBox" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator>
            </label>
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
            <label>
                Gender*
            <asp:RequiredFieldValidator ID="Required5" runat="server" ControlToValidate="GenderRadioButtonList" CssClass="EroorStar" ValidationGroup="1">*</asp:RequiredFieldValidator>
            </label>
            <asp:RadioButtonList ID="GenderRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="form-control">
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="form-group">
            <label>
                Shop Address*
            <asp:RequiredFieldValidator ID="Required6" runat="server" ControlToValidate="Present_AddressTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="Present_AddressTextBox" placeholder="Input Shop Address" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Distributor Address</label>
            <asp:TextBox ID="PermanentTextBox" placeholder="Input Distributor Address" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Phone*
                <asp:RequiredFieldValidator ID="Required" runat="server" ControlToValidate="PhoneTextBox" CssClass="EroorStar" ForeColor="Red" ValidationGroup="1">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="PhoneTextBox" CssClass="EroorStar" ErrorMessage="Invalid Mobile No. " ValidationExpression="(88)?((011)|(015)|(016)|(017)|(018)|(019)|(013)|(014))\d{8,8}" ValidationGroup="1"></asp:RegularExpressionValidator>
            </label>
            <label id="Is_Phone"></label>
            <asp:TextBox ID="PhoneTextBox" onkeypress="return isNumberKey(event)" runat="server" CssClass="form-control _phone_Check" placeholder="Input Phone number"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                E-mail*
                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" CssClass="style4" ErrorMessage="E-mail is required." ForeColor="Red" ToolTip="E-mail is required." ValidationGroup="1">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Email" ErrorMessage="Email not valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="1" CssClass="EroorStar"></asp:RegularExpressionValidator>
            </label>
            <label id="Is_Email"></label>
            <asp:TextBox ID="Email" runat="server" CssClass="form-control mail_Check" placeholder="Write@mail.com"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                User Name*
                 <asp:RequiredFieldValidator ID="UsernameRequired" runat="server" ControlToValidate="UserName" CssClass="EroorStar" ForeColor="Red" ToolTip="Security answer is required." ValidationGroup="1">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="UserName" ErrorMessage="UserName must be minimum of 4-16 characters or digites. first 1 must be letter, Only use (_ .)" ValidationExpression="^[A-Za-z][A-Za-z0-9_.]{3,15}$" ValidationGroup="1" ForeColor="Red"></asp:RegularExpressionValidator>
            </label>
            <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="Input User Name" ToolTip="UserName must be minimum of 4-16 characters or digites. first 1 must be letter, Only use (_ .)"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Password*
                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="*" ToolTip="Password is required." ValidationGroup="1" CssClass="EroorStar"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Input Password" TextMode="Password"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Confirm Password*
                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password" ToolTip="Confirm Password is required." ValidationGroup="1" CssClass="EroorStar">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="1" CssClass="EroorStar"></asp:CompareValidator>
            </label>
            <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" placeholder="Password Again" TextMode="Password"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>
                Security Question*
            <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question" ErrorMessage="Security question is required." ForeColor="Red" InitialValue="0" ToolTip="Security question is required." ValidationGroup="1" CssClass="EroorStar">*</asp:RequiredFieldValidator>
            </label>
            <asp:DropDownList ID="Question" runat="server" CssClass="form-control" EnableViewState="False" ValidationGroup="CreateUserWizard1">
                <asp:ListItem>Select your security question</asp:ListItem>
                <asp:ListItem>What is the first name of your favorite uncle?</asp:ListItem>
                <asp:ListItem>What is your oldest child&#39;s nick name?</asp:ListItem>
                <asp:ListItem>What is the first name of your oldest nephew?</asp:ListItem>
                <asp:ListItem>What is the first name of your aunt?</asp:ListItem>
                <asp:ListItem>Where did you spend your honeymoon?</asp:ListItem>
                <asp:ListItem>What is your favorite game?</asp:ListItem>
                <asp:ListItem>what is your favorite food?</asp:ListItem>
                <asp:ListItem>What was your favorite sport in high school?</asp:ListItem>
                <asp:ListItem>In what city were you born?</asp:ListItem>
                <asp:ListItem>What is the country of your ultimate dream vacation?</asp:ListItem>
                <asp:ListItem>What is the title and author of your favorite book?</asp:ListItem>
                <asp:ListItem>What is your favorite TV program?</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label>
                Security Answer*
            <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer" ErrorMessage="Security answer is required." ForeColor="Red" ToolTip="Security answer is required." ValidationGroup="1">*</asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="Answer" runat="server" CssClass="form-control" placeholder="Answer the Question"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SignupButton" runat="server" CssClass="btn btn-primary" Text="SignUp" ValidationGroup="1" OnClick="SignupButton_Click" />
            <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorStar"></asp:Label>
        </div>
    </div>
    <asp:SqlDataSource ID="RegistrationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Registration(InstitutionID, UserName, Validation, Category, Name, FatherName, MotherName, DateofBirth, BloodGroup, Gender, Present_Address, Permanent_Address, Phone, Email) VALUES (@InstitutionID, @UserName, 'Valid', N'Seller', @Name, @FatherName, @MotherName, @DateofBirth, @BloodGroup, @Gender, @Present_Address, @Permanent_Address, @Phone, @Email)" SelectCommand="SELECT * FROM [Registration]">
        <InsertParameters>
            <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" />
            <asp:ControlParameter ControlID="UserName" DefaultValue="" Name="UserName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="Proprietor_TextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="FatherNameTextBox" Name="FatherName" PropertyName="Text" />
            <asp:ControlParameter ControlID="MotherNameTextBox" Name="MotherName" PropertyName="Text" />
            <asp:ControlParameter ControlID="DateofBirthTextBox" Name="DateofBirth" PropertyName="Text" />
            <asp:ControlParameter ControlID="BloodGroupDropDownList" Name="BloodGroup" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GenderRadioButtonList" Name="Gender" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="Present_AddressTextBox" Name="Present_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="PermanentTextBox" Name="Permanent_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="PhoneTextBox" Name="Phone" PropertyName="Text" />
            <asp:ControlParameter ControlID="Email" Name="Email" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        InsertCommand="INSERT INTO Seller(SellerRegistrationID,Shop_Name,Proprietor,IsCIP) VALUES ((SELECT IDENT_CURRENT('Registration')),@Shop_Name,@Proprietor,@IsCIP )" SelectCommand="SELECT * FROM [Seller]">
        <InsertParameters>
            <asp:ControlParameter ControlID="Shop_Name_TextBox" Name="Shop_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="Proprietor_TextBox" Name="Proprietor" PropertyName="Text" />
            <asp:ControlParameter ControlID="DistributorType_DropDownList" Name="IsCIP" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UserLoginSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO [User_Login_Info] ([UserName], [Password], [Email]) VALUES (@UserName, @Password, @Email)" SelectCommand="SELECT * FROM [User_Login_Info]">
        <InsertParameters>
            <asp:ControlParameter ControlID="UserName" Name="UserName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="Password" Name="Password" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="Email" Name="Email" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <script>
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });
    </script>
</asp:Content>
