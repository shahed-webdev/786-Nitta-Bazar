<%@ Page Title="Recharge Balance" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Create_Account.aspx.cs" Inherits="NittaBazar.AccessAdmin.Sub_Admin.Account.Create_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Recharge Balance</h3>
    <button type="button" class="btn btn-info" style="margin-bottom: 10px;" data-toggle="modal" data-target="#myModal">Create New Accountant</button>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div class="table-responsive">
                <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="AccountSQL" DataKeyNames="SubAdminAccountID,UserName">
                    <Columns>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("UserName") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Sub_Balance" HeaderText="Balance" SortExpression="Sub_Balance" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="CreateDate" HeaderText="Create Date" SortExpression="CreateDate" DataFormatString="{0:d MMM yyyy}" />
                    </Columns>
                    <EmptyDataTemplate>
                        Create New Accountant
                    </EmptyDataTemplate>
                    <SelectedRowStyle CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Sub_Admin_Account.Sub_Balance, Sub_Admin_Account.CreateDate, Registration.Phone, Registration.Email, Sub_Admin_Account.SubAdminAccountID FROM Sub_Admin_Account INNER JOIN Registration ON Sub_Admin_Account.SubAdmin_RegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
                <br />

                <%if (AccountGridView.SelectedValue != null)
                    { %>
                <div class="form-inline">
                    <div class="form-group">
                        <asp:TextBox ID="Amount_TextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" placeholder="Enter Amount" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="Amount_TextBox" CssClass="EroorStar" ValidationGroup="R"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="Recharge_Button" runat="server" Text="Recharge" CssClass="btn btn-primary" OnClick="Recharge_Button_Click" ValidationGroup="R" />
                    </div>
                </div>
                <asp:GridView ID="RechargeRecordGridView" runat="server" CssClass="mGrid" AutoGenerateColumns="False" DataSourceID="RechargeSQL">
                    <Columns>
                        <asp:BoundField DataField="Sub_UserName" HeaderText="Acc. Name" SortExpression="Sub_UserName" />
                        <asp:BoundField DataField="Recharge_Balance" HeaderText="Amount" SortExpression="Recharge_Balance" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="R_By_UserName" HeaderText="Recharge By" SortExpression="R_By_UserName" />
                        <asp:BoundField DataField="Recharge_Date" HeaderText="Recharge Date" SortExpression="Recharge_Date" DataFormatString="{0:d MMM yyyy}" />
                        <asp:TemplateField HeaderText="Approved" SortExpression="Is_Approved">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Is_Approved") %>' Enabled="false" Text=" " />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        No Record
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="RechargeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Sub_Recharge_Authorization(Sub_Admin_RechargeRecordID, SubAdminAccountID, Authority_RegistrationID, Approved_Code) VALUES (@Sub_Admin_RechargeRecordID, @SubAdminAccountID, @Authority_RegistrationID, @Approved_Code)" SelectCommand="SELECT Registration.UserName AS R_By_UserName, Sub_Admin_RechargeRecord.Recharge_Date, Sub_Admin_RechargeRecord.Recharge_Balance, Sub_Admin_T.UserName AS Sub_UserName, Sub_Admin_T.Name AS Sub_Name, Sub_Admin_RechargeRecord.Is_Approved FROM Sub_Admin_Account INNER JOIN Sub_Admin_RechargeRecord ON Sub_Admin_Account.SubAdminAccountID = Sub_Admin_RechargeRecord.SubAdminAccountID INNER JOIN Registration ON Sub_Admin_RechargeRecord.Recharge_By_RegID = Registration.RegistrationID INNER JOIN Registration AS Sub_Admin_T ON Sub_Admin_Account.SubAdmin_RegistrationID = Sub_Admin_T.RegistrationID ORDER BY Sub_Admin_RechargeRecord.Recharge_Date DESC">
                    <InsertParameters>
                        <asp:Parameter Name="Sub_Admin_RechargeRecordID" Type="Int32" />
                        <asp:ControlParameter ControlID="AccountGridView" DefaultValue="" Name="SubAdminAccountID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="Authority_RegistrationID" Type="Int32" />
                        <asp:Parameter Name="Approved_Code"/>
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="RechargeRecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Sub_Admin_RechargeRecord (SubAdminAccountID, Recharge_Balance, Recharge_By_RegID) VALUES (@SubAdminAccountID,@Recharge_Balance,@Recharge_By_RegID)
SELECT @Sub_Admin_RechargeRecordID = Scope_identity()"
                    OnInserted="RechargeRecordSQL_Inserted" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Registration.RegistrationID FROM Registration INNER JOIN
         Sub_Recharge_Authority_List ON Registration.RegistrationID = Sub_Recharge_Authority_List.Authority_RegistrationID">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="AccountGridView" Name="SubAdminAccountID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="Amount_TextBox" Name="Recharge_Balance" PropertyName="Text" />
                        <asp:SessionParameter Name="Recharge_By_RegID" SessionField="RegistrationID" />
                        <asp:Parameter Direction="Output" Name="Sub_Admin_RechargeRecordID" Size="100" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SMS_OtherInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO SMS_OtherInfo(SMS_Send_ID, RegistrationID) VALUES (@SMS_Send_ID, @RegistrationID)" SelectCommand="SELECT * FROM [SMS_OtherInfo]">
                    <InsertParameters>
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:Parameter DbType="Guid" Name="SMS_Send_ID" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <%} %>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Create New Accountant</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <label>
                                    SELECT ACCOUNTANT
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserListDropDownList" CssClass="EroorStar" ErrorMessage="*" InitialValue="0" ValidationGroup="A"></asp:RequiredFieldValidator></label>
                                <asp:DropDownList ID="UserListDropDownList" runat="server" DataSourceID="UserListSQL" DataTextField="Name" DataValueField="RegistrationID" CssClass="form-control" OnDataBound="UserListDropDownList_DataBound">
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="UserListSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Name + '(' + UserName + ')' AS Name, UserName, RegistrationID FROM Registration WHERE (Category = @Category) AND (Validation = 'Valid') AND (RegistrationID NOT IN (SELECT SubAdmin_RegistrationID FROM Sub_Admin_Account)) AND (RegistrationID NOT IN (SELECT Authority_RegistrationID FROM Sub_Recharge_Authority_List))" InsertCommand="INSERT INTO Sub_Admin_Account(SubAdmin_RegistrationID, CreatedBy_RegistrationID) VALUES (@SubAdmin_RegistrationID, @CreatedBy_RegistrationID)">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="UserListDropDownList" Name="SubAdmin_RegistrationID" PropertyName="SelectedValue" />
                                        <asp:SessionParameter Name="CreatedBy_RegistrationID" SessionField="RegistrationID" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="Sub-Admin" Name="Category" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="Create_Button" runat="server" Text="Create Accountant" CssClass="btn btn-primary" ValidationGroup="A" OnClick="Create_Button_Click" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>
    </div>

    <script>
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
