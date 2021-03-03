using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Member
{
    public partial class Auto_Board_Member_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Assign_Button_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in MemberListGridView.Rows)
            {
                CheckBox Add_CheckBox = row.FindControl("Add_CheckBox") as CheckBox;

                if (Add_CheckBox.Checked)
                {
                    MemberSQL.InsertParameters["MemberID"].DefaultValue = MemberListGridView.DataKeys[row.DataItemIndex]["MemberID"].ToString();
                    MemberSQL.Insert();
                }
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
        }
    }
}