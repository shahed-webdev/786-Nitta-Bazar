using System;

namespace NittaBazar.AccessAdmin.Member.CIP
{
    public partial class Receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["P"]))
                Response.Redirect("CIP_Order_List.aspx");
        }
    }
}