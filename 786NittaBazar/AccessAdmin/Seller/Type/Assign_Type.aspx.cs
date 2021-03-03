using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Seller.Type
{
    public partial class Assign_Type : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

        protected void D_District_DropDownList_DataBound(object sender, EventArgs e)
        {
            D_District_DropDownList.Items.Insert(0, new ListItem("[ SELECT DISTRICT ]", "0"));
        }

        protected void T_District_DropDownList_DataBound(object sender, EventArgs e)
        {
            T_District_DropDownList.Items.Insert(0, new ListItem("[ SELECT DISTRICT ]", "0"));
        }

        protected void T_Thana_DropDownList_DataBound(object sender, EventArgs e)
        {
            T_Thana_DropDownList.Items.Insert(0, new ListItem("[ SELECT THANA ]", "0"));
        }

        protected void U_District_DropDownList_DataBound(object sender, EventArgs e)
        {
            U_District_DropDownList.Items.Insert(0, new ListItem("[ SELECT DISTRICT ]", "0"));
        }

        protected void U_Thana_DropDownList_DataBound(object sender, EventArgs e)
        {
            U_Thana_DropDownList.Items.Insert(0, new ListItem("[ SELECT THANA ]", "0"));
        }

        protected void Union_DropDownList_DataBound(object sender, EventArgs e)
        {
            Union_DropDownList.Items.Insert(0, new ListItem("[ SELECT UNION ]", "0"));
        }

        //Update
        protected void Z_SellerButton_Click(object sender, EventArgs e)
        {
            Z_SellerSQL.Update();
            Z_Seller_GridView.DataBind();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void D_Seller_Button_Click(object sender, EventArgs e)
        {
            D_SellerSQL.Update();
            D_Seller_GridView.DataBind();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void T_Seller_Button_Click(object sender, EventArgs e)
        {
            T_SellerSQL.Update();
            T_Seller_GridView.DataBind();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void U_Seller_Button_Click(object sender, EventArgs e)
        {
            U_SellerSQL.Update();
            U_Seller_GridView.DataBind();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}