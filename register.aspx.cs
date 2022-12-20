using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void btnMember_Click(object sender, EventArgs e)
        {
            SqlDataSource2.InsertParameters["pLogin"].DefaultValue = txtLogin.Text;
            SqlDataSource2.InsertParameters["pPassword"].DefaultValue = txtPwd.Text;
            SqlDataSource2.InsertParameters["MEM_NAME"].DefaultValue = txtName.Text;
            SqlDataSource2.InsertParameters["MEM_GENDER"].DefaultValue = rblGender.SelectedValue;
            SqlDataSource2.InsertParameters["mobileNo"].DefaultValue = txtMobile.Text;
            SqlDataSource2.InsertParameters["emailId"].DefaultValue = txtEmail.Text;
            SqlDataSource2.InsertParameters["MEM_ADD1"].DefaultValue = txtAdd1.Text;
            SqlDataSource2.InsertParameters["MEM_ADD2"].DefaultValue = txtAdd2.Text;
            SqlDataSource2.InsertParameters["STATE_ID"].DefaultValue = ddlState.SelectedValue;
            SqlDataSource2.InsertParameters["CITY_ID"].DefaultValue = ddlCity.SelectedValue;
            SqlDataSource2.InsertParameters["PIN"].DefaultValue = txtPin.Text;
            SqlDataSource2.InsertParameters["PAN_NO"].DefaultValue = txtPan.Text;
            SqlDataSource2.InsertParameters["PAN_FILE_NAME"].DefaultValue = fupPan.FileName;
            SqlDataSource2.InsertParameters["PASSPORT_NO"].DefaultValue = txtPassport.Text;
            SqlDataSource2.InsertParameters["PASSPORT_FILE_NAME"].DefaultValue = fupPassport.FileName;
            SqlDataSource2.InsertParameters["COUNTRY_ID"].DefaultValue = ddlCountry.SelectedValue;
            try
            {
                SqlDataSource2.Insert();
                lblResult1.Text = "User Details Saved Successfully";
                try
                {
                    string folderPath = Server.MapPath("~/PAN_Images/");
                    fupPan.SaveAs(folderPath + Path.GetFileName(fupPan.FileName));
                    lblResult1.Text += "<br>PAN Image saved";
                }
                catch (Exception )
                {
                    lblResult1.Text += "<br>PAN Image NOT saved";
                }

                try
                {
                    string folderPathPP = Server.MapPath("~/PP_Images/");
                   fupPassport.SaveAs(folderPathPP + Path.GetFileName(fupPassport.FileName));

                    lblResult1.Text += "<br>Passport Image saved";
                }
                catch (Exception)
                {
                    lblResult1.Text += "<br>Passport Image NOT saved";
                }

            }
            catch (Exception ex)
            {
                lblResult1.Text = "Sorry, could not Save.. Try again later..<br />" + ex.ToString();
            }

        }

        protected void btnAvail_Click(object sender, EventArgs e)
        {
            bool status = false;
            string constr = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("CheckUserAvailability", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserName", txtLogin.Text.Trim());
                    conn.Open();
                    status = Convert.ToBoolean(cmd.ExecuteScalar());
                    conn.Close();
                }
            }
            if (status)
            {
               lblResult.Text = "!! Sorry, Username Already Taken. Please try a different Username ";
                lblResult.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
               lblResult.Text = "Username Available";
                lblResult.ForeColor = System.Drawing.Color.Green;
            }
        }
    }
}