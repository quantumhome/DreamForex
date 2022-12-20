using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace DreamForex
{
    public partial class buySell : System.Web.UI.Page
    {
        DataTable dtBuy;
        DataTable dtSell;
        string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
                if (!IsPostBack)
                {
                    dtBuy = new DataTable();
                    dtBuy.Columns.Add("BOOKING_NO", typeof(string));
                    dtBuy.Columns.Add("Currency_Code", typeof(string));
                    dtBuy.Columns.Add("Forex_Quantity", typeof(int));
                    dtBuy.Columns.Add("Product_Id", typeof(int));
                    dtBuy.Columns.Add("Rate", typeof(float));
                    dtBuy.Columns.Add("Current_Rate", typeof(float));
                    dtBuy.Columns.Add("COMM_COMPANY", typeof(float));
                    dtBuy.Columns.Add("COMM_DREAM ", typeof(float));
                    dtBuy.Columns.Add("AMOUNT_TOTAL", typeof(float));
                    dtBuy.Columns.Add("AMOUNT_Company", typeof(float));
                    dtBuy.Columns.Add("AMOUNT_Dream", typeof(float));
                    dtBuy.Columns.Add("RATE_TO_CLIENT", typeof(float));
                    dtBuy.Columns.Add("LOGIN_ID", typeof(int));
                    ViewState["dtBuy"] = dtBuy;

                    dtSell = new DataTable();
                    dtSell.Columns.Add("BOOKING_NO", typeof(string));
                    dtSell.Columns.Add("Currency_Code", typeof(string));
                    dtSell.Columns.Add("Forex_Quantity", typeof(int));
                    dtSell.Columns.Add("Product_Id", typeof(int));
                    dtSell.Columns.Add("Rate", typeof(float));
                    dtSell.Columns.Add("Current_Rate", typeof(float));
                    dtSell.Columns.Add("COMM_COMPANY", typeof(float));
                    dtSell.Columns.Add("COMM_DREAM ", typeof(float));
                    dtSell.Columns.Add("AMOUNT_TOTAL", typeof(float));
                    dtSell.Columns.Add("AMOUNT_Company", typeof(float));
                    dtSell.Columns.Add("AMOUNT_Dream", typeof(float));
                    dtSell.Columns.Add("RATE_TO_CLIENT", typeof(float));
                    dtSell.Columns.Add("LOGIN_ID", typeof(int));
                    ViewState["dtSell"] = dtSell;
                    DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                    ViewState["dtCurrencyDetails"] = dv.ToTable();
                }
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            if (Session["loginId"] != null)
            {
                SaveBuy();
            }
            else
            {
                Session["dtBuy"] = ViewState["dtBuy"];
                Response.Redirect("~/login.aspx");
            }
        }

        protected void btnSell_Click(object sender, EventArgs e)
        {
            if (Session["loginId"] != null)
            {
                SaveSell();
            }
            else
            {
                Session["dtSell"] = ViewState["dtSell"];
                Response.Redirect("~/login.aspx");
            }
        }

        private void SaveBuy()
        {
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("insertBuy", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (grdBuy.Rows.Count > 0)
                    {
                        dtBuy = (DataTable)ViewState["dtBuy"];
                        cmd.Parameters.AddWithValue("@tblBuyDetails", dtBuy);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }

                    Response.Redirect("~/userHome.aspx");
                }
            }
        }

        private void SaveSell()
        {
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("insertSell", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (grdSell.Rows.Count > 0)
                    {
                        dtSell = (DataTable)ViewState["dtSell"];
                        cmd.Parameters.AddWithValue("@tblSellDetails", dtSell);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    //Server.Transfer("~/login.aspx");
                    Response.Redirect("~/userHome.aspx");
                }
            }
        }

        protected void btnVisa_Click(object sender, EventArgs e)
        {
            Util ut = new Util();
            string orderNo = ut.generateOrderNo('V');

            // INSERT INTO buy table
            Session["orderNo"] = orderNo;
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("visaInsert", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BOOKING_NO", orderNo.ToString());
                    cmd.Parameters.AddWithValue("@PROD_ID", ddlVisa.SelectedValue);
                    cmd.Parameters.AddWithValue("@COUNTRY_ID", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@VISA_REMARKS", txtMsg.Text);
                    cmd.Parameters.Add("@visaId", SqlDbType.Int);
                    cmd.Parameters["@visaId"].Direction = ParameterDirection.Output;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string retVal = cmd.Parameters["@visaId"].Value.ToString();
                    Session["visaId"] = retVal;
                    con.Close();
                    //Server.Transfer("~/login.aspx");
                    Response.Redirect("~/login.aspx");
                }
            }
        }
       
        protected void btnAddMore_Click(object sender, EventArgs e)
        {
                dtBuy = (DataTable)ViewState["dtBuy"];
                DataRow dataRow = dtBuy.NewRow();
                Util ut = new Util();
                if (dtBuy.Rows.Count == 0)
                {
                    string orderNo = ut.generateOrderNo('B');
                    Session["orderNo"] = orderNo;
                }

                // INSERT INTO buy table
                LiveRate lr = (LiveRate)Session["liveRate"];

                dataRow[0] = Session["orderNo"];
                dataRow[1] = lr.CurrCode.ToString();
                dataRow[2] = lr.fxQty.ToString();
                dataRow[3] = lr.prodId.ToString();
                dataRow[4] = lr.rateToClient.ToString("n2");
                dataRow[5] = lr.CurrRate.ToString("n2");
                dataRow[6] = lr.commClient.ToString("n2");
                dataRow[7] = lr.commDream.ToString("n2");
                dataRow[8] = lr.totAmount.ToString("n2");
                dataRow[9] = lr.clientAmount.ToString("n2");
                dataRow[10] = lr.dreamAmount.ToString("n2");
                dataRow[11] = lr.rateToClient.ToString("n2");
                dataRow[12] = Session["loginId"] == null ? DBNull.Value : Session["loginId"];

                dtBuy.Rows.Add(dataRow);
                grdBuy.DataSource = dtBuy;
                grdBuy.DataBind();
                grdBuy.Visible = true;
                ViewState["dtBuy"] = dtBuy;
                if (grdBuy.Rows.Count > 0)
                {
                    btnBuyNow.Enabled = true;
                }

                // Define the name and type of the client scripts on the page.
                String csname1 = "NavigationScript";
                Type cstype = this.GetType();

                // Get a ClientScriptManager reference from the Page class.
                ClientScriptManager cs = Page.ClientScript;

                // Check to see if the startup script is already registered.
                if (!cs.IsStartupScriptRegistered(cstype, csname1))
                {
                    cs.RegisterStartupScript(cstype, csname1, "ToggleToBuy();", true);
                }
        }

        protected void btnAddMoreSell_Click(object sender, EventArgs e)
        {
            dtSell = (DataTable)ViewState["dtSell"];
            DataRow dataRow = dtSell.NewRow();
            Util ut = new Util();
            if (dtSell.Rows.Count == 0)
            {
                string orderNo = ut.generateOrderNo('S');
                Session["orderNo"] = orderNo;
            }

            // INSERT INTO buy table
            LiveRate lr = (LiveRate)Session["liveRate"];

            dataRow[0] = Session["orderNo"];
            dataRow[1] = lr.CurrCode.ToString();
            dataRow[2] = lr.fxQty.ToString();
            dataRow[3] = lr.prodId.ToString();
            dataRow[4] = Math.Round(lr.rateToClient, 2).ToString();
            dataRow[5] = Math.Round(lr.CurrRate, 2).ToString();
            dataRow[6] = Math.Round(lr.commClient, 2).ToString();
            dataRow[7] = Math.Round(lr.commDream, 2).ToString();
            dataRow[8] = Math.Round(lr.totAmount, 2).ToString();
            dataRow[9] = Math.Round(lr.clientAmount, 2).ToString();
            dataRow[10] = Math.Round(lr.dreamAmount, 2).ToString();
            dataRow[11] = Math.Round(lr.rateToClient, 2).ToString();
            dataRow[12] = Session["loginId"] == null ? DBNull.Value : Session["loginId"];
            
            dtSell.Rows.Add(dataRow);
            grdSell.DataSource = dtSell;
            grdSell.DataBind();
            grdSell.Visible = true;
            ViewState["dtSell"] = dtSell;
            if (grdSell.Rows.Count > 0)
            {
                btnSell.Enabled = true;
            }

            // Define the name and type of the client scripts on the page.
            String csname1 = "NavigationScript";
            Type cstype = this.GetType();

            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, csname1))
            {
                cs.RegisterStartupScript(cstype, csname1, "ToggleToSell();", true) ;
            }
        }


        protected void BuyMenu_Click(object sender, EventArgs e)
        {
            
        }

        protected void SellMenu_Click(object sender, EventArgs e)
        {
           
        }

        protected void VisaMenu_Click(object sender, EventArgs e)
        {
            
        }

        protected void ddlCurr_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCurr.SelectedIndex != 0)
            {
                var currentDt = (DataTable)(ViewState["dtCurrencyDetails"]);
                var selectedCurrency = currentDt.Select($"CURR_CODE= '{ddlCurr.SelectedValue}'");
                txtmaxCurrencyValue.Text = selectedCurrency[0]["MAX_QTY"].ToString();
            }
        }
    }
}