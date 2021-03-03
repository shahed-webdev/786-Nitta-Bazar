using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.UI;

namespace NittaBazar
{
    public partial class Manage_Slider_Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.GetCurrent(this).RegisterPostBackControl(this.SubmitButton);
            ScriptManager.GetCurrent(this).RegisterPostBackControl(this.ProductButton);
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            // Check file exist or not  
            if (Slider_FileUpload.PostedFile != null)
            {
                // Check the extension of image  
                string extension = Path.GetExtension(Slider_FileUpload.FileName);
                if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg")
                {
                    Stream strm = Slider_FileUpload.PostedFile.InputStream;
                    using (var Upload_image = System.Drawing.Image.FromStream(strm))
                    {
                        int newWidth = 1600; // New Width of Image in Pixel  
                        int newHeight = 700; // New Height of Image in Pixel  

                        var thumbImg = new Bitmap(newWidth, newHeight);
                        var thumbGraph = Graphics.FromImage(thumbImg);

                        thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                        thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                        thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                        System.IO.MemoryStream stream = new MemoryStream();
                        thumbGraph.DrawImage(Upload_image, imgRectangle);

                        // Save the file  
                        thumbImg.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
                        stream.Position = 0;
                        byte[] image = new byte[stream.Length + 1];
                        stream.Read(image, 0, image.Length);

                        // Create SQL Command
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = "INSERT INTO Home_Slider(Image) VALUES (@Image)";
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

            SliderGridView.DataBind();
        }

        protected void ProductButton_Click(object sender, EventArgs e)
        {
            ProductSQL.Insert();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());

            // Check file exist or not  
            if (Product_FileUpload.PostedFile != null)
            {
                // Check the extension of image  
                string extension = Path.GetExtension(Product_FileUpload.FileName);
                if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg")
                {
                    Stream strm = Product_FileUpload.PostedFile.InputStream;
                    using (var Upload_image = System.Drawing.Image.FromStream(strm))
                    {
                        int newWidth = 300; // New Width of Image in Pixel  
                        int newHeight = 300; // New Height of Image in Pixel  

                        var thumbImg = new Bitmap(newWidth, newHeight);
                        var thumbGraph = Graphics.FromImage(thumbImg);

                        thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                        thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                        thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                        System.IO.MemoryStream stream = new MemoryStream();
                        thumbGraph.DrawImage(Upload_image, imgRectangle);

                        // Save the file  
                        thumbImg.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
                        stream.Position = 0;
                        byte[] image = new byte[stream.Length + 1];
                        stream.Read(image, 0, image.Length);

                        // Create SQL Command
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = "UPDATE Home_Product SET Product_Image = @Image WHERE (ProductID = (select IDENT_CURRENT('Home_Product')))";
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

            ProductGridView.DataBind();
        }
    }
}