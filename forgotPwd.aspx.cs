using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class forgotPwd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("forgotPassword", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@mobileNo", txtMobile.Text);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    int retVal;
                    while (rdr.Read())
                    {
                        retVal = Convert.ToInt32(rdr["ReturnValue"].ToString());
                        if (retVal == 1)
                        {
                            hfLoginId.Value = (rdr["LoginId"].ToString());
                            lblResult.Text = "OTP is sent to Your Email/Mobile";

                            Panel1.Visible = true;
                        }
                        else
                        {
                            lblResult.Text = "Sorry, Your Email/Mobile is NOT registered.";
                        }
                    }
                    con.Close();

                }
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            
            lblResult.Text = "";
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("checkOtp", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@loginId", int.Parse(hfLoginId.Value));
                    cmd.Parameters.AddWithValue("@otp", txtOtp.Text);
                    cmd.Parameters.Add("@result", SqlDbType.Int);
                    cmd.Parameters["@result"].Direction = ParameterDirection.Output;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    //con.Close();
                    string retVal = cmd.Parameters["@result"].Value.ToString();
                    switch (retVal)
                    {
                        case "0":
                            lblOtpResult.Text = "OTP Expired";
                            //lbtnOtp.Visible = true;
                            //PanelModal.Visible = true;
                            break;
                        case "3":
                            lblOtpResult.Text = "OTP Incorrect";
                            //lbtnOtp.Visible = true;
                            //PanelModal.Visible = true;
                            break;
                        case "4": // all correct
                            //lblOtpResult.Text = "You can change password Now.";
                            Panel1.Visible = false;
                            pnChPwd.Visible = true;
                            break;

                    }
                }
            }
        }

        protected void btnChPwd_Click(object sender, EventArgs e)
        {
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd1 = new SqlCommand("updatePassword", con))
                {
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@loginId", hfLoginId.Value);
                    cmd1.Parameters.AddWithValue("@pwd", txtPwd.Text);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                    lblUpdated.Text = "Password Changed Successfully..";
                    lbtnLogin.Visible = true;
                }

            }
        }
    }
}