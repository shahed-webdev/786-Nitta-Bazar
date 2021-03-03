<%@ Page Title="Assign Distributor Type" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Assign_Type.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Type.Assign_Type" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .panel-primary { border-color: #34495e; }
            .panel-primary .table-responsive { margin-bottom: 15px; }
            .panel-primary > .panel-heading { background-color: #34495e; border-color: #34495e; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Assign Distributor Type</h3>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Zone">Zone</a></li>
                <li><a data-toggle="tab" href="#District">District</a></li>
                <li><a data-toggle="tab" href="#Thana">Thana</a></li>
                <li><a data-toggle="tab" href="#Union">Union</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Zone" class="tab-pane active">
                    <h3>Secondary Director (SD)</h3>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="Zone_DropDownList" CssClass="form-control" runat="server" DataSourceID="Main_ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" AppendDataBoundItems="True">
                                        <asp:ListItem Value="0">[ SELECT ZONE ]</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="ZoneSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ZoneID, Zone FROM Seller_Zone"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="Main_ZoneSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT ZoneID, Zone FROM Seller_Zone WHERE (Is_Assign = 0)"></asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Zone_DropDownList" InitialValue="0" ValidationGroup="Z" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                            </div>

                            <div class="table-responsive">
                                <asp:GridView ID="Z_Seller_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SellerID" DataSourceID="Z_SellerSQL">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:Button ID="ZSelectButton" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CssClass="btn btn-default"></asp:Button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                        <asp:BoundField DataField="SellingPoint" HeaderText="Selling Point" SortExpression="SellingPoint" />
                                        <asp:BoundField DataField="Selling_Amount" HeaderText="Selling Amount" SortExpression="Selling_Amount" />
                                    </Columns>
                                    <SelectedRowStyle CssClass="Selected" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="Z_SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Phone, Seller.SellerID, Seller.Selling_Amount, Seller.SellingPoint, Seller.Shop_Name, Seller.Proprietor FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.Seller_Type IS NULL)" UpdateCommand="UPDATE Seller SET Seller_Type = N'SD' WHERE (SellerID = @SellerID) 
UPDATE Seller_Zone SET Is_Assign = 1, AssignDate = GETDATE(), SellerID =@SellerID WHERE (ZoneID = @ZoneID)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="Z_Seller_GridView" Name="SellerID" PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%if (Z_Seller_GridView.Rows.Count > 0)
                                { %>
                            <asp:Button ID="Z_SellerButton" ValidationGroup="Z" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="Z_SellerButton_Click" />
                            <%} %>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="District" class="tab-pane">
                    <h3>Mega Bazar (MB) <small>Min. Sale: 25,000 NP</small></h3>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="D_Zone_DropDownList" CssClass="form-control" runat="server" DataSourceID="ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="D_Zone_DropDownList_DataBound" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="D_Zone_DropDownList" InitialValue="0" ValidationGroup="D" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="D_District_DropDownList" CssClass="form-control" runat="server" DataSourceID="D_District_SQL" DataTextField="District" DataValueField="DistrictID" AutoPostBack="True" OnDataBound="D_District_DropDownList_DataBound">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="D_District_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT District, DistrictID FROM Seller_District WHERE (ZoneID = @ZoneID) AND (Is_Assign = 0)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="D_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="D_District_DropDownList" InitialValue="0" ValidationGroup="D" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="D_Seller_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SellerID" DataSourceID="D_SellerSQL">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:Button ID="DSelectButton" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CssClass="btn btn-default"></asp:Button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                        <asp:BoundField DataField="SellingPoint" HeaderText="Selling Point" SortExpression="SellingPoint" />
                                        <asp:BoundField DataField="Selling_Amount" HeaderText="Selling Amount" SortExpression="Selling_Amount" />
                                    </Columns>
                                    <SelectedRowStyle CssClass="Selected" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="D_SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Phone, Seller.SellerID, Seller.Selling_Amount, Seller.SellingPoint, Seller.Shop_Name, Seller.Proprietor FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.Seller_Type IS NULL) AND (Seller.SellingPoint &gt;= 25000)" UpdateCommand="UPDATE Seller SET Seller_Type = N'MB' WHERE (SellerID = @SellerID) 
UPDATE Seller_District SET Is_Assign = 1, AssignDate = GETDATE(), SellerID =@SellerID WHERE (DistrictID = @DistrictID)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="D_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="D_Seller_GridView" Name="SellerID" PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%if (D_Seller_GridView.Rows.Count > 0)
                                { %>
                            <asp:Button ID="D_Seller_Button" ValidationGroup="D" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="D_Seller_Button_Click" />
                            <%} %>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Thana" class="tab-pane">
                    <h3>Super Bazar (SB) <small>Min. Sale: 12,000 NP</small></h3>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="T_Zone_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="T_Zone_DropDownList_DataBound">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" InitialValue="0" ControlToValidate="T_Zone_DropDownList" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="T_District_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="T_DistrictSQL" DataTextField="District" DataValueField="DistrictID" OnDataBound="T_District_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:SqlDataSource ID="T_DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [DistrictID], [District] FROM [Seller_District] WHERE ([ZoneID] = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="T_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" InitialValue="0" ControlToValidate="T_District_DropDownList" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="T_Thana_DropDownList" CssClass="form-control" runat="server" DataSourceID="T_Thana_SQL" DataTextField="Thana" DataValueField="ThanaID" OnDataBound="T_Thana_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:SqlDataSource ID="T_Thana_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Thana, ThanaID FROM Seller_Thana WHERE (DistrictID = @DistrictID) AND (ZoneID = @ZoneID) AND (Is_Assign = 0)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="T_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="T_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="0" ControlToValidate="T_Thana_DropDownList" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="T_Seller_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SellerID" DataSourceID="T_SellerSQL">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:Button ID="TSelectButton" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CssClass="btn btn-default"></asp:Button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                        <asp:BoundField DataField="SellingPoint" HeaderText="Selling Point" SortExpression="SellingPoint" />
                                        <asp:BoundField DataField="Selling_Amount" HeaderText="Selling Amount" SortExpression="Selling_Amount" />
                                    </Columns>
                                    <SelectedRowStyle CssClass="Selected" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="T_SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Phone, Seller.SellerID, Seller.Selling_Amount, Seller.SellingPoint, Seller.Shop_Name, Seller.Proprietor FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.Seller_Type IS NULL) AND (Seller.SellingPoint &gt;= 12500)" UpdateCommand="UPDATE Seller SET Seller_Type = N'SB' WHERE (SellerID = @SellerID) 
UPDATE Seller_Thana SET Is_Assign = 1, AssignDate = GETDATE(), SellerID =@SellerID WHERE (ThanaID = @ThanaID)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="T_Thana_DropDownList" Name="ThanaID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="T_Seller_GridView" Name="SellerID" PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%if (T_Seller_GridView.Rows.Count > 0)
                                { %>
                            <asp:Button ID="T_Seller_Button" ValidationGroup="T" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="T_Seller_Button_Click" />
                            <%} %>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Union" class="tab-pane">
                    <h3>Mini Bazar (MNB) <small>Min. Sale: 7,000 NP</small></h3>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="U_Zone_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="U_Zone_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" InitialValue="0" ControlToValidate="U_Zone_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="U_District_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="U_DistrictSQL" DataTextField="District" DataValueField="DistrictID" OnDataBound="U_District_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="0" ControlToValidate="U_District_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                    <asp:SqlDataSource ID="U_DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [DistrictID], [District] FROM [Seller_District] WHERE ([ZoneID] = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="U_Thana_DropDownList" CssClass="form-control" runat="server" DataSourceID="U_ThanaSQL" DataTextField="Thana" DataValueField="ThanaID" OnDataBound="U_Thana_DropDownList_DataBound" AutoPostBack="True"></asp:DropDownList>
                                    <asp:SqlDataSource ID="U_ThanaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Thana, ThanaID FROM Seller_Thana WHERE (DistrictID = @DistrictID) AND (ZoneID = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="U_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" InitialValue="0" ControlToValidate="U_Thana_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="Union_DropDownList" CssClass="form-control" runat="server" DataSourceID="Union_SQL" DataTextField="Seller_Union" DataValueField="UnionID" OnDataBound="Union_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:SqlDataSource ID="Union_SQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT UnionID, Seller_Union FROM Seller_Union WHERE (ZoneID = @ZoneID) AND (DistrictID = @DistrictID) AND (ThanaID = @ThanaID) AND (Is_Assign = 0)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="U_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="U_Thana_DropDownList" Name="ThanaID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" InitialValue="0" ControlToValidate="Union_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="U_Seller_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="SellerID" DataSourceID="U_SellerSQL">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:Button ID="USelectButton" runat="server" CausesValidation="False" CommandName="Select" Text="Select" CssClass="btn btn-default"></asp:Button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                                        <asp:BoundField DataField="Shop_Name" HeaderText="Shop Name" SortExpression="Shop_Name" />
                                        <asp:BoundField DataField="Proprietor" HeaderText="Proprietor" SortExpression="Proprietor" />
                                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                        <asp:BoundField DataField="SellingPoint" HeaderText="Selling Point" SortExpression="SellingPoint" />
                                        <asp:BoundField DataField="Selling_Amount" HeaderText="Selling Amount" SortExpression="Selling_Amount" />
                                    </Columns>
                                    <SelectedRowStyle CssClass="Selected" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="U_SellerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Registration.UserName, Registration.Phone, Seller.SellerID, Seller.Selling_Amount, Seller.SellingPoint, Seller.Shop_Name, Seller.Proprietor FROM Seller INNER JOIN Registration ON Seller.SellerRegistrationID = Registration.RegistrationID WHERE (Seller.Seller_Type IS NULL) AND (Seller.SellingPoint &gt;= 7000)" UpdateCommand="UPDATE Seller SET Seller_Type = N'MNB' WHERE (SellerID = @SellerID) 
UPDATE Seller_Union SET Is_Assign = 1, AssignDate = GETDATE(), SellerID =@SellerID WHERE (UnionID = @UnionID)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="Union_DropDownList" Name="UnionID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="U_Seller_GridView" Name="SellerID" PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                            <%if (U_Seller_GridView.Rows.Count > 0)
                                { %>
                            <asp:Button ID="U_Seller_Button" ValidationGroup="U" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="U_Seller_Button_Click" />
                            <%} %>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
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
</asp:Content>
