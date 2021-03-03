<%@ Page Title="Weekly Limit Update" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Weekly_Limit_Change.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.Weekly_Limit_Change" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Weekly Limit Update</h3>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="UserIDTextBox" placeholder="User Id" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserIDTextBox" ErrorMessage="*" CssClass="EroorStar" ValidationGroup="F"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Button ID="Find_Button" ValidationGroup="F" CssClass="btn btn-default" runat="server" Text="Find" />
                </div>
            </div>

            <asp:FormView ID="UserDetails_FormView" DataKeyNames="MemberID" DefaultMode="Edit" runat="server" DataSourceID="UserSQL" Width="100%">
                <EditItemTemplate>
                    <div class="alert alert-info">
                        <i class="fas fa-user-circle"></i>
                        [<%# Eval("UserName") %>] 
                         <%# Eval("Name") %>
                        <i class="fa fa-phone-square"></i>
                        <%# Eval("Phone") %>
                        <i class="fa fa-money-bill"></i>
                        <b>Current Limit:
                        ৳<asp:Label ID="PrevLabel" Font-Bold="true" runat="server" Text='<%# Eval("CIP_IncomeLimit") %>'></asp:Label>
                    </div>

                    <div class="form-inline">
                        <div class="form-group">
                            <asp:TextBox ID="ChangeAmount_TextBox" Text='<%#Bind("CIP_IncomeLimit") %>' placeholder="Enter Amount" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rv1" runat="server" ControlToValidate="ChangeAmount_TextBox" ErrorMessage="*" CssClass="EroorStar" ValidationGroup="Up"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="Update_Button" OnClick="Update_Button_Click" ValidationGroup="Up" CssClass="btn btn-primary" runat="server" Text="Update" />
                        </div>
                    </div>
                </EditItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="UserSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Name, Registration.UserName, Registration.Phone, Member.CIP_IncomeLimit, Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Member.IsCIP = 1) AND (Registration.UserName = @UserName)" UpdateCommand="UPDATE Member SET CIP_IncomeLimit = @CIP_IncomeLimit WHERE (MemberID = @MemberID)" InsertCommand="IF(@Prev_Limit &lt;&gt; @Updated_Limit)
INSERT INTO Member_CIP_Weekly_Limit_Change_Record(MemberID, ChnagedBy_RegistrationID, Prev_Limit, Updated_Limit) VALUES (@MemberID, @ChnagedBy_RegistrationID, @Prev_Limit, @Updated_Limit)">
                <InsertParameters>
                    <asp:SessionParameter Name="ChnagedBy_RegistrationID" SessionField="RegistrationID" />
                    <asp:Parameter Name="MemberID" />
                    <asp:Parameter Name="Prev_Limit" />
                    <asp:Parameter Name="Updated_Limit" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="UserIDTextBox" Name="UserName" PropertyName="Text" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CIP_IncomeLimit" />
                    <asp:Parameter Name="MemberID" />
                </UpdateParameters>
            </asp:SqlDataSource>


            <h4>Change Record</h4>
            <asp:GridView ID="RecordGridView" AllowPaging="true" PageSize="50" AllowSorting="true" DataSourceID="RecordSQL" CssClass="mGrid" runat="server" AutoGenerateColumns="False" PagerStyle-CssClass="pgr">
                <Columns>
                    <asp:BoundField DataField="UserName" HeaderText="User Id" SortExpression="UserName" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Prev_Limit" HeaderText="Prev. Limit" SortExpression="Prev_Limit" />
                    <asp:BoundField DataField="Updated_Limit" HeaderText="Changed Limit" SortExpression="Updated_Limit" />
                    <asp:BoundField DataField="Update_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Update_Date" />
                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" SortExpression="ChangedBy" />
                </Columns>
                <EmptyDataTemplate>
                    No Record
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="RecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_CIP_Weekly_Limit_Change_Record.Prev_Limit, Member_CIP_Weekly_Limit_Change_Record.Updated_Limit, Member_CIP_Weekly_Limit_Change_Record.Update_Date, Registration.UserName AS ChangedBy, Registration_Member.UserName, Registration_Member.Name FROM Registration INNER JOIN Member_CIP_Weekly_Limit_Change_Record INNER JOIN Member ON Member_CIP_Weekly_Limit_Change_Record.MemberID = Member.MemberID ON Registration.RegistrationID = Member_CIP_Weekly_Limit_Change_Record.ChnagedBy_RegistrationID INNER JOIN Registration AS Registration_Member ON Member.MemberRegistrationID = Registration_Member.RegistrationID"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

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
</asp:Content>
