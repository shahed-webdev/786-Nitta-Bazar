using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;

namespace NittaBazar.AccessMember
{
    public partial class Add_New_Member : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["PID"]) && !string.IsNullOrEmpty(Request.QueryString["PType"]))
            {
                PositionMemberUserNameTextBox.Text = Request.QueryString["PID"].ToString();
                PositionMemberUserNameTextBox.Enabled = false;

                PositionTypeDropDownList.SelectedValue = Request.QueryString["PType"].ToString();
                PositionTypeDropDownList.Enabled = false;
            }
        }

        protected void SignupButton_Click(object sender, EventArgs e)
        {

            //SqlCommand cmd = new SqlCommand("SELECT Count(Phone) FROM  Registration WHERE (Phone = @Phone)", con);
            //cmd.Parameters.AddWithValue("@Phone", PhoneTextBox.Text.Trim());

            //con.Open();
            //int dr = (int)cmd.ExecuteScalar();
            //con.Close();

            //if (dr >= 7)
            //{
            //    ErrorLabel.Text = "Mobile Number already exists 7 times";
            //}
            //else
            //{
            ErrorLabel.Text = "";

            bool ISLeftStatus = false;
            bool ISRightStatus = false;

            SqlCommand PositionUserName = new SqlCommand("SELECT Registration.UserName FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE ((Member.Left_Status = 0) OR (Member.Right_Status = 0)) AND (Registration.UserName= @UserName)", con);
            PositionUserName.Parameters.AddWithValue("@UserName", PositionMemberUserNameTextBox.Text.Trim());

            con.Open();
            object IsPositionUserValid = PositionUserName.ExecuteScalar();
            con.Close();

            if (IsPositionUserValid != null)
            {
                SqlCommand Referral_MemberID = new SqlCommand("SELECT Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                Referral_MemberID.Parameters.AddWithValue("@UserName", ReferralIDTextBox.Text);

                SqlCommand PositionMemberID = new SqlCommand("SELECT Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                PositionMemberID.Parameters.AddWithValue("@UserName", PositionMemberUserNameTextBox.Text.Trim());

                con.Open();
                string sReferral_MemberID = Referral_MemberID.ExecuteScalar().ToString();
                string sPositionMemberID = PositionMemberID.ExecuteScalar().ToString();
                con.Close();


                if (PositionTypeDropDownList.SelectedValue == "Left")
                {
                    SqlCommand LeftStatus = new SqlCommand("SELECT Left_Status FROM [Member] WHERE (MemberID = @MemberID)", con);
                    LeftStatus.Parameters.AddWithValue("@MemberID", sPositionMemberID);

                    con.Open();
                    ISLeftStatus = (bool)LeftStatus.ExecuteScalar();
                    con.Close();
                }

                if (PositionTypeDropDownList.SelectedValue == "Right")
                {
                    SqlCommand RightStatus = new SqlCommand("SELECT Right_Status FROM [Member] WHERE (MemberID = @MemberID)", con);
                    RightStatus.Parameters.AddWithValue("@MemberID", sPositionMemberID);

                    con.Open();
                    ISRightStatus = (bool)RightStatus.ExecuteScalar();
                    con.Close();
                }


                ////---------------------Check left and right-----------------
                if (!ISLeftStatus)
                {
                    if (!ISRightStatus)
                    {
                        try
                        {
                            SqlCommand Cmd_User_SN = new SqlCommand("SELECT Member_SN FROM Institution", con);
                            con.Open();
                            int User_SN = Convert.ToInt32(Cmd_User_SN.ExecuteScalar());
                            con.Close();

                            string Password = "12345678";
                            string UserName = DateTime.Now.ToString("yyMM") + User_SN.ToString().PadLeft(5, '0');

                            MembershipCreateStatus createStatus;
                            MembershipUser newUser = Membership.CreateUser(UserName, Password, Email.Text, "When you signup?", DateTime.Now.ToString(), true, out createStatus);

                            if (MembershipCreateStatus.Success == createStatus)
                            {
                                Roles.AddUserToRole(UserName, "Member");

                                RegistrationSQL.InsertParameters["UserName"].DefaultValue = UserName;
                                RegistrationSQL.Insert();

                                MemberSQL.InsertParameters["Referral_MemberID"].DefaultValue = sReferral_MemberID;
                                MemberSQL.InsertParameters["PositionMemberID"].DefaultValue = sPositionMemberID;
                                MemberSQL.Insert();

                                UserLoginSQL.InsertParameters["Password"].DefaultValue = Password;
                                UserLoginSQL.InsertParameters["UserName"].DefaultValue = UserName;
                                UserLoginSQL.Insert();

                                //--------User_SN Update-----------------------------------------------------
                                RegistrationSQL.Update();
                                if (PositionTypeDropDownList.SelectedValue == "Left")
                                {
                                    SqlCommand UpdateMember = new SqlCommand("UPDATE Member SET Left_Status = 1 Where (MemberID = @MemberID)", con);
                                    UpdateMember.Parameters.AddWithValue("@MemberID", sPositionMemberID);

                                    con.Open();
                                    UpdateMember.ExecuteNonQuery();
                                    con.Close();
                                }

                                if (PositionTypeDropDownList.SelectedValue == "Right")
                                {
                                    SqlCommand UpdateMember = new SqlCommand("UPDATE Member SET Right_Status = 1 Where (MemberID = @MemberID)", con);
                                    UpdateMember.Parameters.AddWithValue("@MemberID", sPositionMemberID);

                                    con.Open();
                                    UpdateMember.ExecuteNonQuery();
                                    con.Close();
                                }


                                // MemberSQL.Update Total Carry Member Update by SP Add_Update_CarryMember

                                SqlCommand Cmd_User_MemberID = new SqlCommand("SELECT  Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                                Cmd_User_MemberID.Parameters.AddWithValue("@UserName", UserName);
                                con.Open();
                                string User_MemberID = Cmd_User_MemberID.ExecuteScalar().ToString();
                                con.Close();

                                //S.P Add_Update_CarryMember
                                MemberSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                                MemberSQL.Update();
                                FeeJoinUpdateSQL.Update();

                                // Send SMS
                                #region Send SMS                                 
                                SMS_Class SMS = new SMS_Class();

                                int TotalSMS = 0;
                                int SMSBalance = SMS.SMSBalance;
                                string PhoneNo = PhoneTextBox.Text.Trim();
                                string Msg = "Welcome to Nitta Bazar Marketing Ltd. Your Information has been Inserted Successfully. Your id: " + UserName + " and Password: " + Password;

                                TotalSMS = SMS.SMS_Conut(Msg);

                                if (SMSBalance >= TotalSMS)
                                {

                                    Get_Validation IsValid = SMS.SMS_Validation(PhoneNo, Msg);
                                    if (IsValid.Validation)
                                    {
                                        Guid? SMS_Send_ID = SMS.SMS_Send(PhoneNo, Msg, "Add Customers");
                                        if (SMS_Send_ID != null)
                                        {
                                            SMS_OtherInfoSQL.InsertParameters["SMS_Send_ID"].DefaultValue = SMS_Send_ID.ToString();
                                            SMS_OtherInfoSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                                            SMS_OtherInfoSQL.Insert();
                                        }
                                    }
                                }

                                #endregion SMS


                                Response.Redirect("Added_Customer_Info.aspx?Member=" + User_MemberID);
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
                    else
                    {
                        PositionTypeLabel.Text = "Team B Member Full";
                    }
                }
                else
                {
                    PositionTypeLabel.Text = "Team A Member Full";
                }
            }
            else
            {
                PositionLabel.Text = "Invalid Spot Member User Id";
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

        public string CreatePassword(int length)
        {
            const string valid = "1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        //Check status
        //[WebMethod]
        //public static bool Check_Mobile(string Mobile)
        //{
        //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

        //    SqlCommand cmd = new SqlCommand("SELECT Count(Phone) FROM Registration WHERE (Phone = @Phone)", con);
        //    cmd.Parameters.AddWithValue("@Phone", Mobile.Trim());

        //    con.Open();
        //    int dr = (int)cmd.ExecuteScalar();
        //    con.Close();

        //    return (dr >= 7);
        //}

        [WebMethod]
        public static string Check_Left_Right(string Position_MemberID, string PositionType)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
            string R = "";

            if (PositionType == "Team A")
            {
                SqlCommand LeftStatus = new SqlCommand("SELECT Left_Status FROM [Member] WHERE (MemberID = @MemberID)", con);
                LeftStatus.Parameters.AddWithValue("@MemberID", Position_MemberID);

                con.Open();
                bool IsLeftStatusValid = (bool)LeftStatus.ExecuteScalar();
                con.Close();

                if (IsLeftStatusValid)
                {
                    R = "Team A Member Full";
                }
                else
                {
                    R = "";
                }
            }

            if (PositionType == "Team B")
            {
                SqlCommand RightStatus = new SqlCommand("SELECT Right_Status FROM [Member] WHERE (MemberID = @MemberID)", con);
                RightStatus.Parameters.AddWithValue("@MemberID", Position_MemberID);

                con.Open();
                bool IsRightStatusValid = (bool)RightStatus.ExecuteScalar();
                con.Close();

                if (IsRightStatusValid)
                {
                    R = "Team B Member Full";
                }
                else
                {
                    R = "";
                }
            }

            return R;
        }

        //Get Userid Values autocomplete
        [WebMethod]
        public static string Get_UserInfo_ID(string prefix)
        {
            List<Member> User = new List<Member>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT top(3) Registration.UserName,Registration.Name,Registration.Phone,Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE Registration.UserName like @UserName + '%'";
                    cmd.Parameters.AddWithValue("@UserName", prefix);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Member
                        {
                            Username = dr["UserName"].ToString(),
                            Name = dr["Name"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            MemberID = dr["MemberID"].ToString()
                        });
                    }
                    con.Close();

                    var json = new JavaScriptSerializer().Serialize(User);
                    return json;
                }
            }
        }
        class Member
        {
            public string Username { get; set; }
            public string Name { get; set; }
            public string Phone { get; set; }
            public string MemberID { get; set; }
        }

        //Refarel user
        [WebMethod]
        public static string Get_Refarel_ID(string prefix)
        {
            List<Member> User = new List<Member>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT top(3) Registration.UserName,Registration.Name,Registration.Phone,Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Member.Tatal_Income < 9000) AND Registration.UserName like @UserName + '%'";
                    cmd.Parameters.AddWithValue("@UserName", prefix);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Member
                        {
                            Username = dr["UserName"].ToString(),
                            Name = dr["Name"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            MemberID = dr["MemberID"].ToString()
                        });
                    }
                    con.Close();

                    var json = new JavaScriptSerializer().Serialize(User);
                    return json;
                }
            }
        }
    }
}