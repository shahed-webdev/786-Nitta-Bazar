<%@ Page Title="Generation Commission" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Generation_Commission.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.Generation_Commission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Generation Commission</h3>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Commission">Generation Commission</a></li>
                <li><a data-toggle="tab" href="#Records">Commission Records</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Commission" class="tab-pane active">
                    <asp:GridView ID="Generation_BonusGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Generation_UniLevel_ID" DataSourceID="Generation_BonusSQL">
                        <Columns>
                            <asp:BoundField DataField="Generation_Details" HeaderText="Generation" SortExpression="Generation_Details" />
                            <asp:TemplateField HeaderText="Per 125 NP" SortExpression="Uni_Income">
                                <ItemTemplate>
                                    <asp:TextBox ID="Uni_IncomeTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Uni_Income") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Per_500" HeaderText="Per 500 NP" SortExpression="Per_500" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Generation_BonusSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT *,(Uni_Income*4) as [Per_500] FROM [Generation_Uni_Level]" UpdateCommand="UPDATE Generation_Uni_Level SET Uni_Income = @Uni_Income WHERE (Generation_UniLevel_ID = @Generation_UniLevel_ID)">
                        <UpdateParameters>
                            <asp:Parameter Name="Uni_Income" />
                            <asp:Parameter Name="Generation_UniLevel_ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" Text="Update Commission" CssClass="btn btn-primary" OnClick="UpdateButton_Click" />

                </div>
                <div id="Records" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GenerationGridView" AllowSorting="true" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Generation_UniLevel_RecordsID" DataSourceID="Records_GenerationSQL" AllowPaging="True" PageSize="50">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="Buy Point ID" SortExpression="UserName" />
                                    <asp:BoundField DataField="G_UserName" HeaderText="Get Bouns ID" SortExpression="G_UserName" />
                                    <asp:BoundField DataField="Generation_Details" HeaderText="Generation" SortExpression="Generation" />
                                    <asp:BoundField DataField="Commission_Point" HeaderText="Point" SortExpression="Commission_Point" />
                                    <asp:BoundField DataField="Commission_Amount" HeaderText="Amount" SortExpression="Commission_Amount" />
                                    <asp:BoundField DataField="Tax_Service_Charge" HeaderText="Tax &amp; Charge" SortExpression="Tax_Service_Charge" />
                                    <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" />
                                    <asp:BoundField DataField="Insert_Date" HeaderText="Date" SortExpression="Insert_Date" DataFormatString="{0:d MMM yyyy}" />
                                </Columns>
                                <EmptyDataTemplate>
                                    Empty
                                </EmptyDataTemplate>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="Records_GenerationSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member.MemberID, Member_Bouns_Records_Gen_UniLevel.Generation_UniLevel_RecordsID, Member_Bouns_Records_Gen_UniLevel.Generation_MemberID, Registration.UserName, Generation_Uni_Level.Generation_Details, Member_Bouns_Records_Gen_UniLevel.Generation, Member_Bouns_Records_Gen_UniLevel.Commission_Point, Member_Bouns_Records_Gen_UniLevel.Commission_Amount, Member_Bouns_Records_Gen_UniLevel.Tax_Service_Charge, Member_Bouns_Records_Gen_UniLevel.Net_Amount, Member_Bouns_Records_Gen_UniLevel.Insert_Date, G_Registration.UserName AS G_UserName FROM Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID INNER JOIN Member_Bouns_Records_Gen_UniLevel ON Member.MemberID = Member_Bouns_Records_Gen_UniLevel.MemberID INNER JOIN Generation_Uni_Level ON Member_Bouns_Records_Gen_UniLevel.Generation = Generation_Uni_Level.Generation INNER JOIN Member AS G_Member ON Member_Bouns_Records_Gen_UniLevel.Generation_MemberID = G_Member.MemberID INNER JOIN Registration AS G_Registration ON G_Member.MemberRegistrationID = G_Registration.RegistrationID ORDER BY Insert_Date DESC, UserName,Generation_Details"></asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
