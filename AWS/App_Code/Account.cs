using System;
using System.Collections.Generic;
using System.Web;
using System.Data;


namespace Lib
{
    /// <summary>
    /// Account 的摘要描述
    /// </summary>
    [Serializable]
    public class Account
    {
        private bool _isValid = false;
        public bool IsValid
        {
            get
            {
                return _isValid;
            }
        }

        // 2010/01/19 edit by angus
        private bool _isIPLock = false;
        public bool IsIPLock
        {
            get { return _isIPLock; }
        }
        

        public Account()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //

        }

        public Account(string account, string password, string ip)
        {
            DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("type", "account");
            d.Add("value", account);
            DataTable dt = du.getDataTableBysp("getaccount", d);
            if (dt.Rows.Count == 1)
            {
                if (dt.Rows[0]["password"].ToString() == password)
                {
                    try
                    {
                        if (SysSetting.isIPLock)
                        {
                            if (dt.Rows[0]["ip"].ToString() == ip)
                            {
                                _isValid = true;
                                _isIPLock = true;
                            }
                            else
                            {
                                _isValid = true;
                                _isIPLock = false;
                            }
                        }
                        else
                        {
                            _isValid = true;
                            _isIPLock = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        _isValid = true;
                        _isIPLock = true;
                    }
                

                    _sid = Convert.ToInt32(dt.Rows[0]["sid"]);
                    _account = dt.Rows[0]["account"].ToString();
                    _password = dt.Rows[0]["password"].ToString();
                    _role_code = dt.Rows[0]["role_code"].ToString();
                    _name = dt.Rows[0]["name"].ToString();
                    _id = dt.Rows[0]["id"].ToString();
                    _unit_code = dt.Rows[0]["unit_code"].ToString();
                    _rank_code = dt.Rows[0]["rank_code"].ToString();
                    _tel = dt.Rows[0]["tel"].ToString();
                    _cellphone = dt.Rows[0]["cellphone"].ToString();
                    _mail = dt.Rows[0]["mail"].ToString();
                    _ip = dt.Rows[0]["ip"].ToString();
                    _pwdChange = dt.Rows[0]["pwdChange"].ToString();
                    _status = dt.Rows[0]["status"].ToString();
                    _rank = dt.Rows[0]["rank"].ToString();
                    _unit = dt.Rows[0]["unit"].ToString();
                    _service_code = dt.Rows[0]["service_code"].ToString();
                    _center_code = dt.Rows[0]["center_code"].ToString();
                    dt.Clear();
                    if (_role_code == "3")
                    {
                        dt = du.getDataTableBysp("getoption", "accName", this._account);
                        _optionCode = new Dictionary<string, string>();
                        foreach (DataRow r in dt.Rows)
                        {
                            _optionCode.Add(r[1].ToString(), r[2].ToString());
                        }
                    }

                }
            }
        }

        public Account(string account, string mail, string ip, string resetpw)
        {
            DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("type", "account");
            d.Add("value", account);
            DataTable dt = du.getDataTableBysp("getaccount", d);
            if (dt.Rows.Count == 1)
            {
                if (dt.Rows[0]["mail"].ToString() == mail)
                {
                    if (SysSetting.isIPLock)
                    {
                        if (dt.Rows[0]["ip"].ToString() == ip)
                        {
                            _isValid = true;
                            // 2010/01/19 edit by angus
                            _isIPLock = true;
                        }
                        else
                        {
                            _isValid = true;
                            // 2010/01/19 edit by angus
                            _isIPLock = false;
                        }
                    }
                    else
                    {
                        _isValid = true;
                        // 2010/01/19 edit by angus
                        _isIPLock = true;
                    }

                    _sid = Convert.ToInt32(dt.Rows[0]["sid"]);
                    _account = dt.Rows[0]["account"].ToString();
                    _password = dt.Rows[0]["password"].ToString();
                    _role_code = dt.Rows[0]["role_code"].ToString();
                    _name = dt.Rows[0]["name"].ToString();
                    _id = dt.Rows[0]["id"].ToString();
                    _unit_code = dt.Rows[0]["unit_code"].ToString();
                    _rank_code = dt.Rows[0]["rank_code"].ToString();
                    _tel = dt.Rows[0]["tel"].ToString();
                    _cellphone = dt.Rows[0]["cellphone"].ToString();
                    _mail = dt.Rows[0]["mail"].ToString();
                    _ip = dt.Rows[0]["ip"].ToString();
                    _pwdChange = dt.Rows[0]["pwdChange"].ToString();
                    _status = dt.Rows[0]["status"].ToString();
                    _rank = dt.Rows[0]["rank"].ToString();
                    _unit = dt.Rows[0]["unit"].ToString();
                    _service_code = dt.Rows[0]["service_code"].ToString();
                    _center_code = dt.Rows[0]["center_code"].ToString();
                }
            }
        }

        public Account(string account)
        { 
            DataUtility du = new DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("type", "account");
            d.Add("value", account);
            DataTable dt = du.getDataTableBysp("getaccount", d);
            if (dt.Rows.Count == 1)
            {
                _sid = Convert.ToInt32(dt.Rows[0]["sid"]);
                _account = dt.Rows[0]["account"].ToString();
                _password = dt.Rows[0]["password"].ToString();
                _role_code = dt.Rows[0]["role_code"].ToString();
                _name = dt.Rows[0]["name"].ToString();
                _id = dt.Rows[0]["id"].ToString();
                _unit_code = dt.Rows[0]["unit_code"].ToString();
                _rank_code = dt.Rows[0]["rank_code"].ToString();
                _tel = dt.Rows[0]["tel"].ToString();
                _cellphone = dt.Rows[0]["cellphone"].ToString();
                _mail = dt.Rows[0]["mail"].ToString();
                _ip = dt.Rows[0]["ip"].ToString();
                _pwdChange = dt.Rows[0]["pwdChange"].ToString();
                _status = dt.Rows[0]["status"].ToString();
                _rank = dt.Rows[0]["rank"].ToString();
                _unit = dt.Rows[0]["unit"].ToString();
                _service_code = dt.Rows[0]["service_code"].ToString();
                _center_code = dt.Rows[0]["center_code"].ToString();
                dt.Clear();
            }
        }

        private int _sid;

        public int Sid
        {
            get
            {
                return _sid;
            }
        }

        private string _name;

        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }

