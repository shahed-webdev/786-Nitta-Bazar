using System.Configuration;
using System.Data.SqlClient;

namespace NittaBazar
{
    public class SMS_Option
    {
        public bool Is_Withdraw { get; set; }
        public bool Is_Send { get; set; }
        public bool Is_load { get; set; }

        public SMS_Option()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
            SqlCommand cmd = new SqlCommand("SELECT Is_Withdraw_SMS, Is_BalanceTransffer_SMS, Is_LoadBalance_SMS FROM  Institution", con);


            con.Open();
            SqlDataReader DR;
            DR = cmd.ExecuteReader();

            while (DR.Read())
            {
                Is_Withdraw = (bool)DR["Is_Withdraw_SMS"];
                Is_Send = (bool)DR["Is_BalanceTransffer_SMS"];
                Is_load = (bool)DR["Is_LoadBalance_SMS"];
            }
            con.Close();
        }
    }
}