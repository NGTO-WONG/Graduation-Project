using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project
{
    public class PagingHelper
    {
        public PagingHelper()
        { }
        //HomePageInfo
        //EndPageInfo
        //PrevPageInfo
        //NextPageInfo

        #region 获取当前有效页次
        /// <summary>
        /// 获取当前有效页次
        /// </summary>
        /// <param name="PageCount"></param>
        /// <returns></returns>
        public static int getPage(int PageCount)
        {
            int i = 1;
            try
            {
                i = Common.RequestInt("page");
            }
            catch
            {

                System.Web.HttpContext.Current.Response.Write("<script>alert('参数错误！');history.go(-1);</script>");
                System.Web.HttpContext.Current.Response.End();
            }

            if (i > PageCount)
            {
                i = PageCount;
            }
            if (i < 1)
            {
                i = 1;
            }

            return i;
        }
        #endregion


        #region 获得页数字符串
        /// <summary>
        /// 获得页数字符串
        /// </summary>
        /// <param name="currentPage">当前页</param>
        /// <param name="PageCount">总页数</param>
        /// <param name="link">URL条件(如：&amp;Type=1)</param>
        /// <param name="HomePageInfo">首页标识</param>
        /// <param name="PrevPageInfo">上一页标识</param>
        /// <param name="NextPageInfo">下一页标识</param>
        /// <param name="EndPageInfo">末页标识</param>
        /// <returns></returns>
        public static string getPageStr(int currentPage, int PageCount, string link)
        {
            string refile = HttpContext.Current.Request.Url.AbsolutePath;

            string PrevPageInfo = "<i class=\"icon-double-angle-left\"></i>";
            string NextPageInfo = "<i class=\"icon-double-angle-right\"></i>";

            string str = "";
            if (currentPage == 1)
            {
                //str = str + "<li><a>" + HomePageInfo + "</a></li><li><a>" + PrevPageInfo + "</a></li>";
                str = str + "<li class=\"prev disabled\"><a>" + PrevPageInfo + "</a></li>";
            }
            else
            {
                //str = str + "<li><a href=" + refile + "?page=1" + link + ">" + HomePageInfo + "</a></li><li><a href=?page=" + (currentPage - 1) + "" + link + ">" + PrevPageInfo + "</a></li>";
                str = str + "<li class=\"prev\"><a class=\"prevPage\" href=" + refile + "?page=" + (currentPage - 1) + "" + link + ">" + PrevPageInfo + "</a></li>";
            }

            //数字字符串开始
            int startPage = 1;
            int endPage = 1;
            if ((currentPage + 8) >= PageCount)
            {
                endPage = PageCount;
            }
            else if (currentPage == 1)
            {
                endPage = 10;
            }
            else
            {
                endPage = currentPage + 8;
            }
            if (currentPage > PageCount - 9)
            {
                startPage = PageCount - 9;
            }
            else
            {
                startPage = currentPage - 1;
            }
            if (startPage < 1)
                startPage = 1;
            if (endPage > PageCount)
                endPage = PageCount;

            for (int n = startPage; n <= endPage; n++)
            {
                if (n == currentPage)
                {
                    str = str + "<li class=\"active\"><a>" + n.ToString() + "</a></li>";
                }
                else
                {
                    str = str + "<li><a href='" + refile + "?page=" + n + "" + link + "'>" + n.ToString() + "</a></li>";
                }
            }
            //末页
            //str = str + "...<a href='?page=" + PageCount + "" + link + "'>[" + PageCount + "]</a>";
            //数字字符串结束
            if (currentPage == PageCount)
            {
                //str = str + "<li><a>" + NextPageInfo + "</a></li><li><a>" + EndPageInfo + "</a></li>";
                str = str + "<li class=\"next disabled\"><a>" + NextPageInfo + "</a></li>";
            }
            else
            {
                //str = str + "<li><a href=?page=" + (currentPage + 1) + "" + link + ">" + NextPageInfo + "</a></li><li><a href=?page=" + PageCount + "" + link + ">" + EndPageInfo + "</a></li>";
                str = str + "<li class=\"next\"><a class=\"nextPage\" href=" + refile + "?page=" + (currentPage + 1) + "" + link + ">" + NextPageInfo + "</a></li>";
            }

            return str;
        }
        #endregion

    }
}