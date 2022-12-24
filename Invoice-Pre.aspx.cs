using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.CompilerServices;
using System.Web.UI.HtmlControls;
using AjaxControlToolkit;
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;

namespace DreamForex
{
    public partial class Invoice_Pre : System.Web.UI.Page
    {
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

                DataView dvMem = (DataView)(dsMember.Select(DataSourceSelectArguments.Empty));
                if (dvMem.Count == 0 )// == null)
                {
                    panelForm.Visible = true;
                    name.Text = wName;
                    mobile.Text = wMobile;
                    email.Text = wEmail;
                    ddlCountry.SelectedValue = "46";
                }
                //if(!Page.IsPostBack)
                //{
                //    if (Session["iBookingNo"] != null && dsBookingBuy != null)
                //    {
                //        ViewState["BookingDetails"] = (DataView)(dsBookingBuy.Select(DataSourceSelectArguments.Empty));
                //    }
                //}

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
            dsUser2.InsertParameters["LOGIN_ID"].DefaultValue = Session["iLoginId"].ToString();
            dsUser2.InsertParameters["MEM_NAME"].DefaultValue = name.Text;
            dsUser2.InsertParameters["MEM_GENDER"].DefaultValue = rblGender.SelectedValue;
            dsUser2.InsertParameters["MEM_MOBILE"].DefaultValue = mobile.Text;
            dsUser2.InsertParameters["MEM_EMAIL"].DefaultValue = email.Text;
            dsUser2.InsertParameters["MEM_ADD1"].DefaultValue = txtAdd1.Text;
            dsUser2.InsertParameters["MEM_ADD2"].DefaultValue = txtAdd2.Text;
            dsUser2.InsertParameters["STATE_ID"].DefaultValue = ddlState.SelectedValue;
            dsUser2.InsertParameters["CITY_ID"].DefaultValue = ddlCity.SelectedValue;
            dsUser2.InsertParameters["PIN"].DefaultValue = txtPin.Text;
            dsUser2.InsertParameters["PAN_NO"].DefaultValue = txtPan.Text;
            dsUser2.InsertParameters["PAN_FILE_NAME"].DefaultValue = panFilename;
            dsUser2.InsertParameters["PASSPORT_NO"].DefaultValue = txtPassport.Text;
            dsUser2.InsertParameters["PASSPORT_FILE_NAME"].DefaultValue = ppFilename;
            dsUser2.InsertParameters["COUNTRY_ID"].DefaultValue = ddlCountry.SelectedValue;
            try
            {
                dsUser2.Insert();
                lblResult.Text = "User Details Saved Successfully";
                //*-*-*-*-*-*-*-*-*-*-*
                name.Text = "";
                rblGender.SelectedIndex = 0;
                mobile.Text = "";
                email.Text = "";
                txtAdd1.Text = "";
                txtAdd2.Text = "";
                ddlState.SelectedIndex = 0;
                ddlCity.SelectedIndex = 0;
                txtPin.Text = "";
                txtPan.Text = "";
                panFilename = "";
                txtPassport.Text = "";
                ppFilename = "";
                ddlCountry.SelectedIndex = 0;

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

        }

