using System;
using System.Collections.Generic;
using System.Web;
using System.Data;


namespace Lib
{
    /// <summary>
    /// Unit 的摘要描述
    /// </summary>
    public class Unit
    {
        private DataUtility du;
        private string _unit_code;
        private string _unit_title;
        private string _parent_unit_code;
        private string _service_cdoe;
        private string _parent_title;
        private bool _isEmpty = false;
        private Dictionary<string, object> d;
        private Dictionary<string, Lib.Unit> _childUnit;
        private Array _array;
        private string _SqlText;
        private Dictionary<string, string> list;
        private int _childUnitCount;
        private DataTable _childUnitCodeTable;
        private string[] _childUnitCodeArray;
        private string[] _parentUnitCodeArray;

        public Unit()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public Unit(string unit_code)
        {
            this._unit_code = unit_code;
            du = new DataUtility();
            DataTable dt = du.getDataTableByText("select * from unit where unit_code = @unit_code", "unit_code", this._unit_code);
            if (dt.Rows.Count == 1)
            {
                this._unit_title = dt.Rows[0]["unit_title"].ToString();
                this._parent_unit_code = dt.Rows[0]["parent_unit_code"].ToString();
                this._service_cdoe = dt.Rows[0]["service_code"].ToString();
            }
            if (dt.Rows.Count == 0)
            {
                this._isEmpty = true;
            }
            else
            {
               // throw new Exception("unit_code is override");
            }
        }

        public string Unit_Code
        {
            get
            {
                return _unit_code;
            }
            set {
                _unit_code = value;
            }
        }

        public string Unit_Title
        {
            get {
                return _unit_title;
            }
            set
            {
                _unit_title = value;
            }
        }

        public string Parent_Title
        {
            get {
                return this._parent_title;
            }
            set {
                this._parent_title = value;
            }
        }

        public bool IsEmpty
        {
            get {
                return _isEmpty;
            }
        }
        public string Parent_Unit_Code
        {
            set {
                _parent_unit_code = value;
            }
            get
            {
                return this._parent_unit_code;
            }
        }
        public string Service_Code
        {
            set {
                _service_cdoe = value;
            }
            get
            {
                return this._service_cdoe;
            }
        }
        public void CreateNewUnit()
        {
            if (this._isEmpty == true)
            {
                du = new DataUtility();
                d.Add("unit_code", this._unit_code);
                d.Add("unit_title", this._unit_title);
                d.Add("unit_parent_unit_code", this._parent_unit_code);
                d.Add("service_code", this._service_cdoe);
                du.executeNonQueryByText("insert into unit values (@unit_code,@unit_title,@parent_unit_code,@service_code)", d);
            }
        }

        public Array Child
        {
            get {
                return _array;
            }
            set {
                _array = value;
            }
        }

        public Dictionary<string, Lib.Unit> ChildUnit
        {
            get
            {
                return _childUnit;
            }
            set
            {
                _childUnit = value;
            }
        }

        public Dictionary<string, string> ChildUnitList
        {
            get
            {
                return list;
            }
            set
            {
                list = value;
            }
        }

        public string SqlCmdText
        {
            get
            {
                return _SqlText;
            }
            set
            {
                _SqlText = value;
            }
        }

        public int ChildUnitCount
        {
            get
            {
                return _childUnitCount;
            }
            set
            {
                _childUnitCount = value;
            }
        }

        public DataTable ChildUnitCodeTable
        {
            get
            {
                return _childUnitCodeTable;
            }
            set
            {
                _childUnitCodeTable = value;
            }
        }

        public string[] ChildUnitCodeArray
        {
            get
            {
                return _childUnitCodeArray;
            }
            set
            {
                _childUnitCodeArray = value;
            }
        }

        public string[] ParentUnitCodeArray
        {

            get
            {
                return _parentUnitCodeArray;
            }
            set
            {
                _parentUnitCodeArray = value;
            }
        }

    }

    public class UnitTree
    {
        private Dictionary<string, Unit> d;
        private Unit _u;
        private string SqlCmd = string.Empty;
        private Dictionary<string, string> list = new Dictionary<string, string>();
        private List<string> unitCodeList = new List<string>();
        private List<string> parentunitCodeList = new List<string>();

