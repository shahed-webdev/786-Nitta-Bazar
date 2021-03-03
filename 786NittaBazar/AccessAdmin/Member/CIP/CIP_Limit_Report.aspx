<%@ Page Title="CIP weekly limit report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="CIP_Limit_Report.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.CIP.CIP_Limit_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>cip weekly limit report</h3>

    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="FindTextBox" runat="server" CssClass="form-control" placeholder="Name, Userid, Phone"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Tab1">Customer Available limit</a></li>
                <li><a data-toggle="tab" href="#Tab2">limit Provide Record</a></li>
                <li><a data-toggle="tab" href="#Tab3">limit Deduction Record</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Tab1" class="tab-pane active">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="LimitReport_GridView" runat="server" CssClass="mGrid" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LimitSQL" PageSize="100">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="UserId" SortExpression="UserName" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                    <asp:BoundField DataField="CIP_IncomeLimit" DataFormatString="{0:N}" HeaderText="Income Limit" SortExpression="CIP_IncomeLimit" />
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                                <EmptyDataTemplate>
                                    No record
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="LimitSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.CIP_IncomeLimit FROM Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID WHERE (Member.IsCIP = 1) AND (Member.CIP_IncomeLimit &gt; 0) ORDER BY Member.CIP_IncomeLimit DESC"
                                FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False">
                                <FilterParameters>
                                    <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
                                </FilterParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Tab2" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="Limit_GetRecordGridView" runat="server" CssClass="mGrid" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="Limit_GetRecordSQL" PageSize="100">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="UserId" SortExpression="UserName" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                    <asp:BoundField DataField="LimitAmount" DataFormatString="{0:N}" HeaderText="Limit Amount" SortExpression="LimitAmount" />
                                    <asp:BoundField DataField="InsertDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="InsertDate" />
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                                <EmptyDataTemplate>
                                    No record
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Limit_GetRecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member_CIP_Weekly_Limit_Record.LimitAmount, Member_CIP_Weekly_Limit_Record.InsertDate FROM Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Member_CIP_Weekly_Limit_Record ON Member.MemberID = Member_CIP_Weekly_Limit_Record.MemberID"
                                FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False">
                                <FilterParameters>
                                    <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
                                </FilterParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Tab3" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="DeductionGridView" runat="server" CssClass="mGrid" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="DeductionSQL" PageSize="100">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="UserId" SortExpression="UserName" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                    <asp:BoundField DataField="Previous_LimitAmout" DataFormatString="{0:N}" HeaderText="Prev. Limit" SortExpression="Previous_LimitAmout" />
                                    <asp:BoundField DataField="DiductionAmount" DataFormatString="{0:N}" HeaderText="Diduction Amount" SortExpression="DiductionAmount" />
                                    <asp:BoundField DataField="Diduction_For" HeaderText="Diduction For" SortExpression="Diduction_For" />
                                    <asp:BoundField DataField="InsertDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="InsertDate" />
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                                <EmptyDataTemplate>
                                    No record
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="DeductionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member_CIP_Limit_Diduction_Record.Previous_LimitAmout, Member_CIP_Limit_Diduction_Record.DiductionAmount, Member_CIP_Limit_Diduction_Record.Diduction_For, Member_CIP_Limit_Diduction_Record.InsertDate FROM Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Member_CIP_Limit_Diduction_Record ON Member.MemberID = Member_CIP_Limit_Diduction_Record.MemberID ORDER BY Member_CIP_Limit_Diduction_Record.InsertDate DESC"
                                FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False">
                                <FilterParameters>
                                    <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
                                </FilterParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

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
