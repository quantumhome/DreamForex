using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class adminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session.Count > 0)
            {
                LinkButton lbtn = (LinkButton)Master.FindControl("lbtnLogin");
                Label lblUser = (Label)Master.FindControl("lblUser");

                if ((bool)(Session["clientLogin"] != null))
                {
                    lbtn.Text = "Logout";
                    lblUser.Text = " Welcome , " + Session["userName"].ToString();
                    lbtn.PostBackUrl = "Login.aspx";
                }
                else if ((bool)(Session["adminLogin"] != null))
                {
                    lbtn.Text = "Logout";
                    lbtn.PostBackUrl = "adminLogin.aspx";
                }
            }
            else
            {
                txtUser.Focus();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataView dv = (DataView)dsLogin.Select(DataSourceSelectArguments.Empty);
            //if (dv == null)
            //{
            //    lblResult.Text = "Sorry, invalid username/password";
            //    lblResult.Attributes.Add("class", "alert alert-danger");
            //}
            //else
            //{
                //lblResult.Text = "welcome," + dv.Table.Rows[0]["off_name"].ToString();
                Session["adminLogin"] = true;
                Session["userName"] = "Admin";
                //lblResult.Attributes.Add("class", "alert alert-success");
                Response.Redirect("AdminHome.aspx");
            //}

        }

    }
}