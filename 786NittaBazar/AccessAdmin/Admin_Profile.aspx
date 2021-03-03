<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Admin_Profile.aspx.cs" Inherits="NittaBazar.AccessAdmin.Admin_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Admin_Profile.css?v1.1" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="well main-info">
        <asp:FormView ID="AdminFormView" runat="server" DataKeyNames="RegistrationID" DataSourceID="AdminSQL" OnItemUpdated="AdminFormView_ItemUpdated" Width="100%">
            <EditItemTemplate>
                <div class="col-md-6 col-sm-12">
                    <div class="form-group">
                        <label>Name</label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("Name") %>' />
                    </div>

                    <div class="form-group">
                        <label>Father&#39;s Name:</label>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("FatherName") %>' />
                    </div>
                    <div class="form-group">
                        <label>Mother's Name:</label>
                        <asp:TextBox ID="MotherNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("MotherName") %>' />
                    </div>

                    <div class="form-group">
                        <label>Mobile:</label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text='<%# Bind("Phone") %>' />
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' />
                    </div>
                    <div class="form-group">
                        <label>Present Address:</label>
                        <asp:TextBox ID="Present_AddressTextBox" runat="server" CssClass="form-control" Text='<%# Bind("Present_Address") %>' TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <label>Permanent Address:</label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" Text='<%# Bind("Permanent_Address") %>' TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <label>Image:</label>
                        <asp:FileUpload ID="AdminFileUpload" runat="server" />
                    </div>

                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                </div>
            </EditItemTemplate>

            <ItemTemplate>
                <div class="Info col-md-12">
                    <h3>
                        <i class="glyphicon glyphicon-user rest-userico"></i>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Name") %>' />
                    </h3>

                    <ul>
                        <li>
                            <i class="glyphicon glyphicon-user rest-userico"></i>
                            <b>Father's Name:</b>
                            <asp:Label ID="FatherNameLabel" runat="server" Text='<%# Bind("FatherName") %>' />
                        </li>
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
                    </ul>
                </div>

                <div class="col-md-12">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Edit" Text="Update" />
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="AdminSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT RegistrationID, Name, FatherName, MotherName, DateofBirth, BloodGroup, Gender, NationalID, Present_Address, Permanent_Address, Phone, Email FROM Registration WHERE (RegistrationID = @RegistrationID)" UpdateCommand="UPDATE Registration SET Name = @Name, FatherName = @FatherName, Phone = @Phone, Email = @Email, MotherName = @MotherName, Present_Address = @Present_Address, Permanent_Address = @Permanent_Address WHERE (RegistrationID = @RegistrationID)">
            <SelectParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="FatherName" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Email" />
                <asp:Parameter Name="MotherName" />
                <asp:Parameter Name="Present_Address" />
                <asp:Parameter Name="Permanent_Address" />
                <asp:Parameter Name="RegistrationID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <asp:FormView ID="ABFormView" runat="server" DataSourceID="ABSQL" Width="100%">
        <ItemTemplate>
            <div class="alert alert-info">
                <h4 style="margin-bottom: 0">Balance: <strong>৳<%# Eval("Sub_Balance","{0:N}") %></strong></h4>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="ABSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [Sub_Balance] FROM [Sub_Admin_Account] WHERE ([SubAdmin_RegistrationID] = @SubAdmin_RegistrationID)">
        <SelectParameters>
            <asp:SessionParameter Name="SubAdmin_RegistrationID" SessionField="RegistrationID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Total_Customers">Total Customers</a></li>
                <li><a data-toggle="tab" href="#total_distributors">Total Distributors</a></li>
                <%if (AccountGridView.Rows.Count > 0)
                    { %>
                <li><a data-toggle="tab" href="#Balance_Approve">Balance Approve</a></li>
                <%} %>
                <li><a data-toggle="tab" href="#PChange">Change Password</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Total_Customers" class="tab-pane active">
                    <asp:FormView ID="AU_FormView" runat="server" DataSourceID="Appr_UnAppSQL" Width="100%">
                        <ItemTemplate>
                            <div class="card Total-title">
                                Total Customers: <%# Eval("Total_Customer","{0:N0}") %>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="Appr_UnAppSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT(SELECT count(MemberID) FROM Member)AS Total_Customer, (SELECT count(MemberID)  FROM Member WHERE Is_Identified = 0)AS Unapproved, (SELECT count(MemberID)  FROM Member WHERE Is_Identified = 1)AS Approved"></asp:SqlDataSource>

                    <div class="card">
                        <asp:Repeater ID="DesignationRepeater" DataSourceID="DesignationSQL" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                                    <thead>
                                        <th>Designation</th>
                                        <th>Total Customer</th>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><i class="fas fa-user"></i>
                                        
                                        <%#Eval("Designation") %></td>
                                    <td><%#Eval("Total_Customer") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody> 
                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="DesignationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT COUNT(Member.MemberID) AS Total_Customer, ISNULL(Member_Designation.Designation_ShortKey, 'Without Designation') AS Designation FROM Member LEFT OUTER JOIN Member_Designation ON Member.Designation_SN = Member_Designation.Designation_SN GROUP BY Member_Designation.Designation_ShortKey, Member.Designation_SN ORDER BY Member.Designation_SN"></asp:SqlDataSource>
                    </div>
                    <br />
                    <div class="card">
                        <asp:Repeater ID="PackageRepeater" DataSourceID="PackageSQL" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                                    <thead>
                                        <th>Package</th>
                                        <th>Total Customer</th>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><i class="fas fa-user-tie"></i>
                                        <%#Eval("Package") %></td>
                                    <td><%#Eval("Total_Customer") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody> 
                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="PackageSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT COUNT(Member.MemberID) AS Total_Customer, ISNULL(Member_Package.Member_Package_Status, 'No Package') AS Package FROM Member LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial GROUP BY Member_Package.Member_Package_Status, Member.Member_Package_Serial ORDER BY Member.Member_Package_Serial"></asp:SqlDataSource>
                    </div>
                </div>
                <div id="total_distributors" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="SellerTypeDropDownList" OnSelectedIndexChanged="SellerTypeDropDownList_SelectedIndexChanged" CssClass="form-control" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="0">General</asp:ListItem>
                                        <asp:ListItem Value="1">CIP</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="alert alert-info">
                                <asp:Label ID="Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="SellerGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="SellerSQL" AllowSorting="True" PageSize="20" DataKeyNames="SellerID" AllowPaging="True">
                                    <Columns>
                                        <asp:HyperLinkField DataTextField="UserName" DataNavigateUrlFields="SellerID" DataNavigateUrlFormatString="Seller/Seller_Products_Stock_Details.aspx?d={0}" HeaderText="User ID" Target="_blank" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                        <asp:BoundField DataField="Present_Address" HeaderText="Shop Address" SortExpression="Present_Address" />
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Registration.Email, Seller.SellingPoint, Seller.Selling_Income, Registration.Present_Address, Registration.CreateDate, Seller.SellerID, Seller.IsCIP FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.IsCIP = @IsCIP)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="SellerTypeDropDownList" Name="IsCIP" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <%if (AccountGridView.Rows.Count > 0)
                    { %>
                <div id="Balance_Approve" class="tab-pane">
                    <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="AccountSQL" DataKeyNames="Recharge_AuthorizationID">
                        <Columns>
                            <asp:BoundField DataField="Reg_For" HeaderText="Recharge For" SortExpression="Reg_For" />
                            <asp:BoundField DataField="Recharge_Balance" HeaderText="Balance" SortExpression="Recharge_Balance" DataFormatString="{0:N}" />
                            <asp:BoundField DataField="Reg_For_Phone" HeaderText="Phone" SortExpression="Reg_For_Phone" />
                            <asp:BoundField DataField="Approved_Code" HeaderText="Code" SortExpression="Approved_Code" />
                            <asp:BoundField DataField="Recharge_Date" HeaderText="Recharge Date" SortExpression="Recharge_Date" DataFormatString="{0:d MMM yyyy}" />
                            <asp:BoundField DataField="Reg_By" HeaderText="Recharge by" SortExpression="Reg_By" />
                            <asp:TemplateField HeaderText="Approve" SortExpression="IS_Authority">
                                <ItemTemplate>
                                    <asp:CheckBox ID="Authority_CheckBox" runat="server" Text=" " AutoPostBack="True" OnCheckedChanged="Authority_CheckBox_CheckedChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Sub_Recharge_Authorization.Recharge_AuthorizationID, Sub_Recharge_Authorization.Sub_Admin_RechargeRecordID, Sub_Recharge_Authorization.SubAdminAccountID, Sub_Recharge_Authorization.Is_Approved, 
                         Sub_Recharge_Authorization.Approved_Code, Sub_Recharge_Authorization.Authority_RegistrationID, Sub_Admin_RechargeRecord.Recharge_Balance, Sub_Admin_RechargeRecord.Recharge_Date, RegFor_T.Name AS Reg_For,
                          RegFor_T.Phone AS Reg_For_Phone, RegBy_T.Name AS Reg_By
FROM Sub_Admin_Account INNER JOIN
                         Sub_Recharge_Authorization INNER JOIN
                         Sub_Admin_RechargeRecord ON Sub_Recharge_Authorization.Sub_Admin_RechargeRecordID = Sub_Admin_RechargeRecord.Sub_Admin_RechargeRecordID ON 
                         Sub_Admin_Account.SubAdminAccountID = Sub_Admin_RechargeRecord.SubAdminAccountID INNER JOIN
                         Registration AS RegFor_T ON Sub_Admin_Account.SubAdmin_RegistrationID = RegFor_T.RegistrationID INNER JOIN
                         Registration AS RegBy_T ON Sub_Admin_RechargeRecord.Recharge_By_RegID = RegBy_T.RegistrationID
WHERE (Sub_Recharge_Authorization.Authority_RegistrationID = @RegistrationID) AND (Sub_Recharge_Authorization.Is_Approved = 0)"
                        UpdateCommand="UPDATE Sub_Recharge_Authorization SET Is_Approved = 1, Approved_Process = N'Logedin' WHERE (Recharge_AuthorizationID = @Recharge_AuthorizationID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Recharge_AuthorizationID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <%} %>

                <div id="PChange" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:ChangePassword Width="100%" ID="ChangePassword" runat="server" ChangePasswordFailureText="Password incorrect or New Password invalid." OnChangedPassword="ChangePassword1_ChangedPassword">
                                <ChangePasswordTemplate>
                                    <div class="col-md-6">
                                        <div class="well">
                                            <div class="form-group">
                                                <label>Old Password</label>
                                                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" CssClass="EroorStar" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                <asp:TextBox ID="CurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label>New Password</label>
                                                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" CssClass="EroorStar" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="NewPassword" CssClass="EroorStar" Display="Dynamic" ErrorMessage="Minimum 6 and Maximum 30 characters required." ValidationExpression="^[\s\S]{6,30}$" ValidationGroup="ChangePassword1"></asp:RegularExpressionValidator>
                                                <asp:TextBox ID="NewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label>New Password Again</label>
                                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" CssClass="EroorStar" Display="Dynamic" ErrorMessage="New password does not match" ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" CssClass="EroorStar" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" CssClass="btn btn-primary" Text="Change" ValidationGroup="ChangePassword1" />
                                                <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-primary" Text="Cancel" />
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </ChangePasswordTemplate>
                                <SuccessTemplate>
                                    <div class="alert alert-success">
                                        <label>Congratulation!!</label>
                                        <label>You have Successfully Changed Your Password!</label>
                                        <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" CommandName="Continue" CssClass="btn btn-primary" PostBackUrl="~/Profile_Redirect.aspx" Text="Continue" />
                                    </div>
                                </SuccessTemplate>
                            </asp:ChangePassword>
                            <asp:SqlDataSource ID="User_Login_InfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [User_Login_Info]" UpdateCommand="UPDATE User_Login_Info SET Password = @Password WHERE (UserName = @UserName)">
                                <UpdateParameters>
                                    <asp:Parameter Name="Password" Type="String" />
                                    <asp:Parameter Name="UserName" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
