using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;


namespace Lib
{
    /// <summary>
    /// Player 的摘要描述
    /// </summary>
    /// 
    [Serializable]
    public class Player
    {
        public Player()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }
        public Player(string id, string value, string type)
        {
            try
            {
                DataUtility du = new DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("id", id);
                d.Add("type", type);
                d.Add("value", value);
                DataTable dt = du.getDataTableBysp("Ex105_QueryPlayer", d);
                if (dt.Rows.Count == 1)
                {
                    _isValid = true;
                    _id = dt.Rows[0]["id"].ToString();
                    _gender = dt.Rows[0]["gender"].ToString();
                    _birth = Convert.ToDateTime(dt.Rows[0]["birth"]);
                    _name = dt.Rows[0]["name"].ToString();
                    _unit_Code = dt.Rows[0]["unit_code"].ToString();
                    _rank_code = dt.Rows[0]["rank_code"].ToString();
                    _mail = dt.Rows[0]["mail"].ToString();
                    _oversea = (dt.Rows[0]["oversea"].ToString() == "1" ? true : false);
                    _password = dt.Rows[0]["password"].ToString();
                    _isExist = true;
                    if (string.IsNullOrEmpty(_password))
                    {
                        _isMustReSetPassword = true;
                        _isCanReSetPassword = true;
                    }
                    else
                    {
                        _isMustReSetPassword = false;
                        _isCanReSetPassword = false;
                    }
                }
                else
                {
                    _isExist = true;
                    _isValid = false;
                }

                if (dt.Rows.Count == 0)
                {
                    _isExist = true;
                    _isValid = false;
                }
                else if(dt.Rows.Count > 1)
                {
                    throw new Exception("more than one ID record !!!");
                }
            }
            catch (Exception ex)
            { 
            
            }
        }

        public Player(string id, DateTime birth)
        {

            try
            {
                Lib.DataUtility du = new DataUtility();
                DataTable dt = new DataTable();
                dt = du.getDataTableByText("select id,gender,CONVERT(VARCHAR(10),player.birth, 111) AS birth,name,unit_code,rank_code,mail,oversea,password from player where id = @id", "id", id);
                if (dt.Rows.Count == 1)
                {
                    if (Convert.ToDateTime(dt.Rows[0]["birth"]) == birth)
                    {
                        _isValid = true;
                        _id = dt.Rows[0]["id"].ToString();
                        _gender = dt.Rows[0]["gender"].ToString();
                        _birth = Convert.ToDateTime(dt.Rows[0]["birth"]);
                        _name = dt.Rows[0]["name"].ToString();
                        _unit_Code = dt.Rows[0]["unit_code"].ToString();
                        _rank_code = dt.Rows[0]["rank_code"].ToString();
                        _mail = dt.Rows[0]["mail"].ToString();
                        _oversea = (dt.Rows[0]["oversea"].ToString() == "1" ? true : false);
                        _password = dt.Rows[0]["password"].ToString();
                        _isExist = true;
                        if (string.IsNullOrEmpty(_password))
                        {
                            _isCanReSetPassword = true;
                            _isMustReSetPassword = true;
                        }
                        else
                        {
                            _isCanReSetPassword = false;
                            _isMustReSetPassword = false;
                        }
                    }
                    else
                    {
                        _isExist = true;
                        _isValid = false;
                    }
                }
                if (dt.Rows.Count == 0)
                {
                    _isExist = false;
                }
                else if (dt.Rows.Count > 1)
                {
                    throw new Exception("more than one ID record !!!");
                }

            }
            catch (Exception ex)
            { }
            
        }

        #region member

        private string _id;

        public string ID
        {
            get { return _id; }
            set { _id = value; }
        }

        private string _gender;

        public string Gender
        {
            get { return _gender; }
            set { _gender = value; }
        }

        private DateTime _birth;

        public DateTime Birth
        {
            get { return _birth; }
            set { _birth = value; }
        }

        private string _name;

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        private string _unit_Code;

        public string Unit_Code
        {
            set { _unit_Code = value; }
            get { return _unit_Code; }
        }

        private string _rank_code;

        public string Rank_Code
        {
            get { return _rank_code; }
            set { _rank_code = value; }
        }

        private string _mail;

        public string Mail
        {
            get { return _mail; }
            set { _mail = value; }
        }

        private bool _oversea;

        public bool OverSea
        {
            get { return _oversea; }
            set { _oversea = value; }
        }

        private bool _isExist;

        public bool IsExist
        {
            get {
                return _isExist;
            }
        }

        private bool _isValid;

        public bool IsValid
        {
            get { return _isValid; }
            set { _isValid = value; }
        }

        private bool _isCanReSetPassword;
        public bool IsCanReSetPassword
        {
            get { return _isCanReSetPassword; }
            set { _isCanReSetPassword = value; }
        }

        private string _password;
        public string Password
        {
            get { return _password; }
            set { _password = value; }
        }

        private bool _isMustReSetPassword;
        public bool IsMustReSetPassword
        {
            get { return _isMustReSetPassword; }
            set { _isMustReSetPassword = value; }
        }

        #endregion
    }
}