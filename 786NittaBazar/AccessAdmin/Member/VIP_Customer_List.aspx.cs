using System;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Member
{
    public partial class VIP_Customer_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateCIPButton_Click(object sender, EventArgs e)
        {
            if (IncomeLimit_TextBox.Text != "")
            {
                foreach (GridViewRow row in MemberListGridView.Rows)
                {
                    CheckBox ConfirmCheckBox = row.FindControl("ConfirmCheckBox") as CheckBox;
                    if (ConfirmCheckBox.Checked)
                    {
                        MemberSQL.UpdateParameters["MemberID"].DefaultValue = MemberListGridView.DataKeys[row.DataItemIndex % MemberListGridView.PageSize]["MemberID"].ToString();
                        MemberSQL.Update();
                    }
                }

                MemberListGridView.DataBind();
            }
        }
    }
}