<%@ Page Title="VIP Customer" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="VIP_Customer_List.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.VIP_Customer_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>VIP Customer List</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="FindTextBox" runat="server" CssClass="form-control" placeholder="Name, Userid, Phone"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" CssClass="btn btn-primary" Text="Find" />
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="MemberListGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MemberSQL" CssClass="mGrid" DataKeyNames="MemberID" AllowSorting="True" PageSize="100" AllowPaging="True">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="AllCheckBox" runat="server" Text="All" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="ConfirmCheckBox" runat="server" Text=" " />
                    </ItemTemplate>
                    <ItemStyle Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="UserName" HeaderText="Userid" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="AvailablePoint" HeaderText="Available Point" SortExpression="AvailablePoint" />
                <asp:BoundField DataField="Member_Incentive_Designation" HeaderText="Designation" SortExpression="Member_Incentive_Designation" />
                <asp:BoundField DataField="SignUpDate" HeaderText="SignUp Date" SortExpression="SignUpDate" DataFormatString="{0:d MMM yyyy}" />
            </Columns>
            <EmptyDataTemplate>
                No Customer
            </EmptyDataTemplate>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="MemberSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            SelectCommand="SELECT Registration.Name, Registration.Phone, Registration.Email, Registration.UserName, Member.Is_Identified, Member.SignUpDate, Member.MemberID, Member.AvailablePoint, Member_Package.Member_Package_Short_Key, Member_Designation.Designation_ShortKey AS Member_Incentive_Designation FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID LEFT OUTER JOIN Member_Designation ON Member.Designation_SN = Member_Designation.Designation_SN LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial WHERE (Registration.Category = N'Member') AND (Member.Is_Identified = 1) AND (Member.Default_MemberStatus = 0) AND (Member_Package.Member_Package_Short_Key = N'V')"
            FilterExpression="Name LIKE '{0}%' or Phone LIKE '{0}%' or UserName LIKE '{0}%'" CancelSelectOnNullParameter="False" UpdateCommand="UPDATE Member SET IsCIP = 1, Member_Package_Serial = 4, CIP_IncomeLimit = @CIP_IncomeLimit WHERE (MemberID = @MemberID)">
            <FilterParameters>
                <asp:ControlParameter ControlID="FindTextBox" Name="Find" PropertyName="Text" />
            </FilterParameters>
            <UpdateParameters>
                <asp:Parameter Name="MemberID" />
                <asp:ControlParameter ControlID="IncomeLimit_TextBox" Name="CIP_IncomeLimit" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <br />
        <%if (MemberListGridView.Rows.Count > 0)
            { %>
        <div class="form-inline">
            <div class="form-group">
                <asp:TextBox ID="IncomeLimit_TextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" placeholder="Income Limit" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="IncomeLimit_TextBox" ValidationGroup="1" runat="server" ErrorMessage="*" CssClass="EroorStar"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Button ID="UpdateCIPButton" ValidationGroup="1" runat="server" Text="Update CIP" CssClass="btn btn-info" OnClick="UpdateCIPButton_Click" />
            </div>
        </div>
        <%} %>
    </div>

    <script>
        $(function () {
            $("[id*=AllCheckBox]").on("click", function () {
                var a = $(this), b = $(this).closest("table");
                $("input[type=checkbox]", b).each(function () {
                    a.is(":checked") ? ($(this).attr("checked", "checked"), $("td", $(this).closest("tr")).addClass("selected")) : ($(this).removeAttr("checked"), $("td", $(this).closest("tr")).removeClass("selected"));
                });
            });

            //Add or Remove CheckBox Selected Color
            $("[id*=ConfirmCheckBox]").on("click", function () {
                $(this).is(":checked") ? ($("td", $(this).closest("tr")).addClass("selected")) : ($("td", $(this).closest("tr")).removeClass("selected"), $($(this).closest("tr")).removeClass("selected"));
            });
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