        private string _account;

        public string AccountName
        {
            get
            {
                return _account;
            }
            set
            {
                _account = value;
            }
        }

        private string _password;

        public string Password
        {
            get
            {
                return _password;
            }
            set
            {
                _password = value;
            }
        }

        private string _role_code;

        public string Role
        {
            get
            {
                return _role_code;
            }
        }

        private string _id;

        public string ID
        {
            get
            {
                return _id;
            }
            set
            {
                _id = value;
            }
        }

        private string _unit_code;

        public string Unit_Code
        {
            get
            {
                return _unit_code;
            }
            set
            {
                _unit_code = value;
            }
        }

        private string _rank_code;

        public string Rank_Code
        {
            get
            {
                return _rank_code;
            }
            set
            {
                _rank_code = value;
            }
        }

        private string _tel;

        public string Tel
        {
            get
            {
                return _tel;
            }
            set
            {
                _tel = value;
            }
        }

        private string _cellphone;

        public string CellPhone
        {
            get
            {
                return _cellphone;
            }
            set
            {
                _cellphone = value;
            }

        }

        private string _mail;

        public string Mail
        {
            set
            {
                _mail = value;
            }
            get
            {
                return _mail;
            }
        }

        private string _ip;

        public string IP
        {
            get
            {
                return _ip;
            }
            set
            {
                _ip = value;
            }
        }

        private string _pwdChange;

        public string PwdChange
        {
            get
            {
                return _pwdChange;
            }
            set
            {
                _pwdChange = value;
            }
        }

        private string _status;

        public string Status
        {
            get
            {
                return _status;
            }
        }

        private string _rank;

        public string Rank
        {
            get
            {
                return _rank;
            }
        }

        private string _unit;

        public string Unit
        {
            get
            {
                return _unit;
            }
        }

        private string _service_code;

        public string Service_Code
        {
            get
            {
                return _service_code;
            }
        }
        //2016-9-1新增一個屬性成員單位代碼
        private string _center_code;

        public string center_code
        {
            get
            {
                return _center_code;
            }
        }

        private Dictionary<string, string> _optionCode;

        public Dictionary<string, string> OptionCode
        {
            get {
                return _optionCode;
            }
        
        }



    }

    



}