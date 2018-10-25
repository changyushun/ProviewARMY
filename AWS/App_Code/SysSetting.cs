using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Data;
using System.Web.Script;
using System.Threading;
using System.Globalization;
using System.Web.Hosting;

namespace Lib
{
    /// <summary>
    /// SysSetting 的摘要描述
    /// </summary>
    public class SysSetting
    {
        public SysSetting()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public static bool isIPLock
        {
            get
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                return Convert.ToBoolean(c.AppSettings.Settings["isIPLock"].Value);
            }
            set
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                c.AppSettings.Settings["isIPLock"].Value = value.ToString();
                c.Save();
            }
        }

        public static bool isYearLock
        {
            get
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                return Convert.ToBoolean(c.AppSettings.Settings["YearLock"].Value);
            }
            set
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                c.AppSettings.Settings["YearLock"].Value = value.ToString();
                c.Save();
            }
        }

        //public static string Unit_Version
        //{
        //    get
        //    {
        //        Configuration c = WebConfigurationManager.OpenWebConfiguration("~");
        //        return c.AppSettings.Settings["unit_version"].Value;
        //    }
        //    set
        //    {
        //        Configuration c = WebConfigurationManager.OpenWebConfiguration("~");
        //        c.AppSettings.Settings["unit_version"].Value = value.ToString();
        //        c.Save();
        //    }
        //}

        public static string upfile_random
        {
            get
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                return c.AppSettings.Settings["upfile_random"].Value;
            }
            set
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
                // Get the Configuration object for the mapped virtual directory.
                c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);
                c.AppSettings.Settings["upfile_random"].Value = value.ToString();
                c.Save();
            }
        }

        public static TimeSpan reserveTimeUnit
        {
            get
            {
                Configuration c = null;
                if (HostingEnvironment.ApplicationVirtualPath == "/")
                    c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

                //2017-2-14 以下二段程式碼需MARK，本機測試才能運行。
                //WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);//1
                //// Get the Configuration object for the mapped virtual directory.
                //c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);//2
                
                //Configuration c = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(@"~/");
                TimeSpan ts = new TimeSpan(Convert.ToInt16(c.AppSettings.Settings["reserveTimeUnit"].Value), 0, 0);
                return ts;
            }
        }

        public static void setReserveTimeUnit(int hr)
        {
            Configuration c = null;
            if (HostingEnvironment.ApplicationVirtualPath == "/")
                c = WebConfigurationManager.OpenWebConfiguration("~/web.config");

            WebConfigurationFileMap fileMap = CreateFileMap(HostingEnvironment.ApplicationVirtualPath);
            // Get the Configuration object for the mapped virtual directory.
            c = WebConfigurationManager.OpenMappedWebConfiguration(fileMap, HostingEnvironment.ApplicationVirtualPath);

            c.AppSettings.Settings["reserveTimeUnit"].Value = hr.ToString();
            c.Save();
        }

        private static WebConfigurationFileMap CreateFileMap(string applicationVirtualPath)
        {

            WebConfigurationFileMap fileMap =
                   new WebConfigurationFileMap();

            // Get he physical directory where this app runs. 
            // We'll use it to map the virtual directories 
            // defined next.  
            string physDir = HostingEnvironment.ApplicationPhysicalPath;

            // Create a VirtualDirectoryMapping object to use 
            // as the root directory for the virtual directory 
            // named config.  
            // Note: you must assure that you have a physical subdirectory 
            // named config in the curremt physical directory where this 
            // application runs.
            VirtualDirectoryMapping vDirMap =
                new VirtualDirectoryMapping(physDir, true);

            // Add vDirMap to the VirtualDirectories collection  
            // assigning to it the virtual directory name.
            fileMap.VirtualDirectories.Add(applicationVirtualPath, vDirMap);

            // Create a VirtualDirectoryMapping object to use 
            // as the default directory for all the virtual  
            // directories.
            VirtualDirectoryMapping vDirMapBase =
                new VirtualDirectoryMapping(physDir, true, "web.config");

            // Add it to the virtual directory mapping collection.
            fileMap.VirtualDirectories.Add("/", vDirMapBase);

            // Return the mapping. 
            return fileMap;
        }

        public static bool isOverTime(DateTime t)
        {
            // reserver date - reserverTimeUnit = deadline, then if now is ahead of deadline

            double _unit = SysSetting.reserveTimeUnit.TotalHours;

            DateTime deadline = t.AddHours(-_unit);

            string[] operater = { "/" };
            string[] info = t.Date.ToShortDateString().Split(operater, StringSplitOptions.None);
            
            if (deadline > System.DateTime.Now)            
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public static bool isOverTimeForAD(DateTime t)
        {
            double _unit = SysSetting.reserveTimeUnit.TotalHours;
            DateTime deadline = t.AddHours(-_unit);
            if (deadline > System.DateTime.Now)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public static Dictionary<string, DateTime> getAllowedDates(string unit_id)
        {

            DataUtility du = new DataUtility();
            Dictionary<string, DateTime> d = new Dictionary<string, DateTime>();
            DataTable allow = du.getDataTableBysp("getAllowedDates", "center_code", unit_id);

            foreach (DataRow row in allow.Rows)
            {
                d.Add(row["sid"].ToString(), Convert.ToDateTime(row["date"]));
            }
            return d;
        }

        public static Dictionary<string, DateTime> getDeniedDates(string unit_id)
        {
            DataUtility du = new DataUtility();
            Dictionary<string, DateTime> d = new Dictionary<string, DateTime>();
            DataTable deny = du.getDataTableBysp("getDeniedDates", "center_code", unit_id);

            foreach (DataRow row in deny.Rows)
            {
                d.Add(row["sid"].ToString(), Convert.ToDateTime(row["date"]));
            }
            return d;
        }

        [Flags]
        public enum Role
        {
            admin_hq = 1,
            mag_hq = 2,
            user_hg = 3,
            admin_center = 4,
            mag_center = 5,
            user_center = 6,
        }

        public static string GetJsonFormatData(DataTable table)
        {
            System.Web.Script.Serialization.JavaScriptSerializer s = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> d = new Dictionary<string, object>();
            foreach (DataRow r in table.Rows)
            {
                d = new Dictionary<string, object>();
                foreach (DataColumn c in table.Columns)
                {
                    d.Add(c.ColumnName, r[c]);
                }
                rows.Add(d);
            }
            return s.Serialize(rows);
        }

        public static string GetJsonFormatData(Dictionary<string, object> d)
        {
            System.Web.Script.Serialization.JavaScriptSerializer s = new System.Web.Script.Serialization.JavaScriptSerializer();
            return s.Serialize(d);
        }

        public static string GetJavaScriptHead(string s)
        {
            return "<script type='text/javascript'>" + s + "</script>";
        }

        public static DateTime GetSystemTime(string s)
        {
            return System.DateTime.Now;
        }

        public static DateTime ToWorldDate(string rocDateTime)
        {
            string _date = string.Empty;
            CultureInfo ci = new CultureInfo("en-US");
            //ci.DateTimeFormat.Calendar = tc;
            //ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
            ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
            Thread.CurrentThread.CurrentCulture = ci;
            try
            {
                string[] operater = { "/" };
                string[] info = rocDateTime.Split(operater, StringSplitOptions.None);
                string test1 = System.DateTime.Today.Year.ToString();
                _date = (Convert.ToInt32(info[0]) + 1911).ToString() + "/" + info[1] + "/" + info[2];
                //_date = (Convert.ToInt32(info[0])).ToString() + "/" + info[1] + "/" + info[2];
                DateTime test = Convert.ToDateTime(_date);
                return Convert.ToDateTime(_date);
            }
            catch (Exception ex)
            {
                return Convert.ToDateTime(_date);
            }
        }

        public static string ToRocDateFormat(string rawDate)
        {
            try
            {
                int year = Convert.ToInt32(rawDate.Substring(0, 4));
                return (year - 1911).ToString() + rawDate.Substring(4, rawDate.Length - 4);
            }
            catch
            {
                return rawDate;
            }
        }

        public static string ToRocWeekFormat(DayOfWeek day)
        {
            string result = string.Empty;
            switch (day)
            {
                case DayOfWeek.Monday:
                    result = "星期一";
                    break;
                case DayOfWeek.Tuesday:
                    result = "星期二";
                    break;
                case DayOfWeek.Wednesday:
                    result = "星期三";
                    break;
                case DayOfWeek.Thursday:
                    result = "星期四";
                    break;
                case DayOfWeek.Friday:
                    result = "星期五";
                    break;
                case DayOfWeek.Saturday:
                    result = "星期六";
                    break;
                case DayOfWeek.Sunday:
                    result = "星期天";
                    break;
                default:
                    break;
            }
            return result;
        }

        public static bool SaveLetter(string mailto, string mailfrom, string body, string type, string status)
        {
            try
            {
                DataUtility du = new DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("mailto", mailto);
                d.Add("mailfrom", mailfrom);
                d.Add("body", body);
                d.Add("type", type);
                d.Add("status", status);
                du.executeNonQueryBysp("AddMail", d);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static bool IsImage(HttpPostedFile file)
        {
            return ((file != null) && System.Text.RegularExpressions.Regex.IsMatch(file.ContentType, "image/\\S+") && (file.ContentLength > 0));
        }

        public static void AddLog(string _type, string _acc, string _event, DateTime _eventTime)
        {
            try
            {
                DataUtility du = new DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("type", _type);
                d.Add("acc", _acc);
                d.Add("event", _event);
                d.Add("eventTime", _eventTime);
                du.executeNonQueryBysp("AddLog", d);
            }
            catch (Exception ex)
            {

            }
        }

        public static void ExceptionLog(string type, string log, string page)
        {
            Lib.DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("type", type);
            d.Add("content", log);
            d.Add("date", DateTime.Now);
            d.Add("page", page);
            du.getDataTableByText("insert into exlog values (@date,@content,@type,@page)", d);
        }

        public static string ToRunMinSecFormat(string run)
        {
            try
            {
                int _run = Convert.ToInt32(run);
                string min = (_run / 60).ToString();
                string sec = (_run % 60).ToString();
                return min + ":" + sec;
            }
            catch
            {
                return run;
            }
        }

        public static DataTable GetCenterFromMemo(string _memo)
        { 
            DataTable center = new DataTable();
            Dictionary<string,object> d = new Dictionary<string,object>();
            Lib.DataUtility du = new Lib.DataUtility();
            if (_memo.Contains("E") || _memo.Contains("F"))
            {
                d.Add("IsSwin",true);
                center = du.getDataTableByText("select center_code from Center where IsSwin = @IsSwin", d);
            }
            else
            {
                center = du.getDataTableByText("select center_code from Center");
            }
            return center;
        }

        public static int ConvertAge(DateTime birth,DateTime reserved)
        {      
                int age = reserved.Year - birth.Year;
                if (reserved < birth.AddYears(age)) 
                    age--;
                return age;
        }

        public static int GetUnitVersion()
        {
            DataTable dt = new DataTable();
            dt = new Lib.DataUtility().getDataTableByText("select value from sys_params where type = 'unit_version'");
            return Convert.ToInt32(dt.Rows[0][0]);
        }

        public static int GetPerVersion()
        {
            DataTable dt = new DataTable();
            dt = new Lib.DataUtility().getDataTableByText("select value from sys_params where type = 'per_version'");
            return Convert.ToInt32(dt.Rows[0][0]);
        }

        public static bool CheckYear(DateTime _date)
        {

            int year = _date.Year;
            Lib.DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("year", year);
            DataTable dt = du.getDataTableByText("select islock from Year where year = @year", d);
            if (dt.Rows.Count == 1)
            {
                if (Convert.ToBoolean(dt.Rows[0][0]))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else  
            {
                return false; //不可預約此年度
            }
        }

    }
}
