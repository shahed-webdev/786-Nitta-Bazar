using System;
using System.Data;
using System.Web.UI;

namespace NittaBazar.AccessAdmin.Seller
{
    public partial class Seller_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataView dv = (DataView)SellerSQL.Select(DataSourceSelectArguments.Empty);
                Total_Label.Text = "Total: " + dv.Count.ToString() + " " + SellerTypeDropDownList.SelectedItem.Text + " Distributor(s)";
            }
        }
        protected void FindButton_Click(object sender, EventArgs e)
        {
            DataView dv = (DataView)SellerSQL.Select(DataSourceSelectArguments.Empty);
            Total_Label.Text = "Total: " + dv.Count.ToString() + " " + SellerTypeDropDownList.SelectedItem.Text + " Distributor(s)";
        }
        protected void SellerTypeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SellerSQL.Select(DataSourceSelectArguments.Empty);
            Total_Label.Text = "Total: " + dv.Count.ToString() + " " + SellerTypeDropDownList.SelectedItem.Text + " Distributor(s)";
        }
    }
}