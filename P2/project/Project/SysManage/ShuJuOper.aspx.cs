using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using System.Web.Services;

namespace Project.SysManage
{
    public partial class ShuJuOper : ManagerBase
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
            DataTable dt = DB.getDataTable("select * from ShuJu where Id=" + id);
            if (dt.Rows.Count == 1)
            {
                xm.Text = dt.Rows[0]["xm"].ToString();
                sj.Text = dt.Rows[0]["sj"].ToString();
                //je.Text = dt.Rows[0]["je"].ToString();
                ren.Text = dt.Rows[0]["ren"].ToString();
                demo.Text = dt.Rows[0]["demo"].ToString();
                state.Text = dt.Rows[0]["state"].ToString();
                //state2.Text = dt.Rows[0]["state2"].ToString();
            }
        }

        /// <summary>
        /// 按钮事件：提交信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //StringBuilder strSql = new StringBuilder();

            //if (id <= 0)//添加
            //{
            //    strSql.Append("insert into ShuJu(");
            //    strSql.Append("xm,sj,je,ren,demo,state,userid,state2");
            //    strSql.Append(") values (");
            //    strSql.Append("'" + xm.Text + "','" + sj.Text + "','" + je.Text + "'");
            //    strSql.Append(",'" + ren.Text + "','" + demo.Text + "','" + state.Text + "','" + mbId + "','" + state2.Text + "') ");
            //}
            //else//修改
            //{
            //    strSql.Append("update ShuJu set ");

            //    strSql.Append(" xm = '" + xm.Text + "'");
            //    strSql.Append(" ,sj = '" + sj.Text + "'");
            //    strSql.Append(" ,je = '" + je.Text + "'");
            //    strSql.Append(" ,ren = '" + ren.Text + "'");
            //    strSql.Append(" ,demo = '" + demo.Text + "'");
            //    strSql.Append(" ,state = '" + state.Text + "'");
            //    strSql.Append(" ,state2 = '" + state2.Text + "'");

            //    strSql.Append(" where Id= " + id);
            //}
            //DB.ExecuteSql(strSql.ToString());

            //JavaScriptHelper.Success(this, "保存成功", "ShuJuManage.aspx");
        }
        [WebMethod]
        public static string SaveChange(string strJson)
        {
            try
            {
                JsonRootDto jsonRootDto = JsonConvert.DeserializeObject<JsonRootDto>(strJson);
                StringBuilder strSql = new StringBuilder();
                string str = @"select count(0) as result from ShuJu where xm='" + jsonRootDto.Xm + "' and CONVERT(varchar(10),sj)=CONVERT(varchar(10),'" + jsonRootDto.Sj + "') and ren='" + jsonRootDto.Ren + "'";
                int checkResult = Convert.ToInt32(DB.ExecuteScalar(str));
                if (checkResult == 0)
                {
                    if (Common.RequestInt("id") <= 0)//添加
                    {
                        strSql.Append("insert into ShuJu(");
                        strSql.Append("xm,sj,ren,demo,state,userid,state2");
                        strSql.Append(") values (");
                        strSql.Append("'" + jsonRootDto.Xm + "','" + jsonRootDto.Sj + "'");
                        strSql.Append(",'" + jsonRootDto.Ren + "','" + jsonRootDto.Demo + "','" + jsonRootDto.State + "','" + Convert.ToInt32(HttpContext.Current.Request.Cookies["logininfo"]["Id"]) + "','" + jsonRootDto.State2 + "') ");
                        strSql.Append(";select @@identity");
                    }
                    else//修改
                    {
                        strSql.Append("update ShuJu set ");
                        strSql.Append(" xm = '" + jsonRootDto.Xm + "'");
                        strSql.Append(" ,sj = '" + jsonRootDto.Sj + "'");
                        //strSql.Append(" ,je = '" + je.Text + "'");
                        strSql.Append(" ,ren = '" + jsonRootDto.Ren + "'");
                        strSql.Append(" ,demo = '" + jsonRootDto.Demo + "'");
                        strSql.Append(" ,state = '" + jsonRootDto.State + "'");
                        strSql.Append(" ,state2 = '" + jsonRootDto.State2 + "'");
                        strSql.Append(" where Id= " + Common.RequestInt("id"));
                        strSql.Append(";select '" + Common.RequestInt("id") + "'");
                    }
                    string id = DB.ExecuteScalar(strSql.ToString());
                    if (id != null && id != "")
                    {
                        string sql = "INSERT INTO dbo.ShuJu_Detail ( detailId, Id, detailName, detailValue, createDate ) VALUES ";
                        foreach (ResItem item in jsonRootDto.Res)
                        {
                            sql += "(CONVERT(VARCHAR(50),NEWID()),'" + id + "','" + item.Name + "','" + item.Value + "',GETDATE()),";
                        }
                        DB.ExecuteSql(sql.TrimEnd(','));
                    }
                    return JsonConvert.SerializeObject(new
                    {
                        code = 0,
                        count = 0,
                        data = "保存成功",
                        error = "",
                    });
                }
                else
                {
                    return JsonConvert.SerializeObject(new
                    {
                        code = 1,
                        count = 0,
                        data = "",
                        error = "",
                    });
                }
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new
                {
                    code = 500,
                    count = 0,
                    data = ex.Message,
                    error = "",
                });
            }
        }
        /// <summary>
        /// 获取费用详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [WebMethod]
        public static string GetItemList(string Id)
        {
            DataTable dt = DB.getDataTable("select * from ShuJu_Detail where Id=" + Id);
            return JsonConvert.SerializeObject(new
            {
                code = 0,
                count = 0,
                data = JsonConvert.SerializeObject(dt),
                error = "",
            });
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="res"></param>
        /// <returns></returns>
        [WebMethod]
        public static string Update(string strJson)
        {
            try
            {
                List<ApprovalEntity> entities = JsonConvert.DeserializeObject<List<ApprovalEntity>>(strJson);
                string strSql = "";
                foreach (ApprovalEntity item in entities)
                {
                    strSql += "UPDATE ShuJu_Detail SET ApprovalMoney='" + item.AppMoney + "' WHERE detailId='" + item.Id + "';";
                }
                DB.ExecuteSql(strSql.TrimEnd(';'));
                return JsonConvert.SerializeObject(new
                {
                    code = 0,
                    count = 0,
                    data = "保存成功",
                    error = "",
                });
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new
                {
                    code = 500,
                    count = 0,
                    data = ex.Message,
                    error = "",
                });
            }
        }
    }
    #region 实体
    public class JsonRootDto
    {
        /// <summary>
        /// 招待费
        /// </summary>
        [JsonProperty("xm")]
        public string Xm { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("sj")]
        public DateTime Sj { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("res")]
        public List<ResItem> Res { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("ren")]
        public string Ren { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("demo")]
        public string Demo { get; set; }

        /// <summary>
        /// 未审计
        /// </summary>
        [JsonProperty("state")]
        public string State { get; set; }

        /// <summary>
        /// 未审计
        /// </summary>
        [JsonProperty("state2")]
        public string State2 { get; set; }
    }
    public class ResItem
    {
        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("name")]
        public string Name { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("value")]
        public string Value { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("orderBy")]
        public int OrderBy { get; set; }
    }
    [Serializable]
    public class ApprovalEntity
    {
        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("id")]
        public string Id { get; set; }

        /// <summary>
        /// 唱歌
        /// </summary>
        [JsonProperty("name")]
        public string Name { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("value")]
        public string Value { get; set; }

        /// <summary>
        /// 同意
        /// </summary>
        [JsonProperty("state")]
        public string State { get; set; }

        /// <summary>
        /// 
        /// </summary>
        [JsonProperty("orderBy")]
        public int OrderBy { get; set; }

        /// <summary>
        /// 同意金额
        /// </summary>
        [JsonProperty("appMoney")]
        public string AppMoney { get; set; }

    }
    #endregion
}