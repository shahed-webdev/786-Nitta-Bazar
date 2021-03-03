<%@ Page Title="Send SMS To Distributor" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Send_SMS_To_Seller.aspx.cs" Inherits="NittaBazar.AccessAdmin.SMS.Send_SMS_To_Seller" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #counter { margin: 0; padding: 0; }
            #counter li { margin-right: 10px; margin-bottom: 10px; list-style: none; float: left; background-color: #4B515D; padding: 2px 10px; border-radius: 5px; color: #fff; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="SMSFormView" runat="server" DataSourceID="SMSSQL" Width="100%" CssClass="NoPrint">
        <ItemTemplate>
            <h3>Send SMS To Distributor <small>(Remaining SMS: <%# Eval("SMS_Balance") %>)</small></h3>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SMSSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SMS_Balance FROM Institution" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>"></asp:SqlDataSource>

    <div class="table-responsive" style="margin-bottom: 20px;">
        <asp:GridView ID="SellerGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="SellerSQL" AllowSorting="True" PageSize="150">
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
                <asp:BoundField DataField="UserName" HeaderText="User Id" SortExpression="UserName" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                    <ItemTemplate>
                        <asp:Label ID="MobileLabel" runat="server" Text='<%# Bind("Phone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            </Columns>
            <PagerStyle CssClass="pgr" />
        </asp:GridView>
        <asp:SqlDataSource ID="SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Name, Registration.Phone, Registration.Email FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID"></asp:SqlDataSource>
        <asp:CustomValidator ID="CV" runat="server" ClientValidationFunction="Validate" ErrorMessage="You do not select any distributor." ForeColor="Red" ValidationGroup="1" />
    </div>

    <div class="col-sm-6 well">
        <div class="form-group">
            <label>
                SMS Text<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="Text_TextBox" CssClass="EroorStar" ValidationGroup="1"></asp:RequiredFieldValidator>
            </label>
            &nbsp;<asp:TextBox ID="Text_TextBox" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="clearfix">
            <ul id="counter">
                <li>Length: <span class="length"></span> char.</li>
                <li>Messages: <span class="messages"></span></li>
                <li>Per Message: <span class="per_message"></span> char.</li>
                <li>Remaining: <span class="remaining"></span> char.</li>
            </ul>
        </div>
        <div class="form-group">
            <asp:Button ID="SendButton" CssClass="btn btn-primary" runat="server" Text="Send SMS" ValidationGroup="1" OnClick="SendButton_Click" />
            <asp:SqlDataSource ID="SMS_OtherInfoSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="INSERT INTO SMS_Send_Record (SMS_Send_ID, PhoneNumber, TextSMS, TextCount, SMSCount, PurposeOfSMS, Status, Date, SMS_Response) VALUES  (@SMS_Send_ID,@PhoneNumber,@TextSMS,@TextCount,@SMSCount,@PurposeOfSMS,@Status, GETDATE(),@SMS_Response)
INSERT INTO SMS_OtherInfo(SMS_Send_ID, RegistrationID) VALUES (@SMS_Send_ID, @RegistrationID)"
                SelectCommand="SELECT * FROM [SMS_OtherInfo]">
                <InsertParameters>
                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    <asp:Parameter Name="SMS_Send_ID" DbType="Guid" />
                    <asp:Parameter Name="PhoneNumber" />
                    <asp:Parameter Name="TextSMS" />
                    <asp:Parameter Name="TextCount" />
                    <asp:Parameter Name="SMSCount" />
                    <asp:ControlParameter ControlID="Member_DropDownList" Name="PurposeOfSMS" PropertyName="SelectedItem.Text" />
                    <asp:Parameter DefaultValue="Sent" Name="Status" />
                    <asp:Parameter Name="SMS_Response" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </div>

    <script src="/JS/sms_counter.min.js"></script>
    <script>
        $(function () {
            $('[id*=Text_TextBox]').countSms('#counter');

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

        function Validate(d, c) {
            for (var b = document.getElementById("<%=SellerGridView.ClientID %>").getElementsByTagName("input"), a = 0; a < b.length; a++) {
                     if ("checkbox" == b[a].type && b[a].checked) {
                         c.IsValid = !0;
                         return;
                     }
                 }
                 c.IsValid = !1;
             };
    </script>
</asp:Content>
