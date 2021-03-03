<%@ Page Title="Send SMS To Customer" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Send_SMS_To_Customer.aspx.cs" Inherits="NittaBazar.AccessAdmin.SMS.Send_SMS_To_Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #counter { margin: 0;padding: 0; }
        #counter li {margin-right:10px; margin-bottom: 10px; list-style: none; float: left; background-color:#4B515D; padding: 2px 10px; border-radius: 5px; color: #fff; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:FormView ID="SMSFormView" runat="server" DataSourceID="SMSSQL" Width="100%" CssClass="NoPrint">
        <ItemTemplate>
            <h3>Send SMS To Customer <small>(Remaining SMS: <%# Eval("SMS_Balance") %>)</small></h3>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SMSSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SMS_Balance FROM Institution" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>"></asp:SqlDataSource>

    <div class="col-sm-6 well">
        <div class="form-group">
            <label>
                Select Customer
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" InitialValue="Select" ControlToValidate="Member_DropDownList" CssClass="EroorStar" ValidationGroup="1"></asp:RequiredFieldValidator>
            </label>
            <asp:DropDownList ID="Member_DropDownList" CssClass="form-control" runat="server" AppendDataBoundItems="True" DataSourceID="MemberTypeSQL" DataTextField="Pack" DataValueField="Member_Package_Serial">
                <asp:ListItem Value="Select">[ SELECT ]</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="MemberTypeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member_Package_Serial , Package +' ('+ CAST (Total_Customer as varchar) +')' AS Pack FROM (SELECT COUNT(Member.MemberID) AS Total_Customer, ISNULL(Member_Package.Member_Package_Status, 'No Package') AS Package, Member.Member_Package_Serial FROM  Member LEFT OUTER JOIN Member_Package ON Member.Member_Package_Serial = Member_Package.Package_Serial GROUP BY Member_Package.Member_Package_Status, Member.Member_Package_Serial ) AS M_Package ORDER BY Member_Package_Serial"></asp:SqlDataSource>
        </div>
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
INSERT INTO SMS_OtherInfo(SMS_Send_ID, RegistrationID) VALUES (@SMS_Send_ID, @RegistrationID)" SelectCommand="SELECT * FROM [SMS_OtherInfo]">
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
        });
    </script>
</asp:Content>
