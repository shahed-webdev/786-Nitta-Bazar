using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin.Accounts
{
    public partial class Others_Income : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SqlCommand AccountCmd = new SqlCommand("Select AccountID from Account where InstitutionID = @InstitutionID AND Default_Status = 'True'", con);
                AccountCmd.Parameters.AddWithValue("@InstitutionID", Session["InstitutionID"].ToString());
                con.Open();
                object AccountID = AccountCmd.ExecuteScalar();
                con.Close();

                if (AccountID != null)
                    AccountDropDownList.SelectedValue = AccountID.ToString();
            }

        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            NewCategorySQL.Insert();
            NewCategoryNameTextBox.Text = string.Empty;
            AllCategory.DataBind();
            CategoryDropDownList.DataBind();
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            ExtraIncomeSQL.Insert();
            ExtraIncomeGridView.DataBind();

            AmountTextBox.Text = string.Empty;
            IncomeForTextBox.Text = string.Empty;

            ScriptManager.RegisterStartupScript(this, GetType(), "Msg", "Success();", true);
        }


        protected void CategoryDropDownList_DataBound(object sender, EventArgs e)
        {
            CategoryDropDownList.Items.Insert(0, new ListItem("[ INCOME CATEGORY ]", "0"));
        }

        protected void AccountDropDownList_DataBound(object sender, EventArgs e)
        {
            AccountDropDownList.Items.Insert(0, new ListItem("Without Account", ""));
        }

    }
}