using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class InvoiceSub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Util ut = new Util();
            //ut.checAdminSession(this.Page);
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)dsRate.Select(DataSourceSelectArguments.Empty);
            if (dv != null)
            {
                double rateToClient = Math.Round(Convert.ToDouble(dv.Table.Rows[0]["rateToClient"].ToString()), 2);
                if (rateToClient == 0)
                {
                    lblCurrRate.Text = "Rate Not Found";
                }
                else
                {
                    lblCurrRate.Text = rateToClient.ToString();
                }
                //double currRate = 0, compComm = 0, dreamComm = 0;
                //currRate = Math.Round(Convert.ToDouble(dv.Table.Rows[0]["currExRate"].ToString()), 2);

                //if (dv.Table.Rows[0]["clientComm"].ToString() == "")
                //{
                //    compComm = 0;
                //    lblCurrRate.Text = "Rate Not Found";
                //}
                //else
                //{
                //    compComm = Convert.ToDouble(dv.Table.Rows[0]["clientComm"].ToString());
                //    if (dv.Table.Rows[0]["dreamComm"].ToString() == "")
                //    {
                //        dreamComm = 0;
                //        lblCurrRate.Text = "Rate Not Found";
                //    }
                //    else
                //    {
                //        dreamComm = Convert.ToDouble(dv.Table.Rows[0]["dreamComm"].ToString());
                //        lblCurrRate.Text = (currRate + compComm + dreamComm).ToString();
                //    }
                
            }
            else
            {
                lblCurrRate.Text = "Rate Not Found";
            }
        }

        protected void txtFxAmount_TextChanged(object sender, EventArgs e)
        {
            lblInrAmount.Text = Math.Round(Convert.ToDouble(lblCurrRate.Text) * Convert.ToInt32( txtFxAmount.Text)).ToString();
        }
    }
}

    