        /// <summary>
        /// Unit Tree Contruct For Format All Unit Tree From DataBase
        /// </summary>
        public UnitTree()
        {
            Lib.DataUtility du = new Lib.DataUtility();
            DataTable dt = du.getDataTableByText("select * from unit", null);
            d = new Dictionary<string, Lib.Unit>();
            foreach (DataRow row in dt.Rows)
            {
                Lib.Unit unit = new Lib.Unit();
                unit.Unit_Code = row["unit_code"].ToString();
                unit.Parent_Unit_Code = row["parent_unit_code"].ToString();
                unit.Unit_Title = row["unit_title"].ToString();
                unit.Service_Code = row["service_code"].ToString();
                d.Add(unit.Unit_Code, unit);
            }
            foreach (KeyValuePair<string, Lib.Unit> item in d)
            {
                Lib.Unit u = (Lib.Unit)item.Value;
                //if (u.Parent_Unit_Code != "")
                //{
                    var parent_code = u.Parent_Unit_Code;
                    foreach (KeyValuePair<string, Lib.Unit> parent in d)
                    {
                        if (parent_code == ((Lib.Unit)parent.Value).Unit_Code)
                        {
                            if (((Lib.Unit)parent.Value).ChildUnit == null)
                            {
                                u.Parent_Title = ((Lib.Unit)parent.Value).Unit_Title;

                                ((Lib.Unit)parent.Value).ChildUnit = new Dictionary<string, Lib.Unit>();
                                
                                ((Lib.Unit)parent.Value).ChildUnit.Add(u.Unit_Code, u);
                            }
                            else
                            {
                                u.Parent_Title = ((Lib.Unit)parent.Value).Unit_Title;

                                ((Lib.Unit)parent.Value).ChildUnit.Add(u.Unit_Code, u);
                            }
                            break;
                        }

                    }
                //}
            }

        
        }
        /// <summary>
        /// Get Unit Class With Child Unit Array
        /// </summary>
        /// <param name="unit_code"></param>
        /// <returns></returns>
        public Unit GetUnitWithChild(string unit_code)
        {
            foreach (KeyValuePair<string, Unit> item in d)
            {
                if (((Unit)item.Value).Unit_Code == unit_code)
                {
                    _u = (Unit)item.Value;
                    break;
                }
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("unit_code");

            Lib.Unit unit = _u; // if unit is the biggest 國防部

            #region Sql Command And List

            list.Clear();

            // add self data first
            list.Add(unit.Unit_Code, unit.Unit_Title);
            unitCodeList.Add(unit.Unit_Code);
            DataRow firstRow = dt.NewRow();
            firstRow[0] = unit.Unit_Code;
            dt.Rows.Add(firstRow);

            // then the parent unit
            string myparentunit = "";
            if (unit.Unit_Code == "00001")
            {
                parentunitCodeList.Add(unit.Unit_Code);
            }
            else
            {
                if (unit.Parent_Unit_Code != null)  //this should be 排
                {
                    parentunitCodeList.Add(unit.Parent_Unit_Code);
                    myparentunit = unit.Parent_Unit_Code;
                    Lib.Unit _pu = new Lib.Unit(myparentunit);
                    if (_pu.Parent_Unit_Code != null)  //this should be 連
                    {
                        parentunitCodeList.Add(_pu.Parent_Unit_Code);
                        myparentunit = _pu.Parent_Unit_Code;
                        Lib.Unit _pu_2 = new Lib.Unit(myparentunit);
                        if (_pu_2.Parent_Unit_Code != null)  //this should be 營
                        {
                            parentunitCodeList.Add(_pu_2.Parent_Unit_Code);
                            myparentunit = _pu_2.Parent_Unit_Code;
                            Lib.Unit _pu_3 = new Lib.Unit(myparentunit);
                            if (_pu_3.Parent_Unit_Code != null)  //this should be 旅
                            {
                                parentunitCodeList.Add(_pu_3.Parent_Unit_Code);
                                myparentunit = _pu_3.Parent_Unit_Code;
                                Lib.Unit _pu_4 = new Lib.Unit(myparentunit);
                                if (_pu_4.Parent_Unit_Code != null)  //this should be 司令部
                                {
                                    parentunitCodeList.Add(_pu_4.Parent_Unit_Code);
                                }
                            }
                        }
                    }
                }
            }

            // then the children unit
            if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
            {
                foreach (KeyValuePair<string, Lib.Unit> child_1 in unit.ChildUnit) // this should be 陸總部
                {
                    Lib.Unit myUnit = child_1.Value as Lib.Unit;
                    list.Add(myUnit.Unit_Code, myUnit.Unit_Title);
                    unitCodeList.Add(myUnit.Unit_Code);
                    DataRow row_1 = dt.NewRow();
                    row_1[0] = myUnit.Unit_Code;
                    dt.Rows.Add(row_1);
                    
                    if (myUnit.ChildUnit != null && myUnit.ChildUnit.Count != 0)
                    {
                        foreach (KeyValuePair<string, Lib.Unit> child_2 in myUnit.ChildUnit) // this should be 旅級
                        {
                            Lib.Unit myUnit_2 = child_2.Value as Lib.Unit;
                            list.Add(myUnit_2.Unit_Code, myUnit_2.Unit_Title);
                            unitCodeList.Add(myUnit_2.Unit_Code);
                            DataRow row_2 = dt.NewRow();
                            row_2[0] = myUnit_2.Unit_Code;
                            dt.Rows.Add(row_2);
                            if (myUnit_2.ChildUnit != null && myUnit_2.ChildUnit.Count != 0)
                            {
                                foreach (KeyValuePair<string, Lib.Unit> child_3 in myUnit_2.ChildUnit) // this should be 營級
                                {
                                    Lib.Unit myUnit_3 = child_3.Value as Lib.Unit;
                                    list.Add(myUnit_3.Unit_Code, myUnit_3.Unit_Title);
                                    unitCodeList.Add(myUnit_3.Unit_Code);
                                    DataRow row_3 = dt.NewRow();
                                    row_3[0] = myUnit_3.Unit_Code;
                                    dt.Rows.Add(row_3);
                                    if (myUnit_3.ChildUnit != null && myUnit_3.ChildUnit.Count != 0)
                                    {
                                        foreach (KeyValuePair<string, Lib.Unit> child_4 in myUnit_3.ChildUnit) // this should be 連級
                                        {
                                            Lib.Unit myUnit_4 = child_4.Value as Lib.Unit;
                                            list.Add(myUnit_4.Unit_Code, myUnit_4.Unit_Title);
                                            unitCodeList.Add(myUnit_4.Unit_Code);
                                            DataRow row_4 = dt.NewRow();
                                            row_4[0] = myUnit_4.Unit_Code;
                                            dt.Rows.Add(row_4);
                                            if (myUnit_4.ChildUnit != null && myUnit_4.ChildUnit.Count != 0)
                                            {
                                                foreach (KeyValuePair<string, Lib.Unit> child_5 in myUnit_4.ChildUnit)
                                                {
                                                    // this should be 排級
                                                    Lib.Unit myUnit_5 = child_5.Value as Lib.Unit;
                                                    list.Add(myUnit_5.Unit_Code, myUnit_5.Unit_Title);
                                                    unitCodeList.Add(myUnit_5.Unit_Code);
                                                    DataRow row_5 = dt.NewRow();
                                                    row_5[0] = myUnit_5.Unit_Code;
                                                    dt.Rows.Add(row_5);
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
            SqlCmd = "";
            if (list.Count != 0)
            {
                foreach (KeyValuePair<string, string> pair in list)
                {
                    SqlCmd += "'" + pair.Key + "',";
                    //SqlCmd += pair.Key + ",";
                }
                SqlCmd = SqlCmd.Substring(0, SqlCmd.Length - 1);
            }
            
            _u.SqlCmdText = SqlCmd;
            _u.ChildUnitList = list;
            _u.ChildUnitCount = list.Count;
            _u.ChildUnitCodeTable = dt;
            _u.ChildUnitCodeArray = unitCodeList.ToArray();
            _u.ParentUnitCodeArray = parentunitCodeList.ToArray();
            #endregion

            

            return _u;
        }
        /// <summary>
        /// Get All Unit Tree Array
        /// </summary>
        /// <returns></returns>
        public Dictionary<string, Unit> GetUnitTree()
        {
            return d;
        }

        public Unit GetParentUnitWhitChild(string unit_code)
        {
            foreach (KeyValuePair<string, Unit> item in d)
            {
                if (((Unit)item.Value).Unit_Code == unit_code)
                {
                    _u = (Unit)item.Value;
                    break;
                }
            }

            return _u;
        }
    }

}