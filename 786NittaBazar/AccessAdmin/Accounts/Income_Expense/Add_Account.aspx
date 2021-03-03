<%@ Page Title="Account, Deposit/Withdraw" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Account.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Add_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Account, Deposit/Withdraw</h3>
    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="AccountNameTextBox" placeholder="Enter Account Name" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="AccountNameTextBox" CssClass="EroorSummer" ErrorMessage="*" ValidationGroup="I"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="AddAccountButton" runat="server" CssClass="btn btn-primary" OnClick="AddAccountButton_Click" Text="Add" ValidationGroup="I" />
            <asp:Label ID="ErrLabel" runat="server" CssClass="EroorSummer"></asp:Label>
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="AccountNameGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="AccountID" DataSourceID="AccountNameSQL">
            <Columns>
                <asp:TemplateField HeaderText="Account">
                    <ItemTemplate>
                        <asp:LinkButton ID="lb" runat="server" PostBackUrl='<%# String.Format("Deposit_Withdraw.aspx?AccountID={0}",Eval("AccountID")) %>' Text='<%# Eval("AccountName") %>' />
                        (<asp:Label ID="Label1" runat="server" Text='<%# Bind("AccountBalance") %>' />)
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="AnTextBox" CssClass="form-control" runat="server" Text='<%# Bind("AccountName") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Total_IN" HeaderText="Deposit" SortExpression="Total_IN" ReadOnly="true" />
                <asp:BoundField DataField="Total_OUT" HeaderText="Withdraw" SortExpression="Total_OUT" ReadOnly="true" />
                <asp:BoundField DataField="Total_Income" HeaderText="Income" SortExpression="Total_Income" ReadOnly="true" />
                <asp:BoundField DataField="Total_Expense" HeaderText="Expense" SortExpression="Total_Expense" ReadOnly="true" />
                <asp:BoundField DataField="Deleted_Income" HeaderText="Deleted Income" SortExpression="Deleted_Income" ReadOnly="true" />
                <asp:BoundField DataField="Deleted_Expense" HeaderText="Deleted Expense" SortExpression="Deleted_Expense" ReadOnly="true" />
                <asp:TemplateField HeaderText="Default" SortExpression="Default_Status">
                    <ItemTemplate>
                        <asp:CheckBox ID="DStatusCheckBox" runat="server" Text=" " Checked='<%# Bind("Default_Status") %>' AutoPostBack="True" OnCheckedChanged="DStatusCheckBox_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirm('Do you want to delete?')" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="AccountNameSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand=" IF NOT EXISTS (SELECT * FROM Account_Log WHERE  [AccountID] = @AccountID)
DELETE FROM [Account] WHERE [AccountID] = @AccountID"
            InsertCommand="IF NOT EXISTS(SELECT * FROM  Account WHERE InstitutionID = @InstitutionID AND AccountName = @AccountName)
INSERT INTO Account(AccountName, RegistrationID, InstitutionID) VALUES (@AccountName, @RegistrationID, @InstitutionID)
ELSE
SET @ERROR = @AccountName + '  Already Exists'"
            SelectCommand="SELECT * FROM Account WHERE (InstitutionID = @InstitutionID)" UpdateCommand="UPDATE Account SET AccountName = @AccountName WHERE (AccountID = @AccountID)" OnInserted="AccountNameSQL_Inserted">
            <DeleteParameters>
                <asp:Parameter Name="AccountID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="AccountNameTextBox" Name="AccountName" PropertyName="Text" Type="String" />
                <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                <asp:Parameter Direction="Output" Name="ERROR" Size="256" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="AccountID" Type="Int32" />
                <asp:Parameter Name="AccountName" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="DefaultAccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Account]" UpdateCommand="UPDATE Account SET Default_Status = 1 WHERE (AccountID = @AccountID) AND (InstitutionID=@InstitutionID) 
UPDATE Account SET Default_Status = 0 WHERE (AccountID &lt;&gt;@AccountID) AND (InstitutionID=@InstitutionID)">
            <UpdateParameters>
                <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                <asp:Parameter Name="AccountID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
