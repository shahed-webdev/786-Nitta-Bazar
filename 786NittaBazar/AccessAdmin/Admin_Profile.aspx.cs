using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NittaBazar.AccessAdmin
{
    public partial class Admin_Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataView dv = (DataView)SellerSQL.Select(DataSourceSelectArguments.Empty);
                Total_Label.Text = "Total: " + dv.Count.ToString() + " " + SellerTypeDropDownList.SelectedItem.Text + " Distributor(s)";
            }
        }

        protected void AdminFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            FileUpload MemberFileUpload = (FileUpload)AdminFormView.FindControl("AdminFileUpload");

            //Member Image
            if (MemberFileUpload.PostedFile != null && MemberFileUpload.PostedFile.FileName != "")
            {
                string strExtension = System.IO.Path.GetExtension(MemberFileUpload.FileName);
                if ((strExtension.ToUpper() == ".JPG") || (strExtension.ToUpper() == ".JPEG") || (strExtension.ToUpper() == ".PNG"))
                {
                    // Resize Image Before Uploading to DataBase
                    System.Drawing.Image imageToBeResized = System.Drawing.Image.FromStream(MemberFileUpload.PostedFile.InputStream);
                    int imageHeight = imageToBeResized.Height;
                    int imageWidth = imageToBeResized.Width;

                    int maxHeight = 200;
                    int maxWidth = 180;

                    imageHeight = (imageHeight * maxWidth) / imageWidth;
                    imageWidth = maxWidth;

                    if (imageHeight > maxHeight)
                    {
                        imageWidth = (imageWidth * maxHeight) / imageHeight;
                        imageHeight = maxHeight;
                    }

                    Bitmap bitmap = new Bitmap(imageToBeResized, imageWidth, imageHeight);
                    System.IO.MemoryStream stream = new MemoryStream();
                    bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
                    stream.Position = 0;
                    byte[] image = new byte[stream.Length + 1];
                    stream.Read(image, 0, image.Length);


                    // Create SQL Command
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "UPDATE Registration SET Image = @Image Where RegistrationID = @RegistrationID";
                    cmd.Parameters.AddWithValue("@RegistrationID", AdminFormView.DataKey["RegistrationID"].ToString());

                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;

                    SqlParameter UploadedImage = new SqlParameter("@Image", SqlDbType.Image, image.Length);

                    UploadedImage.Value = image;
                    cmd.Parameters.Add(UploadedImage);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

        }
        protected void ChangePassword1_ChangedPassword(object sender, EventArgs e)
        {
            User_Login_InfoSQL.UpdateParameters["Password"].DefaultValue = ChangePassword.NewPassword;
            User_Login_InfoSQL.UpdateParameters["UserName"].DefaultValue = User.Identity.Name;
            User_Login_InfoSQL.Update();
        }

        //Approved
        protected void Authority_CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            GridViewRow GV = (GridViewRow)(((CheckBox)sender).Parent).Parent;
            CheckBox Authority_CheckBox = (CheckBox)GV.FindControl("Authority_CheckBox");

            if (Authority_CheckBox.Checked)
            {
                AccountSQL.UpdateParameters["Recharge_AuthorizationID"].DefaultValue = AccountGridView.DataKeys[GV.RowIndex]["Recharge_AuthorizationID"].ToString();
                AccountSQL.Update();
            }

            AccountGridView.DataBind();
        }

        protected void SellerTypeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SellerSQL.Select(DataSourceSelectArguments.Empty);
            Total_Label.Text = "Total: " + dv.Count.ToString() + " " + SellerTypeDropDownList.SelectedItem.Text + " Distributor(s)";
        }
    }
}