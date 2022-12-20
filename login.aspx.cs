using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUser.Focus();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("Password_Check", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@loginName", txtUser.Text);
                    cmd.Parameters.AddWithValue("@pwd", pwd.Text);
                    cmd.Parameters.Add("@result", SqlDbType.Int);
                    cmd.Parameters.Add("@loginId", SqlDbType.Int);
                    cmd.Parameters.Add("@memName", SqlDbType.VarChar, 20);

                    cmd.Parameters["@result"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@loginId"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@memName"].Direction = ParameterDirection.Output;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    int retVal = (int)cmd.Parameters["@result"].Value;
                    int wLoginId = (int)cmd.Parameters["@loginId"].Value;
                    switch (retVal)
                    {
                        case 0:
                            lblResult.Text = "Sorry, Invalid Username/password";
                            lblResult.Attributes.Add("class", "label label-danger");
                            break;
                        case 1:
                            lblResult.Text = "Welcome User";// + wLoginId;
                            lblResult.Attributes.Add("class", "label label-success");
                            Session["clientLogin"] = true;
                            Session["userName"] = (string)cmd.Parameters["@memName"].Value.ToString();
                            Session["loginId"] = wLoginId;
                            // getting the buy/sell/online order details

                            //LiveRate lr = (LiveRate)Session["liveRate"];
                            if (Session["orderNo"] != null)
                            {
                                if (Session["orderNo"].ToString().Substring(0, 1) == "B" && Session["dtBuy"]!= null)
                                {
                                    //using (SqlCommand cmd1 = new SqlCommand("updateBuyLoginId", con))
                                    //{
                                    //    cmd1.CommandType = CommandType.StoredProcedure;
                                    //    cmd1.Parameters.AddWithValue("@loginId", wLoginId);
                                    //    cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);

                                    //    // con.Open();
                                    //    cmd1.ExecuteNonQuery();
                                    //    con.Close();
                                    //}
                                    using (SqlCommand cmd1 = new SqlCommand("insertBuy", con))
                                    {
                                        cmd1.CommandType = CommandType.StoredProcedure;
                                        var dtBuy = (DataTable)Session["dtBuy"];
                                       
                                        foreach (DataRow dr in dtBuy.Rows)
                                        {
                                            dr[12] = Session["loginId"];
                                        }
                                         
                                        cmd1.Parameters.AddWithValue("@tblBuyDetails", dtBuy);
                                        //con.Open();
                                        cmd1.ExecuteNonQuery();
                                        con.Close();
                                    }
                                }
                                //insert into Sell table
                                else if (Session["orderNo"].ToString().Substring(0, 1) == "S" && Session["dtSell"]!= null)
                                {
                                    //using (SqlCommand cmd1 = new SqlCommand("updateSellLoginId", con))
                                    //{
                                    //    cmd1.CommandType = CommandType.StoredProcedure;
                                    //    cmd1.Parameters.AddWithValue("@loginId", wLoginId);
                                    //    cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);

                                    //    // con.Open();
                                    //    cmd1.ExecuteNonQuery();
                                    //    con.Close();
                                    //}

                                    using (SqlCommand cmd2 = new SqlCommand("insertSell", con))
                                    {
                                        cmd2.CommandType = CommandType.StoredProcedure;
                                        var dtSell = (DataTable)Session["dtSell"];
                                        foreach (DataRow dr in dtSell.Rows)
                                        {
                                            dr[12] = Session["loginId"];
                                        }
                                        cmd2.Parameters.AddWithValue("@tblSellDetails", dtSell);
                                       // con.Open();
                                        cmd2.ExecuteNonQuery();
                                        con.Close();
                                    }
                                }
                                //insert into VISA table
                                else if (Session["orderNo"].ToString().Substring(0, 1) == "V")
                                {
                                    using (SqlCommand cmd1 = new SqlCommand("updateVisaLoginId", con))
                                    {
                                        cmd1.CommandType = CommandType.StoredProcedure;
                                        cmd1.Parameters.AddWithValue("@loginId", wLoginId);
                                        cmd1.Parameters.AddWithValue("@orderNo", Session["orderNo"]);

                                        // con.Open();
                                        cmd1.ExecuteNonQuery();
                                        con.Close();
                                    }
                                }
                                lblResult.Text = "Your request is booked..";
                            }
                            Response.Redirect("userHome.aspx");
                            break;
                    }

                }
            }
        }
    }
}