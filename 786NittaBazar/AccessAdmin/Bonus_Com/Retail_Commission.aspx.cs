using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Bonus_Com
{
    public partial class Retail_Commission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in Retail_BonusGridView.Rows)
            {
                TextBox Uni_IncomeTextBox = row.FindControl("Retail_Income_TextBox") as TextBox;

                Retail_IncomeSQL.UpdateParameters["Retail_Income"].DefaultValue = Uni_IncomeTextBox.Text;
                Retail_IncomeSQL.UpdateParameters["Generation_Retail_ID"].DefaultValue = Retail_BonusGridView.DataKeys[row.DataItemIndex]["Generation_Retail_ID"].ToString();
                Retail_IncomeSQL.Update();
            }
            Retail_BonusGridView.DataBind();
        }
    }
}