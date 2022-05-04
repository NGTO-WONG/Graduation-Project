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
    public partial class JiHuaOper : ManagerBase
    {
        int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Common.RequestInt("id");
            if (!IsPostBack)
            {
                DB.Bind_Dropdownlist("select * from fenlei", xm, "fenleiname", "fenleiname");
                if (id > 0)
                {
                    Get_Data();
                }
                else
                    ren.Text = mbTrueName;
            }
        }

        void Get_Data()
        {
            DataTable dt = DB.getDataTable("select * from JiHua where Id=" + id);
            if (dt.Rows.Count == 1)
            {
                xm.Text = dt.Rows[0]["xm"].ToString();
                sj.Text = dt.Rows[0]["sj"].ToString();
                je.Text = dt.Rows[0]["je"].ToString();
                ren.Text = dt.Rows[0]["ren"].ToString();
                demo.Text = dt.Rows[0]["demo"].ToString();
                state.SelectedValue = dt.Rows[0]["state"].ToString();
            }
            
        }

        /// <summary>
        /// 按钮事件：提交信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            StringBuilder strSql = new StringBuilder();

            if (id <= 0)//添加
            {
                strSql.Append("insert into JiHua(");
                strSql.Append("xm,sj,je,ren,demo,state,userid");
                strSql.Append(") values (");
                strSql.Append("'" + xm.Text + "','" + sj.Text + "','" + je.Text + "'");
                strSql.Append(",'" + ren.Text + "','" + demo.Text + "','" + state.SelectedValue + "','"+mbId+"') ");
            }
            else//修改
            {
                strSql.Append("update JiHua set ");

                strSql.Append(" xm = '" + xm.Text + "'");
                strSql.Append(" ,sj = '" + sj.Text + "'");
                strSql.Append(" ,je = '" + je.Text + "'");
                strSql.Append(" ,ren = '" + ren.Text + "'");
                strSql.Append(" ,demo = '" + demo.Text + "'");
                strSql.Append(" ,state = '" + state.SelectedValue + "'");

                strSql.Append(" where Id= " + id);
            }
            DB.ExecuteSql(strSql.ToString());

            JavaScriptHelper.Success(this, "保存成功", "JiHuaManage.aspx");
        }
    }
}