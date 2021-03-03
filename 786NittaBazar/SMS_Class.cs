using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;

namespace NittaBazar
{
    public class SMS_Class
    {
        public string Masking { get; set; }
        public int SMSBalance { get; set; }


        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        public SMS_Class()
        {
            SqlCommand Get_SMSBalance_cmd = new SqlCommand("SELECT SMS_Balance FROM Institution", con);

            con.Open();
            this.SMSBalance = Convert.ToInt32(Get_SMSBalance_cmd.ExecuteScalar());
            con.Close();
        }
        public Get_Validation SMS_Validation(string Number, string Text)
        {
            bool IsValid = true;
            string Validation_Message = "";

            if (!Regex.IsMatch(Number, @"^(88)?((011)|(015)|(016)|(017)|(018)|(019)|(013)|(014))\d{8,8}$"))
            {
                IsValid = false;
                Validation_Message += "Invalid Mobile Number ";
            }

            if (IsValid)
            { Validation_Message = "Valid"; }

            Get_Validation V = new Get_Validation();

            V.Validation = IsValid;
            V.Message = Validation_Message;

            return V;
        }
        public Guid? SMS_Send(string Number, string Text, string SMSPurpose)
        {
            Guid SMS_Send_ID = Guid.NewGuid();
            string response_Message = "";

            //-----------------------------------------------Bangla Phone-------------------------------------------------------------------------
            #region Bangla Phone
            var url = "http://loopsitbd.powersms.net.bd/httpapi/sendsms"; // your powersms site url; register the ip first
            var request = HttpWebRequest.Create(url);
            var userId = "seven86";
            var password = "786_SMS";
            var smsText = Uri.EscapeDataString(Text);
            var receiversParam = Number;
            var dataFormat = "userId={0}&password={1}&smsText={2}&commaSeperatedReceiverNumbers={3}";
            var urlEncodedData = string.Format(dataFormat, userId, password, smsText, receiversParam);
            var data = Encoding.ASCII.GetBytes(urlEncodedData);

            request.Method = "post";
            request.Proxy = null;
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;

            try
            {
                using (var requestStream = request.GetRequestStream())
                {
                    requestStream.Write(data, 0, data.Length);
                }


                HttpWebResponse response = request.GetResponse() as HttpWebResponse;

                // Get the response stream
                StreamReader reader = new StreamReader(response.GetResponseStream());

                dynamic Json_Obj = JsonConvert.DeserializeObject(reader.ReadToEnd());
                if (Json_Obj.isError == "False")
                {
                    //ShowLabel.Text = Json_Obj.message + Json_Obj.isError + Json_Obj.insertedSmsIds;
                    response_Message = Json_Obj.message;
                }

                #endregion Bangla Phone

                SqlCommand SendRecordcmd = new SqlCommand("INSERT INTO [SMS_Send_Record] ([SMS_Send_ID], [PhoneNumber], [TextSMS], [TextCount], [SMSCount], [PurposeOfSMS], [Status], [Date], [SMS_Response]) VALUES (@SMS_Send_ID, @PhoneNumber, @TextSMS, @TextCount, @SMSCount, @PurposeOfSMS, @Status, Getdate(), @SMS_Response)", con);
                SendRecordcmd.Parameters.AddWithValue("@SMS_Send_ID", SMS_Send_ID);
                SendRecordcmd.Parameters.AddWithValue("@PhoneNumber", Number);
                SendRecordcmd.Parameters.AddWithValue("@TextSMS", Text);
                SendRecordcmd.Parameters.AddWithValue("@TextCount", Text.Length);
                SendRecordcmd.Parameters.AddWithValue("@SMSCount", SMS_Conut(Text));
                SendRecordcmd.Parameters.AddWithValue("@PurposeOfSMS", SMSPurpose);
                SendRecordcmd.Parameters.AddWithValue("@Status", "Sent");
                SendRecordcmd.Parameters.AddWithValue("@SMS_Response", response_Message);

                con.Open();
                SendRecordcmd.ExecuteNonQuery();
                con.Close();
            }
            catch
            {
                return null;
            }

            return SMS_Send_ID;
        }
        public int SMS_Conut(string Text)
        {
            string gsm7bitChars = "@£$¥èéùìòÇ\\nØø\\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !\\\"#¤%&'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà";
            string gsm7bitExChar = "\\^{}\\\\\\[~\\]|€";

            Regex gsm7bitRegExp = new Regex(@"^[" + gsm7bitChars + "]*$");
            Regex gsm7bitExRegExp = new Regex(@"^[" + gsm7bitChars + gsm7bitExChar + "]*$");
            Regex gsm7bitExOnlyRegExp = new Regex(@"^[\\" + gsm7bitExChar + "]*$");

            string sms = Text.Replace(Environment.NewLine, " ").Trim();

            int _results = 0;

            for (int ctr = 0; ctr <= sms.Length - 1; ctr++)
            {
                if (gsm7bitExOnlyRegExp.IsMatch(sms[ctr].ToString()))
                { _results++; }
            }

            double SMS_Count = 0;

            double SMS_Length = 0;

            if (gsm7bitRegExp.IsMatch(sms))
            {
                SMS_Length = sms.Length + _results;
                if (SMS_Length > 160)
                {
                    SMS_Count = Math.Ceiling(SMS_Length / 153);
                }
                else
                {
                    SMS_Count = 1;
                }
            }
            else if (gsm7bitExRegExp.IsMatch(sms))
            {
                SMS_Length = sms.Length + _results;
                if (SMS_Length > 160)
                {
                    SMS_Count = Math.Ceiling(SMS_Length / 153);
                }
                else
                {
                    SMS_Count = 1;
                }
            }
            else
            {
                SMS_Length = sms.Length;
                if (SMS_Length > 70)
                {
                    SMS_Count = Math.Ceiling(SMS_Length / 67);
                }
                else
                {
                    SMS_Count = 1;
                }
            }

            return (int)SMS_Count;
        }
        public int SMS_Length(string Text)
        {
            string gsm7bitChars = "@£$¥èéùìòÇ\\nØø\\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !\\\"#¤%&'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà";
            string gsm7bitExChar = "\\^{}\\\\\\[~\\]|€";

            Regex gsm7bitRegExp = new Regex(@"^[" + gsm7bitChars + "]*$");
            Regex gsm7bitExRegExp = new Regex(@"^[" + gsm7bitChars + gsm7bitExChar + "]*$");
            Regex gsm7bitExOnlyRegExp = new Regex(@"^[\\" + gsm7bitExChar + "]*$");

            string sms = Text.Replace(Environment.NewLine, " ").Trim();
            int _results = 0;

            for (int ctr = 0; ctr <= sms.Length - 1; ctr++)
            {
                if (gsm7bitExOnlyRegExp.IsMatch(sms[ctr].ToString()))
                { _results++; }
            }

            int sms_count = 0;
            if (gsm7bitRegExp.IsMatch(sms))
            {
                sms_count = sms.Length + _results;
            }
            else if (gsm7bitExRegExp.IsMatch(sms))
            {
                sms_count = sms.Length + _results;
            }
            else
            {
                sms_count = sms.Length;
            }

            return sms_count;
        }

        public bool Multiple_SMS_Send(string Number, string Text, string SMSPurpose)
        {

            var url = "http://loopsitbd.powersms.net.bd/httpapi/sendsms"; // your powersms site url; register the ip first
            var request = HttpWebRequest.Create(url);
            var userId = "seven86";
            var password = "786_SMS";
            var smsText = Uri.EscapeDataString(Text);
            var receiversParam = Number;
            var dataFormat = "userId={0}&password={1}&smsText={2}&commaSeperatedReceiverNumbers={3}";
            var urlEncodedData = string.Format(dataFormat, userId, password, smsText, receiversParam);
            var data = Encoding.ASCII.GetBytes(urlEncodedData);

            request.Method = "post";
            request.Proxy = null;
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;

            try
            {
                using (var requestStream = request.GetRequestStream())
                {
                    requestStream.Write(data, 0, data.Length);
                }
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            }
            catch
            {
                return false;
            }
            return true;
        }

    }

    public class Get_Validation
    {
        public bool Validation { get; set; }
        public string Message { get; set; }
    }
}