        protected void lbtnAddNewMember_Click(object sender, EventArgs e)
        {
            panelForm.Visible = true;
            lblResult.Text = "";
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)dsCompany.Select(DataSourceSelectArguments.Empty);
            if (dv.Count > 0)
            {
                lblGSTIN.Text =  dv.Table.Rows[0]["GSTIN"].ToString();
                lblRBI.Text = dv.Table.Rows[0]["RBI_LIC_NO"].ToString();
                lblCIN.Text =  dv.Table.Rows[0]["CIN"].ToString();
                lblCompName.Text = dv.Table.Rows[0]["COMP_NAME"].ToString();
                lblCompAdd1.Text = dv.Table.Rows[0]["COMP_ADDRESS_1"].ToString();
                lblCompAdd2.Text = dv.Table.Rows[0]["COMP_ADDRESS_2"].ToString();
                //lblStCity.Text = dv.Table.Rows[0]["CITY_NAME"].ToString();
                lblCompState.Text = dv.Table.Rows[0]["STATE_NAME"].ToString();
                //lblPin.Text = dv.Table.Rows[0]["PIN"].ToString();
                //lblPhno.Text = "Phone No. : " + dv.Table.Rows[0]["PHONE"].ToString();
                lblCompEmail.Text =  dv.Table.Rows[0]["EMAIL"].ToString();
                lblInvoiceDt.Text = DateTime.Now.Date.ToString("dd-MMM-yyyy");

                //Selected Member Details
                DataView dv1 = (DataView)dsMemberId.Select(DataSourceSelectArguments.Empty);
                if (dv1.Count > 0)
                {
                    lblPartyName.Text = dv1.Table.Rows[0]["MEM_NAME"].ToString();
                    lblPartyAddress.Text = dv1.Table.Rows[0]["MEM_ADD1"].ToString() + " " + dv1.Table.Rows[0]["MEM_ADD2"].ToString();

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
                    DataView dv2 = (DataView)(dsBookingBuy.Select(DataSourceSelectArguments.Empty));
                    if (dv2.Count > 0)
                    {
                        lblCurr.Text = dv2.Table.Rows[0]["CURR_CODE"].ToString();
                        LblAmount.Text = dv2.Table.Rows[0]["FX_QTY"].ToString();
                        lblRate.Text = dv2.Table.Rows[0]["RATE_TO_CLIENT"].ToString();
                        double compRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_COMPANY"].ToString());
                        double dreamRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_DREAM"].ToString());
                        for(int i= 1; i < dv2.Count; i++)
                        {
                            HtmlTableRow tRow = new HtmlTableRow();
                            currencyTable.Rows.Add(tRow);
                            tRow.ID = "tr" + i;

                            tRow.Controls.Add(new HtmlTableCell () { ID = "CellCurrent" +i , Align= "Center"  });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellHSN" + i , Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellFXNo" + i , Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellRate" + i , Align = "Center" });
                            tRow.Controls.Add(new HtmlTableCell() { ID = "CellAmount" + i , Align = "Center" });
                            tRow.Cells[0].Controls.Add(new Label() { CssClass = "disp" ,  Text = dv2.Table.Rows[i]["CURR_CODE"].ToString() });
                            tRow.Cells[1].Controls.Add(new Label() { CssClass = "disp" , Text = dv2.Table.Rows[i]["FX_QTY"].ToString()});
                            tRow.Cells[2].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["RATE_TO_CLIENT"].ToString() });
                            tRow.Cells[3].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["RATE_TO_CLIENT"].ToString() });
                            tRow.Cells[4].Controls.Add(new Label() { CssClass = "disp", Text = dv2.Table.Rows[i]["RATE_TO_CLIENT"].ToString() });
                        }

