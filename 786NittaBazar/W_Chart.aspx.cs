using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;

namespace NittaBazar
{
    public partial class W_Chart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        //public static void Insert(string Id, string name, string price, string quntity)
        //{
        //    string constr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(constr))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("INSERT INTO Z_Shopping_cart (id, name, price, quntity) VALUES (@id, @name, @price, @quntity)"))
        //        {
        //            cmd.Parameters.AddWithValue("@id", Id);
        //            cmd.Parameters.AddWithValue("@name", name);
        //            cmd.Parameters.AddWithValue("@price", price);
        //            cmd.Parameters.AddWithValue("@quntity", quntity);
        //            cmd.Connection = con;
        //            con.Open();
        //            cmd.ExecuteScalar();
        //            con.Close();
        //        }
        //    }

        //}



        [WebMethod]
        public static void Set_Product(List<Product> List_Product)
        {
            for (int i = 0; i < List_Product.Count; i++)
            {
                Product P_Detail = List_Product[i];

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Z_Shopping_cart (id, name, price, quntity) VALUES (@id, @name, @price, @quntity)"))
                    {
                        cmd.Parameters.AddWithValue("@id", P_Detail.id);
                        cmd.Parameters.AddWithValue("@name", P_Detail.name);
                        cmd.Parameters.AddWithValue("@price", P_Detail.price);
                        cmd.Parameters.AddWithValue("@quntity", P_Detail.quantity);
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteScalar();
                        con.Close();
                    }
                }

            }
        }
        public class Product
        {
            public string id { get; set; }
            public string name { get; set; }
            public string summary { get; set; }
            public string price { get; set; }
            public string quantity { get; set; }
            public string image { get; set; }
        }
    }
}
