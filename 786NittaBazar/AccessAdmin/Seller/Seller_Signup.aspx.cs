using System;
using System.Web;
using System.Web.Security;

namespace NittaBazar.AccessAdmin.Seller
{
    public partial class Seller_Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignupButton_Click(object sender, EventArgs e)
        {
            var _user = Membership.GetUserNameByEmail(Email.Text);

            if (_user != null)
            {
                ErrorLabel.Text = "Email id already exists.";
            }
            else
            {
                try
                {
                    MembershipCreateStatus createStatus;
                    MembershipUser newUser = Membership.CreateUser(UserName.Text, Password.Text, Email.Text, Question.Text, Answer.Text, true, out createStatus);

                    if (MembershipCreateStatus.Success == createStatus)
                    {
                        Roles.AddUserToRole(UserName.Text.Trim(), "Seller");

                        RegistrationSQL.Insert();
                        SellerSQL.Insert();
                        UserLoginSQL.Insert();

                        Response.Redirect("Seller_List.aspx");
                    }

                    else
                    {
                        ErrorLabel.Text = GetErrorMessage(createStatus) + "<br />";
                    }
                }
                catch (MembershipCreateUserException ex)
                {
                    ErrorLabel.Text = GetErrorMessage(ex.StatusCode) + "<br />";
                }
                catch (HttpException ex)
                {
                    ErrorLabel.Text = ex.Message + "<br />";
                }
            }
        }

        public string GetErrorMessage(MembershipCreateStatus status)
        {
            switch (status)
            {
                case MembershipCreateStatus.Success:
                    return "The user account was successfully created!";

                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
    }
}