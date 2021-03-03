<%@ Page Title="Membership Bonus" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Membership_Bonus.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.Membership_Bonus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        h3 { font-size:21px;}
        .QM, .AM { font-size:14px;}
        .QM {color:#ed4055; margin-top:18px;}
        .AM { color:#2D3091; margin-top: 35px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Membership Bonus</h3>
   

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Plan-1">1st</a></li>
                <li><a data-toggle="tab" href="#Plan-2">2nd</a></li>
                <li><a data-toggle="tab" href="#Plan-3">3rd</a></li>
                <li><a data-toggle="tab" href="#Plan-4">4th</a></li>
                <li><a data-toggle="tab" href="#Plan-5">5th</a></li>
                <li><a data-toggle="tab" href="#Plan-6">6th</a></li>
                <li><a data-toggle="tab" href="#Plan-7">7th</a></li>
                <li><a data-toggle="tab" href="#Plan-8">8th</a></li>
                <li class="pull-right"><a data-toggle="modal" data-target="#myModal">Show Policy</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Plan-1" class="tab-pane active">
                    <h3>1st</h3>
                    <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P1_GridView" AllowSorting="true" AllowPaging="true" PageSize="150" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P1_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                        <PagerStyle CssClass="pgr" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P1_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID WHERE (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) ORDER BY Member.Auto_Member_SN">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="1" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P1_GridView" AllowPaging="true" PageSize="150" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P1_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                        <PagerStyle CssClass="pgr" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P1_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="1" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-2" class="tab-pane">
                    <h3>2nd</h3>
                      <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P2_GridView" AllowPaging="true" PageSize="150" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P2_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                        <PagerStyle CssClass="pgr" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P2_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="2" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P2_GridView" AllowPaging="true" PageSize="150" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P2_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                        <PagerStyle CssClass="pgr" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P2_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="2" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-3" class="tab-pane">
                    <h3>3rd</h3>
                    <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P3_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P3_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P3_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="3" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P3_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P3_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P3_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="3" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-4" class="tab-pane">
                    <h3>4th</h3>
                     <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P4_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P4_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P4_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="4" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P4_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P4_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P4_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="4" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-5" class="tab-pane">
                    <h3>5th</h3>
                   <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P5_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P5_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P5_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="5" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P5_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P5_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P5_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="5" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-6" class="tab-pane">
                    <h3>6th</h3>
                    <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P6_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P6_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P6_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="6" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P6_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P6_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P6_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="6" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-7" class="tab-pane">
                    <h3>7th</h3>
                    <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P7_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P7_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P7_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="7" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P7_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P7_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P7_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="7" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div id="Plan-8" class="tab-pane">
                    <h3>8th</h3>
                    <h4 class="QM">Qualified Member</h4>
                    <asp:GridView ID="Q_P8_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Q_P8_SQL">
                        <Columns>
                            <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Q_P8_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="8" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <h4 class="AM">Achiever Member</h4>
                    <asp:GridView ID="A_P8_GridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="A_P8_SQL">
                        <Columns>
                             <asp:TemplateField HeaderText="S.N">
                                <ItemTemplate>
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Auto_Member_SN" HeaderText="Auto ID" SortExpression="Auto_Member_SN" />
                            <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="Date" />
                        </Columns>
                         <EmptyDataTemplate>
                            No Record
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:SqlDataSource ID="A_P8_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT        Registration.UserName, Registration.Name, Registration.Phone, Member.Auto_Member_SN, Member_AutoPlan_Record.Date
FROM            Member INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_AutoPlan_Record ON Member.MemberID = Member_AutoPlan_Record.MemberID
WHERE        (Member_AutoPlan_Record.IS_Bonus_Achieved = @IS_Bonus_Achieved) AND (Member_AutoPlan_Record.AutoPlan_No = @AutoPlan_No) AND (Current_Plan_Status = 1)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_Bonus_Achieved" />
                            <asp:Parameter DefaultValue="8" Name="AutoPlan_No" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>



    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Policy</h4>
                </div>
                <div class="modal-body">
                    <asp:GridView ID="Plan_PolicyGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Member_AutoPlan_PolicyID" DataSourceID="Plan_PolicySQL">
                        <Columns>
                            <asp:BoundField DataField="AutoPlan_No" HeaderText="SN" SortExpression="AutoPlan_No" />
                            <asp:BoundField DataField="AutoPlan" HeaderText="Auto Plan" SortExpression="AutoPlan" />
                            <asp:BoundField DataField="Plan_Ratio" HeaderText="Plan Ratio" SortExpression="Plan_Ratio" />
                            <asp:TemplateField HeaderText="Achive Amount" SortExpression="Plan_Amount">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Plan_Amount","{0:N}") %>'></asp:Label>
                                    /-
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Plan_PolicySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Member_AutoPlan_Policy]"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
