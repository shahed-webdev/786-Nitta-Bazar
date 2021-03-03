using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessMember
{
    public partial class Added_Customer_Info : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["member"]))
            {
                Response.Redirect("Add_New_Member.aspx");
            }
        }
    }
}