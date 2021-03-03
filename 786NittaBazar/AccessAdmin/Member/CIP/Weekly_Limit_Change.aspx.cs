using System;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Member.CIP
{
    public partial class Weekly_Limit_Change : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Update_Button_Click(object sender, EventArgs e)
        {
            var Prevlabel = UserDetails_FormView.FindControl("PrevLabel") as Label;
            var UpdateAmount = UserDetails_FormView.FindControl("ChangeAmount_TextBox") as TextBox;
            var MemberID = UserDetails_FormView.DataKey["MemberID"].ToString();

            UserSQL.InsertParameters["MemberID"].DefaultValue = MemberID;
            UserSQL.InsertParameters["Prev_Limit"].DefaultValue = Prevlabel.Text;
            UserSQL.InsertParameters["Updated_Limit"].DefaultValue = UpdateAmount.Text;
            UserSQL.Insert();

            UserSQL.UpdateParameters["MemberID"].DefaultValue = MemberID;
            UserSQL.UpdateParameters["CIP_IncomeLimit"].DefaultValue = UpdateAmount.Text;
            UserSQL.Update();

            RecordGridView.DataBind();
        }
    }
}