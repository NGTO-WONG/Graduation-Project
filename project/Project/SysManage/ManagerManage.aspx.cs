using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project.SysManage
{
    public partial class ManagerManage : ManagerBase
    {
        protected int PageSize = 12;
        protected int PageCount;
        protected int RecordCount;
        protected int CurrentPage;//当前页
        protected int get_grade;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_grade = Common.RequestInt("grade");
            if (!IsPostBack)
            {
                Get_Data();
            }
        }

        private void Get_Data()
        {
            string where = "grade=" + get_grade;
            if (!string.IsNullOrEmpty(txtKey.Text.Trim()))
                where += " and (ManagerName like '%" + txtKey.Text.Trim() + "%' or Title like '%" + txtKey.Text.Trim() + "%')";

            DataTable dt = DB.GetListByPage("Manager", "Id", where, "Id", 1, 1, 1, out PageCount, out RecordCount);
            if (dt.Rows.Count > 0)
            {
                CurrentPage = PagingHelper.getPage(PageCount);//当前页
                rptList.DataSource = DB.GetListByPage("Manager", "*", where, "Id", 1, PageSize, CurrentPage, out PageCount, out RecordCount);
                rptList.DataBind();
                ltlNull.Text = "";
            }
            else
            {
                rptList.DataSource = string.Empty;
                rptList.DataBind();
                ltlNull.Text = "<tr><td>暂无数据</td></tr>";
            }

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

        /// <summary>
        /// 列表绑定事件
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                if (DB.ExecuteSql("delete from Manager where Id=" + e.CommandArgument.ToString()) >= 0)
                {
                    Common.ShowMessage(Page, "删除成功！", "", Request.Url.AbsoluteUri);
                }
                else
                {
                    Common.ShowMessage(Page, "删除失败！", "");
                }
            }
        }


    }
}