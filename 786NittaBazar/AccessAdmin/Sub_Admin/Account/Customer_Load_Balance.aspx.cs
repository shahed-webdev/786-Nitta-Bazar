using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace NittaBazar.AccessAdmin.Sub_Admin.Account
{
    public partial class Customer_Load_Balance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SMS_Option IsSMS = new SMS_Option();
            MemberTextBox.Visible = IsSMS.Is_load;
            LoadButton.Visible = IsSMS.Is_load;
        }
        protected void ABFormView_DataBound(object sender, EventArgs e)
        {
            double Available_Balance = Convert.ToDouble(ABFormView.DataKey["Sub_Balance"]);

            if (Available_Balance <= 0)
            {
                MemberTextBox.Enabled = false;
                BalanceTextBox.Enabled = false;
                LoadButton.Enabled = false;
                ErrorLabel.Text = "You don't have enough balance";
            }
            else
            {
                MemberTextBox.Enabled = true;
                BalanceTextBox.Enabled = true;
                LoadButton.Enabled = true;
            }
        }

        [WebMethod]
        public static string Get_Member(string prefix)
        {
            List<Member> User = new List<Member>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT top(2) Registration.UserName, Registration.Name, Registration.Phone, Member.MemberID,Member.Load_Balance FROM Registration INNER JOIN Member ON Registration.RegistrationID = Member.MemberRegistrationID WHERE Registration.UserName LIKE @UserName + '%'";
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
                            MemberID = dr["MemberID"].ToString(),
                            Balance = dr["Load_Balance"].ToString()
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
            public string MemberID { get; set; }
            public string Balance { get; set; }
        }
        protected void LoadButton_Click(object sender, EventArgs e)
        {
            if (MemberID_HF.Value != "")
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
                SqlCommand Balance_cmd = new SqlCommand("SELECT isnull(Sub_Balance,0) as Sub_Balance FROM Sub_Admin_Account WHERE (SubAdmin_RegistrationID = @RegistrationID)", con);
                Balance_cmd.Parameters.AddWithValue("@RegistrationID", Session["RegistrationID"].ToString());

                con.Open();
                double Available_Balance = Convert.ToDouble(Balance_cmd.ExecuteScalar());
                con.Close();

                double Send_Balance = Convert.ToDouble(BalanceTextBox.Text.Trim());

                if (Send_Balance <= Available_Balance && Send_Balance != 0)
                {
                    LoadBalanceSQL.Insert();
                    LoadBalanceSQL.Update();

                    #region Send SMS
                    SMS_Class SMS = new SMS_Class();
                    int TotalSMS = 0;
                    int SMSBalance = SMS.SMSBalance;

                    DateTime time = DateTime.Now;
                    string SentTime = time.ToString("dd MMM yy (hh:mm tt)");

                    string Msg = "Your account balance refilled from: " + User.Identity.Name + " by tk: " + BalanceTextBox.Text + ". Date: " + SentTime + " nittabazar.xyz";
                    string Phone = Phone_HF.Value;

                    TotalSMS = SMS.SMS_Conut(Msg);

                    if (SMSBalance >= TotalSMS)
                    {
                        Get_Validation IsValid = SMS.SMS_Validation(Phone, Msg);
                        if (IsValid.Validation)
                        {
                            Guid? SMS_Send_ID = SMS.SMS_Send(Phone, Msg, "Customer Load Balance");
                            if (SMS_Send_ID != null)
                            {
                                SMS_OtherInfoSQL.InsertParameters["SMS_Send_ID"].DefaultValue = SMS_Send_ID.ToString();
                                SMS_OtherInfoSQL.Insert();
                            }
                        }
                    }
                    #endregion sms

                    MemberTextBox.Text = "";
                    BalanceTextBox.Text = "";
                    MemberID_HF.Value = "";
                    ABFormView.DataBind();

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Balance loaded Successfully')", true);
                }
                else
                {
                    ErrorLabel.Text = "Send Amount greater than available balance";
                }
            }
        }
    }
}