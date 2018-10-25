using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace Lib
{
    /// <summary>
    /// Score 的摘要描述
    /// </summary>
    public class Score
    {
        private string _id;
        private string _age;
        private string _date;
        private string _name;
        private string _center_name;
        private string _sit_ups_score;
        private string _push_ups_score;
        private string _run_score;
        private string _status;

        public Score()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public string name
        {
            get { return _name; }
            set { _name = value; }
        }

        public string id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string age
        {
            get { return _age; }
            set { _age = value; }
        }

        public string date
        {
            get { return _date; }
            set { _date = value; }
        }

        public string center_name
        {
            get { return _center_name; }
            set { _center_name = value; }
        }

        public string sit_ups_score
        {
            get { return _sit_ups_score; }
            set { _sit_ups_score = value; }
        }

        public string push_ups_score
        {
            get { return _push_ups_score; }
            set { _push_ups_score = value; }
        }

        public string run_score
        {
            get { return _run_score; }
            set { _run_score = value; }
        }

        public string status
        {
            get { return _status; }
            set { _status = value; }
        }
    }
}
