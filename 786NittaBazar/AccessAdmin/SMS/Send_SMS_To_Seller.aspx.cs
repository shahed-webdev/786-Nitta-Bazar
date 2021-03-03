using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.SMS
{
    public partial class Send_SMS_To_Seller : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SendButton_Click(object sender, EventArgs e)
        {
            SMS_Class SMS = new SMS_Class();

            int TotalSMS = 0;
            int Total_Person = 0;
            int SMSBalance = SMS.SMSBalance;
            string Msg = Text_TextBox.Text.Trim();

            string PhoneNo = "";
            string All_PhoneNo = "";

            List<string> NumberList = new List<string>();

            TotalSMS = SMS.SMS_Conut(Msg);


            foreach (GridViewRow row in SellerGridView.Rows)
            {
                CheckBox ConfirmCheckBox = row.FindControl("ConfirmCheckBox") as CheckBox;
                Label MobileLabel = row.FindControl("MobileLabel") as Label;

                if (ConfirmCheckBox.Checked)
                {
                    PhoneNo = MobileLabel.Text;
                    Get_Validation IsValid = SMS.SMS_Validation(PhoneNo, Msg);

                    if (IsValid.Validation)
                    {
                        NumberList.Add(PhoneNo);

                        Total_Person++;
                    }

                }
            }


            if (SMSBalance >= TotalSMS * Total_Person)
            {
                All_PhoneNo = String.Join(",", NumberList.ToArray());
                bool isResponse = SMS.Multiple_SMS_Send(All_PhoneNo, Msg, "Seller");

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
