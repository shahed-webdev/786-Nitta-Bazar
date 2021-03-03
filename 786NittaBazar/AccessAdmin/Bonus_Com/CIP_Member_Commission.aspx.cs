using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Bonus_Com
{
    public partial class CIP_Member_Commission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddButton_Click(object sender, EventArgs e)
        {
            AreaSQL.Insert();
            AreaGridView.DataBind();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
        }

        protected void Update_Button_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in AreaGridView.Rows)
            {
                var AreaName = row.FindControl("Up_AreaName_TextBox") as TextBox;
                var Commission = row.FindControl("Up_Commission_TextBox") as TextBox;

                AreaSQL.UpdateParameters["OfficeAreaName"].DefaultValue = AreaName.Text;
                AreaSQL.UpdateParameters["WeeklyCommissionPercetage"].DefaultValue = Commission.Text;
                AreaSQL.UpdateParameters["MemberOfficeAreaID"].DefaultValue = AreaGridView.DataKeys[row.DataItemIndex]["MemberOfficeAreaID"].ToString();
                AreaSQL.Update();

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Updated Successfully')", true);
            }
        }

        protected void AssignButton_Click(object sender, EventArgs e)
        {
            UserSQL.Update();
            CountAreaRepeater.DataBind();
        }
    }
}