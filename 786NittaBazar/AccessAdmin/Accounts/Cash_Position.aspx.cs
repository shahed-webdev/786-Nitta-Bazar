using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Accounts
{
    public partial class Cash_Position : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                Find_Date_TextBox.Text = DateTime.Now.ToString("d MMM yyyy");
        }

        protected void Add_CashButton_Click(object sender, EventArgs e)
        {
            CashPositionSQL.Insert();
            CashUnit_TextBox.Text = "";
            Quantity_TextBox.Text = "";
            Cash_Date_TextBox.Text = "";
            CashGridView.DataBind();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Successfully Inserted')", true);
        }
    }
}