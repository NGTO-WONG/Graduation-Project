using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

namespace Project.SysManage
{
    public partial class ManagerOper : ManagerBase
    {
        protected int get_grade;
        int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_grade = Common.RequestInt("grade");
            id = Common.RequestInt("id");
            if (!IsPostBack)
            {
                if (id > 0)
                {
                    Get_Data();
                }
                else
                    Grade.SelectedValue = get_grade.ToString();
            }
        }

        void Get_Data()
        {
            DataTable dt = DB.getDataTable("select * from Manager where Id=" + id);
            if (dt.Rows.Count == 1)
            {
                Tel.Text = dt.Rows[0]["Tel"].ToString();
                ManagerPwd.Text = dt.Rows[0]["ManagerPwd"].ToString();
                ManagerName.Text = dt.Rows[0]["ManagerName"].ToString();
                Email.Text = dt.Rows[0]["Email"].ToString();
                Title.Text = dt.Rows[0]["Title"].ToString();
                Grade.SelectedValue = dt.Rows[0]["Grade"].ToString();
                State.SelectedValue = dt.Rows[0]["State"].ToString();
            }

        }

        /// <summary>
        /// 按钮事件：提交信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //验证重复
            if (id <= 0 && DB.getDataTable("select * from Manager where ManagerName='" + ManagerName.Text.Trim() + "'").Rows.Count > 0)
            {
                JavaScriptHelper.Error(this, "此 账号 已存在");
                return;
            }

            StringBuilder strSql = new StringBuilder();
            if (id <= 0)//添加
            {
                strSql.Append("insert into Manager(");
                strSql.Append("Tel,ManagerPwd,ManagerName,Email,Title,RegTime,LoginCount,Grade,State");
                strSql.Append(") values (");
                strSql.Append("'" + Tel.Text + "','" + ManagerPwd.Text + "','" + ManagerName.Text + "','" + Email.Text + "','" + Title.Text + "',getdate(),0," + Grade.SelectedValue);
                strSql.Append(",'" + State.SelectedValue + "') "); 
            }
            else//修改
            {
                strSql.Append("update Manager set ");

                strSql.Append(" Tel = '" + Tel.Text.Trim() + "',");
                strSql.Append(" ManagerPwd = '" + ManagerPwd.Text.Trim() + "',");
                strSql.Append(" ManagerName = '" + ManagerName.Text.Trim() + "',");
                strSql.Append(" Email = '" + Email.Text.Trim() + "',");
                strSql.Append(" Title = '" + Title.Text.Trim() + "',");
                strSql.Append(" Grade = '" + Grade.SelectedValue + "',");
                strSql.Append(" State = '" + State.SelectedValue + "'");
                
                strSql.Append(" where Id= " + id);
            }
            DB.ExecuteSql(strSql.ToString());


            JavaScriptHelper.Success(this, "保存成功", "ManagerManage.aspx?grade=" + get_grade);
        }


    }
}