                        if(dv2.Count <10)
                        {
                            var rowsRequired = 10- dv2.Count;
                            for(int i=0; i < rowsRequired; i++)
                            {
                                HtmlTableRow tRow = new HtmlTableRow();
                                currencyTable.Rows.Add(tRow);
                                tRow.ID = "trBlank" + i;
                                tRow.Controls.Add(new HtmlTableCell());
                                tRow.Controls.Add(new HtmlTableCell());
                                tRow.Controls.Add(new HtmlTableCell());
                                tRow.Controls.Add(new HtmlTableCell());
                                tRow.Controls.Add(new HtmlTableCell());
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

                        double wRs = Math.Round(Convert.ToDouble(LblAmount.Text) * Convert.ToDouble(lblRate.Text));
                        lblAmtWords.Text = wRs.ToString();

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

                        //double iCgstAmt = (wRs * iCgst) / 100;
                        //double iSgstAmt =  (wRs *  iSgst )/ 100;
                        //double iIgstAmt = (wRs * iIgst )/ 100;

                        lblAmtCGST.Text = iCgstAmt.ToString();
                        lblAmtSGST.Text = iSgstAmt.ToString();
                        lblAmtIGST.Text = iIgstAmt.ToString();
                        lblAmtTotal.Text = (wRs + iCgstAmt + iSgstAmt + iIgstAmt).ToString();
                        //*-*-*-*-*-*-*-*-*-*
                    }
                    // *-*-*-*-*-*-*-*-*-*-*-*-*
                }
            }
            else
            {
               // mLblResult.Text = "Please fill up Company Details";
            }
            //DataView dv = (DataView)dsCompany.Select(DataSourceSelectArguments.Empty);
            //if (dv.Count > 0)
            //{
            //    lblGstin.Text = "GSTIN : " + dv.Table.Rows[0]["GSTIN"].ToString();
            //    lblRbi.Text = dv.Table.Rows[0]["RBI_LIC_NO"].ToString();
            //    lblCin.Text = "CIN : " + dv.Table.Rows[0]["CIN"].ToString();
            //    lblCompanyname.Text = dv.Table.Rows[0]["COMP_NAME"].ToString();
            //    lblAdd1.Text = dv.Table.Rows[0]["COMP_ADDRESS_1"].ToString();
            //    lblAdd2.Text = dv.Table.Rows[0]["COMP_ADDRESS_2"].ToString();
            //    lblStCity.Text = dv.Table.Rows[0]["CITY_NAME"].ToString();
            //    lblCoState.Text = dv.Table.Rows[0]["STATE_NAME"].ToString();
            //    lblPin.Text = dv.Table.Rows[0]["PIN"].ToString();
            //    lblPhno.Text = "Phone No. : " + dv.Table.Rows[0]["PHONE"].ToString();
            //    lblEmail.Text = "eMail : " + dv.Table.Rows[0]["EMAIL"].ToString();
            //    txtInvDt.Text = DateTime.Now.Date.ToString("dd-MMM-yyyy");

            //    //Selected Member Details
            //    DataView dv1 = (DataView)dsMemberId.Select(DataSourceSelectArguments.Empty);
            //    if (dv1.Count > 0)
            //    {
            //        iTxtname.Text = dv1.Table.Rows[0]["MEM_NAME"].ToString();
            //        iTxtAdd1.Text = dv1.Table.Rows[0]["MEM_ADD1"].ToString();
            //        iTxtAdd2.Text = dv1.Table.Rows[0]["MEM_ADD2"].ToString();
            //        iTxtMobile.Text = dv1.Table.Rows[0]["MEM_MOBILE"].ToString();
            //        iTxtEmail.Text = dv1.Table.Rows[0]["MEM_EMAIL"].ToString();
            //        iLblCity.Text = dv1.Table.Rows[0]["CITY_NAME"].ToString();
            //        iLblState.Text = dv1.Table.Rows[0]["STATE_NAME"].ToString();
            //        iTxtPin.Text = dv1.Table.Rows[0]["PIN"].ToString();
            //        //iTxtGstinUin.Text = dv1.Table.Rows[0]["MEM_EMAIL"].ToString();
            //        lblCountry.Text = dv1.Table.Rows[0]["COUNTRY_NAME"].ToString();
            //        //iTxtProceedTo.Text = "";
            //        iTxtPP.Text = dv1.Table.Rows[0]["PASSPORT_NO"].ToString();
            //        iTxtPan.Text = dv1.Table.Rows[0]["PAN_NO"].ToString();

            //        //Select data from book table
            //        DataView dv2 = (DataView)(dsBookingBuy.Select(DataSourceSelectArguments.Empty));
            //        if (dv2.Count > 0)
            //        {
            //            iTxtCurrcode.Text = dv2.Table.Rows[0]["CURR_CODE"].ToString();
            //            iTxtFxAmt.Text = dv2.Table.Rows[0]["FX_QTY"].ToString();
            //            iTxtRate.Text = dv2.Table.Rows[0]["RATE_TO_CLIENT"].ToString();
            //            double compRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_COMPANY"].ToString());
            //            double dreamRate = Convert.ToDouble(dv2.Table.Rows[0]["COMM_DREAM"].ToString());
            //        }

            //        DataView dv3 = (DataView)dsHsn.Select(DataSourceSelectArguments.Empty);
            //        if (dv3.Count > 0)
            //        {
            //            iLblHsn.Text = dv3.Table.Rows[0]["HSNCODE"].ToString();

            //            iLblCgst.Text = "CGST : @ " + dv3.Table.Rows[0]["CGST"].ToString() + " %";
            //            iLblSgst.Text = "SGST : @ " + dv3.Table.Rows[0]["SGST"].ToString() + " %";
            //            iLblIgst.Text = "IGST : @ " + dv3.Table.Rows[0]["IGST"].ToString() + " %";

            //            int iCgstrate = Convert.ToInt32(dv3.Table.Rows[0]["CGST"].ToString());
            //            int iSgstrate = Convert.ToInt32(dv3.Table.Rows[0]["SGST"].ToString());
            //            int iIgstrate = Convert.ToInt32(dv3.Table.Rows[0]["IGST"].ToString());

            //            double iCgstAmt = 0, iSgstAmt = 0, iIgstAmt = 0;

            //            double wRs = Math.Round(Convert.ToDouble(iTxtFxAmt.Text) * Convert.ToDouble(iTxtRate.Text));
            //            iLblValue.Text = wRs.ToString();

            //            //GST Calculation

            //            if (lblCoState.Text == iLblState.Text) // CGST, SGST
            //            {
            //                if (wRs <= 25000)
            //                {
            //                    iCgstAmt = 45;
            //                    iSgstAmt = iCgstAmt;
            //                }
            //                if (wRs > 25000 && wRs <= 100000)
            //                {
            //                    iCgstAmt = Math.Round((wRs * iCgstrate) / 100);
            //                    iSgstAmt = iCgstAmt;
            //                }
            //                if (wRs > 100000 && wRs <= 1000000)
            //                {
            //                    iCgstAmt = 180 + Math.Round(((wRs - 100000) * iCgstrate) / 100);
            //                    iSgstAmt = iCgstAmt;
            //                }
            //                if (wRs > 1000000)
            //                {
            //                    iCgstAmt = 990 + Math.Round(((wRs - 1000000) * iCgstrate) / 100);
            //                    iSgstAmt = iCgstAmt;
            //                }
            //            }
            //            else // IGST
            //            {
            //                if (wRs <= 25000)
            //                {
            //                    iIgstAmt = 45;
            //                }
            //                if (wRs > 25000 && wRs <= 100000)
            //                {
            //                    iIgstAmt = Math.Round((wRs * iIgstrate) / 100);
            //                }
            //                if (wRs > 100000 && wRs <= 1000000)
            //                {
            //                    iIgstAmt = 180 + Math.Round(((wRs - 100000) * iIgstrate) / 100);
            //                }
            //                if (wRs > 1000000)
            //                {
            //                    iIgstAmt = 990 + Math.Round(((wRs - 1000000) * iIgstrate) / 100);
            //                }
            //            }

            //            //****************

            //            //double iCgstAmt = (wRs * iCgst) / 100;
            //            //double iSgstAmt =  (wRs *  iSgst )/ 100;
            //            //double iIgstAmt = (wRs * iIgst )/ 100;

            //            iTxtCgst.Text = iCgstAmt.ToString();
            //            iTxtSgst.Text = iSgstAmt.ToString();
            //            iTxtIgst.Text = iIgstAmt.ToString();
            //            iTxtTotal.Text = (wRs + iCgstAmt + iSgstAmt + iIgstAmt).ToString();
            //            //*-*-*-*-*-*-*-*-*-*
            //        }
            //        // *-*-*-*-*-*-*-*-*-*-*-*-*
            //    }
            //}
            //else
            //{
            //    mLblResult.Text = "Please fill up Company Details";
            //}
            ModalPopupExtender1.Show();
        }
    }
}