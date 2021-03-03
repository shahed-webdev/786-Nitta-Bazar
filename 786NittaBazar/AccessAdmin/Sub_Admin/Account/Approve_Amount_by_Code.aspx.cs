using System;
using System.Drawing;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Sub_Admin.Account
{
    public partial class Approve_Amount_by_Code : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Approve_Button_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in AccountGridView.Rows)
            {
                HiddenField Code_HF = row.FindControl("Code_HF") as HiddenField;
                TextBox Code_TextBox = row.FindControl("Code_TextBox") as TextBox;

                if (Code_HF.Value == Code_TextBox.Text.Trim())
                {
                    AccountSQL.UpdateParameters["Recharge_AuthorizationID"].DefaultValue = AccountGridView.DataKeys[row.DataItemIndex]["Recharge_AuthorizationID"].ToString();
                    AccountSQL.Update();
                }
                else
                {
                    row.BackColor = Color.Red;
                }
            }
        }
    }
}