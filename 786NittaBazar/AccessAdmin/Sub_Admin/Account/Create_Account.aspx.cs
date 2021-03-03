using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Sub_Admin.Account
{
    public partial class Create_Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Create_Button_Click(object sender, EventArgs e)
        {
            UserListSQL.Insert();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Account Created Successfully')", true);
            AccountGridView.DataBind();
        }

        protected void UserListDropDownList_DataBound(object sender, EventArgs e)
        {
            UserListDropDownList.Items.Insert(0, new ListItem("[ SELECT ]", "0"));
        }

        protected void Recharge_Button_Click(object sender, EventArgs e)
        {
            DataView dv = (DataView)RechargeRecordSQL.Select(DataSourceSelectArguments.Empty);

            if (dv.Count > 0)
            {
                RechargeRecordSQL.Insert();

                foreach (DataRowView rowView in dv)
                {
                    string A_Code = Code(6);

                    RechargeSQL.InsertParameters["Sub_Admin_RechargeRecordID"].DefaultValue = ViewState["Sub_Admin_RechargeRecordID"].ToString();
                    RechargeSQL.InsertParameters["Authority_RegistrationID"].DefaultValue = rowView.Row["RegistrationID"].ToString();
                    RechargeSQL.InsertParameters["Approved_Code"].DefaultValue = A_Code;
                    RechargeSQL.Insert();

                    // Send SMS
                    #region Send SMS                                 
                    SMS_Class SMS = new SMS_Class();

                    int TotalSMS = 0;
                    int SMSBalance = SMS.SMSBalance;
                    string PhoneNo = rowView.Row["Phone"].ToString();
                    string username = AccountGridView.DataKeys[AccountGridView.SelectedIndex]["UserName"].ToString();
                    string Msg = Amount_TextBox.Text.Trim() + " tk recharge for " + username + ". Recharge amount will be added after approved. Approve code is: " + A_Code + ". Nitta Bazar Marketing Ltd.";

                    TotalSMS = SMS.SMS_Conut(Msg);

                    if (SMSBalance >= TotalSMS)
                    {

                        Get_Validation IsValid = SMS.SMS_Validation(PhoneNo, Msg);
                        if (IsValid.Validation)
                        {
                            Guid? SMS_Send_ID = SMS.SMS_Send(PhoneNo, Msg, "Acc. Recharge Code");
                            if (SMS_Send_ID != null)
                            {
                                SMS_OtherInfoSQL.InsertParameters["SMS_Send_ID"].DefaultValue = SMS_Send_ID.ToString();
                                SMS_OtherInfoSQL.Insert();
                            }
                        }
                    }

                    #endregion SMS
                }

                Amount_TextBox.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Successfully Recharge')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Authorized person not found!')", true);
                Amount_TextBox.Text = "";
            }
        }

        public string Code(int length)
        {
            const string valid = "1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        protected void RechargeRecordSQL_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            ViewState["Sub_Admin_RechargeRecordID"] = e.Command.Parameters["@Sub_Admin_RechargeRecordID"].Value.ToString();
        }
    }
}