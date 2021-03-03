<%@ Page Title="Cash Position" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Cash_Position.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Cash_Position" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Cash Position</h3>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div class="form-inline">
                <div class="form-group">
                    <asp:TextBox ID="Find_Date_TextBox" CssClass="form-control Datetime" placeholder="Find Date" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="FindButton" runat="server" Text="Find" CssClass="btn btn-primary" />
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Insert Cash</button>
                </div>
            </div>

            <div class="alert alert-success">
                <asp:FormView ID="TotalFormView" runat="server" DataSourceID="TotlaSQL">
                    <ItemTemplate>
                            <label id="date"></label>
                            Total: <%# Eval("Total") %> Tk
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="TotlaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT SUM(Amount) AS Total FROM Cash_Position WHERE (Cash_Date = @Cash_Date)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Find_Date_TextBox" Name="Cash_Date" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

            <asp:GridView ID="CashGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="CashPositionID" DataSourceID="CashPositionSQL">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="uButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success"></asp:Button>
                            &nbsp;<asp:Button ID="ckButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger"></asp:Button>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="eButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-default"></asp:Button>
                        </ItemTemplate>
                        <HeaderStyle CssClass="hidden-print" />
                        <ItemStyle Width="155px" CssClass="hidden-print" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cash Unit" SortExpression="CashUnit">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("CashUnit") %>' onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("CashUnit") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity" SortExpression="Quantity">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("Quantity") %>' onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" SortExpression="Amount" />
                    <asp:BoundField DataField="Cash_Date" DataFormatString="{0:d MMM yyyy}" HeaderText="Date" ReadOnly="True" SortExpression="Cash_Date" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="dButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-warning" OnClientClick="return confirm('are you sure want delete?')"></asp:Button>
                        </ItemTemplate>
                        <HeaderStyle CssClass="hidden-print" />
                        <ItemStyle Width="60px" CssClass="hidden-print" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pgr" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <button type="button" class="btn btn-primary hidden-print" onclick="window.print();"><span class="glyphicon glyphicon-print"></span> Print</button>

    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Insert Cash</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <label>
                                    Cash Unit
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="CashUnit_TextBox" ValidationGroup="I" CssClass="EroorStar" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator></label>
                                <asp:TextBox ID="CashUnit_TextBox" CssClass="form-control" placeholder="Cash Unit" runat="server" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>
                                    Quantity
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Quantity_TextBox" ValidationGroup="I" CssClass="EroorStar" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator></label>
                                <asp:TextBox ID="Quantity_TextBox" CssClass="form-control" placeholder="Quantity" runat="server" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>
                                    Date
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Cash_Date_TextBox" ValidationGroup="I" CssClass="EroorStar" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator></label>
                                <asp:TextBox ID="Cash_Date_TextBox" CssClass="form-control Datetime" placeholder="Date" runat="server" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="Add_CashButton" CssClass="btn btn-primary" runat="server" Text="Add Cash" OnClick="Add_CashButton_Click" ValidationGroup="I" />
                                <asp:SqlDataSource ID="CashPositionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
                                    DeleteCommand="DELETE FROM [Cash_Position] WHERE [CashPositionID] = @CashPositionID" 
                                    InsertCommand="IF NOT EXISTS(SELECT * FROM Cash_Position WHERE CashUnit = @CashUnit AND Cash_Date = @Cash_Date)
INSERT INTO Cash_Position(RegistrationID, CashUnit, Quantity, Cash_Date) VALUES (@RegistrationID, @CashUnit, @Quantity, @Cash_Date)" 
                                    SelectCommand="SELECT * FROM Cash_Position WHERE (Cash_Date = @Cash_Date)" 
                                    UpdateCommand="IF NOT EXISTS(SELECT * FROM Cash_Position WHERE CashUnit = @CashUnit AND Cash_Date = @Cash_Date)
UPDATE Cash_Position SET CashUnit = @CashUnit, Quantity = @Quantity WHERE (CashPositionID = @CashPositionID)">
                                    <DeleteParameters>
                                        <asp:Parameter Name="CashPositionID" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="CashUnit_TextBox" Name="CashUnit" PropertyName="Text" />
                                        <asp:ControlParameter ControlID="Cash_Date_TextBox" Name="Cash_Date" PropertyName="Text" />
                                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" />
                                        <asp:ControlParameter ControlID="Quantity_TextBox" Name="Quantity" PropertyName="Text" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Find_Date_TextBox" Name="Cash_Date" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="CashUnit" Type="Int32" />
                                        <asp:Parameter Name="Cash_Date" />
                                        <asp:Parameter Name="Quantity" Type="Int32" />
                                        <asp:Parameter Name="CashPositionID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>


  <script>
      $(function () {
         $('.Datetime').datepicker({
             format: 'dd M yyyy',
             todayBtn: "linked",
             todayHighlight: true,
             autoclose: true
         });

         $("#date").text($('[id*=Find_Date_TextBox]').val());
      });
      //For Update Pannel
      Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {
          $('.Datetime').datepicker({
              format: 'dd M yyyy',
              todayBtn: "linked",
              todayHighlight: true,
              autoclose: true
          });

          $("#date").text($('[id*=Find_Date_TextBox]').val());
      });
      function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
   </script>
</asp:Content>
