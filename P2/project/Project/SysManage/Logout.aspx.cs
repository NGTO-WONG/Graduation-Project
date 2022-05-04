using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.SysManage
{
    public partial class Logout : ManagerBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["logininfo"];
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now.AddDays(-1);
                cookie.Values.Clear();
                System.Web.HttpContext.Current.Response.Cookies.Set(cookie);
                //Response.Redirect("login.aspx?grade=" + mbGrade);
                Response.Redirect("/index.aspx");
            }
        }
    }
}