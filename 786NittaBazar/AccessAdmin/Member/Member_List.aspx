<%@ Page Title="Customer List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Member_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.Member_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>All Customer List</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="FindTextBox" runat="server" CssClass="form-control" placeholder="Find by Name, Username, Phone"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" OnClick="FindButton_Click" />
                </div>
            </div>

            <div class="alert alert-success">
                <asp:Label ID="Total_Label" runat="server" CssClass="Result_Msg"></asp:Label>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="MemberListGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MemberSQL" CssClass="mGrid" DataKeyNames="MemberID" AllowSorting="True" AllowPaging="True" PageSize="30">
                    <Columns>
                        <asp:HyperLinkField SortExpression="UserName" DataTextField="UserName" DataNavigateUrlFields="MemberID" DataNavigateUrlFormatString="Member_Details.aspx?member={0}" HeaderText="User ID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
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
                    SelectCommand="SELECT Registration.Name, Registration.Phone, Registration.Email, Registration.UserName, Member.Is_Identified, Member.SignUpDate, Member.MemberID, Member.AvailablePoint, Member_Package.Member_Package_Short_Key, Member_Designation.Designation_ShortKey AS Member_Incentive_Designation FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID LEFT OUTER JOIN Member_Designation ON Member.Designation_SN = Member_Designation.Designation_SN LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial WHERE (Registration.Category = N'Member') AND (Member.Is_Identified = 1) AND (Member.Default_MemberStatus = 0)"
                    FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False">
                    <FilterParameters>
                        <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
                    </FilterParameters>
                </asp:SqlDataSource>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
