using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Configuration;



namespace Lib
{

    /// <summary>
    /// DataUtility 的摘要描述
    /// </summary>
    public class DataUtility
    {
        public DataUtility()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
            // for default connection string
            _conString = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
        }

        /// <summary>
        /// Set ConnectionString Value
        /// </summary>
        /// <param name="conString"></param>
        public DataUtility(string conString)
        {
            _conString = conString;
        }

        /// <summary>
        /// Set ConnectionString Value By AppSettings, choice name or index only
        /// </summary>
        /// <param name="conStringName">Connection String Name In Web AppSettings</param>
        /// <param name="index">Connection String Index In Web AppSettings</param>
        public DataUtility(string conStringName, bool isName, int index)
        {
            if (isName)
            {
                _conString = ConfigurationManager.ConnectionStrings[conStringName].ConnectionString;
            }
            else
            {
                _conString = ConfigurationManager.ConnectionStrings[index].ConnectionString;
            }

        }

        private string _conString;

        public string connectionString
        {
            get
            {
                return _conString;
            }
            set
            {
                _conString = value;
            }
        }

        /// <summary>
        /// Return DataTable By Store Procedure
        /// </summary>
        /// <param name="spName">SP name</param>
        /// <param name="pName">parameter name</param>
        /// <param name="value">parameter value</param>
        /// <returns></returns>
        public DataTable getDataTableBysp(string spName, string pName, object value)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue(pName, value);
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dt;
        }

        /// <summary>
        /// Return DataTable By Store Procedure
        /// </summary>
        /// <param name="spName">SP name</param>
        /// <param name="pList">SqlParameter Array</param>
        /// <returns></returns>
        public DataTable getDataTableBysp(string spName, SqlParameter[] pList)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddRange(pList);
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dt;
        }

        public DataTable getDataTableBysp(string spName, Dictionary<string, object> list)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (list != null)
                    {
                        foreach (KeyValuePair<string, object> item in list)
                        {
                            cmd.Parameters.AddWithValue(item.Key, item.Value);
                        }
                    }
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();

            }
            return dt;
        }
        //2017-11-23新增取得成績統計大量資料使用sp(延長timeout)
        public DataTable getDataTableBysp_BigData(string spName, Dictionary<string, object> list)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString+";Connection Timeout=120"))
            {
                
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (list != null)
                    {
                        foreach (KeyValuePair<string, object> item in list)
                        {
                            cmd.Parameters.AddWithValue(item.Key, item.Value);
                        }
                    }
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();

            }
            return dt;
        }

        public DataTable getDataTableBysp(string spName, string p_name, DataTable list)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(p_name, SqlDbType.Structured);
                    cmd.Parameters[p_name].Direction = ParameterDirection.Input;
                    cmd.Parameters[p_name].TypeName = "unit_code_table";
                    cmd.Parameters[p_name].Value = list;
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();

            }
            return dt;
        }

        public DataTable getDataTableByText(string commandText, string p_name, DataTable list)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add(p_name, SqlDbType.Structured);
                    cmd.Parameters[p_name].Direction = ParameterDirection.Input;
                    cmd.Parameters[p_name].TypeName = "unit_code_table";
                    cmd.Parameters[p_name].Value = list;
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();

            }
            return dt;
        }

        /// <summary>
        /// Return DataTable By CommandText
        /// </summary>
        /// <param name="commandText">Sql Command Text</param>
        /// <returns></returns>
        public DataTable getDataTableByText(string commandText, Dictionary<string, object> list)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    if (list != null)
                    {
                        foreach (KeyValuePair<string, object> item in list)
                        {
                            cmd.Parameters.AddWithValue(item.Key, item.Value);
                        }
                    }
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dt;
        }

        public DataTable getDataTableByText(string commandText, string name, object value)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue(name, value);
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dt;
        }

        public DataTable getDataTableByText(string commandText)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    dt.Load(cmd.ExecuteReader());
                }
                con.Close();
            }
            return dt;
        }

        public DataSet getDataSet(string sp_Name, Dictionary<string, object> list, string p_name, DataTable dt)
        {
            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = sp_Name;
                    cmd.CommandType = CommandType.StoredProcedure;
                    foreach (KeyValuePair<string, object> item in list)
                    {
                        cmd.Parameters.AddWithValue(item.Key, item.Value);
                    }
                    cmd.Parameters.Add(p_name, SqlDbType.Structured);
                    cmd.Parameters[p_name].Direction = ParameterDirection.Input;
                    cmd.Parameters[p_name].TypeName = "unit_code_table";
                    cmd.Parameters[p_name].Value = dt;
                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    adp.Fill(ds);
                }
                con.Close();
            }
            return ds;
        }

        /// <summary>
        /// ExecuteNonQuery By Store Procedure
        /// </summary>
        /// <param name="spName">Store Procedure Name</param>
        /// <param name="pName">Sql Parameter Name</param>
        /// <param name="value">Object Value</param>
        public void executeNonQueryBysp(string spName, string pName, object value)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue(pName, value);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
        }



        /// <summary>
        /// ExecuteNonQuery By Store Procedure
        /// </summary>
        /// <param name="spName">Store Procedure Name</param>
        /// <param name="pList">SqlParameter Array</param>
        public void executeNonQueryBysp(string spName, SqlParameter[] pList)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddRange(pList);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
        }

        public void executeNonQueryBysp(string spName, Dictionary<string, object> list)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (list != null)
                    {
                        foreach (KeyValuePair<string, object> item in list)
                        {
                            cmd.Parameters.AddWithValue(item.Key, item.Value);
                        }
                        cmd.ExecuteNonQuery();
                    }

                }
                con.Close();

            }
        }

       

        public void executeNonQueryBysp(string spName, List<Dictionary<string, object>> list)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = spName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (list != null)
                    {
                        foreach (Dictionary<string, object> d in list)
                        {
                            foreach (KeyValuePair<string, object> item in d)
                            {
                                cmd.Parameters.AddWithValue(item.Key, item.Value);
                            }
                            cmd.ExecuteNonQuery();
                            cmd.Parameters.Clear();
                        }
                    }

                }
                con.Close();
            }


        }

        /// <summary>
        /// ExecuteNonQuery By Sql Command Text
        /// </summary>
        /// <param name="commandText">Command Text</param>
        public void executeNonQueryByText(string commandText)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
        }

        public void executeNonQueryByText(string commandText, Dictionary<string, object> list)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    if (list != null)
                    {
                        foreach (KeyValuePair<string, object> item in list)
                        {
                            cmd.Parameters.AddWithValue(item.Key, item.Value);
                        }
                        cmd.ExecuteNonQuery();
                    }

                }
                con.Close();

            }
        }

        public void executeNonQueryByText(string commandText, string name, object value)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;


                    cmd.Parameters.AddWithValue(name, value);

                    cmd.ExecuteNonQuery();


                }
                con.Close();

            }
        }

        public void executeNonQueryByText(string commandText, List<Dictionary<string, object>> list)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    if (list != null)
                    {
                        foreach (Dictionary<string, object> d in list)
                        {
                            foreach (KeyValuePair<string, object> item in d)
                            {
                                cmd.Parameters.AddWithValue(item.Key, item.Value);
                            }
                            cmd.ExecuteNonQuery();
                            cmd.Parameters.Clear();
                        }
                    }

                }
                con.Close();
            }
        }

        /// <summary>
        /// Return Object Value Like Sql Syntax 'select count...'
        /// </summary>
        /// <param name="commandText"></param>
        /// <returns></returns>
        public object executeScalar(string commandText)
        {
            object ob = null;
            using (SqlConnection con = new SqlConnection(_conString))
            {
                con.Open();
                using (SqlCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandType = CommandType.Text;
                    ob = cmd.ExecuteScalar();
                }
                con.Close();
            }
            return ob;
        }

        /// <summary>
        /// Batch Job With Transaction
        /// </summary>
        /// <param name="cmdText">Sql Command Text</param>
        /// <param name="list">List Of SqlParameter Collection</param>
        public void executeNonQueryWithTransaction(string cmdText, List<SqlParameter[]> list)
        {
            using (SqlConnection con = new SqlConnection(_conString))
            {
                SqlTransaction trans;
                trans = con.BeginTransaction();
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = cmdText;
                try
                {
                    foreach (SqlParameter[] pArray in list)
                    {
                        cmd.Parameters.AddRange(pArray);
                        cmd.ExecuteNonQuery();
                    }
                    trans.Commit();
                }
                catch (SqlException ex)
                {
                    trans.Rollback();
                    cmd.Dispose();
                }
            }
        }
        public void executeNonQueryWithTransaction(List<Dictionary<string, List<Dictionary<string, object>>>> list)
        {
            //using (SqlConnection con = new SqlConnection(_conString))
            //{
            //    con.Open();
            //    SqlTransaction trans;
            //    trans = con.BeginTransaction();
            //    try
            //    {
            //        foreach (Dictionary<string, Dictionary<string, List<>> item in list)
            //        {
            //            SqlCommand cmd = con.CreateCommand();
            //            cmd.CommandText = item.Keys.ToString();
            //            cmd.CommandType = CommandType.StoredProcedure;
            //            if (item.Values != null)
            //            {
            //                foreach (Dictionary<string, object> pair in item.Values)
            //                {
            //                    cmd.Parameters.Add(pair.Keys.ToString(), pair.Values);
            //                }
            //            }
            //            cmd.ExecuteNonQuery();
            //            cmd.Dispose();
            //        }
            //        trans.Commit();
            //    }
            //    catch (Exception ex)
            //    {
            //        trans.Rollback();
            //    }
            //    con.Close();
            //}
        }
    }
}