using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DreamForex
{
    /// <summary>
    /// Summary description for RegistrationService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class RegistrationService : System.Web.Services.WebService
    {

        [WebMethod]
        public void UserNameExists(string userName)
        {
            bool userNameInUse = false;

            string cs = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("CheckUserAvailability", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@UserName",
                    Value = userName
                });

                con.Open();
                userNameInUse = Convert.ToBoolean(cmd.ExecuteScalar());
            }

            Registration regsitration = new Registration();
            regsitration.UserName = userName;
            regsitration.UserNameInUse = userNameInUse;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(regsitration));
        }

        [WebMethod(EnableSession = true)]
        public void GetLiveRate(string pCurrCode,  int prodId, int fxQty)
        {
            double sCurrRate=0;
            double clientComm=0;
            double dreamComm=0;

            double currAmount = 0;
            double clientAmount = 0;
            double dreamAmount = 0;

            double amountToClient = 0;
            double rateToClient = 0;

            string cs = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("getRate", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@currCode",
                    Value = pCurrCode
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@prodId",
                    Value = prodId
                });
                //cmd.Parameters.AddWithValue("@currCode", pCurrCode);
                //cmd.Parameters.AddWithValue("@prodId", prodId);
                //cmd.Parameters.Add("@currExRate", SqlDbType.Float).Direction = ParameterDirection.Output;
                //cmd.Parameters.Add("@clientComm", SqlDbType.Float).Direction = ParameterDirection.Output;
                //cmd.Parameters.Add("@dreamComm", SqlDbType.Float).Direction = ParameterDirection.Output;


                con.Open();
                // sCurrRate = Convert.ToDouble(cmd.ExecuteScalar());
                SqlDataReader rdr = cmd.ExecuteReader();
                
                while (rdr.Read())
                {
                    sCurrRate = Convert.ToDouble(rdr["currExRate"].ToString());
                    clientComm = Convert.ToDouble( rdr["clientComm"].ToString());
                    dreamComm = Convert.ToDouble( rdr["dreamComm"].ToString());
                }
                //sCurrRate = (double)cmd.Parameters["currExRate"].Value;
                // clientComm = (double)cmd.Parameters["@clientComm"].Value;
                // dreamComm = (double)cmd.Parameters["@dreamComm"].Value;
                 currAmount =Math.Round( sCurrRate * fxQty,2);
                 clientAmount = Math.Round( clientComm * fxQty,2);
                 dreamAmount = Math.Round( dreamComm * fxQty,2);

                if (prodId == 1 || prodId == 2) {
                    amountToClient = Math.Round(currAmount + clientAmount + dreamAmount, 0);
                    rateToClient = Math.Round(sCurrRate + clientComm + dreamComm, 2);
                }
                else if (prodId == 3 || prodId == 4)
                {
                    amountToClient = Math.Round(currAmount - clientAmount - dreamAmount, 0);
                    rateToClient = Math.Round(sCurrRate - clientComm - dreamComm, 2);

                }
            }
            
            LiveRate lvRate  = new LiveRate();
            lvRate.CurrCode = pCurrCode;
            lvRate.fxQty = fxQty;
            lvRate.CurrRate = sCurrRate;
            lvRate.clientAmount = clientAmount;
            lvRate.dreamAmount = dreamAmount;
            lvRate.prodId = prodId;
            lvRate.totAmount = amountToClient;
            lvRate.rateToClient = rateToClient;
            lvRate.commClient = clientComm;
            lvRate.commDream = dreamComm;
            //lvRate.orderNo = "1";
            Session["liveRate"] = lvRate;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lvRate));

        }
    }
}
