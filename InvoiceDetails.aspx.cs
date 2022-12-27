using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class InvoiceDetails : System.Web.UI.Page
    {
        string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                //dsUser2.Select("Select * FROM MEMEBER_USER WHERE @MEMBER_ID =1");
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
    }
}