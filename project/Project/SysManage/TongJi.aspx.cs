using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project.SysManage
{
    public partial class TongJi : ManagerBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtTime1.Text = DateTime.Now.ToString("yyyy-MM-01");
                txtTime2.Text = DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");

                Get_Data();
            }
        }

        private void Get_Data()
        {
            var sql = @"select xm,COUNT(0) num,SUM(je) price
from ShuJu
where {0}
group by xm";

            if (!string.IsNullOrEmpty(txtTime1.Text) && !string.IsNullOrEmpty(txtTime2.Text))
                sql = string.Format(sql, "CAST(sj as datetime) between CAST('" + txtTime1.Text + "' as datetime) and CAST('" + txtTime2.Text + "' as datetime)");
            else
                sql = string.Format(sql, "1=1");

            DataTable dt = DB.getDataTable(sql);
            rptList.DataSource = dt;
            rptList.DataBind();

            dt.Dispose();
        }

        /// <summary>
        /// 搜索事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Get_Data();
        }


    }
}