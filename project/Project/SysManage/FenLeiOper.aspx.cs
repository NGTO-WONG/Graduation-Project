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
    public partial class FenLeiOper : ManagerBase
    {
        int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Common.RequestInt("id");
            if (!IsPostBack)
            {
                if (id > 0)
                {
                    Get_Data();
                }
            }
        }

        void Get_Data()
        {
            DataTable dt = DB.getDataTable("select * from FenLei where Id=" + id);
            if (dt.Rows.Count == 1)
            {
                FenLeiName.Text = dt.Rows[0]["FenLeiName"].ToString();
                
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
            if (id <= 0 && DB.getDataTable("select * from FenLei where FenLeiName='" + FenLeiName.Text.Trim() + "'").Rows.Count > 0)
            {
                JavaScriptHelper.Error(this, "已存在");
                return;
            }

            StringBuilder strSql = new StringBuilder();
            if (id <= 0)//添加
            {
                strSql.Append("insert into FenLei(");
                strSql.Append("FenLeiName");
                strSql.Append(") values (");
                strSql.Append("'" + FenLeiName.Text + "'");
                strSql.Append(") ");  
            }
            else//修改
            {
                strSql.Append("update FenLei set ");

                strSql.Append(" FenLeiName = '" + FenLeiName.Text.Trim() + "'");
                strSql.Append(" where Id= " + id);
            }
            DB.ExecuteSql(strSql.ToString());


            JavaScriptHelper.Success(this, "保存成功", "FenLeiManage.aspx");
        }


    }
}