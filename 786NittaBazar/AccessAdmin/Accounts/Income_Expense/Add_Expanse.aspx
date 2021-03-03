<%@ Page Title="Expanse" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Expanse.aspx.cs" Inherits="NittaBazar.AccessAdmin.Accounts.Add_Expanse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Expense</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="form-inline NoPrint">
                <div class="form-group">
                    <asp:DropDownList ID="FindCategoryDropDownList" runat="server" AppendDataBoundItems="True" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="CategoryName" DataValueField="ExpanseCategoryID">
                        <asp:ListItem Value="0">[ All Category ]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="CategorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT CategoryName, ExpanseCategoryID FROM Expanse_Category WHERE (InstitutionID = @InstitutionID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="FormDateTextBox" runat="server" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" placeholder="From Date" CssClass="Datetime form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="ToDateTextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" placeholder="To Date" CssClass="Datetime form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="FindButton" runat="server" Text="Find" CssClass="btn btn-primary"/>
                </div>
                <div class="form-group pull-right">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Category_Modal">Add New Category</button>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Expense_Modal">Add Expense</button>
                </div>
                <div class="clearfix"></div>
            </div>

            <asp:FormView ID="TotalFormView" runat="server" DataSourceID="ViewExpanseSQL" Width="100%">
                <ItemTemplate>
                    <div class="alert alert-info">
                        <h4 style="margin-bottom:0">Total Expense: <%#Eval("TotalExp","{0:N}") %> Tk</h4>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="ViewExpanseSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                SelectCommand="SELECT ISNULL(SUM(ExpanseAmount), 0) AS TotalExp FROM Expanse WHERE (InstitutionID = @InstitutionID) AND ((ExpanseCategoryID = @ExpanseCategoryID ) or ( @ExpanseCategoryID = 0))  AND ((ExpanseDate BETWEEN @Fdate AND @TDate) OR ((@Fdate = '1-1-1760') AND (@TDate = '1-1-1760')))">
                <SelectParameters>
                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                    <asp:ControlParameter ControlID="FindCategoryDropDownList" Name="ExpanseCategoryID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="FormDateTextBox" Name="Fdate" PropertyName="Text" DefaultValue="1-1-1760" />
                    <asp:ControlParameter ControlID="ToDateTextBox" Name="TDate" PropertyName="Text" DefaultValue="1-1-1760" />
                </SelectParameters>
            </asp:SqlDataSource>


            <div class="table-responsive">
                <asp:GridView ID="ExpanseGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpanseID" DataSourceID="ExpanseSQL" AllowPaging="True" PageSize="20" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ExpanseFor" HeaderText="Expanse For" SortExpression="ExpanseFor" />
                        <asp:TemplateField HeaderText="Expanse Amount" SortExpression="ExpanseAmount">
                            <EditItemTemplate>
                                <asp:TextBox ID="ExpTextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" Text='<%# Bind("ExpanseAmount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ExpanseAmount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ExpanseDate" DataFormatString="{0:d MMM yyyy}" HeaderText="Expanse Date" SortExpression="ExpanseDate" ReadOnly="True" />
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:Button ID="UpdateButton" CssClass="btn btn-default" runat="server" CausesValidation="True" CommandName="Update" Text="Updete"></asp:Button>
                                &nbsp;<asp:Button ID="CancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:Button>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <% if (User.Identity.Name == "admin")
                                    { %>
                                <asp:Button ID="EditButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:Button>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="No_Print" />
                            <ItemStyle Width="80px" CssClass="No_Print" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <% if (User.Identity.Name == "admin")
                                    { %>
                                <asp:Button ID="DLinkButton" runat="server" CssClass="btn btn-default" CausesValidation="False" OnClientClick="return confirm('Are You Sure Want To Delete?')" CommandName="Delete" Text="Delete"></asp:Button>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="No_Print" />
                            <ItemStyle Width="40px" CssClass="No_Print" />
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        Empty
                    </EmptyDataTemplate>
                    <PagerStyle CssClass="pgr" />
                </asp:GridView>
                <asp:SqlDataSource ID="ExpanseSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand="set context_info @RegistrationID
DELETE FROM [Expanse] WHERE [ExpanseID] = @ExpanseID"
                    InsertCommand="INSERT INTO Expanse(RegistrationID, InstitutionID, ExpanseCategoryID, ExpanseAmount, ExpanseFor, AccountID, ExpanseDate) VALUES (@RegistrationID, @InstitutionID, @ExpanseCategoryID, @ExpanseAmount, @ExpanseFor, @AccountID, @ExpanseDate)" SelectCommand="SELECT Expanse.ExpanseDate, Expanse_Category.CategoryName, Expanse.ExpanseFor, Expanse.ExpanseAmount, Expanse.ExpanseID,Expanse.Expense_Payment_Method FROM Expanse INNER JOIN Expanse_Category ON Expanse.ExpanseCategoryID = Expanse_Category.ExpanseCategoryID WHERE (Expanse.InstitutionID = @InstitutionID) AND ((Expanse.ExpanseCategoryID = @ExpanseCategoryID ) or ( @ExpanseCategoryID = 0)) AND((Expanse.ExpanseDate BETWEEN @Fdate AND @TDate) OR ((@Fdate = '1-1-1760') AND (@TDate = '1-1-1760'))) ORDER BY Expanse.ExpanseDate DESC" UpdateCommand="set context_info @RegistrationID
UPDATE Expanse SET ExpanseAmount = @ExpanseAmount, ExpanseFor = @ExpanseFor WHERE (ExpanseID = @ExpanseID)">
                    <DeleteParameters>
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:Parameter Name="ExpanseID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:ControlParameter ControlID="CategoryDropDownList" Name="ExpanseCategoryID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="AccountDropDownList" Name="AccountID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="AmountTextBox" Name="ExpanseAmount" PropertyName="Text" Type="Double" />
                        <asp:ControlParameter ControlID="ExpaneForTextBox" Name="ExpanseFor" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="Expane_DateTextBox" Name="ExpanseDate" PropertyName="Text" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                        <asp:ControlParameter ControlID="FindCategoryDropDownList" Name="ExpanseCategoryID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="FormDateTextBox" DefaultValue="1-1-1760" Name="Fdate" PropertyName="Text" />
                        <asp:ControlParameter ControlID="ToDateTextBox" DefaultValue="1-1-1760" Name="TDate" PropertyName="Text" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                        <asp:Parameter Name="ExpanseAmount" Type="Double" />
                        <asp:Parameter Name="ExpanseFor" Type="String" />
                        <asp:Parameter Name="ExpanseID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <!-- Category Modal -->
    <div id="Category_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Expense Category</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>
                                    Category
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="CategoryNameTextBox" CssClass="EroorSummer" ErrorMessage="*" ValidationGroup="CI"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="CategoryNameTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="NewCategoryButton" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="NewCategoryButton_Click" ValidationGroup="CI" />
                            </div>

                            <asp:GridView ID="CategoryNameGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ExpanseCategoryID" DataSourceID="CategoryNameSQL" OnRowDeleted="CategoryNameGridView_RowDeleted" AllowPaging="True">
                                <Columns>
                                    <asp:BoundField DataField="CategoryName" HeaderText="Category Name" SortExpression="CategoryName" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CausesValidation="True" CommandName="Update" Text="Updete"></asp:LinkButton>
                                            &nbsp;<asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="80px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="False" Text="Delete" OnClientClick="return confirm('Are You Sure Want To Delete?')" CommandName="Delete"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="CategoryNameSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand=" IF NOT EXISTS ( SELECT  * FROM Expanse WHERE (InstitutionID = @InstitutionID) AND (ExpanseCategoryID= @ExpanseCategoryID))
DELETE FROM [Expanse_Category] WHERE [ExpanseCategoryID] = @ExpanseCategoryID"
                                InsertCommand=" IF NOT EXISTS ( SELECT  * FROM [Expanse_Category] WHERE (InstitutionID = @InstitutionID) AND (CategoryName= @CategoryName))
INSERT INTO [Expanse_Category] ([RegistrationID], [InstitutionID], [CategoryName]) VALUES (@RegistrationID, @InstitutionID, @CategoryName)"
                                SelectCommand="SELECT * FROM Expanse_Category WHERE (InstitutionID = @InstitutionID) ORDER BY ExpanseCategoryID DESC" UpdateCommand="UPDATE Expanse_Category SET CategoryName = @CategoryName WHERE (ExpanseCategoryID = @ExpanseCategoryID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="InstitutionID" />
                                    <asp:Parameter Name="ExpanseCategoryID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                    <asp:ControlParameter ControlID="CategoryNameTextBox" Name="CategoryName" PropertyName="Text" Type="String" />
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="CategoryName" Type="String" />
                                    <asp:Parameter Name="ExpanseCategoryID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Expense Modal -->
    <div id="Expense_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Expense</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>
                                    CATEGORY
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CategoryDropDownList" CssClass="EroorSummer" ErrorMessage="*" InitialValue="0" ValidationGroup="1">*</asp:RequiredFieldValidator>
                                </label>
                                <asp:DropDownList ID="CategoryDropDownList" runat="server" CssClass="form-control" DataSourceID="CategorySQL" DataTextField="CategoryName" DataValueField="ExpanseCategoryID" AppendDataBoundItems="True">
                                    <asp:ListItem Value="0">[ SELECT CATEGORY ]</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label>
                                    Expense Amount
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="AmountTextBox" CssClass="EroorSummer" ErrorMessage="*" ValidationGroup="1">*</asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="AmountTextBox" onkeypress="return isNumberKey(event)" autocomplete="off" onDrop="blur();return false;" onpaste="return false" runat="server" CssClass="form-control" placeholder="Amount"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Expane For</label>
                                <asp:TextBox ID="ExpaneForTextBox" runat="server" CssClass="form-control" placeholder="Expane For"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Expane Date</label>
                                <asp:TextBox ID="Expane_DateTextBox" autocomplete="off" runat="server" CssClass="form-control Datetime" placeholder="Expane Date"></asp:TextBox>
                            </div>

                            <%
                                System.Data.DataView DetailsDV = new System.Data.DataView();
                                DetailsDV = (System.Data.DataView)AccountSQL.Select(DataSourceSelectArguments.Empty);
                                if (DetailsDV.Count > 0)
                                {%>
                            <div class="form-group">
                                <label>Account</label>
                                <asp:DropDownList ID="AccountDropDownList" runat="server" CssClass="form-control" DataSourceID="AccountSQL" DataTextField="AccountName" DataValueField="AccountID" OnDataBound="AccountDropDownList_DataBound">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="AccountSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT AccountID,AccountName  +' ('+ CONVERT (VARCHAR(100), AccountBalance)+')' as AccountName  FROM Account WHERE (InstitutionID = @InstitutionID AND AccountBalance &lt;&gt; 0)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="InstitutionID" SessionField="InstitutionID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%}%>

                            <div class="form-group">
                                <asp:Button ID="SubmitButton" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="SubmitButton_Click" ValidationGroup="1" />
                                <label id="ErMsg" class="SuccessMessage"></label>
                                <asp:Label ID="CheckBalanceLabel" runat="server" CssClass="EroorStar"></asp:Label>
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
                <img src="/CSS/Image/loading.gif" alt="Loading..." />
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

        //For Update Pannel
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (a, b) {
            $('.Datetime').datepicker({
                format: 'dd M yyyy',
                todayBtn: "linked",
                todayHighlight: true,
                autoclose: true
            });
        });

        function Success() {
            var e = $('#ErMsg');
            e.text("Expense Added Successfully!!");
            e.fadeIn();
            e.queue(function () { setTimeout(function () { e.dequeue(); }, 3000); });
            e.fadeOut('slow');
        }

        function isNumberKey(a) { a = a.which ? a.which : event.keyCode; return 46 != a && 31 < a && (48 > a || 57 < a) ? !1 : !0 };
    </script>

</asp:Content>
