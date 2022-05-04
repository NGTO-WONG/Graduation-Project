using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace Project
{
    public class PagerDAL
    {
        #region 分页方法_单字段排序
        public static DataSet GetPagerList(SqlConnection conn, string table, string col, int orderby, string collist, int pagesize, int CurrentPage, string Where, out int PageCount, out int RecordCount)
        {
            SqlCommand cmd = new SqlCommand("UP_Page", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter spar;
            spar = cmd.Parameters.Add("@table", SqlDbType.VarChar, 50);
            spar.Direction = ParameterDirection.Input;
            spar.Value = table;

            spar = cmd.Parameters.Add("@col", SqlDbType.VarChar, 50);
            spar.Direction = ParameterDirection.Input;
            spar.Value = col;

            spar = cmd.Parameters.Add("@orderby", SqlDbType.Int);
            spar.Direction = ParameterDirection.Input;
            spar.Value = orderby;

            spar = cmd.Parameters.Add("@collist", SqlDbType.VarChar, 800);
            spar.Direction = ParameterDirection.Input;
            spar.Value = collist;

            spar = cmd.Parameters.Add("@pagesize", SqlDbType.Int);
            spar.Direction = ParameterDirection.Input;
            spar.Value = pagesize;

            spar = cmd.Parameters.Add("@CurrentPage", SqlDbType.Int);
            spar.Direction = ParameterDirection.Input;
            spar.Value = CurrentPage;

            spar = cmd.Parameters.Add("@Where", SqlDbType.VarChar, 800);
            spar.Direction = ParameterDirection.Input;
            spar.Value = Where;

            spar = cmd.Parameters.Add("@PageCount", SqlDbType.Int);
            spar.Direction = ParameterDirection.Output;

            spar = cmd.Parameters.Add("@RecordCount", SqlDbType.Int);
            spar.Direction = ParameterDirection.Output;

            DataSet ds = new DataSet();
            SqlDataAdapter CommadAdp = new SqlDataAdapter();
            CommadAdp.SelectCommand = cmd;
            try
            {
                CommadAdp.Fill(ds);
                PageCount = (int)cmd.Parameters["@PageCount"].Value;
                RecordCount = (int)cmd.Parameters["@RecordCount"].Value;
                conn.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;

        }
        #endregion

        #region 分页方法_多字段排序
        /// <summary>
        /// 分页方法_多字段排序
        /// </summary>
        /// <param name="conn">数据库连接类</param>
        /// <param name="tbname">要分页显示的表名</param>
        /// <param name="FieldKey">用于定位记录的主键(惟一键)字段,只能是单个字段</param>
        /// <param name="FieldShow">以逗号分隔的要显示的字段列表,如果不指定,则显示所有字段</param>
        /// <param name="Where">查询条件</param>
        /// <param name="FieldOrder">以逗号分隔的排序字段列表,可以指定在字段后面指定DESC/ASC，用于指定排序顺序</param>
        /// <param name="PageSize">每页的大小(记录数)</param>
        /// <param name="PageCurrent">当前页码</param>
        /// <param name="PageCount">总页数</param>
        /// <returns></returns>
        public static DataSet GetPagerListByMultiWord(SqlConnection conn, string tbname, string FieldKey, string FieldShow, string Where, string FieldOrder, int PageSize, int PageCurrent, out int PageCount)
        {
            SqlCommand cmd = new SqlCommand("UP_PageByMulti", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter spar;
            //
            spar = cmd.Parameters.Add("@tbname", SqlDbType.VarChar, 50);
            spar.Direction = ParameterDirection.Input;
            spar.Value = tbname;
            //
            spar = cmd.Parameters.Add("@FieldKey", SqlDbType.VarChar, 50);
            spar.Direction = ParameterDirection.Input;
            spar.Value = FieldKey;
            //
            spar = cmd.Parameters.Add("@FieldShow", SqlDbType.VarChar, 800);
            spar.Direction = ParameterDirection.Input;
            spar.Value = FieldShow;
            //
            spar = cmd.Parameters.Add("@Where", SqlDbType.VarChar, 800);
            spar.Direction = ParameterDirection.Input;
            spar.Value = Where;
            //
            spar = cmd.Parameters.Add("@FieldOrder", SqlDbType.VarChar, 50);
            spar.Direction = ParameterDirection.Input;
            spar.Value = FieldOrder;
            //
            spar = cmd.Parameters.Add("@PageSize", SqlDbType.Int);
            spar.Direction = ParameterDirection.Input;
            spar.Value = PageSize;
            //
            spar = cmd.Parameters.Add("@PageCurrent", SqlDbType.Int);
            spar.Direction = ParameterDirection.Input;
            spar.Value = PageCurrent;
            //
            spar = cmd.Parameters.Add("@PageCount", SqlDbType.Int);
            spar.Direction = ParameterDirection.Output;

            DataSet ds = new DataSet();
            SqlDataAdapter CommadAdp = new SqlDataAdapter();
            CommadAdp.SelectCommand = cmd;
            try
            {
                CommadAdp.Fill(ds);
                PageCount = (int)cmd.Parameters["@PageCount"].Value;
                conn.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;

        }
        #endregion
    }
}