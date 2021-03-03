<%@ Page Title="Loaded Balance Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Load_Balance_Report.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Load_Balance_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Loaded Balance Report</h3>
    <div class="form-inline">
        <div class="form-group">
            <asp:DropDownList ID="Type_DropDownList" CssClass="form-control" runat="server">
                <asp:ListItem Value="%">All Type</asp:ListItem>
                <asp:ListItem Value="Seller">Distributor</asp:ListItem>
                <asp:ListItem Value="Member">Customer</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="Accountant_DropDownList" CssClass="form-control" runat="server" AppendDataBoundItems="True" DataSourceID="AccountantSQL" DataTextField="Name" DataValueField="RegistrationID">
                <asp:ListItem Value="%">All Accountant</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="AccountantSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.RegistrationID, Registration.Name + ' (' + Registration.UserName + ')' AS Name FROM Sub_Admin_Account INNER JOIN Registration ON Sub_Admin_Account.SubAdmin_RegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
        </div>
        <div class="form-group">
            <asp:TextBox ID="FromDateTextBox" autocomplete="off" placeholder="From Date" CssClass="form-control datepicker" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="ToDateTextBox" autocomplete="off" placeholder="To Date" CssClass="form-control datepicker" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="FindButton" runat="server" Text="Find" CssClass="btn btn-default" />
        </div>
    </div>
   <div class="alert alert-success">
        <h4 style="margin-bottom:0" id="Total_Label"></h4>
    </div>
    <div class="table-responsive">
        <asp:GridView ID="LoadGridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="LoadSQL" AllowSorting="True" PageSize="50">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
               <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                    <ItemTemplate>
                        <label class="AmountLabel"><%# Eval("Amount") %></label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Insert_Date" HeaderText="Date" SortExpression="Insert_Date" DataFormatString="{0:d MMM yyyy}" />
                <asp:BoundField DataField="Load_By" HeaderText="Load By" SortExpression="Load_By" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="LoadSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT UserName, Name, Phone, Amount, Insert_Date, Load_By, RegistrationID, Category FROM VW_Load_Balance_Record WHERE (Category LIKE @Category) AND (Insert_Date BETWEEN ISNULL(@Fdate, '1-1-1760') AND ISNULL(@TDate, '1-1-3760')) AND (RegistrationID LIKE @RegistrationID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Type_DropDownList" Name="Category" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="FromDateTextBox" Name="Fdate" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="TDate" PropertyName="Text" />
                <asp:ControlParameter ControlID="Accountant_DropDownList" Name="RegistrationID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <script>
        $(function () {
            $('.datepicker').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });

            var grandTotal = 0;
            $(".AmountLabel").each(function () {
                var value = $(this).html();
                if (value != "")
                    grandTotal = grandTotal + parseFloat(value);
            });
            $("#Total_Label").html("Total: ৳" + grandTotal.toString());
        });
    </script>
</asp:Content>
