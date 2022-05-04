using System;

namespace Project
{
    /// <summary>
    /// 处理结果集
    /// </summary>
    public class AjaxJsonResult
    {
        /// <summary>
        /// 操作结果：1 成功 -1 失败
        /// </summary>
        public int Result { get; set; }
        /// <summary>
        /// 结果说明 （如：操作成功、参数错误等）
        /// </summary>
        public string Message { get; set; }
    }
}
