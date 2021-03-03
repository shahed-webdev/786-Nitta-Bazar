using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace NittaBazar.AccessAdmin.SMS
{
    public partial class Send_SMS_To_Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SendButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            SqlCommand UserPhoneCmd = new SqlCommand("SELECT DISTINCT Registration.Phone FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Member.Member_Package_Serial = @Member_Package_Serial)", con);
            UserPhoneCmd.Parameters.AddWithValue("@Member_Package_Serial", Member_DropDownList.SelectedValue);

            SMS_Class SMS = new SMS_Class();

            int TotalSMS = 0;
            int Total_Person = 0;
            int SMSBalance = SMS.SMSBalance;
            string Msg = Text_TextBox.Text.Trim();

            string PhoneNo = "";
            string All_PhoneNo = "";

            List<string> NumberList = new List<string>();

            TotalSMS = SMS.SMS_Conut(Msg);


            con.Open();
            SqlDataReader Member_Phone;
            Member_Phone = UserPhoneCmd.ExecuteReader();

            while (Member_Phone.Read())
            {
                PhoneNo = Member_Phone["Phone"].ToString();
                Get_Validation IsValid = SMS.SMS_Validation(PhoneNo, Msg);

                if (IsValid.Validation)
                {
                    NumberList.Add(PhoneNo);

                    Total_Person++;
                }

            }
            con.Close();


            if (SMSBalance >= TotalSMS * Total_Person)
            {
                All_PhoneNo = String.Join(",", NumberList.ToArray());
                bool isResponse = SMS.Multiple_SMS_Send(All_PhoneNo, Msg, Member_DropDownList.SelectedItem.Text);

                if (isResponse)
                {
                    foreach (var Number in NumberList)
                    {
                        Guid SMS_Send_ID = Guid.NewGuid();

                        SMS_OtherInfoSQL.InsertParameters["PhoneNumber"].DefaultValue = Number;
                        SMS_OtherInfoSQL.InsertParameters["TextSMS"].DefaultValue = Msg;
                        SMS_OtherInfoSQL.InsertParameters["TextCount"].DefaultValue = TotalSMS.ToString();
                        SMS_OtherInfoSQL.InsertParameters["SMSCount"].DefaultValue = SMS.SMS_Conut(Msg).ToString();
                        SMS_OtherInfoSQL.InsertParameters["SMS_Send_ID"].DefaultValue = SMS_Send_ID.ToString();
                        SMS_OtherInfoSQL.Insert();
                    }

                    SMSFormView.DataBind();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('SMS Successfully Sent')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('You have no enough SMS balance')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('SMS Server Not found!')", true);
            }
        }
    }
}