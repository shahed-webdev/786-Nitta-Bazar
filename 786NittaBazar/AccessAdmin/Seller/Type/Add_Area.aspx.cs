using System;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Seller.Type
{
    public partial class Add_Area : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Zone_Button_Click(object sender, EventArgs e)
        {
            Insert_ZoneSQL.Insert();
            Zone_Name_TextBox.Text = "";
        }

        protected void District_Button_Click(object sender, EventArgs e)
        {
            Insert_DistrictSQL.Insert();
            DistrictName_TextBox.Text = "";
        }

        protected void Thana_Button_Click(object sender, EventArgs e)
        {
            Insert_ThanaSQL.Insert();
            Thana_TextBox.Text = "";
        }

        protected void Union_Button_Click(object sender, EventArgs e)
        {
            Insert_UnionSQL.Insert();
            Union_TextBox.Text = "";
        }

        protected void D_Zone_DropDownList_DataBound(object sender, EventArgs e)
        {
            D_Zone_DropDownList.Items.Insert(0, new ListItem("[ SELECT ZONE ]", "0"));
        }

        protected void T_Zone_DropDownList_DataBound(object sender, EventArgs e)
        {
            T_Zone_DropDownList.Items.Insert(0, new ListItem("[ SELECT ZONE ]", "0"));
        }

        protected void U_Zone_DropDownList_DataBound(object sender, EventArgs e)
        {
            U_Zone_DropDownList.Items.Insert(0, new ListItem("[ SELECT ZONE ]", "0"));
        }
    }
}