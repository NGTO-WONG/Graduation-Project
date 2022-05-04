using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Project.SysManage
{
    public partial class Login : System.Web.UI.Page
    {
        protected int get_grade;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_grade = Common.RequestInt("grade");
            get_grade = get_grade == 0 ? 1 : get_grade;
            if (!IsPostBack)
            {
                grade.SelectedValue = get_grade.ToString();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            ltlMess.Text = "";
            string user = Common.UrnHtml(username.Value.Trim());
            string pwd = userpwd.Value.Trim();


            string sql = "";
            sql = "select * from Manager where ManagerName='" + user + "' and ManagerPwd='" + pwd + "' and grade=" + grade.SelectedValue;

            SqlDataReader dr = DB.getDataReader(sql);
            if (dr.Read())
            {
                //Cookie记录用户登录信息
                HttpCookie cookies;
                cookies = new HttpCookie("logininfo");
                cookies.Values.Add("Grade", grade.SelectedValue);
                cookies.Values.Add("Id", dr[0].ToString());
                cookies.Values.Add("Manager", HttpUtility.UrlEncode(user));
                cookies.Values.Add("TrueName", HttpUtility.UrlEncode(dr["Title"].ToString()));
                Response.Cookies.Set(cookies);

                dr.Close();
                dr.Dispose();

                Response.Redirect("MainFrame.aspx");
            }
            else
            {
                dr.Close();
                dr.Dispose();
                ltlMess.Text = "登录账号或密码错误.";
            }
        }
    }
}