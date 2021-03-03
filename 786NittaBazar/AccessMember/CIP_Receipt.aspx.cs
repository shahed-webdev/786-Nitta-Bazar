using System;

namespace NittaBazar.AccessMember
{
    public partial class CIP_Receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["P"]))
            {
                Response.Redirect("Add_cip_Customer.aspx");
            }
        }
    }
}