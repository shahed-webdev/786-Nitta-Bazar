<%@ Page Title="Add Area" Language="C#" MasterPageFile="~/Basic.Master" AutoEventWireup="true" CodeBehind="Add_Area.aspx.cs" Inherits="NittaBazar.AccessAdmin.Seller.Type.Add_Area" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h3>Area</h3>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <ul class="nav panel-tabs">
                <li class="active"><a data-toggle="tab" href="#Zone">Add Zone</a></li>
                <li><a data-toggle="tab" href="#District">Add District</a></li>
                <li><a data-toggle="tab" href="#Thana">Add Thana</a></li>
                <li><a data-toggle="tab" href="#Union">Add Union</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="tab-content">
                <div id="Zone" class="tab-pane active">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="Zone_Name_TextBox" placeholder="Enter Zone Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Zone_Name_TextBox" ValidationGroup="Z" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="Zone_Button" CssClass="btn btn-primary" runat="server" Text="Add Zone" ValidationGroup="Z" OnClick="Zone_Button_Click" />
                                </div>
                            </div>
                            <asp:GridView ID="ZoneGridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ZoneID" DataSourceID="Insert_ZoneSQL">
                                <Columns>
                                    <asp:BoundField DataField="Zone" HeaderText="Zone" SortExpression="Zone" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Insert_ZoneSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="IF NOT EXISTS(SELECT * FROM [Seller_Zone] WHERE Zone = @Zone)
INSERT INTO [Seller_Zone] ([RegistrationID], [Zone]) VALUES (@RegistrationID, @Zone)" SelectCommand="SELECT * FROM [Seller_Zone]" UpdateCommand="UPDATE Seller_Zone SET Zone = @Zone WHERE (ZoneID = @ZoneID)">
                                <InsertParameters>
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                    <asp:ControlParameter ControlID="Zone_Name_TextBox" Name="Zone" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Zone" Type="String" />
                                    <asp:Parameter Name="ZoneID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="District" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="D_Zone_DropDownList" CssClass="form-control" runat="server" DataSourceID="Insert_ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="D_Zone_DropDownList_DataBound" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="D_Zone_DropDownList" InitialValue="0" ValidationGroup="D" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="DistrictName_TextBox" placeholder="Enter District Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="DistrictName_TextBox" ValidationGroup="D" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="District_Button" CssClass="btn btn-primary" runat="server" Text="Add District" ValidationGroup="D" OnClick="District_Button_Click" />
                                </div>
                            </div>
                            <asp:GridView ID="District_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="DistrictID" DataSourceID="Insert_DistrictSQL">
                                <Columns>
                                    <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Insert_DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="IF NOT EXISTS(SELECT * FROM Seller_District WHERE ZoneID = @ZoneID AND District = @District)
