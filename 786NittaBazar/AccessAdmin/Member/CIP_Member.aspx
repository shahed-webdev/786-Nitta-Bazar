<%@ Page Title="CIP Customer List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="CIP_Member.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP_Member" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>CIP Customer List</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="FromTextBox" autocomplete="off" runat="server" CssClass="form-control datepicker" placeholder="From Date"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ToTextBox" autocomplete="off" runat="server" CssClass="form-control datepicker" placeholder="To Date"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FindTextBox" runat="server" CssClass="form-control" placeholder="Name, Userid, Phone"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" OnClick="FindButton_Click" />
        </div>
    </div>

    <div class="alert alert-info">
        <asp:Label ID="Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
    </div>
    <div class="table-responsive">
        <asp:GridView ID="MemberListGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MemberSQL" CssClass="mGrid" DataKeyNames="MemberID" AllowSorting="True" AllowPaging="True" PageSize="30">
            <Columns>
                <asp:HyperLinkField SortExpression="UserName" DataTextField="UserName" DataNavigateUrlFields="MemberID" DataNavigateUrlFormatString="Member_Details.aspx?member={0}" HeaderText="User ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Total_Income" HeaderText="Total Income" SortExpression="Total_Income" DataFormatString="{0:N}" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:BoundField DataField="AvailablePoint" HeaderText="Available Point" SortExpression="AvailablePoint" />
                <asp:BoundField DataField="Member_Package_Short_Key" HeaderText="Package Status" SortExpression="Member_Package_Short_Key" />
                <asp:BoundField DataField="Member_Incentive_Designation" HeaderText="Designation" SortExpression="Member_Incentive_Designation" />
                <asp:BoundField DataField="SignUpDate" HeaderText="SignUp Date" SortExpression="SignUpDate" DataFormatString="{0:d MMM yyyy}" />
            </Columns>
            <EmptyDataTemplate>
                No Customer
            </EmptyDataTemplate>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            SelectCommand="SELECT Registration.Name, Registration.Phone, Registration.Email, Registration.UserName, Member.Is_Identified, Member.SignUpDate, Member.MemberID, Member.AvailablePoint, Member_Package.Member_Package_Short_Key, Member_Designation.Designation_ShortKey AS Member_Incentive_Designation,(Member.Referral_Income + Member.Matching_Income + Member.Generation_Income + Member.Instant_Cash_Back_Income + Member.Auto_Income + Member.Executive_Bonus_Income + Member.CIP_Income) AS Total_Income FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID LEFT OUTER JOIN Member_Designation ON Member.Designation_SN = Member_Designation.Designation_SN LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial WHERE (Registration.Category = N'Member') AND (Member.Is_Identified = 1) AND (Member.Default_MemberStatus = 0) AND (Member.IsCIP = 1) AND (Member.SignUpDate BETWEEN ISNULL(@Fdate, '1-1-1760') AND ISNULL(@TDate, '1-1-3760'))"  FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="FromTextBox" Name="Fdate" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToTextBox" Name="TDate" PropertyName="Text" />
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>
    </div>

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
