<%@ Page Title="Distributor Load Balance" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Load_Balance.aspx.cs" Inherits="NittaBazar.AccessAdmin.Sub_Admin.Account.Load_Balance" %>

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
            <h3>Distributor Load Balance</h3>
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
                Distributor Id
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SellerTextBox" CssClass="EroorStar" ErrorMessage="Required" ValidationGroup="1"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="SellerTextBox" placeholder="Distributor Id" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
        </div>
        <div id="user-info" class="alert-success">
            <div class="userid">
                <i class="fas fa-user-circle"></i>
                <label id="Seller_Name"></label>

                <i class="fa fa-phone-square"></i>
                <label id="Seller_Phone"></label>

                <i class="fas fa-money-bill-alt"></i>
                <label id="Seller_Balance"></label>
            </div>
            <asp:HiddenField ID="SellerID_HF" runat="server" />
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
            <asp:SqlDataSource ID="LoadBalanceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO [Seller_Load_Balance_Record] ([Admin_RegistrationID], [SellerID], [Amount]) VALUES (@Admin_RegistrationID, @SellerID, @Amount)" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Seller_Load_Balance_Record.Amount, Seller_Load_Balance_Record.Insert_Date, Load_By.Name AS Load_By FROM Seller_Load_Balance_Record INNER JOIN Seller ON Seller_Load_Balance_Record.SellerID = Seller.SellerID INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID INNER JOIN Registration AS Load_By ON Seller_Load_Balance_Record.Admin_RegistrationID = Load_By.RegistrationID WHERE (Load_By.RegistrationID = @RegistrationID) ORDER BY Seller_Load_Balance_Record.Insert_Date" 
                UpdateCommand="UPDATE Seller SET Load_Balance = Load_Balance + @Load_Balance WHERE (SellerID = @SellerID)
UPDATE  Sub_Admin_Account SET  Sub_Balance = Sub_Balance - @Sub_Balance WHERE (SubAdmin_RegistrationID = @RegistrationID)">
                <InsertParameters>
                    <asp:SessionParameter Name="Admin_RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:ControlParameter ControlID="SellerID_HF" Name="SellerID" PropertyName="Value" Type="Int32" />
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Amount" PropertyName="Text" Type="Double" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Load_Balance" PropertyName="Text" />
                    <asp:ControlParameter ControlID="SellerID_HF" Name="SellerID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="BalanceTextBox" Name="Sub_Balance" PropertyName="Text" />
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
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
        //Get Seller Info
        $(function () {
            $('[id*=SellerTextBox]').typeahead({
                minLength:2,
                source: function (request, result) {
                    $.ajax({
                        url: "Load_Balance.aspx/Get_Seller",
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
                    $("#Seller_Name").text(map[item].Name);
                    $("#Seller_Phone").text(map[item].Phone);
                    $("#Seller_Balance").text("Current Balance: " + map[item].Balance + " Tk");

                    $("[id$=SellerID_HF]").val(map[item].SellerID);
                    $("[id$=Phone_HF]").val(map[item].Phone);
                    return item;
                }
            });

            //Seller reset
            $("[id*=SellerTextBox]").on('keyup', function () {
                $("#Seller_Name").text("");
                $("#Seller_Phone").text("");
                $("[id*=BalanceTextBox]").val("");

                $("[id$=SellerID_HF]").val("");
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
