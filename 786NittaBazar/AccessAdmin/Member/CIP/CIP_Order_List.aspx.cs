using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Member.CIP
{
    public partial class CIP_Order_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataView dv = (DataView)OrderSQL.Select(DataSourceSelectArguments.Empty);
                Total_Label.Text = "Total: " + dv.Count.ToString() + " Order";
            }
        }

        protected void DeliveryButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            string Product_DistributionID = OrderGridView.DataKeys[row.RowIndex % OrderGridView.PageSize]["Product_DistributionID"].ToString();


            DeliverySQL.UpdateParameters["Product_DistributionID"].DefaultValue = Product_DistributionID;
            DeliverySQL.Update();


            SqlCommand Product_Dis_cmd = new SqlCommand("SELECT ProductID, SellingQuantity FROM Product_Distribution_Records WHERE (Product_DistributionID = @Product_DistributionID)", con);
            Product_Dis_cmd.Parameters.AddWithValue("Product_DistributionID", Product_DistributionID);

            con.Open();
            SqlDataReader Product_Distri;
            Product_Distri = Product_Dis_cmd.ExecuteReader();

            while (Product_Distri.Read())
            {
                Stock_UpdateSQL.UpdateParameters["Product_PointID"].DefaultValue = Product_Distri["ProductID"].ToString();
                Stock_UpdateSQL.UpdateParameters["Stock_Quantity"].DefaultValue = Product_Distri["SellingQuantity"].ToString();
                Stock_UpdateSQL.Update();
            }
            con.Close();


            OrderGridView.DataBind();
            Response.Redirect("Receipt.aspx?P=" + Product_DistributionID);
        }

        protected void FindButton_Click(object sender, EventArgs e)
        {
            DataView dv = (DataView)OrderSQL.Select(DataSourceSelectArguments.Empty);
            Total_Label.Text = "Total: " + dv.Count.ToString() + " Order";
        }
    }
}