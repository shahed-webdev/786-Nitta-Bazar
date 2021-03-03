<%@ Page Title="Free Joining Limit" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Joining_Limit.aspx.cs" Inherits="NittaBazar.AccessAdmin.Member.Joining_Limit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Free Joining Limit</h3>

    <div class="form-inline">
        <div class="form-group">
            <asp:TextBox ID="UserID_TextBox" placeholder="Enter User Id" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RF" runat="server" ErrorMessage="*" CssClass="EroorStar" ControlToValidate="UserID_TextBox" ValidationGroup="F"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="Find_Button" CssClass="btn btn-primary" runat="server" Text="Find User" ValidationGroup="F" />
        </div>
    </div>

    <asp:FormView ID="Join_FormView" DefaultMode="Edit" DataKeyNames="MemberID" runat="server" DataSourceID="Joining_LimitSQL" Width="100%">
        <EditItemTemplate>
            <ul class="list-group">
                <li class="list-group-item">User Id: <%# Eval("UserName") %></li>
                <li class="list-group-item">Name: <%#Eval("Name") %></li>
                <li class="list-group-item">Phone: <%# Eval("Phone") %></li>
            </ul>

            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="FreeJoinLimitTextBox" CssClass="form-control" placeholder="Joining Limit" runat="server" Text='<%# Bind("FreeJoinLimit") %>' />
                     <asp:RequiredFieldValidator ID="RF" runat="server" ErrorMessage="*" CssClass="EroorStar" ControlToValidate="FreeJoinLimitTextBox" ValidationGroup="JL"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-default" ValidationGroup="JL" CausesValidation="True" CommandName="Update" Text="Update" />
                </div>
            </div>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="Joining_LimitSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Member.FreeJoinLimit,Member.MemberID, Registration.UserName, Registration.Name, Registration.FatherName, Registration.Phone FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)" UpdateCommand="UPDATE [Member] SET [FreeJoinLimit] = @FreeJoinLimit WHERE [MemberID] = @MemberID">
        <SelectParameters>
            <asp:ControlParameter ControlID="UserID_TextBox" Name="UserName" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FreeJoinLimit" Type="Int32" />
            <asp:Parameter Name="MemberID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
