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
    public partial class EditInfo : ManagerBase
    {
        int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = mbId;
            if (!IsPostBack)
            {
                if (id > 0)
                {
                    Get_Data();
                }
                else
                    btnSave.Visible = false;
            }
        }

        void Get_Data()
        {
            DataTable dt = DB.getDataTable("select * from Manager where Id=" + id);
            if (dt.Rows.Count == 1)
            {
                Tel.Text = dt.Rows[0]["Tel"].ToString();
                ManagerName.Text = dt.Rows[0]["ManagerName"].ToString();
                Email.Text = dt.Rows[0]["Email"].ToString();
                Title.Text = dt.Rows[0]["Title"].ToString();
                RegTime.Text = dt.Rows[0]["RegTime"].ToString();
            }
            else
                btnSave.Visible = false;
        }

        /// <summary>
        /// 按钮事件：提交信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Manager set ");

            strSql.Append(" Tel = '" + Tel.Text.Trim() + "',");
            strSql.Append(" ManagerName = '" + ManagerName.Text.Trim() + "',");
            strSql.Append(" Email = '" + Email.Text.Trim() + "',");
            strSql.Append(" Title = '" + Title.Text.Trim() + "'");

            strSql.Append(" where Id= " + id);
            DB.ExecuteSql(strSql.ToString());


            JavaScriptHelper.Success(this, "保存成功");
        }


    }
}