<%@ Page Title="Balance Transfer Report" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Balance_Transfer_Report.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Balance_Transfer_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mGrid td small { display: block; color: #929292; line-height: 15px; font-size: 13px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Balance Transfer Report</h3>

    <div class="form-inline">
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
        <asp:GridView ID="TransferGridView" CssClass="mGrid" runat="server" AutoGenerateColumns="False" DataSourceID="TransferSQL" AllowSorting="True" PageSize="50">
            <Columns>
                <asp:TemplateField HeaderText="Distrubutor" SortExpression="SellerName">
                    <ItemTemplate>
                        <%# Eval("SellerName") %>
                        <small><%#Eval("SellerUserName") %></small>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Customer" SortExpression="Name">
                    <ItemTemplate>
                        <%#Eval("Name") %>
                        <small><%#Eval("UserName") %></small>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                    <ItemTemplate>
                        <label class="AmountLabel"><%# Eval("Amount") %></label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TransitionDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" SortExpression="TransitionDate"></asp:BoundField>
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="TransferSQL" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Seller_Reg.Name AS SellerName, Seller_Reg.UserName AS SellerUserName, Fund_Transition.Amount, Registration.UserName, Registration.Name, Registration.Phone, Fund_Transition.TransitionDate FROM Fund_Transition INNER JOIN Registration AS Seller_Reg ON Fund_Transition.Received_RegistrationID = Seller_Reg.RegistrationID INNER JOIN Registration ON Fund_Transition.Sent_RegistrationID = Registration.RegistrationID WHERE (Seller_Reg.Category = N'Seller') AND (CAST(Fund_Transition.TransitionDate AS DATE) BETWEEN ISNULL(@Fdate, '1-1-1760') AND ISNULL(@TDate, '1-1-3760')) ORDER BY Fund_Transition.TransitionDate">
            <SelectParameters>
                <asp:ControlParameter ControlID="FromDateTextBox" Name="Fdate" PropertyName="Text" />
                <asp:ControlParameter ControlID="ToDateTextBox" Name="TDate" PropertyName="Text" />
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
            })

            var grandTotal = 0;
            $(".AmountLabel").each(function () {
                var value = $(this).html();
                if (value != "")
                    grandTotal = grandTotal + parseFloat(value);
            });
            $("#Total_Label").html("Total: ৳"+grandTotal.toString());
        });
    </script>
</asp:Content>