INSERT INTO Seller_District(ZoneID, RegistrationID, District) VALUES (@ZoneID, @RegistrationID, @District)" SelectCommand="SELECT DistrictID, ZoneID, RegistrationID, District, InsertDate, Is_Assign FROM Seller_District WHERE (ZoneID = @ZoneID)" UpdateCommand="UPDATE Seller_District SET District = @District WHERE (DistrictID = @DistrictID)">
                                <InsertParameters>
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                    <asp:ControlParameter ControlID="D_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="DistrictName_TextBox" Name="District" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="D_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="District" Type="String" />
                                    <asp:Parameter Name="DistrictID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Thana" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="T_Zone_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="Insert_ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="T_Zone_DropDownList_DataBound">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" InitialValue="0" ControlToValidate="T_Zone_DropDownList" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="T_District_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="T_DistrictSQL" DataTextField="District" DataValueField="DistrictID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="T_DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [DistrictID], [District] FROM [Seller_District] WHERE ([ZoneID] = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="T_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" InitialValue="0" ControlToValidate="T_District_DropDownList" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="Thana_TextBox" placeholder="Enter Thana Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Thana_TextBox" ValidationGroup="T" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="Thana_Button" CssClass="btn btn-primary" runat="server" Text="Add Thana" ValidationGroup="T" OnClick="Thana_Button_Click" />
                                </div>
                            </div>
                            <asp:GridView ID="Thana_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ThanaID" DataSourceID="Insert_ThanaSQL">
                                <Columns>
                                    <asp:BoundField DataField="Thana" HeaderText="Thana" SortExpression="Thana" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Insert_ThanaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="IF NOT EXISTS(SELECT * FROM Seller_Thana WHERE ZoneID = @ZoneID AND DistrictID = @DistrictID AND Thana = @Thana)
INSERT INTO Seller_Thana(DistrictID, ZoneID, RegistrationID, Thana) VALUES (@DistrictID, @ZoneID, @RegistrationID, @Thana)" SelectCommand="SELECT ZoneID, DistrictID, ThanaID, RegistrationID, Thana, InsertDate, Is_Assign FROM Seller_Thana WHERE (ZoneID = @ZoneID) AND (DistrictID = @DistrictID)" UpdateCommand="UPDATE Seller_Thana SET Thana = @Thana WHERE (ThanaID = @ThanaID)">
                                <InsertParameters>
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                    <asp:ControlParameter ControlID="T_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="T_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="Thana_TextBox" Name="Thana" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="T_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="T_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Thana" Type="String" />
                                    <asp:Parameter Name="ThanaID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="Union" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="U_Zone_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="Insert_ZoneSQL" DataTextField="Zone" DataValueField="ZoneID" OnDataBound="U_Zone_DropDownList_DataBound"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" InitialValue="0" ControlToValidate="U_Zone_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="U_District_DropDownList" CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="U_DistrictSQL" DataTextField="District" DataValueField="DistrictID"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="0" ControlToValidate="U_District_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                    <asp:SqlDataSource ID="U_DistrictSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [DistrictID], [District] FROM [Seller_District] WHERE ([ZoneID] = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="U_Thana_DropDownList" CssClass="form-control" runat="server" DataSourceID="U_ThanaSQL" DataTextField="Thana" DataValueField="ThanaID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="U_ThanaSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT Thana, ThanaID FROM Seller_Thana WHERE (DistrictID = @DistrictID) AND (ZoneID = @ZoneID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="U_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" InitialValue="0" ControlToValidate="U_Thana_DropDownList" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="Union_TextBox" placeholder="Enter Union Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="Union_TextBox" ValidationGroup="U" runat="server" CssClass="EroorStar" ErrorMessage="*" />
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="Union_Button" CssClass="btn btn-primary" runat="server" Text="Add Union" ValidationGroup="U" OnClick="Union_Button_Click" />
                                </div>
                            </div>
                            <asp:GridView ID="Union_GridView" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="UnionID" DataSourceID="Insert_UnionSQL">
                                <Columns>
                                    <asp:BoundField DataField="Seller_Union" HeaderText="Union" SortExpression="Seller_Union" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="Insert_UnionSQL" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" InsertCommand="IF NOT EXISTS(SELECT * FROM Seller_Union WHERE ZoneID = @ZoneID AND DistrictID = @DistrictID AND ThanaID = @ThanaID AND Seller_Union = @Seller_Union)
INSERT INTO Seller_Union(ThanaID, DistrictID, ZoneID, RegistrationID, Seller_Union) VALUES (@ThanaID, @DistrictID, @ZoneID, @RegistrationID, @Seller_Union)" SelectCommand="SELECT ZoneID, DistrictID, ThanaID, UnionID, RegistrationID, Seller_Union, InsertDate, Is_Assign FROM Seller_Union WHERE (ZoneID = @ZoneID) AND (DistrictID = @DistrictID) AND (ThanaID = @ThanaID)" UpdateCommand="UPDATE Seller_Union SET Seller_Union = @Seller_Union WHERE (UnionID = @UnionID)">
                                <InsertParameters>
                                    <asp:SessionParameter Name="RegistrationID" SessionField="RegistrationID" Type="Int32" />
                                    <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="U_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="U_Thana_DropDownList" Name="ThanaID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="Union_TextBox" Name="Seller_Union" PropertyName="Text" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="U_Zone_DropDownList" Name="ZoneID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="U_District_DropDownList" Name="DistrictID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="U_Thana_DropDownList" Name="ThanaID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Seller_Union" Type="String" />
                                    <asp:Parameter Name="UnionID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
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
