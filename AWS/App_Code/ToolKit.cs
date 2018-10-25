using System;
using System.Collections.Generic;
using System.Web;


namespace Lib
{
    /// <summary>
    /// ToolKit 的摘要描述
    /// </summary>
    public class ToolKit
    {
        public ToolKit()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public static TimeSpan ConvertToTimeSpan(Int32 totalMiliSecond)
        {
            int minsec = totalMiliSecond % 1000;
            int sec = (totalMiliSecond / 1000) % 60;
            int min = (totalMiliSecond / 60000) % 60;
            int hr = (totalMiliSecond / 3600000) % 60;
            return new TimeSpan(0, hr, min, sec, minsec);
        }
    }
}
