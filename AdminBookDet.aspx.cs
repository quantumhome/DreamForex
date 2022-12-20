using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class AdminBookDet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util ut = new Util();
            ut.checAdminSession(this.Page);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt = null;
            string strTable = DropDownList1.SelectedItem.Text;

            string constring = ConfigurationManager.ConnectionStrings["FOREXConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("AdminBuy", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@p_table", strTable);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        dt = new DataTable();
                        sda.Fill(dt);
                    }
                }
            }
            GridView1.DataSource = dt;

            GridView1.DataBind();
            GridView1.Visible = true;
        }
    }
}