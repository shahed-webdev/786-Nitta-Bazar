<%@ Page Title="Customer Load Balance" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Customer_Load_Balance.aspx.cs" Inherits="NittaBazar.AccessAdmin.Sub_Admin.Account.Customer_Load_Balance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #user-info { display: none; }
            #user-info label { margin-bottom: 0; }
        .userid { font-size: 14px; padding: 13px 10px; margin-bottom: 7px; }
            .userid i { padding-left: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="ABFormView" runat="server" DataSourceID="AvilAbleBalanceSQL" DataKeyNames="Sub_Balance" OnDataBound="ABFormView_DataBound" Width="100%">
        <ItemTemplate>
            <h3>Customer Load Balance</h3>
            <h4 class="alert alert-success">
                <i class="fas fa-money-bill-alt"></i>
                My Balance: <strong>৳<%#Eval("Sub_Balance","{0:N}") %></strong></h4>
            <asp:HiddenField ID="AvailableBlnc_HF" Value='<%#Bind("Sub_Balance") %>' runat="server" />
        </ItemTemplate>
        <EmptyDataTemplate>
            <h3>No balance</h3>
        </EmptyDataTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="AvilAbleBalanceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT isnull(Sub_Balance,0) as Sub_Balance FROM Sub_Admin_Account WHERE (SubAdmin_RegistrationID = @SubAdmin_RegistrationID)" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="SubAdmin_RegistrationID" SessionField="RegistrationID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="col-md-7 well">
        <div class="form-group">
            <label>
                Customer Id
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="MemberTextBox" CssClass="EroorStar" ErrorMessage="Required" ValidationGroup="1"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="MemberTextBox" placeholder="Customer Id" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
        </div>
        <div id="user-info" class="alert-success">
            <div class="userid">
                <i class="fas fa-user-circle"></i>
                <label id="Customer_Name"></label>

                <i class="fa fa-phone-square"></i>
                <label id="Customer_Phone"></label>

                <i class="fas fa-money-bill-alt"></i>
                <label id="Customer_Balance"></label>
            </div>
            <asp:HiddenField ID="MemberID_HF" runat="server" />
            <asp:HiddenField ID="Phone_HF" runat="server" />
        </div>
        <div class="form-group">
            <label>
                Balance
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="BalanceTextBox" CssClass="EroorStar" ErrorMessage="Required" ValidationGroup="1"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="BalanceTextBox" CssClass="form-control" runat="server" onkeypress="return isNumberKey(event)" placeholder="Enter Balance" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="LoadButton" runat="server" Text="Balance Load" CssClass="btn btn-primary" ValidationGroup="1" OnClick="LoadButton_Click" />
            <asp:SqlDataSource ID="LoadBalanceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO Member_Load_Balance_Record(Admin_RegistrationID, Amount, MemberID) VALUES (@Admin_RegistrationID, @Amount, @MemberID)" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Member_Load_Balance_Record.Amount, Load_By.Name AS Load_By, Member_Load_Balance_Record.Insert_Date FROM Member INNER JOIN Member_Load_Balance_Record ON Member.MemberID = Member_Load_Balance_Record.MemberID INNER JOIN Registration AS Load_By ON Member_Load_Balance_Record.Admin_RegistrationID = Load_By.RegistrationID INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Load_By.RegistrationID = @RegistrationID) ORDER BY Member_Load_Balance_Record.Insert_Date" UpdateCommand="UPDATE Member SET Load_Balance = Load_Balance + @Load_Balance WHERE (MemberID = @MemberID)
UPDATE  Sub_Admin_Account SET  Sub_Balance = Sub_Balance - @Sub_Balance WHERE (SubAdmin_RegistrationID = @RegistrationID)">
                <InsertParameters>
                    <asp:SessionParameter Name="Admin_RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                    <asp:ControlParameter ControlID="MemberID_HF" Name="MemberID" PropertyName="Value" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Sub_Balance" PropertyName="Text" />
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Load_Balance" PropertyName="Text" />
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                    <asp:ControlParameter ControlID="MemberID_HF" Name="MemberID" PropertyName="Value" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SMS_OtherInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO SMS_OtherInfo(SMS_Send_ID, MemberID, RegistrationID) VALUES (@SMS_Send_ID, @MemberID, @RegistrationID)" SelectCommand="SELECT * FROM [SMS_OtherInfo]">
                <InsertParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:SessionParameter Name="MemberID" SessionField="MemberID" Type="Int32" />
                    <asp:Parameter Name="SMS_Send_ID" DbType="Guid" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:Label ID="ErrorLabel" runat="server" CssClass="EroorSummer"></asp:Label>
        </div>
    </div>

    <div class="clearfix"></div>
    <div class="table-responsive">
        <h4>Record</h4>
        <asp:GridView ID="RecordGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="LoadBalanceSQL" AllowPaging="True" AllowSorting="True" PageSize="80">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="User id" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0:N}" />
                <asp:BoundField DataField="Insert_Date" HeaderText="Load Date" SortExpression="Insert_Date" DataFormatString="{0:d MMM yyyy}" />
                <asp:BoundField DataField="Load_By" HeaderText="Loaded by" SortExpression="Load_By" />
            </Columns>
            <EmptyDataTemplate>
                No record
            </EmptyDataTemplate>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
    </div>

    <script>
        $(function () {
            //Get Seller Info
            $('[id*=MemberTextBox]').typeahead({
                minLength: 2,
                source: function (request, result) {
                    $.ajax({
                        url: "Customer_Load_Balance.aspx/Get_Member",
                        data: JSON.stringify({ 'prefix': request }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            label = [];
                            map = {};
                            $.map(JSON.parse(response.d), function (item) {
                                label.push(item.Username);
                                map[item.Username] = item;
                            });
                            result(label);
                        }
                    });
                },
                updater: function (item) {
                    $("#user-info").css("display", "block");
                    $("#Customer_Name").text(map[item].Name);
                    $("#Customer_Phone").text(map[item].Phone);
                    $("#Customer_Balance").text("Current Balance: " + map[item].Balance + " Tk");

                    $("[id$=MemberID_HF]").val(map[item].MemberID);
                    $("[id$=Phone_HF]").val(map[item].Phone);
                    return item;
                }
            });

            //Seller reset
            $("[id*=MemberTextBox]").on('keyup', function () {
                $("#Customer_Name").text("");
                $("#Customer_Phone").text("");
                $("[id*=BalanceTextBox]").val("");

                $("[id$=MemberID_HF]").val("");
                $("[id$=Phone_HF]").val("");
                $("#user-info").css("display", "none");
            });

            //Send_Amount_TextBox
            $("[id*=BalanceTextBox]").on('keyup', function () {
                var Available = parseFloat($("[id*=AvailableBlnc_HF]").val());
                var Send = parseFloat($("[id*=BalanceTextBox]").val());

                if ($("[id*=BalanceTextBox]").val() != "") {
                    Available >= Send ? ($("[id*=LoadButton]").prop("disabled", !1).addClass("btn btn-primary"), $("[id*=ErrorLabel]").text("")) : ($("[id*=LoadButton]").prop("disabled", !0).removeClass("btn btn-primary"), $("[id*=ErrorLabel]").text("Send Amount greater than available balance"));
                }
            });
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>
</asp:Content>
