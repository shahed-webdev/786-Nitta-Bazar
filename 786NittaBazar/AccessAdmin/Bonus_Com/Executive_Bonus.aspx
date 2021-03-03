<%@ Page Title="Executive Bonus" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Executive_Bonus.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.Executive_Bonus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
      .Per{text-align:center; padding:30px 5px; background-color:#00AFAD; color:#fff; font-size:17px; margin:10px 0}
      .Point{text-align:center; padding:30px 5px; background-color:#0090E9; color:#fff; font-size:17px; margin:10px 0}
      .Amount {text-align:center; padding:30px 5px; background-color:#717BBB; color:#fff; font-size:17px; margin:10px 0}
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Executive Bonus</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Flash_Matching">Executive Bonus</a></li>
                <li><a data-toggle="tab" href="#Matching_Achievers">Bonus Records</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Flash_Matching" class="tab-pane active">
                    <asp:GridView ID="IncentiveGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Member_DesignationID" DataSourceID="Mega_MatchingSQL">
                        <Columns>
                            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                            <asp:BoundField DataField="Designation_ShortKey" HeaderText="Short Key" SortExpression="Designation_ShortKey" />
                            <asp:BoundField DataField="Mega_Matching_Percentage" HeaderText="Mega Matching %" SortExpression="Mega_Matching_Percentage" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Mega_MatchingSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Member_Designation]"></asp:SqlDataSource>

                    <asp:FormView ID="MegaFormView" runat="server" DataSourceID="MegaPointSQL" DataKeyNames="Mega_Matching_Amount" Width="100%">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-md-4 col-sm-4">
                                    <div class="Per">
                                        Per <%# Eval("Mega_Matching_UnitPoint") %>
                                    Point = <%#Eval("Mega_Matching_UnitAmount") %> TK
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <div class="Point">
                                        Total Point: <%# Eval("Mega_Matching_Point") %>
                                    </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="Amount">
                                    Total Amount: <%# Eval("Mega_Matching_Amount") %> TK
                                </div>
                            </div>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="MegaPointSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Mega_Matching_UnitPoint, Mega_Matching_UnitAmount, Mega_Matching_Point, Mega_Matching_Amount FROM Institution" InsertCommand="Add_Mega_Matching" InsertCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>

                <div id="Matching_Achievers" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="MegaRecordsGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Monthly_ExcutiveBounsID" DataSourceID="Monthly_ExcutiveBounsSQL">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="AmountLB" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CommandArgument='<%#Eval("InsertDate","{0:y}") %>' OnCommand="AmountLB_Command"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="InsertDate" HeaderText="Month" SortExpression="InsertDate" DataFormatString="{0:d MMM yyyy}" />
                                    <asp:BoundField DataField="Monthly_Point" HeaderText="Monthly Point" SortExpression="Monthly_Point" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="Monthly_Amount" HeaderText="Monthly Amount" SortExpression="Monthly_Amount" DataFormatString="{0:N}" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No Records
                                </EmptyDataTemplate>
                                <SelectedRowStyle CssClass="Selected" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="Monthly_ExcutiveBounsSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Monthly_ExcutiveBounsID,InsertDate, Monthly_Point, Monthly_Amount FROM Member_Bouns_Records_Executive"></asp:SqlDataSource>


                            <br />
                            <h5 class="alert alert-info" id="DV">
                                <asp:Label ID="MonthLabel" runat="server" Font-Bold="true"></asp:Label>
                                Designation wise Achievers
                            </h5>
                            <asp:GridView ID="DesignationGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Designation_ArcSQL" DataKeyNames="Designation_SN">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DesignationLB" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CommandArgument='<%#Eval("Designation") %>' OnCommand="DesignationLB_Command"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                                    <asp:BoundField DataField="DesignationBouns_Amount" HeaderText="Amount" SortExpression="DesignationBouns_Amount" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="DesignationBouns_Tax_Service_Charge" HeaderText="Tax &amp; Charge" SortExpression="DesignationBouns_Tax_Service_Charge" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="Net_Amount" HeaderText="Net" SortExpression="Net_Amount" ReadOnly="True" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="Incentive_Achieved_Members" HeaderText="Achieved" SortExpression="Incentive_Achieved_Members" />
                                    <asp:BoundField DataField="Per_Member_Amount" HeaderText="Per Member" ReadOnly="True" SortExpression="Per_Member_Amount" DataFormatString="{0:N}" />
                                </Columns>
                                <SelectedRowStyle CssClass="Selected" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="Designation_ArcSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT   Member_Bouns_Records_Executive_Designation.Monthly_ExcutiveBounsID, Member_Designation.Designation, Member_Designation.Designation_ShortKey, Member_Bouns_Records_Executive_Designation.Designation_SN, 
                         Member_Bouns_Records_Executive_Designation.DesignationBouns_Amount, Member_Bouns_Records_Executive_Designation.DesignationBouns_Tax_Service_Charge, 
                         Member_Bouns_Records_Executive_Designation.Net_Amount, Member_Bouns_Records_Executive_Designation.Incentive_Achieved_Members, Member_Bouns_Records_Executive_Designation.Per_Member_Amount, 
                         Member_Bouns_Records_Executive_Designation.InsertDate
FROM            Member_Bouns_Records_Executive_Designation INNER JOIN
                         Member_Designation ON Member_Bouns_Records_Executive_Designation.Designation_SN = Member_Designation.Designation_SN
WHERE        (Member_Bouns_Records_Executive_Designation.Monthly_ExcutiveBounsID = @Monthly_ExcutiveBounsID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="MegaRecordsGridView" Name="Monthly_ExcutiveBounsID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <br />
                            <h5 class="alert alert-success" id="MV">
                                <asp:Label ID="DesignationLabel" runat="server" Font-Bold="true"></asp:Label>
                                Achievers Members
                            </h5>
                            <asp:GridView ID="MembersGridView" runat="server" CssClass="mGrid" AutoGenerateColumns="False" DataKeyNames="ExecutiveBounsDetailsID" DataSourceID="Arc_MembersSQL">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                                    <asp:BoundField DataField="DesignationBouns_Amount" HeaderText="Amount" SortExpression="DesignationBouns_Amount" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="DesignationBouns_Tax_Service_Charge" HeaderText="Tax &amp; Charge" SortExpression="DesignationBouns_Tax_Service_Charge" DataFormatString="{0:N}" />
                                    <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" DataFormatString="{0:N}" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Arc_MembersSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Bouns_Records_Executive_Details.ExecutiveBounsDetailsID, Member_Bouns_Records_Executive_Details.Monthly_ExcutiveBounsID, Member_Bouns_Records_Executive_Details.MemberID, 
                         Member_Designation.Designation, Registration.UserName, Member_Bouns_Records_Executive_Details.Designation_SN, Member_Bouns_Records_Executive_Details.DesignationBouns_Amount, 
                         Member_Bouns_Records_Executive_Details.DesignationBouns_Tax_Service_Charge, Member_Bouns_Records_Executive_Details.Net_Amount, Member_Bouns_Records_Executive_Details.Incentive_Achieved_Members, 
                         Member_Bouns_Records_Executive_Details.Per_Member_Amount,
                         Member_Bouns_Records_Executive_Details.InsertDate
FROM            Member_Bouns_Records_Executive_Details INNER JOIN
                         Member ON Member_Bouns_Records_Executive_Details.MemberID = Member.MemberID INNER JOIN
                         Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN
                         Member_Designation ON Member_Bouns_Records_Executive_Details.Designation_SN = Member_Designation.Designation_SN
WHERE        (Member_Bouns_Records_Executive_Details.Monthly_ExcutiveBounsID = @Monthly_ExcutiveBounsID) AND (Member_Bouns_Records_Executive_Details.Designation_SN = @Designation_SN)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="MegaRecordsGridView" Name="Monthly_ExcutiveBounsID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DesignationGridView" Name="Designation_SN" PropertyName="SelectedValue" />
                                </SelectParameters>
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

    <script>
        if (!$('[id*=DesignationGridView]').length) {
            $("#DV").hide();
        }
        if (!$('[id*=MembersGridView]').length) {
            $("#MV").hide();
        }
        //For Update Pannel
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {

            if (!$('[id*=DesignationGridView]').length) {
                $("#DV").hide();
            }
            if (!$('[id*=MembersGridView]').length) {
                $("#MV").hide();
            }
        });
    </script>
</asp:Content>
