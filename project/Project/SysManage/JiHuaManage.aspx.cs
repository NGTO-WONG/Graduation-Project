﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project.SysManage
{
    public partial class JiHuaManage : ManagerBase
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
            if (mbGrade == 3)
                where += " and UserId=" + mbId;

            if (!string.IsNullOrEmpty(txtKey.Text.Trim()))
                where += " and (xm like '%" + txtKey.Text.Trim() + "%' or ren like '%" + txtKey.Text.Trim() + "%' or demo like '%" + txtKey.Text.Trim() + "%')";

            DataTable dt = DB.GetListByPage("JiHua", "Id", where, "Id", 1, 1, 1, out PageCount, out RecordCount);
            if (dt.Rows.Count > 0)
            {
                CurrentPage = PagingHelper.getPage(PageCount);//当前页
                rptList.DataSource = DB.GetListByPage("JiHua", "*", where, "Id", 1, PageSize, CurrentPage, out PageCount, out RecordCount);
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
                if (DB.ExecuteSql("delete from JiHua where Id=" + e.CommandArgument.ToString()) >= 0)
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