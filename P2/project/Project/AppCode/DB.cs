using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Sql;
using System.Data.SqlClient;

namespace Project
{
    public class DB
    {
        #region 公共成员
        public static SqlConnection sqlconnection;//定义公共成员
        public static readonly string cnstr = ConfigurationManager.ConnectionStrings["DataAccess"].ConnectionString;
        #endregion

        public DB()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        #region 打开数据库连接
        /// <summary>
        /// 打开数据库连接 返回SqlConnection
        /// </summary>
        /// <returns></returns>
        public static SqlConnection OpenConnection()
        {
            try
            {
                sqlconnection = new SqlConnection(cnstr);
                sqlconnection.Open();
                return sqlconnection;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        #endregion

        #region 关闭数据库连接并释放资源
        /// <summary>
        /// 关闭数据库连接并释放资源
        /// </summary>
        /// <param name="Conn">数据库连接对象</param>
        public static void DisposeConnection(SqlConnection Conn)
        {
            if (Conn != null)
            {
                Conn.Close();
                Conn.Dispose();
            }
        }
        #endregion

        #region 执行Sql查询语句
        ///<summary>
        /// 执行Sql查询语句 执行成功返回受影响的行数，执行失败返回-1；
        /// </summary>
        /// <param name="strSQL">传入的Sql语句</param>
        /// <returns>返回受影响的行数</returns>
        public static int ExecuteSql(string strSQL)
        {
            SqlConnection conn = OpenConnection();
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                int val = comm.ExecuteNonQuery();

                DisposeConnection(conn);
                return val;

            }
            catch (Exception e)
            {
                DisposeConnection(conn);
                throw new Exception(e.Message);
            }
        }
        /// <summary>
        /// 执行查询，并返回查询所返回的结果集中第一行的第一列。忽略其他列或行
        /// </summary>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public static string ExecuteScalar(string strSQL)
        {
            SqlConnection conn = OpenConnection();
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                string val = comm.ExecuteScalar().ToString();

                DisposeConnection(conn);
                return val;

            }
            catch (Exception e)
            {
                DisposeConnection(conn);
                throw new Exception(e.Message);
            }
        }
        #endregion

        #region 返回指定Sql语句的SqlDataReader，请注意，在使用后请关闭本对象，同时将自动调用closeConnection()来关闭数据库连接
        /// <summary>
        /// 返回指定Sql语句的SqlDataReader，请注意，在使用后请关闭本对象，同时将自动调用closeConnection()来关闭数据库连接 
        /// </summary>
        /// <param name="strSQL">传入的Sql语句</param>
        /// <returns>SqlDataReader对象</returns>
        public static SqlDataReader getDataReader(string strSQL)
        {
            SqlConnection conn = OpenConnection();
            SqlDataReader dr = null;
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                dr = comm.ExecuteReader();
                return dr;
            }
            catch (Exception ex)
            {
                if (dr != null && !dr.IsClosed)
                    dr.Close();
                DisposeConnection(conn);
                throw new Exception(ex.Message);
            }

        }
        #endregion

        #region 返回指定Sql语句的DataTable
        /// <summary>
        /// 返回指定Sql语句的DataTable
        /// </summary>
        /// <param name="strSQL">传入的Sql语句</param>
        /// <returns>DataTable</returns>
        public static DataTable getDataTable(string strSQL)
        {
            SqlConnection conn = OpenConnection();
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                SqlDataAdapter da = new SqlDataAdapter(comm);
                DataTable table = new DataTable();
                da.Fill(table);

                DisposeConnection(conn);
                return table;
            }
            catch (Exception ex)
            {
                DisposeConnection(conn);
                throw new Exception(ex.Message);
            }
        }
        #endregion

        #region 返回指定Sql语句的DataSet
        /// <summary> 
        /// 返回指定Sql语句的DataSet 
        /// </summary> 
        /// <param name="strSQL">传入的Sql语句</param> 
        /// <returns>DataSet</returns> 
        public static DataSet getDataSet(string strSQL)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            SqlConnection conn = OpenConnection();
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                comm.CommandType = CommandType.Text;
                da.SelectCommand = comm;
                da.Fill(ds);

                DisposeConnection(conn);
                return ds;
            }
            catch (Exception e)
            {
                DisposeConnection(conn);
                throw new Exception(e.Message);
            }
        }
        #endregion

        #region 查询数据库中是否存在该条数据 存在返回True,不存在返回False
        /// <summary>
        /// 是否存在值
        /// </summary>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        public static bool isExists(string strSQL)
        {
            SqlConnection conn = OpenConnection();
            try
            {
                SqlCommand comm = new SqlCommand(strSQL, conn);
                SqlDataReader dr = comm.ExecuteReader();

                if (dr.HasRows) return true;

                DisposeConnection(conn);
                return false;
            }
            catch (Exception ex)
            {
                DisposeConnection(conn);
                throw new Exception(ex.Message);
            }

        }
        #endregion

        #region 获取记录总数
        /// <summary>
        /// 获取查询记录总数
        /// </summary>
        /// <param name="strSql"></param>
        /// <returns></returns>
        public static int getRowCount(string tableNm)
        {
            SqlConnection cn = OpenConnection();
            int intRowCount = 0;

            string str = "select count(*) from (" + tableNm + ")";
            SqlCommand cmd = new SqlCommand(str, cn);
            intRowCount = (int)cmd.ExecuteScalar();
            DisposeConnection(cn);
            return intRowCount;
        }
        #endregion

        #region 为DropDownList绑定数据
        public static void Bind_Dropdownlist(string sql, DropDownList ddl, string value, string text)
        {
            ddl.DataSource = getDataTable(sql);
            ddl.DataTextField = text;
            ddl.DataValueField = value;
            ddl.DataBind();
        }
        #endregion

        #region 为Repeater绑定数据
        public static void Bind_Repeater(string sql, Repeater rpt, SqlConnection cn)
        {
            SqlDataReader dr = getDataReader(sql);
            rpt.DataSource = dr;
            rpt.DataBind();
            dr.Close();
            dr.Dispose();
        }
        #endregion


        /// <summary>
        /// 获得数据列表（分页，可自定义排序）
        /// </summary>
        /// <param name="table">表名</param>
        /// <param name="wordname">要获取的字段(空则获取全部字段值)</param>
        /// <param name="Condition">条件(例：Id>0 and ...)</param>
        /// <param name="orderfile">排序字段</param>
        /// <param name="ordertype">排序方式：1降序，0升序</param>
        /// <param name="pagesize">每页记录数</param>
        /// <param name="CurrentPage">当前页</param>
        /// <param name="PageCount">总页数（返回值）</param>
        /// <param name="RecordCount">总记录数（返回值）</param>
        /// <returns></returns>
        public static DataTable GetListByPage(string table, string wordname, string Condition, string orderfile, int ordertype, int pagesize, int CurrentPage, out int PageCount, out int RecordCount)
        {
            wordname = !string.IsNullOrEmpty(wordname) ? wordname : "*";
            return PagerDAL.GetPagerList(OpenConnection(), table, orderfile, ordertype, wordname, pagesize, CurrentPage, Condition, out PageCount, out RecordCount).Tables[0];
        }


    }
}