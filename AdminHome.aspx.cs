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
    public partial class AdminHome1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfTab.Value = "users";
            Util ut = new Util();
            ut.checAdminSession(this.Page);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            hfTab.Value = "users";
            dsOffUsers.InsertParameters["OFF_USER_NAME"].DefaultValue = txtLogin.Text;
            dsOffUsers.InsertParameters["OFF_NAME"].DefaultValue = txtName.Text;
            dsOffUsers.InsertParameters["Password"].DefaultValue = txtPwd.Text;
            dsOffUsers.InsertParameters["MOBILENO"].DefaultValue = txtMobile.Text;
            dsOffUsers.InsertParameters["EMAILID"].DefaultValue = txtEmail.Text;
            try
            {
                dsOffUsers.Insert();
              //  lblSuccess.Text = "User added succesfully...";
                
            }
            catch(Exception ex ) {
                PanelUserFail.Visible = true;
                lblFail.Text = "Sorry,,unable to add user. Please try after sometime...<br>" + ex.ToString();
            }

        }

        protected void dsOffUsers_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            hfTab.Value = "users";
            string res =  e.Command.Parameters["@result"].Value.ToString();
           switch (res)
            {
                case "OK":
                    lblSuccess.Text = "User added successfully";
                    PanelUserSuccess.Visible = true;
                    break;

                case "LO" :
                    lblFail.Text = "Login name already taken..Try a different one..";
                    PanelUserFail.Visible = true;
                    txtLogin.Focus();
                    break;

                case "US":
                    lblFail.Text = "This user is already registered..Try a different one..";
                    PanelUserFail.Visible = true;
                    txtName.Focus();
                    break;

                case "MO":
                    lblFail.Text = "Mobile number is already registered..Try a different one..";
                    PanelUserFail.Visible = true;
                    txtMobile.Focus();
                    break;
                case "EM":
                    lblFail.Text = "Email is already registered..Try a different one..";
                    PanelUserFail.Visible = true;
                    txtEmail.Focus();
                    break;
            }


        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            hfTab.Value = "users";
            TextBox tb = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPwd");
            if (tb != null)
            {
                dsOffUsers.UpdateParameters["Password"].DefaultValue = tb.Text;
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfTab.Value = "book";
            if (DropDownList1.SelectedValue.ToString() == "BUY")
            {
                gvBuy.Visible = true;
                gvSell.Visible = false;
            }else if (DropDownList1.SelectedValue.ToString() == "SELL")
            {
                gvSell.Visible = true;
                gvBuy.Visible = false;
            }
            else
            {
                gvBuy.Visible = false;
                gvSell.Visible = false;
            }
            //DataTable dt = null;
            //string strTable = DropDownList1.SelectedItem.Text;

            //string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            //using (SqlConnection con = new SqlConnection(constring))
            //{
            //    using (SqlCommand cmd = new SqlCommand("AdminBuy", con))
            //    {
            //        cmd.CommandType = CommandType.StoredProcedure;
            //        cmd.Parameters.AddWithValue("@p_table", strTable);

            //        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            //        {
            //            dt = new DataTable();
            //            sda.Fill(dt);
            //        }
            //    }
            //}
            //GridView2.DataSource = dt;

            //GridView2.DataBind();
       
        }

        protected void lbtnBuyLoginId_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            Session["iLoginId"]= btn.CommandArgument;
            Session["iBookingNo"] = btn.Text;
            Response.Redirect("Invoice-Pre.aspx");
        }
    }
}