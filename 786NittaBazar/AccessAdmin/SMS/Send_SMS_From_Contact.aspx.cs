using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.SMS
{
    public partial class Send_SMS_From_Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void GroupNameDropDownList_DataBound(object sender, EventArgs e)
        {
            GroupNameDropDownList.Items.Insert(0, new ListItem("[ SELECT ]", "0"));
        }
        protected void SelectGroupDropDownList_DataBound(object sender, EventArgs e)
        {
            SelectGroupDropDownList.Items.Insert(0, new ListItem("[ SELECT GROUP ]", "0"));
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            AddGroupSQL.Insert();
            GroupGridView.DataBind();
            GroupName.Text = string.Empty;
        }
        protected void AddButton_Click(object sender, EventArgs e)
        {
            Group_Phone_NumberSQL.Insert();
            PersonNameTextBox.Text = string.Empty;
            MobileNumberTextBox.Text = string.Empty;
            AddressTextBox.Text = string.Empty;
            MsgLabel.Text = "Contact Successfully Added";
            SelectGroupDropDownList.SelectedIndex = 0;
        }


        protected void SendSMSButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            SqlCommand UserPhoneCmd = new SqlCommand("SELECT MobileNo FROM SMS_Group_Phone_Number WHERE (SMS_GroupID = @SMS_GroupID)", con);
            UserPhoneCmd.Parameters.AddWithValue("@SMS_GroupID", SelectGroupDropDownList.SelectedValue);

            SMS_Class SMS = new SMS_Class();

            int TotalSMS = 0;
            int Total_Person = 0;
            int SMSBalance = SMS.SMSBalance;
            string Msg = SMSTextBox.Text.Trim();

            string PhoneNo = "";
            string All_PhoneNo = "";

            List<string> NumberList = new List<string>();

            TotalSMS = SMS.SMS_Conut(Msg);


            con.Open();
            SqlDataReader Member_Phone;
            Member_Phone = UserPhoneCmd.ExecuteReader();

            while (Member_Phone.Read())
            {
                PhoneNo = Member_Phone["MobileNo"].ToString();
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
                bool isResponse = SMS.Multiple_SMS_Send(All_PhoneNo, Msg, "Contact List");

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

        protected void Group_Phone_NumberSQL_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            IteamCountLabel.Text = "Total: " + e.AffectedRows.ToString() + " Contact.";
        }
    }
}