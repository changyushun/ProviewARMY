using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// WorkWeek 的摘要描述
/// </summary>

namespace Lib
{
    public class WorkWeek
    {
        public bool isSetYear { get; set; }//是否已設定工作日

        public Dictionary<DayOfWeek, bool> DicWeek;//星期對應是否開啟
        public WorkWeek(int year)
        {
            DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("year", year);
            DataTable dt = new DataTable();
            dt = du.getDataTableBysp("Ex107_GetYearWorkDay", d);
            if (dt.Rows.Count == 1)
            {
                DicWeek = new Dictionary<DayOfWeek, bool>();
                if (dt.Rows[0]["Monday"] != DBNull.Value)
                {                  
                    DicWeek.Add(DayOfWeek.Monday, Convert.ToBoolean(dt.Rows[0]["Monday"]));
                    DicWeek.Add(DayOfWeek.Tuesday, Convert.ToBoolean(dt.Rows[0]["Tuesday"]));
                    DicWeek.Add(DayOfWeek.Wednesday, Convert.ToBoolean(dt.Rows[0]["Wednesday"]));
                    DicWeek.Add(DayOfWeek.Thursday, Convert.ToBoolean(dt.Rows[0]["Thursday"]));
                    DicWeek.Add(DayOfWeek.Friday, Convert.ToBoolean(dt.Rows[0]["Friday"]));
                    DicWeek.Add(DayOfWeek.Saturday, Convert.ToBoolean(dt.Rows[0]["Saturday"]));
                    DicWeek.Add(DayOfWeek.Sunday, Convert.ToBoolean(dt.Rows[0]["Sunday"]));
                    isSetYear = true;
                }
                else
                {
                    DicWeek.Add(DayOfWeek.Monday, false);
                    DicWeek.Add(DayOfWeek.Tuesday, false);
                    DicWeek.Add(DayOfWeek.Wednesday, false);
                    DicWeek.Add(DayOfWeek.Thursday, false);
                    DicWeek.Add(DayOfWeek.Friday, false);
                    DicWeek.Add(DayOfWeek.Saturday, false);
                    DicWeek.Add(DayOfWeek.Sunday, false);
                    isSetYear = false;
                }
                
            }
        }
        
    }
}
