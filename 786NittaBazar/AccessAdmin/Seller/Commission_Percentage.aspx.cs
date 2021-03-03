using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Seller
{
    public partial class Commission_Percentage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            bool isUpdate = false;
            foreach (GridViewRow row in SellerGridView.Rows)
            {
                TextBox Commission_TextBox = row.FindControl("Commission_TextBox") as TextBox;
                if (Commission_TextBox.Text != "")
                {
                    SellerSQL.UpdateParameters["CommissionPercentage"].DefaultValue = Commission_TextBox.Text;
                    SellerSQL.UpdateParameters["SellerID"].DefaultValue = SellerGridView.DataKeys[row.RowIndex]["SellerID"].ToString();
                    SellerSQL.Update();
                    isUpdate = true;
                }
            }

            if (isUpdate)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Update Successfully')", true);
        }
    }
}