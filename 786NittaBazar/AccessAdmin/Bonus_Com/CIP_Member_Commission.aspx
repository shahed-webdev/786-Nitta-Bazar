<%@ Page Title="CIP Member Commission" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="CIP_Member_Commission.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.CIP_Member_Commission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>CIP Member Weekly Commission</h3>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Tab1">Assign Customer in Area</a></li>
                <li><a data-toggle="tab" href="#Tab2">Commission Record</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Tab1" class="tab-pane active">
                    <div class="form-inline">
                        <div class="form-group">
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Add/Update Area</button>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="CustomerId_TextBox" placeholder="Customer Id" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="f" ControlToValidate="CustomerId_TextBox" CssClass="EroorStar" ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="Find_Button" runat="server" Text="Find" CssClass="btn btn-danger" />
                        </div>
                    </div>

                    <asp:FormView ID="UserDetails_FormView" DataKeyNames="MemberID" runat="server" DataSourceID="UserSQL" Width="100%">
                        <ItemTemplate>
                            <div class="alert alert-success">
                                <i class="fas fa-id-card-alt"></i>
                                <%# Eval("UserName") %>

                                <i class="fas fa-user-circle"></i>
                                <%# Eval("Name") %>
                                <i class="fa fa-phone-square"></i>
                                <%# Eval("Phone") %>
                            </div>

                            <p><%# Eval("OfficeAreaName","Current Area: {0}") %></p>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="UserSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.Name, Registration.UserName, Registration.Phone, Member.CIP_IncomeLimit, Member.MemberID, Member_Office_Area.OfficeAreaName FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID LEFT OUTER JOIN Member_Office_Area ON Member.MemberOfficeAreaID = Member_Office_Area.MemberOfficeAreaID WHERE (Member.IsCIP = 1) AND (Registration.UserName = @UserName)" UpdateCommand="UPDATE Member SET MemberOfficeAreaID = @MemberOfficeAreaID WHERE (MemberID = @MemberID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="CustomerId_TextBox" Name="UserName" PropertyName="Text" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="UpAreaDropDownList" Name="MemberOfficeAreaID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="UserDetails_FormView" Name="MemberID" PropertyName="DataKey[0]" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <%if (UserDetails_FormView.DataItemCount > 0)
                        {%>
                    <div class="form-inline">
                        <div class="form-group">
                            <asp:DropDownList ID="UpAreaDropDownList" CssClass="form-control" runat="server" DataSourceID="AreaSQL" DataTextField="OfficeAreaName" DataValueField="MemberOfficeAreaID" AppendDataBoundItems="True">
                                <asp:ListItem Value="0">[ SELECT AREA TO ASSIGN ]</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="ReH3" ControlToValidate="UpAreaDropDownList" ValidationGroup="AS" runat="server" CssClass="EroorStar" InitialValue="0" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="AssignButton" OnClick="AssignButton_Click" ValidationGroup="AS" CssClass="btn btn-primary" runat="server" Text="Assign" />
                        </div>
                    </div>
                    <%} %>

                    <div class="row" style="margin-top:20px;">
                        <div class="col-sm-6">
                            <asp:Repeater ID="CountAreaRepeater" runat="server" DataSourceID="CountAreaSQL">
                                <HeaderTemplate>
                                    <ul class="list-group">
                                        <li class="list-group-item active">Total Customer In Area</li>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li class="list-group-item"><%#Eval("OfficeAreaName") %>
                                        <span class="badge float-right"><%#Eval("Total") %></span>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource ID="CountAreaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Office_Area.OfficeAreaName, COUNT(Member.MemberID) AS Total FROM Member INNER JOIN Member_Office_Area ON Member.MemberOfficeAreaID = Member_Office_Area.MemberOfficeAreaID GROUP BY Member_Office_Area.OfficeAreaName"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>

                <div id="Tab2" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="RecordGridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="Weekly_CIP_BounsID" DataSourceID="RecordSQL">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False" HeaderText="Select Date">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("InsertDate", "{0:d MMM yyyy}") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="OfficeAreaName" HeaderText="Area Name" SortExpression="OfficeAreaName" />
                                    <asp:BoundField DataField="Total_CIP_Member" HeaderText="Total CIP Member" SortExpression="Total_CIP_Member" />
                                    <asp:BoundField DataField="Per_Member_Commission" HeaderText="Per Member Comm." SortExpression="Per_Member_Commission" DataFormatString="{0:N}" />
                                </Columns>
                                <SelectedRowStyle CssClass="Selected" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="RecordSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Bouns_CIP_Weekly.Weekly_CIP_BounsID, Member_Bouns_CIP_Weekly.Total_CIP_Member, Member_Bouns_CIP_Weekly.Per_Member_Commission, Member_Office_Area.OfficeAreaName, Member_Bouns_CIP_Weekly.InsertDate FROM Member_Bouns_CIP_Weekly LEFT OUTER JOIN Member_Office_Area ON Member_Bouns_CIP_Weekly.MemberOfficeAreaID = Member_Office_Area.MemberOfficeAreaID"></asp:SqlDataSource>

                            <h4>Record Details</h4>
                            <asp:GridView ID="DetailsGridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="DetailsSQL" AllowPaging="True" AllowSorting="True" PageSize="100">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="User id" SortExpression="UserName" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="CIP_Bouns_Amount" HeaderText="CIP Bouns Amount" SortExpression="CIP_Bouns_Amount" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="CIP_Bouns_Tax_Service_Charge" HeaderText="Tax/Service Charge" SortExpression="CIP_Bouns_Tax_Service_Charge" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" DataFormatString="{0:N}" />
                                </Columns>
                                <EmptyDataTemplate>
                                    Select Date
                                </EmptyDataTemplate>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="DetailsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Bouns_CIP_Weekly_Details.MemberID, Member_Bouns_CIP_Weekly_Details.CIP_Bouns_Amount, Member_Bouns_CIP_Weekly_Details.CIP_Bouns_Tax_Service_Charge, Member_Bouns_CIP_Weekly_Details.Net_Amount, Member_Bouns_CIP_Weekly_Details.InsertDate, Registration.UserName, Registration.Name FROM Member_Bouns_CIP_Weekly_Details INNER JOIN Member ON Member_Bouns_CIP_Weekly_Details.MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Member_Bouns_CIP_Weekly_Details.Weekly_CIP_BounsID = @Weekly_CIP_BounsID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="RecordGridView" Name="Weekly_CIP_BounsID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>



    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Customer Area</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <label>Area Name<asp:RequiredFieldValidator ID="R1" ControlToValidate="AreanameTextBox" ValidationGroup="1" runat="server" CssClass="EroorStar" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                <asp:TextBox ID="AreanameTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Weekly Commission Amount<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="CommissionTextBox" ValidationGroup="1" runat="server" CssClass="EroorStar" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                <asp:TextBox ID="CommissionTextBox" onkeypress="return isNumberKey(event)" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="AddButton" runat="server" Text="Add" CssClass="btn btn-primary" ValidationGroup="1" OnClick="AddButton_Click" />
                                <asp:SqlDataSource ID="AreaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="IF NOT EXISTS(SELECT * from [Member_Office_Area] where [OfficeAreaName] =@OfficeAreaName)
