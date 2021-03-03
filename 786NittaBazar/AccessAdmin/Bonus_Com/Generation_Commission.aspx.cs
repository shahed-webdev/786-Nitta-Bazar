using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Bonus_Com
{
    public partial class Generation_Commission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in Generation_BonusGridView.Rows)
            {
                TextBox Uni_IncomeTextBox = row.FindControl("Uni_IncomeTextBox") as TextBox;

                Generation_BonusSQL.UpdateParameters["Uni_Income"].DefaultValue = Uni_IncomeTextBox.Text;
                Generation_BonusSQL.UpdateParameters["Generation_UniLevel_ID"].DefaultValue = Generation_BonusGridView.DataKeys[row.DataItemIndex]["Generation_UniLevel_ID"].ToString();
                Generation_BonusSQL.Update();
            }
            Generation_BonusGridView.DataBind();
        }
    }
}