using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Member.CIP
{
    public partial class Change_Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["Pdid"]))
            {
                Response.Redirect("CIP_Order_List.aspx");
            }

            try
            {
                GridView ReceiptGV = MemberFormView.FindControl("ReceiptGridView") as GridView;
                CIPProductSQL.SelectParameters["Product_PointID"].DefaultValue = ReceiptGV.DataKeys[0]["ProductID"].ToString();
                CIPProductSQL.SelectParameters["Product_Point"].DefaultValue = ReceiptGV.DataKeys[0]["SellingUnitPoint"].ToString();
                CIPProductSQL.SelectParameters["Product_Price"].DefaultValue = ReceiptGV.DataKeys[0]["SellingUnitPrice"].ToString();
            }
            catch
            {
                Response.Redirect("CIP_Order_List.aspx");
            }
        }

        protected void ChangeButton_Click(object sender, EventArgs e)
        {
            GridView ReceiptGV = MemberFormView.FindControl("ReceiptGridView") as GridView;
            double PrevPrice = Convert.ToDouble(ReceiptGV.DataKeys[0]["SellingUnitPrice"]);
            double PrevPoint = Convert.ToDouble(ReceiptGV.DataKeys[0]["SellingUnitPoint"]);

            double NewPrice = Convert.ToDouble(PriceHF.Value);
            double NewPoint = Convert.ToDouble(PointHF.Value);

            CIPProductSQL.InsertParameters["Additional_Amount"].DefaultValue = (NewPrice - PrevPrice).ToString();
            CIPProductSQL.InsertParameters["Additional_Point"].DefaultValue = (NewPoint - PrevPoint).ToString();
            CIPProductSQL.Insert();

            CIPProductSQL.Update();

            Response.Redirect("Change_Receipt.aspx?P=" + Request.QueryString["Pdid"]);
        }

        //Product
        [WebMethod]
        public static string GetProduct(string pid)
        {
            List<Product> User = new List<Product>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT Product_Name, Product_Point, Product_Price FROM Product_Point_Code WHERE (Product_PointID = @Product_PointID)";
                    cmd.Parameters.AddWithValue("Product_PointID", pid);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Product
                        {
                            Name = dr["Product_Name"].ToString(),
                            Price = dr["Product_Price"].ToString(),
                            Point = dr["Product_Point"].ToString(),
                        });
                    }
                    con.Close();

                    var json = new JavaScriptSerializer().Serialize(User);
                    return json;
                }
            }
        }
        class Product
        {
            public string Name { get; set; }
            public string Price { get; set; }
            public string Point { get; set; }
        }
    }
}