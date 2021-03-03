<%@ Page Title="Income" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Others_Income.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Others_Income" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Income</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="form-inline NoPrint">
                <div class="form-group">
                    <asp:DropDownList ID="FindCategoryDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="Extra_Income_CategoryName" DataValueField="Extra_IncomeCategoryID">
                        <asp:ListItem Value="0">[ INCOME CATEGORY ]</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="FormDateTextBox" runat="server" CssClass="Datetime form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" placeholder="From Date"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="ToDateTextBox" runat="server" CssClass="Datetime form-control" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" placeholder="To Date"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="FindButton" runat="server" Text="Find" class="btn btn-primary" />
                </div>

                <div class="form-group pull-right">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Category_Modal">Add New Category</button>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Income_Modal">Add Income</button>
                </div>
                <div class="clearfix"></div>
            </div>

            <asp:FormView ID="TotalFormView" runat="server" DataSourceID="ViewIncomeSQL" Width="100%">
                <ItemTemplate>
                    <div class="alert alert-info">
                        <h4 style="margin-bottom: 0">Total Income: <%# Eval("Amount","{0:N}") %> Tk</h4>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="ViewIncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                SelectCommand="SELECT ISNULL(SUM(Extra_IncomeAmount), 0) AS Amount FROM [Extra_Income] WHERE (InstitutionID = @InstitutionID) AND ((Extra_IncomeCategoryID = @Extra_IncomeCategoryID) or ( @Extra_IncomeCategoryID = 0))  AND ((Extra_IncomeDate BETWEEN @Fdate AND @TDate) OR ((@Fdate = '1-1-1760') AND (@TDate = '1-1-1760')))">
                <SelectParameters>
                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                    <asp:ControlParameter ControlID="FindCategoryDropDownList" Name="Extra_IncomeCategoryID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="FormDateTextBox" DefaultValue="1-1-1760" Name="Fdate" PropertyName="Text" />
                    <asp:ControlParameter ControlID="ToDateTextBox" DefaultValue="1-1-1760" Name="TDate" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div class="table-responsive">
                <asp:GridView ID="ExtraIncomeGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Extra_IncomeID" DataSourceID="ExtraIncomeSQL" AllowPaging="True" PageSize="20" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="Extra_Income_CategoryName" HeaderText="Category" ReadOnly="True" SortExpression="Extra_Income_CategoryName" />
                        <asp:BoundField DataField="Extra_IncomeFor" HeaderText="Income For" SortExpression="Extra_IncomeFor" />
                        <asp:TemplateField HeaderText="Amount" SortExpression="Extra_IncomeAmount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Extra_IncomeAmount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Extra_IncomeAmount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Extra_IncomeDate" HeaderText="Income Date" SortExpression="Extra_IncomeDate" ReadOnly="True" DataFormatString="{0:d MMM yyyy}" />
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:Button ID="UpdateLinkButton" CssClass="btn btn-default" runat="server" CausesValidation="True" CommandName="Update" Text="Updete"></asp:Button>
                                &nbsp;<asp:Button ID="CancelLinkButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:Button>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <% if (User.Identity.Name == "admin")
                                    { %>
                                <asp:Button ID="EditLinkButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:Button>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="NoPrint" />
                            <ItemStyle Width="70px" CssClass="NoPrint" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <% if (User.Identity.Name == "admin")
                                    { %>
                                <asp:Button ID="DeleteLinkButton" CssClass="btn btn-default" runat="server" CausesValidation="False" OnClientClick="return confirm('Are You Sure Want To Delete?')" CommandName="Delete" Text="Delete"></asp:Button>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="NoPrint" />
                            <ItemStyle Width="40px" CssClass="NoPrint" />
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        No Income Added
                    </EmptyDataTemplate>
                    <PagerStyle CssClass="pgr" />
                </asp:GridView>
                <asp:SqlDataSource ID="ExtraIncomeSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                    DeleteCommand="set context_info @RegistrationID
DELETE FROM [Extra_Income] WHERE [Extra_IncomeID] = @Extra_IncomeID"
                    InsertCommand="INSERT INTO Extra_Income(InstitutionID, RegistrationID, Extra_IncomeCategoryID, Extra_IncomeAmount, Extra_IncomeFor, AccountID, Extra_IncomeDate) VALUES (@InstitutionID, @RegistrationID, @Extra_IncomeCategoryID, @Extra_IncomeAmount, @Extra_IncomeFor, @AccountID, @Extra_IncomeDate)"
                    SelectCommand="SELECT Extra_Income.Extra_IncomeAmount, Extra_Income.Extra_IncomeFor, Extra_Income.Extra_IncomePayment_Method, Extra_Income.Extra_IncomeDate, Extra_IncomeCategory.Extra_Income_CategoryName, Extra_Income.Extra_IncomeID FROM Extra_Income INNER JOIN Extra_IncomeCategory ON Extra_Income.Extra_IncomeCategoryID = Extra_IncomeCategory.Extra_IncomeCategoryID WHERE (Extra_Income.InstitutionID = @InstitutionID) AND (Extra_Income.Extra_IncomeCategoryID = @Extra_IncomeCategoryID OR @Extra_IncomeCategoryID = 0) AND (Extra_Income.Extra_IncomeDate BETWEEN @Fdate AND @TDate) OR (Extra_Income.InstitutionID = @InstitutionID) AND (Extra_Income.Extra_IncomeCategoryID = @Extra_IncomeCategoryID OR @Extra_IncomeCategoryID = 0) AND (@Fdate = '1-1-1760') AND (@TDate = '1-1-1760') Order by Extra_Income.Extra_IncomeDate DESC"
                    UpdateCommand="set context_info @RegistrationID
UPDATE Extra_Income SET Extra_IncomeAmount = @Extra_IncomeAmount, Extra_IncomeFor = @Extra_IncomeFor WHERE (Extra_IncomeID = @Extra_IncomeID)">
                    <DeleteParameters>
                        <asp:Parameter Name="Extra_IncomeID" Type="Int32" />
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:ControlParameter ControlID="CategoryDropDownList" Name="Extra_IncomeCategoryID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="AccountDropDownList" Name="AccountID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="AmountTextBox" Name="Extra_IncomeAmount" PropertyName="Text" Type="Double" />
                        <asp:ControlParameter ControlID="IncomeForTextBox" Name="Extra_IncomeFor" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="Income_DateTextBox" Name="Extra_IncomeDate" PropertyName="Text" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:ControlParameter ControlID="FindCategoryDropDownList" Name="Extra_IncomeCategoryID" PropertyName="SelectedValue" DefaultValue="" />
                        <asp:ControlParameter ControlID="FormDateTextBox" DefaultValue="1-1-1760" Name="Fdate" PropertyName="Text" />
                        <asp:ControlParameter ControlID="ToDateTextBox" DefaultValue="1-1-1760" Name="TDate" PropertyName="Text" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Extra_IncomeAmount" Type="Double" />
                        <asp:Parameter Name="Extra_IncomeFor" Type="String" />
                        <asp:Parameter Name="Extra_IncomeID" Type="Int32" />
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <!-- Category Modal -->
    <div id="Category_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Income Category</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>
                                    Category Name
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="NewCategoryNameTextBox" CssClass="EroorStar" ErrorMessage="*" ValidationGroup="G"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="NewCategoryNameTextBox" runat="server" CssClass="form-control" placeholder="Category Name" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="SaveButton" runat="server" CssClass="btn btn-primary" OnClick="SaveButton_Click" Text="Submit" ValidationGroup="G" />
                            </div>

                            <asp:GridView ID="AllCategory" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="Extra_IncomeCategoryID" DataSourceID="NewCategorySQL" AllowPaging="True">
                                <Columns>
                                    <asp:BoundField DataField="Extra_Income_CategoryName" HeaderText="Category Name" SortExpression="Extra_Income_CategoryName" />
                                    <asp:TemplateField>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Updete"></asp:LinkButton>
                                            &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="NoPrint" />
                                        <ItemStyle Width="40px" CssClass="NoPrint" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="False" OnClientClick="return confirm('Are You Sure Want To Delete?')" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="NoPrint" />
                                        <ItemStyle Width="40px" CssClass="NoPrint" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="NewCategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand="DELETE FROM [Extra_IncomeCategory] WHERE [Extra_IncomeCategoryID] = @Extra_IncomeCategoryID" InsertCommand=" IF NOT EXISTS ( SELECT  * FROM [Extra_IncomeCategory] WHERE (InstitutionID = @InstitutionID) AND ([Extra_Income_CategoryName]= @Extra_Income_CategoryName))

INSERT INTO [Extra_IncomeCategory] ([InstitutionID], [RegistrationID], [Extra_Income_CategoryName]) VALUES (@InstitutionID, @RegistrationID, @Extra_Income_CategoryName)"
                                SelectCommand="SELECT * FROM [Extra_IncomeCategory] WHERE ([InstitutionID] = @InstitutionID)" UpdateCommand="UPDATE Extra_IncomeCategory SET Extra_Income_CategoryName = @Extra_Income_CategoryName WHERE (Extra_IncomeCategoryID = @Extra_IncomeCategoryID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="Extra_IncomeCategoryID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                    <asp:ControlParameter ControlID="NewCategoryNameTextBox" Name="Extra_Income_CategoryName" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Extra_Income_CategoryName" Type="String" />
                                    <asp:Parameter Name="Extra_IncomeCategoryID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Income Modal -->
    <div id="Income_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Income</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>
                                    Income Category
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="CategoryDropDownList" CssClass="EroorSummer" ErrorMessage="*" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                                </label>
                                <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="Extra_Income_CategoryName" DataValueField="Extra_IncomeCategoryID" OnDataBound="CategoryDropDownList_DataBound">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Extra_IncomeCategory] WHERE ([InstitutionID] = @InstitutionID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>

                            <div class="form-group">
                                <label>
                                    Amount
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorSummer" ErrorMessage="*" ValidationGroup="1">*</asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="AmountTextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="form-control" placeholder="Amount"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Income For</label>
                                <asp:TextBox ID="IncomeForTextBox" runat="server" CssClass="form-control" placeholder="Income For"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Income Date</label>
                                <asp:TextBox ID="Income_DateTextBox" autocomplete="off" runat="server" CssClass="form-control Datetime" placeholder="Income Date"></asp:TextBox>
                            </div>
                            <%System.Data.DataView DetailsDV = new System.Data.DataView();
                                DetailsDV = (System.Data.DataView)AccountSQL.Select(DataSourceSelectArguments.Empty);
                                if (DetailsDV.Count > 0)
                                {%>
                            <div class="form-group">
                                <label>Account</label>
                                <asp:DropDownList ID="AccountDropDownList" runat="server" CssClass="form-control" DataSourceID="AccountSQL" DataTextField="AccountName" DataValueField="AccountID" OnDataBound="AccountDropDownList_DataBound">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT AccountID,AccountName  FROM Account WHERE (InstitutionID = @InstitutionID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%}%>

                            <div class="form-group">
                                <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="SubmitButton_Click" ValidationGroup="1" />
                                <label id="ErMsg" class="SuccessMessage"></label>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>


    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <div id="progress_BG"></div>
            <div id="progress">
                <img src="../../CSS/Image/loading.gif" alt="Loading..." />
                <br />
                <b>Loading...</b>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


    <script type="text/javascript">
        //Disable the submit button after clicking
        $("form").submit(function () {
            $("[id*=SubmitButton]").attr("disabled", true);
            setTimeout(function () {
                $("[id*=SubmitButton]").prop('disabled', false);
            }, 2000); // 2 seconds
            return true;
        })

        $(function () {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };

        function Success() {
            var e = $('#ErMsg');
            e.text("Income Added Successfully!!");
            e.fadeIn();
            e.queue(function () { setTimeout(function () { e.dequeue(); }, 3000); });
            e.fadeOut('slow');
        }
    </script>
</asp:Content>
