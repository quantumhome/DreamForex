using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class userHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util ut = new Util();
            ut.checkUserSession(this.Page);
            if (!Page.IsPostBack)
            {
                if (Session["dtBuy"] != null)
                {
                    lblUserMessage.Text = "Your Order has been booked with Order Id " + Session["orderNo"];
                    Session["dtBuy"] = null;
                }
                if (Session["dtSell"] != null)
                {
                    lblUserMessage.Text = "Your Order has been booked with Order Id " + Session["orderNo"];
                    Session["dtSell"] = null;
                }
                Session["orderNo"] = null;
            }
            else
            {
                lblUserMessage.Text = String.Empty;
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.Visible = true;
        }
    }
}