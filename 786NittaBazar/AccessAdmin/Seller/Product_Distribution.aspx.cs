using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Seller
{
    public partial class Product_Distribution : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Rl", "RemoveCart();", true);
            }
        }

        //Get Seller
        [WebMethod]
        public static string GetCustomers(string prefix)
        {
            List<Member> User = new List<Member>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT top(3) Registration.UserName, Registration.Name, Registration.Phone,Seller.IsCIP, Seller.SellerID FROM Registration INNER JOIN Seller ON Registration.RegistrationID = Seller.SellerRegistrationID WHERE Registration.UserName LIKE @UserName + '%'";
                    cmd.Parameters.AddWithValue("@UserName", prefix);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Member
                        {
                            Username = dr["UserName"].ToString(),
                            Name = dr["Name"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            SellerID = dr["SellerID"].ToString(),
                            IsCIP = dr["IsCIP"].ToString()
                        });
                    }
                    con.Close();

                    var json = new JavaScriptSerializer().Serialize(User);
                    return json;
                }
            }
        }
        class Member
        {
            public string Username { get; set; }
            public string Name { get; set; }
            public string Phone { get; set; }
            public string SellerID { get; set; }
            public string IsCIP { get; set; }
        }

        //Get product
        [WebMethod]
        public static string GetProduct(string prefix, string SellerID)
        {
            List<Product> User = new List<Product>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT TOP (2) Product_Point_Code.Product_Code, Product_Point_Code.Product_Name, Product_Point_Code.Product_Price, Product_Point_Code.Product_Point, Product_Point_Code.Product_PointID, Product_Point_Code.Net_Quantity, Product_Point_Code.Seller_Commission * Seller.CommissionPercentage / 100 AS Seller_Commission FROM Product_Point_Code CROSS JOIN Seller WHERE (Product_Point_Code.Stock_Quantity > 0) AND (Product_Point_Code.IsActive = 1) AND (Seller.SellerID = @SellerID) AND ((Seller.IsCIP = 0 AND Product_Point_Code.IsCIP = 0) OR (Seller.IsCIP = 1)) AND Product_Point_Code.Product_Code LIKE @Product_Code + '%'";
                    cmd.Parameters.AddWithValue("@Product_Code", prefix);
                    cmd.Parameters.AddWithValue("@SellerID", SellerID);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Product
                        {
                            Code = dr["Product_Code"].ToString(),
                            Name = dr["Product_Name"].ToString(),
                            Price = dr["Product_Price"].ToString(),
                            Point = dr["Product_Point"].ToString(),
                            Net_Quantity = dr["Net_Quantity"].ToString(),
                            Commission = dr["Seller_Commission"].ToString(),
                            ProductID = dr["Product_PointID"].ToString()
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
            public string Code { get; set; }
            public string Name { get; set; }
            public string Price { get; set; }
            public string Point { get; set; }
            public string Net_Quantity { get; set; }
            public string Commission { get; set; }
            public string ProductID { get; set; }
        }

        //shopping cart
        class Shopping
        {
            public string ProductID { get; set; }
            public int Quantity { get; set; }
            public string Unit_Price { get; set; }
            public string Unit_Point { get; set; }
            public string Commission { get; set; }
        }
        List<Shopping> ProductList()
        {
            string json = JsonData.Value;
            JavaScriptSerializer js = new JavaScriptSerializer();
            List<Shopping> data = js.Deserialize<List<Shopping>>(json);
            return data;
        }
        protected void SellButton_Click(object sender, EventArgs e)
        {
            if (JsonData.Value != "")
            {
                if (SellerID_HF.Value != "")
                {
                    Product_DistributionSQL.Insert();

                    List<Shopping> P_List = new List<Shopping>(ProductList());

                    foreach (Shopping item in P_List)
                    {
                        Product_Distribution_RecordsSQL.InsertParameters["ProductID"].DefaultValue = item.ProductID;
                        Product_Distribution_RecordsSQL.InsertParameters["Product_DistributionID"].DefaultValue = ViewState["Product_DistributionID"].ToString();
                        Product_Distribution_RecordsSQL.InsertParameters["SellingQuantity"].DefaultValue = item.Quantity.ToString();
                        Product_Distribution_RecordsSQL.InsertParameters["SellingUnitPrice"].DefaultValue = item.Unit_Price;
                        Product_Distribution_RecordsSQL.InsertParameters["SellingUnitPoint"].DefaultValue = item.Unit_Point;
                        Product_Distribution_RecordsSQL.InsertParameters["SellingUnit_Commission"].DefaultValue = item.Commission;
                        Product_Distribution_RecordsSQL.Insert();

                        Seller_Product_insert_UpdateSQL.InsertParameters["Product_PointID"].DefaultValue = item.ProductID;
                        Seller_Product_insert_UpdateSQL.InsertParameters["SellerProduct_Stock"].DefaultValue = item.Quantity.ToString();
                        Seller_Product_insert_UpdateSQL.Insert();

                        Stock_UpdateSQL.UpdateParameters["Product_PointID"].DefaultValue = item.ProductID;
                        Stock_UpdateSQL.UpdateParameters["Stock_Quantity"].DefaultValue = item.Quantity.ToString();
                        Stock_UpdateSQL.Update();
                    }

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Rl", "RemoveCart();", true);
                    Response.Redirect("Distribution_Receipt.aspx?Distribution=" + ViewState["Product_DistributionID"].ToString());
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Invalid Seller')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No Product added in cart')", true);
            }
        }

        protected void Product_DistributionSQL_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            ViewState["Product_DistributionID"] = e.Command.Parameters["@Product_DistributionID"].Value.ToString();
        }
    }
}