INSERT INTO [Member_Office_Area] ([RegistrationID], [OfficeAreaName], [WeeklyCommissionPercetage]) VALUES (@RegistrationID, @OfficeAreaName, @WeeklyCommissionPercetage)"
                                    SelectCommand="SELECT * FROM [Member_Office_Area]" UpdateCommand="IF NOT EXISTS(SELECT * from [Member_Office_Area] where [OfficeAreaName] =@OfficeAreaName AND MemberOfficeAreaID &lt;&gt; @MemberOfficeAreaID)
UPDATE Member_Office_Area SET OfficeAreaName = @OfficeAreaName, WeeklyCommissionPercetage = @WeeklyCommissionPercetage WHERE (MemberOfficeAreaID = @MemberOfficeAreaID)">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                        <asp:ControlParameter ControlID="AreanameTextBox" Name="OfficeAreaName" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="CommissionTextBox" Name="WeeklyCommissionPercetage" PropertyName="Text" Type="Double" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="OfficeAreaName" />
                                        <asp:Parameter Name="WeeklyCommissionPercetage" />
                                        <asp:Parameter Name="MemberOfficeAreaID" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>

                            <asp:GridView ID="AreaGridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="MemberOfficeAreaID" DataSourceID="AreaSQL">
                                <Columns>
                                    <asp:TemplateField HeaderText="Area Name" SortExpression="OfficeAreaName">
                                        <ItemTemplate>
                                            <asp:TextBox ID="Up_AreaName_TextBox" CssClass="form-control" runat="server" Text='<%# Bind("OfficeAreaName") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="uR1" ControlToValidate="Up_AreaName_TextBox" ValidationGroup="u" runat="server" CssClass="EroorStar" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Commission Amount" SortExpression="WeeklyCommissionPercetage">
                                        <ItemTemplate>
                                            <asp:TextBox ID="Up_Commission_TextBox" onkeypress="return isNumberKey(event)" CssClass="form-control" runat="server" Text='<%# Bind("WeeklyCommissionPercetage") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="uR2" ControlToValidate="Up_Commission_TextBox" ValidationGroup="u" runat="server" CssClass="EroorStar" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <br />
                            <div class="form-group">
                                <asp:Button ID="Update_Button" ValidationGroup="u" runat="server" Text="Update" CssClass="btn btn-info" OnClick="Update_Button_Click" />
                            </div>
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

    <script>
        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
