using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessMember
{
    public partial class Add_cip_Customer : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CIP"].ToString() != "True" || Session["CIP"] == null)
            {
                Response.Redirect("MemberProfile.aspx");
            }

        }
        protected void ABFormView_DataBound(object sender, EventArgs e)
        {
            double Available_Balance = Convert.ToDouble(ABFormView.DataKey["Load_Balance_Available"]);

            if (Available_Balance <= 0)
            {
                SignupButton.Enabled = false;
            }
            else
            {
                SignupButton.Enabled = true;
            }
        }

        List<string> Add_Mulitpale_Member(string sReferral_MemberID, string sPositionMemberID, string MemberOfficeAreaID, double T_Point, string Join_SN)
        {
            List<string> returnValues = new List<string>();

            SqlCommand Cmd_User_SN = new SqlCommand("SELECT Member_SN FROM Institution", con);

            con.Open();
            int User_SN = Convert.ToInt32(Cmd_User_SN.ExecuteScalar());
            con.Close();

            //For Left Member Add
            string Password = "12345678";
            string UserName = DateTime.Now.ToString("yyMM") + User_SN.ToString().PadLeft(5, '0');

            MembershipCreateStatus createStatus;

            Membership.CreateUser(UserName, Password, Email.Text, "When you signup?", DateTime.Now.ToString(), true, out createStatus);

            if (MembershipCreateStatus.Success == createStatus)
            {
                Roles.AddUserToRole(UserName, "Member");

                RegistrationSQL.InsertParameters["UserName"].DefaultValue = UserName;
                RegistrationSQL.Insert();

                var DecimalPoint_Carry = Math.Round(T_Point % 1, 2);

                MemberSQL.InsertParameters["MemberOfficeAreaID"].DefaultValue = MemberOfficeAreaID;
                MemberSQL.InsertParameters["Referral_MemberID"].DefaultValue = sReferral_MemberID;
                MemberSQL.InsertParameters["PositionMemberID"].DefaultValue = sPositionMemberID;
                MemberSQL.InsertParameters["DecimalPoint_Carry"].DefaultValue = DecimalPoint_Carry.ToString();
                MemberSQL.InsertParameters["PositionType"].DefaultValue = "Left"; //change here 16 may 2019 
                MemberSQL.Insert();

                UserLoginSQL.InsertParameters["Password"].DefaultValue = Password;
                UserLoginSQL.InsertParameters["UserName"].DefaultValue = UserName;
                UserLoginSQL.Insert();

                //--------User_SN Update-----------------------------------------------------
                RegistrationSQL.Update();

                //----------------------------Update Left_Status & Right_Status-------------
                SqlCommand UpdateMember = new SqlCommand("UPDATE Member SET Left_Status = 1, Right_Status = 1 Where (MemberID = @MemberID)", con);
                UpdateMember.Parameters.AddWithValue("@MemberID", sPositionMemberID);

                con.Open();
                UpdateMember.ExecuteNonQuery();
                con.Close();

                // MemberSQL.Update Total Carry Member Update by SP Add_Update_CarryMember

                SqlCommand Cmd_User_MemberID = new SqlCommand("SELECT  Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                Cmd_User_MemberID.Parameters.AddWithValue("@UserName", UserName);

                con.Open();
                string User_MemberID = Convert.ToString(Cmd_User_MemberID.ExecuteScalar());
                con.Close();

                //S.P Add_Update_CarryMember
                MemberSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                MemberSQL.Update();


                //CIP Product sell
                #region CIP Member 
                Product_DistributionSQL.InsertParameters["Buy_MemberID"].DefaultValue = User_MemberID;
                Product_DistributionSQL.InsertParameters["Join_SN"].DefaultValue = Join_SN;
                Product_DistributionSQL.Insert();



                //CIP Product sell record
                Product_Distribution_RecordsSQL.InsertParameters["Product_DistributionID"].DefaultValue = ViewState["Product_DistributionID"].ToString();
                Product_Distribution_RecordsSQL.Insert();

                //Weekly limit records
                WeeklyLimitSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                WeeklyLimitSQL.InsertParameters["Product_DistributionID"].DefaultValue = ViewState["Product_DistributionID"].ToString();
                WeeklyLimitSQL.Insert();
                #endregion CIP   

                if (T_Point >= 1)
                {
                    //DecimalPoint_Carry
                    int Point_countable = (int)T_Point;

                    // Update S.P Add_Point
                    A_PointSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                    A_PointSQL.InsertParameters["Point"].DefaultValue = Point_countable.ToString();
                    A_PointSQL.Insert();


                    // Update S.P Add_Referral_Bonus

                    A_PointSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                    A_PointSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                    A_PointSQL.Update();

                    // Update S.P Add_Generation_UniLevel
                    GenerationSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                    GenerationSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                    GenerationSQL.Update();

                    // Update S.P Add_Designation_Loop
                    Update_Designation_SQL.Update();

                    returnValues.Add(User_MemberID);
                }

            }

            //For Right Member Add
            Password = "12345678";
            UserName = DateTime.Now.ToString("yyMM") + (User_SN + 1).ToString().PadLeft(5, '0');

            Membership.CreateUser(UserName, Password, Email.Text, "When you signup?", DateTime.Now.ToString(), true, out createStatus);

            if (MembershipCreateStatus.Success == createStatus)
            {
                Roles.AddUserToRole(UserName, "Member");


                RegistrationSQL.InsertParameters["UserName"].DefaultValue = UserName;
                RegistrationSQL.Insert();

                var DecimalPoint_Carry = Math.Round(T_Point % 1, 2);

                MemberSQL.InsertParameters["MemberOfficeAreaID"].DefaultValue = MemberOfficeAreaID;
                MemberSQL.InsertParameters["Referral_MemberID"].DefaultValue = sReferral_MemberID;
                MemberSQL.InsertParameters["PositionMemberID"].DefaultValue = sPositionMemberID;
                MemberSQL.InsertParameters["DecimalPoint_Carry"].DefaultValue = DecimalPoint_Carry.ToString();
                MemberSQL.InsertParameters["PositionType"].DefaultValue = "Right"; //change here 16 may 2019 
                MemberSQL.Insert();

                UserLoginSQL.InsertParameters["Password"].DefaultValue = Password;
                UserLoginSQL.InsertParameters["UserName"].DefaultValue = UserName;
                UserLoginSQL.Insert();

                //--------User_SN Update-----------------------------------------------------
                RegistrationSQL.Update();


                // MemberSQL.Update Total Carry Member Update by SP Add_Update_CarryMember

                SqlCommand Cmd_User_MemberID = new SqlCommand("SELECT  Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                Cmd_User_MemberID.Parameters.AddWithValue("@UserName", UserName);

                con.Open();
                string User_MemberID = Convert.ToString(Cmd_User_MemberID.ExecuteScalar());
                con.Close();

                //S.P Add_Update_CarryMember
                MemberSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                MemberSQL.Update();


                //CIP Product sell
                #region CIP Member 
                Product_DistributionSQL.InsertParameters["Buy_MemberID"].DefaultValue = User_MemberID;
                Product_DistributionSQL.InsertParameters["Join_SN"].DefaultValue = Join_SN;
                Product_DistributionSQL.Insert();

                //CIP Product sell record
                Product_Distribution_RecordsSQL.InsertParameters["Product_DistributionID"].DefaultValue = ViewState["Product_DistributionID"].ToString();
                Product_Distribution_RecordsSQL.Insert();

                //Weekly limit records
                WeeklyLimitSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                WeeklyLimitSQL.InsertParameters["Product_DistributionID"].DefaultValue = ViewState["Product_DistributionID"].ToString();
                WeeklyLimitSQL.Insert();
                #endregion CIP   

                if (T_Point >= 1)
                {
                    //DecimalPoint_Carry
                    int Point_countable = (int)T_Point;

                    // Update S.P Add_Point
                    A_PointSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                    A_PointSQL.InsertParameters["Point"].DefaultValue = Point_countable.ToString();
                    A_PointSQL.Insert();


                    // Update S.P Add_Referral_Bonus

                    A_PointSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                    A_PointSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                    A_PointSQL.Update();

                    // Update S.P Add_Generation_UniLevel
                    GenerationSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                    GenerationSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                    GenerationSQL.Update();

                    // Update S.P Add_Designation_Loop
                    Update_Designation_SQL.Update();

                    returnValues.Add(User_MemberID);
                }
            }
            return returnValues;
        }

        protected void SignupButton_Click(object sender, EventArgs e)
        {
            SqlCommand Balance_cmd = new SqlCommand("SELECT Load_Balance_Available FROM Member WHERE (MemberID = @MemberID)", con);
            Balance_cmd.Parameters.AddWithValue("@MemberID", Session["MemberID"].ToString());

            var SignUpCount = Convert.ToInt32(SignupCount_DropDownList.SelectedValue);

            double Price = Convert.ToDouble(PriceHF.Value) * SignUpCount;
            con.Open();
            double Balance = (double)Balance_cmd.ExecuteScalar();
            con.Close();

            if (Balance >= Price)
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
                                Membership.CreateUser(UserName, Password, Email.Text, "When you signup?", DateTime.Now.ToString(), true, out createStatus);

                                if (MembershipCreateStatus.Success == createStatus)
                                {
                                    Roles.AddUserToRole(UserName, "Member");

                                    RegistrationSQL.InsertParameters["UserName"].DefaultValue = UserName;
                                    RegistrationSQL.Insert();

                                    SqlCommand Cmd_MemberOfficeArea = new SqlCommand("SELECT MemberOfficeAreaID FROM Member WHERE (MemberID = @MemberID)", con);
                                    Cmd_MemberOfficeArea.Parameters.AddWithValue("@MemberID", Session["MemberID"].ToString());

                                    con.Open();
                                    var MemberOfficeAreaID = Cmd_MemberOfficeArea.ExecuteScalar().ToString();
                                    con.Close();

                                    var T_Point = Convert.ToDouble(PointHF.Value);
                                    var DecimalPoint_Carry = Math.Round(T_Point % 1, 2);

                                    MemberSQL.InsertParameters["MemberOfficeAreaID"].DefaultValue = MemberOfficeAreaID;
                                    MemberSQL.InsertParameters["Referral_MemberID"].DefaultValue = sReferral_MemberID;
                                    MemberSQL.InsertParameters["PositionMemberID"].DefaultValue = sPositionMemberID;
                                    MemberSQL.InsertParameters["DecimalPoint_Carry"].DefaultValue = DecimalPoint_Carry.ToString();
                                    MemberSQL.InsertParameters["PositionType"].DefaultValue = PositionTypeDropDownList.SelectedValue; //change here 16 may 2019 
                                    MemberSQL.Insert();

                                    UserLoginSQL.InsertParameters["Password"].DefaultValue = Password;
                                    UserLoginSQL.InsertParameters["UserName"].DefaultValue = UserName;
                                    UserLoginSQL.Insert();

                                    //--------User_SN Update----------------------
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

                                    SqlCommand Cmd_User_MemberID = new SqlCommand("SELECT Member.MemberID FROM Member INNER JOIN Registration ON Member.MemberRegistrationID = Registration.RegistrationID WHERE (Registration.UserName = @UserName)", con);
                                    Cmd_User_MemberID.Parameters.AddWithValue("@UserName", UserName);
                                    con.Open();
                                    string User_MemberID = Cmd_User_MemberID.ExecuteScalar().ToString();
                                    con.Close();

                                    //S.P Add_Update_CarryMember
                                    MemberSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                                    MemberSQL.Update();

                                    //CIP Product sell
                                    #region CIP Member 
                                    Product_DistributionSQL.InsertParameters["Buy_MemberID"].DefaultValue = User_MemberID;
                                    Product_DistributionSQL.InsertParameters["Join_SN"].DefaultValue = "0";
                                    Product_DistributionSQL.Insert();

                                    string Product_DistributionID = ViewState["Product_DistributionID"].ToString();

                                    //CIP Product sell record
                                    Product_Distribution_RecordsSQL.InsertParameters["Product_DistributionID"].DefaultValue = Product_DistributionID;
                                    Product_Distribution_RecordsSQL.Insert();

                                    //Member Balance update
                                    Product_DistributionSQL.UpdateParameters["Joined_Member_Amount"].DefaultValue = Price.ToString();
                                    Product_DistributionSQL.Update();

                                    //Weekly limit records
                                    WeeklyLimitSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                                    WeeklyLimitSQL.InsertParameters["Product_DistributionID"].DefaultValue = Product_DistributionID;
                                    WeeklyLimitSQL.Insert();
                                    #endregion CIP   

                                    if (T_Point >= 1)
                                    {
                                        //DecimalPoint_Carry
                                        int Point_countable = (int)T_Point;
                                        // Update S.P Add_Point
                                        A_PointSQL.InsertParameters["MemberID"].DefaultValue = User_MemberID;
                                        A_PointSQL.InsertParameters["Point"].DefaultValue = Point_countable.ToString();
                                        A_PointSQL.Insert();

                                        // Update S.P Add_Referral_Bonus
                                        A_PointSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                                        A_PointSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                                        A_PointSQL.Update();

                                        // Update S.P Add_Generation_UniLevel
                                        GenerationSQL.UpdateParameters["MemberID"].DefaultValue = User_MemberID;
                                        GenerationSQL.UpdateParameters["Point"].DefaultValue = Point_countable.ToString();
                                        GenerationSQL.Update();

                                        // Update S.P Add_Designation_Loop
                                        Update_Designation_SQL.Update();
                                    }

                                    //Multiple Member Add
                                    #region Join Multiple IDs
                                    if (SignUpCount > 1)
                                    {
                                        if (SignUpCount == 3)
                                        {
                                            Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);
                                        }
                                        else if (SignUpCount == 7)
                                        {
                                            var MemberIDs = Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);

                                            foreach (var MemberID in MemberIDs)
                                            {
                                                Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);
                                            }
                                        }
                                        else if (SignUpCount == 15)
                                        {
                                            var MemberIDs = Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);

                                            foreach (var MemberID in MemberIDs)
                                            {
                                                var MIDs = Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);

                                                foreach (var MID in MIDs)
                                                {
                                                    Add_Mulitpale_Member(sReferral_MemberID, User_MemberID, MemberOfficeAreaID, T_Point, Product_DistributionID);
                                                }
                                            }
                                        }
                                    }
                                    #endregion Join Multiple IDs

                                    // Send SMS
                                    #region Send SMS                                 
                                    SMS_Class SMS = new SMS_Class();

                                    int TotalSMS = 0;
                                    int SMSBalance = SMS.SMSBalance;
                                    string PhoneNo = PhoneTextBox.Text.Trim();
                                    string Msg = $"Welcome to Nitta Bazar Marketing Ltd. You join {SignUpCount} id(s) successfully. You id started from: {UserName} and Password: {Password}";

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

                                    PriceHF.Value = "";
                                    PointHF.Value = "";

                                    Response.Redirect("CIP_Receipt.aspx?P=" + Product_DistributionID);
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
            else
            {
                ErrorLabel.Text = "You Don't Have Enough Balance";
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

        //Get Get_Position_ID
        [WebMethod]
        public static string Get_Position_ID(string prefix)
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


        //Product
        [WebMethod]
        public static string GetProduct(string pid)
        {
            List<Product> User = new List<Product>();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT Product_PointID, Product_Name, Product_Code, Product_Point, Product_Price FROM Product_Point_Code WHERE (Product_PointID = @Product_PointID)";
                    cmd.Parameters.AddWithValue("Product_PointID", pid);
                    cmd.Connection = con;

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        User.Add(new Product
                        {
                            Code = dr["Product_Code"].ToString(),
                            Name = dr["Product_Name"].ToString(),
                            Price = dr["Product_Price"].ToString(),
                            Point = dr["Product_Point"].ToString(),
                            ProductID = dr["Product_PointID"].ToString()
                        });
                    }
                    con.Close();

                    var json = new JavaScriptSerializer().Serialize(User);
                    return json;
                }
            }
        }
        class Product
        {
            public string Code { get; set; }
            public string Name { get; set; }
            public string Price { get; set; }
            public string Point { get; set; }
            public string ProductID { get; set; }
        }

        protected void Product_DistributionSQL_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            ViewState["Product_DistributionID"] = e.Command.Parameters["@Product_DistributionID"].Value.ToString();
        }
    }
}