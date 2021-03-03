<%@ Page Title="Auto Board Member List" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Auto_Board_Member_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.Auto_Board_Member_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Auto Board Member List</h3>
    <div class="table-responsive">
        <asp:GridView ID="MemberListGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="MemberSQL" DataKeyNames="MemberID" AllowSorting="True">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="All_CheckBox" runat="server" Text="All" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="Add_CheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                    <ItemStyle Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="UserName" HeaderText="User id" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" SortExpression="Amount" />
                <asp:BoundField DataField="Point" HeaderText="Point" ReadOnly="True" SortExpression="Point" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT  Shopping.MemberID, Registration.UserName, Registration.Name, Registration.Phone, SUM(Shopping.ShoppingAmount) AS Amount, SUM(Shopping.ShoppingPoint) AS Point FROM  Shopping INNER JOIN
         Member ON Shopping.MemberID = Member.MemberID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE  (Member.Auto_Member_SN IS NULL) GROUP BY Shopping.MemberID, Registration.UserName, Registration.Name, Registration.Phone HAVING (SUM(Shopping.ShoppingAmount) &gt;= 2000) ORDER BY Amount DESC" InsertCommand="IF EXISTS(SELECT MemberID, Auto_Member_SN FROM  Member  Where MemberID = @MemberID  AND  Auto_Member_SN IS NULL)
INSERT INTO Member_AutoPlan (MemberID,AutoPlan_No) Values (@MemberID,1)
">
            <InsertParameters>
                <asp:Parameter Name="MemberID" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <asp:Button ID="Assign_Button" CssClass="btn btn-primary" runat="server" Text="Assign" OnClick="Assign_Button_Click" />


    <script>
        $(function () {
            //Select All Checkbox
            $("[id*=All_CheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });

            $("[id*=Add_CheckBox]").on("click", function () {
                var a = $(this).closest("table"), b = $("[id*=All_CheckBox]", a);
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected"), $("[id*=chkRow]", a).length == $("[id*=chkRow]:checked", a).length && b.attr("checked", "checked")) : ($("td", $(this).closest("tr")).removeClass("selected"), b.removeAttr("checked"));
            });
        });
    </script>
</asp:Content>
