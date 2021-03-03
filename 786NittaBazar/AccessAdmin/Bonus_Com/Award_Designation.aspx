<%@ Page Title="Award & Designation" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Award_Designation.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.Award_Designation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Award & Designation</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Record">Records</a></li>
                <li><a data-toggle="tab" href="#Designation">Award & Designation</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Record" class="tab-pane active">
                    <asp:GridView ID="IncentiveGridView0" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="RecordSQL">
                        <Columns>
                            <asp:BoundField DataField="UserName" HeaderText="User Id" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Designation_SN" HeaderText="D. SN" SortExpression="Designation_SN" />
                            <asp:BoundField DataField="Designation_ShortKey" HeaderText="Short Key" SortExpression="Designation_ShortKey" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                            <asp:BoundField DataField="Insert_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Achieved Date" SortExpression="Insert_Date" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="RecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Designation.Designation_ShortKey, Member_Designation.Designation, Member_Designation_Records.Designation_SN, Member_Designation_Records.Insert_Date, Registration.UserName, Registration.Name, Registration.Phone FROM Member_Designation INNER JOIN Member_Designation_Records ON Member_Designation.Designation_SN = Member_Designation_Records.Designation_SN INNER JOIN Member ON Member_Designation_Records.MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
                </div>
                <div id="Designation" class="tab-pane">
                    <asp:GridView ID="IncentiveGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Member_DesignationID" DataSourceID="IncentiveSQL">
                        <Columns>
                            <asp:BoundField DataField="Incentive_Condition" HeaderText="Condition" SortExpression="Incentive_Condition" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                            <asp:BoundField DataField="Designation_ShortKey" HeaderText="Short Key" SortExpression="Designation_ShortKey" />
                            <asp:BoundField DataField="Incentive_Offer" HeaderText="Incentive" SortExpression="Incentive_Offer" />
                            <asp:BoundField DataField="Incentive_Achieved_Members" HeaderText="Achieved Members" SortExpression="Incentive_Achieved_Members" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="IncentiveSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Member_Designation]"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
