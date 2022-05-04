using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.SysManage
{
    public partial class EditPwd : ManagerBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["logininfo"] != null)
                {
                    if (Request.Cookies["logininfo"]["Manager"] != null)
                    {
                        ltlLoginName.Text = HttpUtility.UrlDecode(Request.Cookies["logininfo"]["Manager"].ToString());
                    }
                    else
                    {
                        Response.Redirect("login.aspx");
                    }
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string pwd_old = OldPwd.Value.Trim();
            string pwd_new = NewPwd.Value.Trim();
            bool bl = DB.isExists("select * from Manager where ManagerName='" + ltlLoginName.Text.Trim() + "' and ManagerPwd='" + pwd_old + "'");
            if (bl)
            {
                DB.ExecuteSql("update Manager set ManagerPwd='" + pwd_new + "' where ManagerName='" + ltlLoginName.Text.Trim() + "'");

                Common.ShowMessage(Page, "更新成功！", "");
            }
            else
            {
                Common.ShowMessage(Page, "原密码错误！", "");
            }

        }


    }
}