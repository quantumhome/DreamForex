using Humanizer;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class InvoiceSellDetails : System.Web.UI.Page
    {
        string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Util ut = new Util();
            ut.checAdminSession(this.Page);

            if (Session["iLoginId"] != null)
            {
                string wName = string.Empty, wMobile = string.Empty, wEmail = string.Empty;
                DataView dv = (DataView)(dsUser1.Select(DataSourceSelectArguments.Empty));
                if (dv != null)
                {
                    wName = dv.Table.Rows[0]["MEM_NAME"].ToString();
                    wMobile = dv.Table.Rows[0]["MOBILENO"].ToString();
                    wEmail = dv.Table.Rows[0]["EMAILID"].ToString();
                    lblUserDet.Text = "Name : <b>" + wName + "</b>, Mobile No. : <b>" + wMobile + "</b>, Email : <b>" + wEmail + "</b>";
                  
                   
                }
                if (!Page.IsPostBack)
                {
                    DataView dvMem = (DataView)(dsUser2.Select(DataSourceSelectArguments.Empty));
                    if (dvMem.Count > 0)// == null)
                    {
                        panelForm.Visible = true;
                        name.Text = dvMem.Table.Rows[0]["MEM_NAME"].ToString();
                        mobile.Text = dvMem.Table.Rows[0]["MEM_MOBILE"].ToString();
                        email.Text = dvMem.Table.Rows[0]["MEM_EMAIL"].ToString();
                        Session["MEMBER_ID"] = dvMem.Table.Rows[0]["MEMBER_ID"].ToString();
                        if (dvMem.Table.Rows[0]["MEM_GENDER"].ToString() == "Male")
                        {
                            rblGender.SelectedValue = "M";
                        }
                        else if (dvMem.Table.Rows[0]["MEM_GENDER"].ToString() == "FeMale")
                        {
                            rblGender.SelectedValue = "F";
                        }
                        else
                        {
                            rblGender.SelectedValue = "O";
                        }

                        ddlCountry.SelectedValue = dvMem.Table.Rows[0]["COUNTRY_ID"].ToString();
                        ddlState.SelectedValue = dvMem.Table.Rows[0]["STATE_ID"].ToString();
                        ddlCity.SelectedValue = dvMem.Table.Rows[0]["CITY_ID"].ToString();
                        txtPin.Text = dvMem.Table.Rows[0]["PIN"].ToString();
                        txtPan.Text = dvMem.Table.Rows[0]["PAN_NO"].ToString();
                        txtPassport.Text = dvMem.Table.Rows[0]["PASSPORT_NO"].ToString();
                        txtAdd1.Text = dvMem.Table.Rows[0]["MEM_ADD1"].ToString();
                        txtAdd2.Text = dvMem.Table.Rows[0]["MEM_ADD2"].ToString();
                    }
                }
               
                DataView dvInvoiceVsBooking = (DataView)(dsInvoiceVsBooking.Select(DataSourceSelectArguments.Empty));
                if (dvInvoiceVsBooking != null && dvInvoiceVsBooking.Table.Rows.Count > 0)
                {
                    txtInvoiceSerialNumber.Text = dvInvoiceVsBooking.Table.Rows[0]["INVOICE_SERIAL_NO"].ToString();
                  
                    GenerateInvoice();
                    ModalPopupExtender1.Show();
                    btnMember.Enabled = false;
                }
                DataView dvInvoice = (DataView)(ds_Invoice.Select(DataSourceSelectArguments.Empty));
                if (dvInvoice != null && dvInvoice.Table.Rows.Count > 0)
                {
                    int max_Invoice_Sno = int.Parse(dvInvoice.Table.Rows[0]["INVOICE_SERIAL_NO"].ToString()) + 1;
                    txtInvoiceSerialNumber.Text = max_Invoice_Sno.ToString();
                }
                else
                {
                    txtInvoiceSerialNumber.Text = "1";
                }

                DataView dsBookingBuyDetails = (DataView)(dsBookingSell.Select(DataSourceSelectArguments.Empty));
                if (dsBookingBuyDetails != null && dsBookingBuyDetails.Table.Rows.Count > 0)
                {
                    if (dsBookingBuyDetails.Table.Rows[0]["ProceedTo"].ToString() != "")
                    {
                        var selectedText = dsBookingBuyDetails.Table.Rows[0]["ProceedTo"].ToString();
                        DataView dsCountryDetails = (DataView)(dsCountry.Select(DataSourceSelectArguments.Empty));
                     
                        dsCountryDetails.RowFilter = "COUNTRY_NAME = '" + selectedText + "'";
                        var values = dsCountryDetails.Table.Rows[0]["COUNTRY_ID"].ToString();
                        ddlProceedTo.SelectedValue = values;
                    }
                }


            }
            else
            {
                Session.RemoveAll();
                Session.Abandon();
                Response.Redirect("AdminHome.aspx");
            }
        }

        protected void btnMember_Click(object sender, EventArgs e)
        {
            string panFilename = DateTime.Now.ToString("yyyyMMddHHmmssffff") + "_" + fupPan.FileName;
            string ppFilename = DateTime.Now.ToString("yyyyMMddHHmmssffff") + "_" + fupPassport.FileName;
            dsUser2.UpdateParameters["LOGIN_ID"].DefaultValue = Session["iLoginId"].ToString();
            dsUser2.UpdateParameters["MEM_NAME"].DefaultValue = name.Text;
            if(rblGender.SelectedValue == "M")
            {
              dsUser2.UpdateParameters["MEM_GENDER"].DefaultValue = "Male";
            }
            else if (rblGender.SelectedValue == "F")
            {
              dsUser2.UpdateParameters["MEM_GENDER"].DefaultValue = "Female";
            }
            else
            {
                dsUser2.UpdateParameters["MEM_GENDER"].DefaultValue = "Others";
            }
            dsUser2.UpdateParameters["MEM_MOBILE"].DefaultValue = mobile.Text;
            dsUser2.UpdateParameters["MEM_EMAIL"].DefaultValue = email.Text;
            dsUser2.UpdateParameters["MEM_ADD1"].DefaultValue = txtAdd1.Text;
            dsUser2.UpdateParameters["MEM_ADD2"].DefaultValue = txtAdd2.Text;
            dsUser2.UpdateParameters["STATE_ID"].DefaultValue = ddlState.SelectedValue;
            dsUser2.UpdateParameters["CITY_ID"].DefaultValue = ddlCity.SelectedValue;
            dsUser2.UpdateParameters["PIN"].DefaultValue = txtPin.Text;
            dsUser2.UpdateParameters["PAN_NO"].DefaultValue = txtPan.Text;
            dsUser2.UpdateParameters["PAN_FILE_NAME"].DefaultValue = panFilename;
            dsUser2.UpdateParameters["PASSPORT_NO"].DefaultValue = txtPassport.Text;
            dsUser2.UpdateParameters["PASSPORT_FILE_NAME"].DefaultValue = ppFilename;
            dsUser2.UpdateParameters["COUNTRY_ID"].DefaultValue = ddlCountry.SelectedValue;
            dsUser2.UpdateParameters["MEMBER_ID"].DefaultValue = Session["MEMBER_ID"].ToString();
            try
            {
                var response=  dsUser2.Update();
                lblResult.Text = "User Details Saved Successfully";
                //*-*-*-*-*-*-*-*-*-*-*
                //name.Text = "";
                //rblGender.SelectedIndex = 0;
                //mobile.Text = "";
                //email.Text = "";
                //txtAdd1.Text = "";
                //txtAdd2.Text = "";
                //ddlState.SelectedIndex = 0;
                //ddlCity.SelectedIndex = 0;
                //txtPin.Text = "";
                //txtPan.Text = "";
                //panFilename = "";
                //txtPassport.Text = "";
                //ppFilename = "";
                //ddlCountry.SelectedIndex = 0;

                //*-*-*-*-*-*-*-*-*-*-*
                try
                {
                    string folderPath = Server.MapPath("~/PAN_Images/");
                    fupPan.SaveAs(folderPath + DateTime.Now.ToString("yyyyMMddHHmmssffff") + "_" + fupPan.FileName);
                    lblResult.Text += "<br>PAN Image saved";

                }
                catch (Exception)
                {
                    lblResult.Text += "<br>PAN Image NOT saved";
                }

                try
                {
                    string folderPathPP = Server.MapPath("~/PP_Images/");
                    fupPassport.SaveAs(folderPathPP + DateTime.Now.ToString("yyyyMMddHHmmssffff") + "_" + fupPassport.FileName);

                    lblResult.Text += "<br>Passport Image saved";
                }
                catch (Exception)
                {
                    lblResult.Text += "<br>Passport Image NOT saved";
                }

            }
            catch (Exception ex)
            {
                lblResult.Text = "Sorry, could not Save.. Try again later..<br />" + ex.ToString();
            }
            SaveInvoiceDetails();
            GenerateInvoice();
            btnMember.Enabled = false;
            ModalPopupExtender1.Show();
        }

        private void SaveInvoiceDetails()
        {
            ds_Invoice.InsertParameters["INVOICE_SERIAL_NO"].DefaultValue = txtInvoiceSerialNumber.Text;
            ds_Invoice.InsertParameters["DT_INVOICE"].DefaultValue = DateTime.Now.ToString();
            ds_Invoice.InsertParameters["BOOKING_NO"].DefaultValue = Session["iBookingNo"].ToString();
            ds_Invoice.InsertParameters["BOOKING_FLAG"].DefaultValue = "T";
            ds_Invoice.InsertParameters["LOGIN_ID"].DefaultValue = Session["iLoginId"].ToString();
            ds_Invoice.InsertParameters["PROCEED_TO"].DefaultValue = ddlProceedTo.SelectedItem.Text;
            var response = ds_Invoice.Insert();
        }

        public void GenerateInvoice()
        {
            DataView dv = (DataView)dsCompany.Select(DataSourceSelectArguments.Empty);
            if (dv.Count > 0)
            {
                lblGSTIN.Text = dv.Table.Rows[0]["GSTIN"].ToString();
                lblRBI.Text = dv.Table.Rows[0]["RBI_LIC_NO"].ToString();
                lblCIN.Text = dv.Table.Rows[0]["CIN"].ToString();
                lblCompName.Text = dv.Table.Rows[0]["COMP_NAME"].ToString();
                lblCompAdd1.Text = dv.Table.Rows[0]["COMP_ADDRESS_1"].ToString();
                lblCompAdd2.Text = dv.Table.Rows[0]["COMP_ADDRESS_2"].ToString();
                //lblStCity.Text = dv.Table.Rows[0]["CITY_NAME"].ToString();
                lblCompState.Text = dv.Table.Rows[0]["STATE_NAME"].ToString();
                //lblPin.Text = dv.Table.Rows[0]["PIN"].ToString();
                //lblPhno.Text = "Phone No. : " + dv.Table.Rows[0]["PHONE"].ToString();
                lblCompEmail.Text = dv.Table.Rows[0]["EMAIL"].ToString();
                lblInvoiceDt.Text = DateTime.Now.Date.ToString("dd-MMM-yyyy");

                //Selected Member Details
                DataView dv1 = (DataView)dsMemberId.Select(DataSourceSelectArguments.Empty);
                if (dv1.Count > 0)
                {
                    lblPartyName.Text = dv1.Table.Rows[0]["MEM_NAME"].ToString();
                    lblPartyAddress.Text = dv1.Table.Rows[0]["MEM_ADD1"].ToString() + ", " + dv1.Table.Rows[0]["MEM_ADD2"].ToString() + ", " + dv1.Table.Rows[0]["CITY_NAME"].ToString() + ", " + dv1.Table.Rows[0]["STATE_NAME"].ToString() + ", " + dv1.Table.Rows[0]["COUNTRY_NAME"].ToString();

                    lblPartyMobile.Text = dv1.Table.Rows[0]["MEM_MOBILE"].ToString();
                    //iTxtEmail.Text = dv1.Table.Rows[0]["MEM_EMAIL"].ToString();
                    //iLblCity.Text = dv1.Table.Rows[0]["CITY_NAME"].ToString();
                    lblPartyState.Text = dv1.Table.Rows[0]["STATE_NAME"].ToString();
                    lblPartyGSTIN.Text = dv1.Table.Rows[0]["PIN"].ToString();
                    //iTxtGstinUin.Text = dv1.Table.Rows[0]["MEM_EMAIL"].ToString();
                    lblPartyNation.Text = dv1.Table.Rows[0]["COUNTRY_NAME"].ToString();
                    //iTxtProceedTo.Text = "";
                    lblPassportNo.Text = dv1.Table.Rows[0]["PASSPORT_NO"].ToString();
                    //iTxtPan.Text = dv1.Table.Rows[0]["PAN_NO"].ToString();

                    //Select data from book table
                    DataView dv2 = (DataView)(dsBookingSell.Select(DataSourceSelectArguments.Empty));
                    if (dv2.Count > 0)
                    {
                        lblCurr.Text = dv2.Table.Rows[0]["CURR_CODE"].ToString();
                        lblRate.Text = dv2.Table.Rows[0]["RATE_TO_CLIENT"].ToString();
                        lblFXNo.Text = dv2.Table.Rows[0]["FX_QTY"].ToString();
                        LblAmount.Text = dv2.Table.Rows[0]["AMOUNT_TOTAL"].ToString();
                        lblProceedToReport.Text = dv2.Table.Rows[0]["ProceedTo"].ToString();
                        double compRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_COMPANY"].ToString());
                        double dreamRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_DREAM"].ToString());
                        for (int i = 1; i < dv2.Count; i++)
                        {
                            HtmlTableRow tRow = new HtmlTableRow();
                            currencyTable.Rows.Add(tRow);
                            tRow.ID = "tr" + i;

                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellCurrent" + i, Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellHSN" + i, Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellFXNo" + i, Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellRate" + i, Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellAmount" + i, Align = "Center" });
                            tRow.Cells[0].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["CURR_CODE"].ToString() });
                            //tRow.Cells[1].Controls.Add(new Label() { CssClass = "disp" , Text = dv2.Table.Rows[i]["FX_QTY"].ToString()});
                            tRow.Cells[2].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["FX_QTY"].ToString() });
                            tRow.Cells[3].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["RATE_TO_CLIENT"].ToString() });
                            tRow.Cells[4].Controls.Add(new Label() { ID = "LblAmount" + i, CssClass = "disp", Text = dv2.Table.Rows[i]["AMOUNT_TOTAL"].ToString() });
                        }

                        if (dv2.Count < 10)
                        {
                            var rowsRequired = 10 - dv2.Count;
                            for (int i = 0; i < rowsRequired; i++)
                            {
                                HtmlTableRow tRow = new HtmlTableRow();
                                currencyTable.Rows.Add(tRow);
                                tRow.ID = "trBlank" + i;
                                tRow.Controls.Add(new HtmlTableCell() { InnerHtml = "&nbsp;" });
                                tRow.Controls.Add(new HtmlTableCell() { InnerHtml = "&nbsp;" });
                                tRow.Controls.Add(new HtmlTableCell() { InnerHtml = "&nbsp;" });
                                tRow.Controls.Add(new HtmlTableCell() { InnerHtml = "&nbsp;" });
                                tRow.Controls.Add(new HtmlTableCell() { InnerHtml = "&nbsp;" });
                            }

                        }

                        //for (int i=0; i<dv2.Count; i++)
                        //{
                        //    HtmlTableRow row = currencyTable.Rows[i];
                        //    //dr = dt.NewRow();
                        //    //dr["ProductID"] = row.Cells[0].Controls[0];
                        //    //dr["Quantity"] = row.Cells[2].Controls[0];
                        //    //dr["Price"] = row.Cells[3].Controls[0];
                        //    //dt.Rows.Add(dr);
                        //}
                    }

                    DataView dv3 = (DataView)dsHsn.Select(DataSourceSelectArguments.Empty);
                    if (dv3.Count > 0)
                    {
                        lblHSN.Text = dv3.Table.Rows[0]["HSNCODE"].ToString();

                        lblAmtCGST.Text = "CGST : @ " + dv3.Table.Rows[0]["CGST"].ToString() + " %";
                        lblAmtSGST.Text = "SGST : @ " + dv3.Table.Rows[0]["SGST"].ToString() + " %";
                        lblAmtIGST.Text = "IGST : @ " + dv3.Table.Rows[0]["IGST"].ToString() + " %";

                        int iCgstrate = Convert.ToInt32(dv3.Table.Rows[0]["CGST"].ToString());
                        int iSgstrate = Convert.ToInt32(dv3.Table.Rows[0]["SGST"].ToString());
                        int iIgstrate = Convert.ToInt32(dv3.Table.Rows[0]["IGST"].ToString());

                        double iCgstAmt = 0, iSgstAmt = 0, iIgstAmt = 0;
                        double wRs = 0;
                        foreach (Control ctr in currencyTable.Controls)
                        {
                            if (ctr is HtmlTableRow)
                            {
                                foreach (Control td in ctr.Controls)
                                {
                                    if (td is HtmlTableCell)
                                    {
                                        foreach (Control lblAmounts in td.Controls)
                                        {
                                            if (lblAmounts is Label)
                                            {
                                                if (lblAmounts.ID != null && lblAmounts.ID.Contains("LblAmount"))
                                                {
                                                    var amount = (Label)lblAmounts;
                                                    wRs += Math.Round(Convert.ToDouble(amount.Text));
                                                }
                                            }
                                            //if(htmlTableCell.HasControls)
                                            //foreach(Control labels in htmlTableCell)
                                            //{
                                            //    if(labels is Label && ctr.ID.Contains("LblAmount"))
                                            //    {

                                            //    }
                                            //}
                                            //if(htmlTableCell is Label && ctr.ID.Contains("LblAmount"))
                                            //{
                                            //    && 
                                            //}
                                        }
                                    }
                                }

                                //wRs += Math.Round(Convert.ToDouble(label.Text));
                            }
                        }

                        //wRs = Math.Round(Convert.ToDouble(LblAmount.Text) * Convert.ToDouble(lblRate.Text));
                       
                        //GST Calculation

                        if (lblCompState.Text == lblPartyState.Text) // CGST, SGST
                        {
                            if (wRs <= 25000)
                            {
                                iCgstAmt = 45;
                                iSgstAmt = iCgstAmt;
                            }
                            if (wRs > 25000 && wRs <= 100000)
                            {
                                iCgstAmt = Math.Round((wRs * iCgstrate) / 100);
                                iSgstAmt = iCgstAmt;
                            }
                            if (wRs > 100000 && wRs <= 1000000)
                            {
                                iCgstAmt = 180 + Math.Round(((wRs - 100000) * iCgstrate) / 100);
                                iSgstAmt = iCgstAmt;
                            }
                            if (wRs > 1000000)
                            {
                                iCgstAmt = 990 + Math.Round(((wRs - 1000000) * iCgstrate) / 100);
                                iSgstAmt = iCgstAmt;
                            }
                        }
                        else // IGST
                        {
                            if (wRs <= 25000)
                            {
                                iIgstAmt = 45;
                            }
                            if (wRs > 25000 && wRs <= 100000)
                            {
                                iIgstAmt = Math.Round((wRs * iIgstrate) / 100);
                            }
                            if (wRs > 100000 && wRs <= 1000000)
                            {
                                iIgstAmt = 180 + Math.Round(((wRs - 100000) * iIgstrate) / 100);
                            }
                            if (wRs > 1000000)
                            {
                                iIgstAmt = 990 + Math.Round(((wRs - 1000000) * iIgstrate) / 100);
                            }
                        }

                        //****************

                        //iCgstAmt = (iCgstAmt) / 100;
                        //iSgstAmt = (iSgstAmt) / 100;
                        //iIgstAmt = (iIgstAmt) / 100;

                        lblAmtCGST.Text = iCgstAmt.ToString();
                        lblAmtSGST.Text = iSgstAmt.ToString();
                        lblAmtIGST.Text = iIgstAmt.ToString();
                        lblAmtTotal.Text = (wRs + iCgstAmt + iSgstAmt + iIgstAmt).ToString();
                        lblAmtWords.Text = Convert.ToInt32(wRs).ToWords();
                        //*-*-*-*-*-*-*-*-*-*
                    }
                    // *-*-*-*-*-*-*-*-*-*-*-*-*
                }
            }
            else
            {
                // mLblResult.Text = "Please fill up Company Details";
            }
            
                lblInvoiceNo.Text = txtInvoiceSerialNumber.Text;
            //}
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/InvoiceSell_Pre.aspx");
        }
    }
}