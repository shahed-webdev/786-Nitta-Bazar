<%@ Page Title="Send SMS From Contact List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Send_SMS_From_Contact.aspx.cs" Inherits="NittaBazar.AccessAdmin.SMS.Send_SMS_From_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #counter { margin: 0; padding: 0; }
            #counter li { margin-right: 10px; margin-bottom: 10px; list-style: none; float: left; background-color: #4B515D; padding: 2px 10px; border-radius: 5px; color: #fff; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="SMSFormView" runat="server" DataSourceID="SMSSQL" Width="100%" CssClass="NoPrint">
        <ItemTemplate>
            <h3>Send SMS From Contact List <small>(Remaining SMS: <%# Eval("SMS_Balance") %>)</small></h3>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SMSSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SMS_Balance FROM Institution" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>"></asp:SqlDataSource>

    <div class="form-inline NoPrint">
        <div class="form-group">
            <asp:DropDownList ID="SelectGroupDropDownList" runat="server" CssClass="form-control" DataSourceID="AddGroupSQL" DataTextField="GroupName" DataValueField="SMS_GroupID" AutoPostBack="True" OnDataBound="SelectGroupDropDownList_DataBound">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="SelectGroupDropDownList" CssClass="EroorSummer" ErrorMessage="Select Group" InitialValue="0" ValidationGroup="SN">*</asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:TextBox ID="SearchTextBox" placeholder="Name OR Mobile No." runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="SearchButton" runat="server" CssClass="btn btn-primary" Text="Search" />
        </div>

        <div class="form-group pull-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal2">Add Mobile No.</button>
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Add Group</button>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="alert alert-success">
        <asp:Label ID="IteamCountLabel" runat="server" Font-Bold="True" Font-Size="15px"></asp:Label>
    </div>

    <div class="table-responsive" style="margin-bottom:20px;">
        <asp:GridView ID="ContactListGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SMS_NumberID" DataSourceID="Group_Phone_NumberSQL" AllowPaging="True" PageSize="20">
            <Columns>
                <asp:BoundField DataField="GroupName" HeaderText="Group" ReadOnly="True" SortExpression="GroupName" />
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mobile No." SortExpression="MobileNo">
                    <EditItemTemplate>
                        <asp:TextBox ID="UMobieTextBox" CssClass="form-control" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RV" runat="server" ControlToValidate="UMobieTextBox" CssClass="EroorStar" ErrorMessage="Invalid!" ValidationExpression="(88)?((011)|(015)|(016)|(017)|(018)|(019)|(013)|(014))\d{8,8}" ValidationGroup="UP" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="MobileNoLabel" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Add_Date" HeaderText="Add Date" SortExpression="Add_Date" DataFormatString="{0:d MMM yyyy}" ReadOnly="True" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" ValidationGroup="UP" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="HideCB" />
                    <ItemStyle Width="85px" CssClass="HideCB " />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="DeletLinkButton" OnClientClick="return confirm('Are you sure want to delete?')" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="HideCB" />
                    <ItemStyle Width="30px" CssClass="HideCB " />
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                No Record
            </EmptyDataTemplate>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="Group_Phone_NumberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            DeleteCommand="DELETE FROM [SMS_Group_Phone_Number] WHERE [SMS_NumberID] = @SMS_NumberID"
            InsertCommand="INSERT INTO SMS_Group_Phone_Number(RegistrationID, SMS_GroupID, Name, MobileNo, Address, Add_Date) VALUES (@RegistrationID, @SMS_GroupID, @Name, @MobileNo, @Address, GETDATE())"
            SelectCommand="SELECT SMS_Group_Phone_Number.SMS_NumberID, SMS_Group_Phone_Number.SMS_GroupID, ISNULL(SMS_Group_Phone_Number.Name, '') AS Name, SMS_Group_Phone_Number.MobileNo, SMS_Group_Phone_Number.Add_Date, SMS_Group_Phone_Number.Address, SMS_Group_Name.GroupName FROM SMS_Group_Phone_Number INNER JOIN SMS_Group_Name ON SMS_Group_Phone_Number.SMS_GroupID = SMS_Group_Name.SMS_GroupID WHERE (SMS_Group_Phone_Number.SMS_GroupID = @SMS_GroupID) OR (@SMS_GroupID = 0) ORDER BY SMS_Group_Phone_Number.SMS_GroupID"
            UpdateCommand="UPDATE SMS_Group_Phone_Number SET Name =@Name, MobileNo =@MobileNo, Address =@Address WHERE (SMS_NumberID = @SMS_NumberID)"
            OnSelected="Group_Phone_NumberSQL_Selected"
            FilterExpression="MobileNo like '%{0}%' or Name like '%{0}%'" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:Parameter Name="SMS_NumberID" Type="Int32" />
            </DeleteParameters>
            <FilterParameters>
                <asp:ControlParameter ControlID="SearchTextBox" Name="Mobile" PropertyName="Text" DefaultValue="%" />

            </FilterParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                <asp:ControlParameter ControlID="GroupNameDropDownList" Name="SMS_GroupID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="PersonNameTextBox" Name="Name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="MobileNumberTextBox" Name="MobileNo" PropertyName="Text" />
                <asp:ControlParameter ControlID="AddressTextBox" Name="Address" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SelectGroupDropDownList" Name="SMS_GroupID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:ControlParameter ControlID="ContactListGridView" Name="MobileNo" PropertyName="SelectedDataKey[1]" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="SMS_NumberID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <%if (ContactListGridView.Rows.Count > 0)
        {%>
    <div class="row">
        <div class="col-sm-6 NoPrint">
            <div class="well">
                <div class="form-group">
                    <label>
                        Text Message
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="SMSTextBox" CssClass="EroorSummer" ErrorMessage="Write SMS Text" ValidationGroup="SN" />
                    </label>
                    <asp:TextBox ID="SMSTextBox" runat="server" Height="107px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="clearfix">
                    <ul id="counter">
                        <li>Length: <span class="length"></span> char.</li>
                        <li>Messages: <span class="messages"></span></li>
                        <li>Per Message: <span class="per_message"></span> char.</li>
                        <li>Remaining: <span class="remaining"></span> char.</li>
                    </ul>
                </div>

                <div class="form-group">
                    <asp:Button ID="SendSMSButton" runat="server" CssClass="btn btn-primary" Text="Send" ValidationGroup="SN" OnClick="SendSMSButton_Click" />
                    <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorSummer"></asp:Label>
                    <asp:SqlDataSource ID="SMS_OtherInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO SMS_Send_Record (SMS_Send_ID, PhoneNumber, TextSMS, TextCount, SMSCount, PurposeOfSMS, Status, Date, SMS_Response) VALUES  (@SMS_Send_ID,@PhoneNumber,@TextSMS,@TextCount,@SMSCount,@PurposeOfSMS,@Status, GETDATE(),@SMS_Response)
INSERT INTO SMS_OtherInfo(SMS_Send_ID, RegistrationID) VALUES (@SMS_Send_ID, @RegistrationID)"
                        SelectCommand="SELECT * FROM [SMS_OtherInfo]">
                        <InsertParameters>
                            <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                            <asp:Parameter DefaultValue="Contact List" Name="PurposeOfSMS" />
                            <asp:Parameter DefaultValue="Sent" Name="Status" />
                            <asp:Parameter Name="SMS_Send_ID" DbType="Guid" />
                            <asp:Parameter Name="PhoneNumber" />
                            <asp:Parameter Name="TextSMS" />
                            <asp:Parameter Name="TextCount" />
                            <asp:Parameter Name="SMSCount" />
                            <asp:Parameter Name="SMS_Response" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="EroorSummer" DisplayMode="List" ValidationGroup="SN" />
                </div>
            </div>
        </div>
    </div>
    <%} %>



    <!--Add Group-->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add New Group</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upnlUsers" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="GroupName" placeholder="Group Name" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="GroupName" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="G"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="SaveButton" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="SaveButton_Click" ValidationGroup="G" />
                                </div>
                            </div>

                            <asp:SqlDataSource ID="AddGroupSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand="DELETE FROM [SMS_Group_Name] WHERE [SMS_GroupID] = @SMS_GroupID" InsertCommand="INSERT INTO SMS_Group_Name(RegistrationID, GroupName) VALUES (@RegistrationID, @GroupName)" SelectCommand="SELECT SMS_GroupID, RegistrationID, GroupName FROM SMS_Group_Name" UpdateCommand="UPDATE SMS_Group_Name SET GroupName = @GroupName WHERE (SMS_GroupID = @SMS_GroupID)" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>">
                                <DeleteParameters>
                                    <asp:Parameter Name="SMS_GroupID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                                    <asp:ControlParameter ControlID="GroupName" Name="GroupName" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="GroupName" Type="String" />
                                    <asp:Parameter Name="SMS_GroupID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GroupGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SMS_GroupID" DataSourceID="AddGroupSQL" AllowPaging="True">
                                <Columns>
                                    <asp:BoundField DataField="GroupName" HeaderText="Group Name" SortExpression="GroupName" />
                                    <asp:CommandField ShowEditButton="True" />
                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>
    </div>

    <!--Add Number-->
    <div id="myModal2" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Contact</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>

                            <div class="form-group">
                                <label>
                                    Group Name
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="GroupNameDropDownList" CssClass="EroorStar" ErrorMessage="*" InitialValue="0" ValidationGroup="N"></asp:RequiredFieldValidator>
                                </label>
                                <asp:DropDownList ID="GroupNameDropDownList" runat="server" CssClass="form-control" DataSourceID="AddGroupSQL" DataTextField="GroupName" DataValueField="SMS_GroupID" OnDataBound="GroupNameDropDownList_DataBound">
                                    <asp:ListItem Value="0">[ SELECT ]</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label>
                                    Person Name
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="PersonNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="N"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="PersonNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>
                                    Mobile Number
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="MobileNumberTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="N"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="MobileNumberTextBox" CssClass="EroorSummer" ErrorMessage="Invalid !" ValidationExpression="(88)?((011)|(015)|(016)|(017)|(018)|(019)|(013)|(014))\d{8,8}" ValidationGroup="N"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="MobileNumberTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Address</label>
                                <asp:TextBox ID="AddressTextBox" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="AddButton" runat="server" CssClass="btn btn-primary" OnClick="AddButton_Click" Text="Add To List" ValidationGroup="N" />
                                <asp:Label ID="MsgLabel" runat="server" ForeColor="#339933"></asp:Label>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>
    </div>

    <script src="/JS/sms_counter.min.js"></script>
    <script>
        $(function () {
            $('[id*=SMSTextBox]').countSms('#counter');

            $("[id*=SelectGroupDropDownList]").change(function () {
                $("[id*=SearchTextBox]").val('')
            });
        });
    </script>
</asp:Content>
