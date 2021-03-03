<%@ Page Title="Retail Commission" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Retail_Commission.aspx.cs" Inherits="NittaBazar.AccessAdmin.Bonus_Com.Retail_Commission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Retail Commission</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Flash_Matching">Retail Commission</a></li>
                <li><a data-toggle="tab" href="#Record">Commission Records</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Flash_Matching" class="tab-pane active">
                    <asp:GridView ID="Retail_BonusGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Generation_Retail_ID" DataSourceID="Retail_IncomeSQL">
                        <Columns>
                            <asp:BoundField DataField="Generation_Details" HeaderText="Generation" SortExpression="Generation_Details" />
                            <asp:TemplateField HeaderText="Retail Income" SortExpression="Retail_Income">
                                <ItemTemplate>
                                    <asp:TextBox ID="Retail_Income_TextBox" CssClass="form-control" runat="server" Text='<%# Bind("Retail_Income") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Retail_IncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Generation_Retail_Profit]" UpdateCommand="UPDATE Generation_Retail_Profit SET Retail_Income = @Retail_Income WHERE (Generation_Retail_ID = @Generation_Retail_ID)">
                        <UpdateParameters>
                            <asp:Parameter Name="Retail_Income" />
                            <asp:Parameter Name="Generation_Retail_ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" Text="Update Commission" CssClass="btn btn-primary" OnClick="UpdateButton_Click" />
                </div>

                <div id="Record" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="Records_CachBackGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="Records_CachBackSQL" AllowPaging="True" PageSize="50">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="Buy Point ID" SortExpression="UserName" />
                                    <asp:BoundField DataField="G_UserName" HeaderText="Get Bouns ID" SortExpression="G_UserName" />
                                    <asp:BoundField DataField="Generation_Details" HeaderText="Generation" SortExpression="Generation_Details" />
                                    <asp:BoundField DataField="Commission_Point" HeaderText="Point" SortExpression="Commission_Point" />
                                    <asp:BoundField DataField="Commission_Amount" HeaderText="Amount" SortExpression="Commission_Amount" />
                                    <asp:BoundField DataField="Tax_Service_Charge" HeaderText="Tax &amp; Charge" SortExpression="Tax_Service_Charge" />
                                    <asp:BoundField DataField="Net_Amount" HeaderText="Net" ReadOnly="True" SortExpression="Net_Amount" />
                                </Columns>
                                <EmptyDataTemplate>
                                    Empty
                                </EmptyDataTemplate>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="Records_CachBackSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Bouns_Records_Gen_Retails.Generation, Member_Bouns_Records_Gen_Retails.Commission_Point, Member_Bouns_Records_Gen_Retails.Commission_Amount, Member_Bouns_Records_Gen_Retails.Tax_Service_Charge, Member_Bouns_Records_Gen_Retails.Net_Amount, Member_Bouns_Records_Gen_Retails.Insert_Date, Registration.UserName, Generation_Retail_Profit.Generation_Details, Member.MemberID, G_Registration.UserName AS G_UserName FROM Member_Bouns_Records_Gen_Retails INNER JOIN Member ON Member_Bouns_Records_Gen_Retails.MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID INNER JOIN Generation_Retail_Profit ON Member_Bouns_Records_Gen_Retails.Generation = Generation_Retail_Profit.Generation INNER JOIN Member AS G_Member ON Member_Bouns_Records_Gen_Retails.Generation_MemberID = G_Member.MemberID INNER JOIN Registration AS G_Registration ON G_Member.MemberRegistrationID = G_Registration.RegistrationID"></asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
