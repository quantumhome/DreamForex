using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
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

        protected void gvBuy_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Label lblAMOUNT_TOTAL_INVOICE = (Label)gvBuy.Rows[e.RowIndex].FindControl("lblAMOUNT_TOTAL_INVOICE");
            Label lblAMOUNT_TOTAL = (Label)gvBuy.Rows[e.RowIndex].FindControl("lblAMOUNT_TOTAL");
            Label lblAMOUNT_COMPANY_INVOICE = (Label)gvBuy.Rows[e.RowIndex].FindControl("lblAMOUNT_COMPANY_INVOICE");
            TextBox txtRTCInvoice = (TextBox)gvBuy.Rows[e.RowIndex].FindControl("txtRTCInvoice");
            Label lblBUY_SUB_ID = (Label)gvBuy.Rows[e.RowIndex].FindControl("lblBUY_SUB_ID");
            Label lblFX_QTY = (Label)gvBuy.Rows[e.RowIndex].FindControl("lblFX_QTY");
            Label grdLblAMOUNT_DREAM = (Label)gvBuy.Rows[e.RowIndex].FindControl("grdLblAMOUNT_DREAM");

            
            dsBuy.UpdateParameters["RATE_TO_CLIENT_INVOICE"].DefaultValue = txtRTCInvoice.Text;
            var totalAmountInvoice = double.Parse(txtRTCInvoice.Text) * double.Parse(lblFX_QTY.Text);
            var totalCommissionInvoice = double.Parse(lblAMOUNT_TOTAL.Text) - (totalAmountInvoice - double.Parse(grdLblAMOUNT_DREAM.Text));
            dsBuy.UpdateParameters["AMOUNT_TOTAL_INVOICE"].DefaultValue = totalAmountInvoice.ToString();
            dsBuy.UpdateParameters["AMOUNT_COMPANY_INVOICE"].DefaultValue = totalCommissionInvoice.ToString();
            dsBuy.UpdateParameters["BUY_SUB_ID"].DefaultValue = lblBUY_SUB_ID.Text;
            
            try
            {
                var response = dsBuy.Update();
                var select= dsBuy.Select(DataSourceSelectArguments.Empty);
                dsBuy.DataBind();
                gvBuy.DataBind();
            }
            catch
            {

            }
         }

        protected void gvSell_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Label lblAMOUNT_TOTAL_INVOICE = (Label)gvSell.Rows[e.RowIndex].FindControl("lblAMOUNT_TOTAL_INVOICE");
            Label lblAMOUNT_TOTAL = (Label)gvSell.Rows[e.RowIndex].FindControl("lblAMOUNT_TOTAL");
            Label lblAMOUNT_COMPANY_INVOICE = (Label)gvSell.Rows[e.RowIndex].FindControl("lblAMOUNT_COMPANY_INVOICE");
            TextBox txtRTCInvoice = (TextBox)gvSell.Rows[e.RowIndex].FindControl("txtRTCInvoice");
            Label lblBUY_SUB_ID = (Label)gvSell.Rows[e.RowIndex].FindControl("lblBUY_SUB_ID");
            Label lblFX_QTY = (Label)gvSell.Rows[e.RowIndex].FindControl("lblFX_QTY");
            Label grdLblAMOUNT_DREAM = (Label)gvSell.Rows[e.RowIndex].FindControl("grdLblAMOUNT_DREAM");


            dsSell.UpdateParameters["RATE_TO_CLIENT_INVOICE"].DefaultValue = txtRTCInvoice.Text;
            var totalAmountInvoice = double.Parse(txtRTCInvoice.Text) * double.Parse(lblFX_QTY.Text);
            var totalCommissionInvoice = double.Parse(lblAMOUNT_TOTAL.Text) - (totalAmountInvoice - double.Parse(grdLblAMOUNT_DREAM.Text));
            dsSell.UpdateParameters["AMOUNT_TOTAL_INVOICE"].DefaultValue = totalAmountInvoice.ToString();
            dsSell.UpdateParameters["AMOUNT_COMPANY_INVOICE"].DefaultValue = totalCommissionInvoice.ToString();
            dsSell.UpdateParameters["BUY_SUB_ID"].DefaultValue = lblBUY_SUB_ID.Text;

            try
            {
                var response = dsSell.Update();
                var select = dsSell.Select(DataSourceSelectArguments.Empty);
                dsSell.DataBind();
                gvSell.DataBind();
            }
            catch
            {

            }
        }


        protected void OnBuyRowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBuy.EditIndex = e.NewEditIndex;
            gvBuy.DataBind();
        }

        protected void OnSellRowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSell.EditIndex = e.NewEditIndex;
            gvSell.DataBind();
        }

        protected void OnUpdateBuy(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
            
            Label lblAMOUNT_TOTAL_INVOICE = (Label)gvBuy.Rows[row.RowIndex].FindControl("lblAMOUNT_TOTAL_INVOICE");
            Label lblAMOUNT_TOTAL = (Label)gvBuy.Rows[row.RowIndex].FindControl("lblAMOUNT_TOTAL");
            Label lblAMOUNT_COMPANY_INVOICE = (Label)gvBuy.Rows[row.RowIndex].FindControl("lblAMOUNT_COMPANY_INVOICE");
            TextBox txtRTCInvoice = (TextBox)gvBuy.Rows[row.RowIndex].FindControl("txtRTCInvoice");
            Label lblBUY_SUB_ID = (Label)gvBuy.Rows[row.RowIndex].FindControl("lblBUY_SUB_ID");
            Label lblFX_QTY = (Label)gvBuy.Rows[row.RowIndex].FindControl("lblFX_QTY");
            Label grdLblAMOUNT_DREAM = (Label)gvBuy.Rows[row.RowIndex].FindControl("grdLblAMOUNT_DREAM");


            dsBuy.UpdateParameters["RATE_TO_CLIENT_INVOICE"].DefaultValue = txtRTCInvoice.Text;
            var totalAmountInvoice = double.Parse(txtRTCInvoice.Text) * double.Parse(lblFX_QTY.Text);
            var totalCommissionInvoice = double.Parse(lblAMOUNT_TOTAL.Text) - (totalAmountInvoice - double.Parse(grdLblAMOUNT_DREAM.Text));
            dsBuy.UpdateParameters["AMOUNT_TOTAL_INVOICE"].DefaultValue = totalAmountInvoice.ToString();
            dsBuy.UpdateParameters["AMOUNT_COMPANY_INVOICE"].DefaultValue = totalCommissionInvoice.ToString();
            dsBuy.UpdateParameters["BUY_SUB_ID"].DefaultValue = lblBUY_SUB_ID.Text;

            try
            {
                var response = dsBuy.Update();
                var select = dsBuy.Select(DataSourceSelectArguments.Empty);
                dsBuy.DataBind();
                gvBuy.DataBind();
            }
            catch
            {

            }
            gvBuy.EditIndex = -1;
            gvBuy.DataBind();
        }

        protected void OnUpdateSell(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;

            Label lblAMOUNT_TOTAL_INVOICE = (Label)gvSell.Rows[row.RowIndex].FindControl("lblAMOUNT_TOTAL_INVOICE");
            Label lblAMOUNT_TOTAL = (Label)gvSell.Rows[row.RowIndex].FindControl("lblAMOUNT_TOTAL");
            Label lblAMOUNT_COMPANY_INVOICE = (Label)gvSell.Rows[row.RowIndex].FindControl("lblAMOUNT_COMPANY_INVOICE");
            TextBox txtRTCInvoice = (TextBox)gvSell.Rows[row.RowIndex].FindControl("txtRTCInvoice");
            Label lblSELL_SUB_ID = (Label)gvSell.Rows[row.RowIndex].FindControl("lblSELL_SUB_ID");
            Label lblFX_QTY = (Label)gvSell.Rows[row.RowIndex].FindControl("lblFX_QTY");
            Label grdLblAMOUNT_DREAM = (Label)gvSell.Rows[row.RowIndex].FindControl("grdLblAMOUNT_DREAM");


            dsSell.UpdateParameters["RATE_TO_CLIENT_INVOICE"].DefaultValue = txtRTCInvoice.Text;
            var totalAmountInvoice = double.Parse(txtRTCInvoice.Text) * double.Parse(lblFX_QTY.Text);
            var totalCommissionInvoice = double.Parse(lblAMOUNT_TOTAL.Text) - (totalAmountInvoice - double.Parse(grdLblAMOUNT_DREAM.Text));
            dsSell.UpdateParameters["AMOUNT_TOTAL_INVOICE"].DefaultValue = totalAmountInvoice.ToString();
            dsSell.UpdateParameters["AMOUNT_COMPANY_INVOICE"].DefaultValue = totalCommissionInvoice.ToString();
            dsSell.UpdateParameters["SELL_SUB_ID"].DefaultValue = lblSELL_SUB_ID.Text;

            try
            {
                var response = dsSell.Update();
                var select = dsSell.Select(DataSourceSelectArguments.Empty);
                dsSell.DataBind();
                gvSell.DataBind();
            }
            catch
            {

            }
            gvSell.EditIndex = -1;
            gvSell.DataBind();
        }

        protected void OnCancelBuy(object sender, EventArgs e)
        {
            gvBuy.EditIndex = -1;
            gvBuy.DataBind();
        }

        protected void OnCancelSell(object sender, EventArgs e)
        {
            gvSell.EditIndex = -1;
            gvSell.DataBind();
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

        protected void lbtnSellLoginId_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            Session["iLoginId"] = btn.CommandArgument;
            Session["iBookingNo"] = btn.Text;
            Response.Redirect("InvoiceSell_Pre.aspx");
        }

        protected void lnkGrdBuy_Command(object sender, CommandEventArgs e)
        {

        }
        
        protected void gvBuy_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Checking the RowType of the Row  
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index= e.Row.RowIndex;
                
                Label lblInvoice = e.Row.FindControl("lblINVOICE_ID") as Label;
                LinkButton editBtn = (LinkButton)e.Row.FindControl("lnkBtnEditBuy");
                if (lblInvoice.Text != "")
                {
                    editBtn.Visible = false;
                }
               
            }
        }

        protected void gvSell_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Checking the RowType of the Row  
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index = e.Row.RowIndex;

                Label lblInvoice = e.Row.FindControl("lblINVOICE_ID") as Label;
                LinkButton editBtn = (LinkButton)e.Row.FindControl("lnkBtnEditSell");
                if (lblInvoice.Text != "")
                {
                    editBtn.Visible = false;
                }
            }
        }
    }
}