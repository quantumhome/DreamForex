using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//namespace DreamForex
//{
public class Util
{
    public string generateOrderNo(char quoteFor)
    {
        string otpNumber = "";
        Random random = new Random();
        int n = random.Next(0, 100000);
        otpNumber += quoteFor + n.ToString("D5");
        return otpNumber.Trim() + DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }

    public void checkUserSession(Page pg)
    {
        if (pg.Session.Count > 0)
        {
            LinkButton lbtn = (LinkButton)pg.Master.FindControl("lbtnLogin");
            LinkButton lbtn1 = (LinkButton)pg.Master.FindControl("lbtnLogout");

            Label lblUser = (Label)pg.Master.FindControl("lblUser");
            lbtn.Text = "Logout";
            lblUser.Text = " Welcome , " + pg.Session["userName"].ToString();

            if ((bool)(pg.Session["clientLogin"] != null))
            {
                lbtn.Visible = false;
                lbtn1.Visible = true;
            }
        }
        else
        {
            pg.Response.Redirect("Login.aspx");
        }
    }

    public void checAdminSession(Page pg)
    {
        if (pg.Session.Count > 0)
        {
            LinkButton lbtn = (LinkButton)pg.Master.FindControl("lbtnLogin");
            LinkButton lbtn1 = (LinkButton)pg.Master.FindControl("lbtnLogout");

            Label lblUser = (Label)pg.Master.FindControl("lblUser");
            lbtn.Text = "Logout";
            lblUser.Text = " Welcome , " + pg.Session["userName"].ToString();

            if ((bool)(pg.Session["adminLogin"] != null))
            {
                lbtn.Visible = false;
                lbtn1.Visible = true;
            }
        }
        else
        {
            pg.Response.Redirect("adminLogin.aspx");
        }
    }

}
//}