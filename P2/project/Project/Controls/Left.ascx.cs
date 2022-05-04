using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.Controls
{
    public partial class Left : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// 获取数据
        /// </summary>
        private void BindData()
        {
            rptListFenLei.DataSource = DB.getDataTable("select * from FenLei");
            rptListFenLei.DataBind();

            rptListPro.DataSource = DB.getDataTable("select top 5 * from Product where State='通过' order by newid()");
            rptListPro.DataBind();
        }
    }
}