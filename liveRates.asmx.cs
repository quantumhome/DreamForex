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
    /// Summary description for liveRates1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    //// [System.Web.Script.Services.ScriptService]
    public class liveRates1 : System.Web.Services.WebService
    {

        [WebMethod]
        public void getLiveRate(string currCode)
        {
            decimal currRate;
            string cs = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("getRate", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@currCode",
                    Value = currCode
                });

                con.Open();
                currRate =Convert.ToDecimal(cmd.ExecuteScalar());
            }

            //Registration regsitration = new Registration();
            liveRates lvRate = new liveRates();
            lvRate.currCode = currCode;
            //regsitration.UserName = userName;

            //regsitration.UserNameInUse = userNameInUse;
            lvRate.currRate = currRate;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lvRate));
        }
    }
}
