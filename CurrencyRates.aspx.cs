using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace DreamForex
{
    public partial class _CurrRates : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.UseAccessibleHeader = true;
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
            //https://fcsapi.com/api-v3/forex/latest?symbol=all_forex&access_key=0Rb7s7UjLFFma9CY9LRFT
            //    var settings = new JsonSerializerSettings(); 
            //settings.CheckAdditionalContent = false;
            //string json = (new WebClient()).DownloadString("https://fcsapi.com/api-v3/forex/latest?symbol=all_forex&access_key=0Rb7s7UjLFFma9CY9LRFT");

            //********************************
            // For Currency Rates
            //string json = (new WebClient()).DownloadString("https://api.fastforex.io/fetch-all?api_key=211262507c-d35094e5e0-r9i0oc");

            // for Currency Names
            //string json = (new WebClient()).DownloadString("https://api.fastforex.io/currencies?api_key=211262507c-d35094e5e0-r9i0oc");

            //*******************************************

            string json = (new WebClient()).DownloadString("https://api.exchangerate.host/latest?base=USD&symbols=AED,AUD,BHD,BND,CAD,CHF,CNY,DKK,EUR,GBP,HKD,IDR,IEP,INR,JPY,KRW,KWD,LKR,MUR,MVR,MYR,NOK,NZD,PHP,RUB,OMR,QAR,SAR,SCP,SEK,SGD,THB,USD,VND,ZAR");


            var rss = JObject.Parse(json);
            //for currency rates
            //var results = ((JObject)rss["results"]);

            var result = rss["success"];
            //lblResult.Text = "Result count = " + result;
            if ((Boolean)result)
            {
                //// Delete Previous Entry
               
                 liveRateDataInsUpd("truncateLive");       
                
                ////*********************
                var rates = rss["rates"];
                string retRate;
                string currCode;
                decimal currRate;

                int found;
                string defaultNumber;
                foreach (var curr in rates)
                {
                    retRate = curr.ToString();
                    currCode = retRate.Substring(1, 3);
                    found = retRate.IndexOf(":");
                    defaultNumber = retRate.Substring(found + 1).ToString(); //9E-05

                    currRate = decimal.Parse(defaultNumber, System.Globalization.NumberStyles.Float);
                    //lblResult.Text += currCode + " = " + currRate + "<br/>";

                    dsLiveRate.InsertParameters["CURR_CODE"].DefaultValue = currCode;
                    dsLiveRate.InsertParameters["CURR_RATE"].DefaultValue = currRate.ToString();
                    dsLiveRate.Insert();
                }
            }
            else
            {
                lblResult.Text = "Sorry, Server is down. Please try after sometime..";
            }

            liveRateDataInsUpd("updateINRliveRate");

            GridView1.DataBind();

            ////for Currencies
            //var results = ((JObject)rss["results"]);

            //int i = 0;

            //foreach(var curr in results)
            //{
            //    lblResult.Text += i++ + ". " + curr.Key + " : " + curr.Value +"<br/>";

            //}
        }

        protected void liveRateDataInsUpd(string sp)
        {
            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand(sp, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

        }
    }






}