using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project
{
    /// <summary>
    /// 登录用户基类
    /// </summary>
    public class ManagerBase : System.Web.UI.Page
    {
        public int mbId;
        public string mbUserName;
        public string mbTrueName;
        public int mbGrade;

        public ManagerBase()
        {
            if (HttpContext.Current.Request.Cookies["logininfo"] != null)
            {
                mbId = Convert.ToInt32(HttpContext.Current.Request.Cookies["logininfo"]["Id"]);
                mbUserName = HttpContext.Current.Server.UrlDecode(HttpContext.Current.Request.Cookies["logininfo"]["Manager"]);
                mbTrueName = HttpContext.Current.Server.UrlDecode(HttpContext.Current.Request.Cookies["logininfo"]["TrueName"]);
                mbGrade = Convert.ToInt32(HttpContext.Current.Request.Cookies["logininfo"]["Grade"]);
            }
            else
            {
                HttpContext.Current.Response.Write("<script type='text/javascript'>alert('请先登录。');this.top.location.href= '/SysManage/Login.aspx?grade=1';</script>");
                HttpContext.Current.Response.End();
            }
        }

    }
}