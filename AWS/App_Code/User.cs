using System;
using System.Collections.Generic;
using System.Web;
using System.Data;


namespace Lib
{
    /// <summary>
    /// User 的摘要描述
    /// </summary>
    public class User
    {
        private string _account;
        private string _pwd;
        private string _grantedip;
        private string _clientip;
        private string _name;
        private string _rank;
        private string _unit;
        

        public User()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public User(string account, string pwd, string ipAddr)
        {
            _account = account;
            _pwd = pwd;
            _clientip = ipAddr;
            if (SysSetting.isIPLock)
            { 
            
            }
        }

        public string Account
        {
            get {
                return _account;
            }
            set
            {
                _account = value;
            }
        }

        public string Password
        {
            get
            {
                return _pwd;
            }
            set
            {
                _pwd = value;
            }
        }

        public string IP
        {
            get {

                return _grantedip;
            }

            set{
                _grantedip = value;
            }
            
        }

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

        public string Rank
        {
            get
            {
                return _rank;
            }
            set
            {
                _rank = value;
            }
        }

        public string Unit
        {
            get 
            {
                return _unit;
            }
            set
            {
                _unit = value;
            }
        }
            
    }

    public class UserUtility
    {
        public UserUtility()
        { 
        
        }
    }

}