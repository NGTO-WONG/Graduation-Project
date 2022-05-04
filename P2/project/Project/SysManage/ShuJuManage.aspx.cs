using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;

namespace Project.SysManage
{
    public partial class ShuJuManage : ManagerBase
    {
        protected int PageSize = 12;
        protected int PageCount;
        protected int RecordCount;
        protected int CurrentPage;//当前页
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Get_Data();
            }
        }

        private void Get_Data()
        {
            string where = "1=1";
            if (mbGrade == 2)
                where += " and UserId=" + mbId;

            if (!string.IsNullOrEmpty(txtKey.Text.Trim()))
                where += " and (xm like '%" + txtKey.Text.Trim() + "%' or ren like '%" + txtKey.Text.Trim() + "%' or demo like '%" + txtKey.Text.Trim() + "%')";

            DataTable dt = DB.GetListByPage("ShuJu", "Id", where, "Id", 1, 1, 1, out PageCount, out RecordCount);
            if (dt.Rows.Count > 0)
            {
                CurrentPage = PagingHelper.getPage(PageCount);//当前页
                rptList.DataSource = DB.GetListByPage("ShuJu", @"*,
            CAST(
            (SELECT COUNT(0)
            FROM dbo.ShuJu_Detail
            WITH(NOLOCK)
            WHERE ShuJu.Id = ShuJu_Detail.Id
            AND ShuJu_Detail.state = '不同意') AS VARCHAR(10)) + '/' + CAST(
            (SELECT COUNT(0)
            FROM dbo.ShuJu_Detail
            WITH(NOLOCK)
            WHERE ShuJu.Id = ShuJu_Detail.Id

            AND ShuJu_Detail.state = '同意') AS VARCHAR(10)) AS result", where, "Id", 1, PageSize, CurrentPage, out PageCount, out RecordCount);
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
                if (DB.ExecuteSql("delete from ShuJu where Id=" + e.CommandArgument.ToString()) >= 0)
                {
                    Common.ShowMessage(Page, "删除成功！", "", Request.Url.AbsoluteUri);
                }
                else
                {
                    Common.ShowMessage(Page, "删除失败！", "");
                }
            }
        }
        /// <summary>
        /// 获取费用明细
        /// </summary>
        /// <param name="strJson"></param>
        /// <returns></returns>
        [WebMethod]
        public static string GetItemList(string strJson)
        {
            string sql = "SELECT detailName,detailValue,state FROM dbo.ShuJu_Detail WHERE Id='" + strJson + "'";
            DataTable dt = DB.getDataTable(sql);
            if (dt != null && dt.Rows.Count > 0)
            {
                return JsonConvert.SerializeObject(new
                {
                    code = 0,
                    count = 0,
                    data = dt,
                    error = "",
                });
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    code = 400,
                    count = 0,
                    data = "",
                    error = "",
                });
            }

        }
    }
}