using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Bonus_Com
{
    public partial class Executive_Bonus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void MegaButton_Click(object sender, EventArgs e)
        {
            //double Mega_Matching_Amount = Convert.ToDouble(MegaFormView.DataKey["Mega_Matching_Amount"]);

            //if (Mega_Matching_Amount != 0)
            //{
            //    //SP Add_Mega_Matching
            //    MegaPointSQL.Insert();

            //    Response.Redirect(Request.Url.AbsolutePath);
            //}
            //else
            //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Mega Amount: 0')", true);
        }

        protected void AmountLB_Command(object sender, CommandEventArgs e)
        {
            MonthLabel.Text = e.CommandArgument.ToString();
        }

        protected void DesignationLB_Command(object sender, CommandEventArgs e)
        {
            DesignationLabel.Text = e.CommandArgument.ToString();
        }
    }
}