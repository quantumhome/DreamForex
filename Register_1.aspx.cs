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
    public partial class Register_1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }
        protected void btnMember_Click(object sender, EventArgs e)
        {
            Util ut = new Util();
            string rndNo = ut.generateOrderNo(' '); // for SMS OTP

            SqlDataSource1.InsertParameters["username"].DefaultValue = txtLogin.Text;
            SqlDataSource1.InsertParameters["Password"].DefaultValue = txtPwd.Text;
            SqlDataSource1.InsertParameters["MEM_NAME"].DefaultValue = txtName.Text;
            SqlDataSource1.InsertParameters["MOBILENO"].DefaultValue = txtMobile.Text;
            SqlDataSource1.InsertParameters["EMAILID"].DefaultValue = txtEmail.Text;
            SqlDataSource1.InsertParameters["otpmode"].DefaultValue = rblOtp.SelectedValue;
            SqlDataSource1.InsertParameters["OTP"].DefaultValue = rndNo;
            try
            {
                SqlDataSource1.Insert();
                lblOtp.Text = "OTP has been sent to your : " + rblOtp.SelectedItem + " valid for 10 Minutes";
                Panel1.Visible = true;

            }
            catch (Exception ex)
            {
                lblOtp.Text = "Sorry, Cannot register. Please try after sometime<br>" + ex.ToString(); ;
            }

        }

        protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            hfUserId.Value = e.Command.Parameters["@userId"].Value.ToString();

            //lblUserId.Text = "UserId = " + hfUserId.Value;

        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("checkOtp", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@loginId", int.Parse(hfUserId.Value));
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
                            lblVerify.Text = "OTP Expired";
                            lbtnOtp.Visible = true;
                            PanelModal.Visible = true;
                            break;
                        case "3":
                            lblVerify.Text = "OTP Incorrect";
                            lbtnOtp.Visible = true;
                            PanelModal.Visible = true;
                            break;
                        case "4":
                            //string constring1 = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
                            //using (SqlConnection con = new SqlConnection(constring))

                            if (Session["orderNo"].ToString().Substring(0, 1) == "B")
                            {
                                using (SqlCommand cmd1 = new SqlCommand("updateBuyLoginId", con))
                                {
                                    cmd1.CommandType = CommandType.StoredProcedure;
                                    cmd1.Parameters.AddWithValue("@loginId", hfUserId.Value);
                                    cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);
                                    // con.Open();
                                    cmd1.ExecuteNonQuery();
                                    //con.Close();
                                }
                            }
                            else if (Session["orderNo"].ToString().Substring(0, 1) == "S")
                            {
                                using (SqlCommand cmd1 = new SqlCommand("updateSellLoginId", con))
                                {
                                    cmd1.CommandType = CommandType.StoredProcedure;
                                    cmd1.Parameters.AddWithValue("@loginId", hfUserId.Value);
                                    cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);
                                    // con.Open();
                                    cmd1.ExecuteNonQuery();

                                }
                                //con.Close();
                            }
                            else if (Session["orderNo"].ToString().Substring(0, 1) == "V")
                            {
                                using (SqlCommand cmd1 = new SqlCommand("updateVisaLoginId", con))
                                {
                                    cmd1.CommandType = CommandType.StoredProcedure;
                                    cmd1.Parameters.AddWithValue("@loginId", hfUserId.Value);
                                    cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);
                                    // con.Open();
                                    cmd1.ExecuteNonQuery();

                                }
                               
                            }
                            con.Close();
                            lblVerify.Text = "Your Registration is Completed";
                            PanelModal_ModalPopupExtender.Show();
                            break;
                    }
                }
            }
        }




        protected void lbtnOtp_Click(object sender, EventArgs e)
        {
            Util ut = new Util();
            string newOtp = ut.generateOrderNo(' ');
            SqlDataSource2.UpdateParameters["OTP"].DefaultValue = newOtp;
            SqlDataSource2.UpdateParameters["LOGIN_ID"].DefaultValue = hfUserId.Value;
            try
            {
                SqlDataSource2.Update();
                lblOtp.Text = "OTP has been sent to your : " + rblOtp.SelectedItem + " valid for 10 Minutes";
                lbtnOtp.Enabled = false;
            }
            catch
            {

            }

        }

        protected void lbtnClose_Click(object sender, EventArgs e)
        {
            PanelModal_ModalPopupExtender.Hide();
            Response.Redirect("login.aspx");
        }


    }
}
