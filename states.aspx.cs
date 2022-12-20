using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DreamForex
{
    public partial class states : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.UseAccessibleHeader = true;
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void cmbState_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbCity.Items.Clear();
            cmbCity.Items.Add(new ListItem("Select City", ""));
            cmbCity.SelectedIndex = 0;
            cmbCity.DataBind();
        }
    }
}