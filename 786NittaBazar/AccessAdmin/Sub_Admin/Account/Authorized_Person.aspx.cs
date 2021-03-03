using System;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Sub_Admin.Account
{
    public partial class Authorized_Person : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Authority_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            GridViewRow GV = (GridViewRow)(((CheckBox)sender).Parent).Parent;
            CheckBox Authority_CheckBox = (CheckBox)GV.FindControl("Authority_CheckBox");

            string RegistrationID = AccountGridView.DataKeys[GV.RowIndex]["RegistrationID"].ToString();

            if (Authority_CheckBox.Checked)
            {
                AccountSQL.InsertParameters["Authority_RegistrationID"].DefaultValue = RegistrationID;
                AccountSQL.Insert();
            }
            else
            {
                AccountSQL.DeleteParameters["Authority_RegistrationID"].DefaultValue = RegistrationID;
                AccountSQL.Delete();
            }

            AccountGridView.DataBind();
        }
    }
}