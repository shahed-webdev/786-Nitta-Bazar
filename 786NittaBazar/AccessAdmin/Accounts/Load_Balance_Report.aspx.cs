using System;

namespace NittaBazar.AccessAdmin.Accounts
{
    public partial class Load_Balance_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                FromDateTextBox.Text = DateTime.Now.ToString("d MMM yyyy");
                ToDateTextBox.Text = DateTime.Now.ToString("d MMM yyyy");
            }
        }
    }
}