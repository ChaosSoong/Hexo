---
title: 'CSharp读取Excel表格'
date: 2016-10-14 14:49:49
tags: [CSharp,sql]
categories: CSharp
---
前两天把dae批量转换为gltf后,需要新建三维模型表,该表一共八个字段,共有100多条记录,所以手动导入数据库甚是麻烦,而且主键ID要唯一,就想到使用GUID类,模型路径和缩略图都是长字符串,所以就 先存到Excel表格里,再获取表格里内容,插入到数据库中.代码见下(有注释哦)
<!--more-->
		public string GetExcel()
        	{
            gasgisEntities db = new gasgisEntities();
            string createsql = "CREATE TABLE public.t_3DModels(ID character varying(32) NOT NULL,code character varying(20),order1 character varying(20),name1 character varying(32),modelPath character varying(40),thumbnailpath character varying(40),remark character varying(32),gltfSize int,CONSTRAINT 't_3DModels_pkey' PRIMARY KEY (ID))";
            db.Database.ExecuteSqlCommand(createsql);//创建三维表
            HttpPostedFileBase systembackground = Request.Files["systembackground"];
            string newname = Request["txtname"]; //获取重命名  
            string filename = "";
            string filenames = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";
            string path = "";
            foreach (string upload in Request.Files)
            {        
                path = AppDomain.CurrentDomain.BaseDirectory + "uploads/";
                filename = Path.GetFileName(Request.Files[upload].FileName);
                Request.Files[upload].SaveAs(Path.Combine(path, filenames));//保存文件
            }
            string filenameurl = Server.MapPath("/") + "uploads\\" + filenames;
            string strConn = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + filenameurl + ";Extended Properties='Excel 12.0; HDR=NO; IMEX=1'";
            OleDbConnection conn = new OleDbConnection(strConn);
            conn.Open();
            string strExcel = "";
            OleDbDataAdapter myCommand = null;
            DataSet ds = null;
            string[] names = filename.Split('.');
            // 得到包含数据架构的数据表
            System.Data.DataTable dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            if (dt == null)
            {
                return null;
            }
            else
            {
                String[] Sheets = new String[dt.Rows.Count];
                // 添加工作表名称到字符串数组
                foreach (DataRow row in dt.Rows)
                {
                    string strSheetTableName = row["TABLE_NAME"].ToString();
                    //过滤无效SheetName
                    if (strSheetTableName.Contains("$") && strSheetTableName.Replace("'", "").EndsWith("$"))
                    {
                        strExcel = "select * from [" + strSheetTableName + "]";
                        myCommand = new OleDbDataAdapter(strExcel, conn);
                        ds = new DataSet();
                        myCommand.Fill(ds, "table1");
                        string ID, code, order, name, modelPath, thumbnailpath, remark, gltfsize;
                        try
                        {
                            ID = ds.Tables[0].Rows[0][0].ToString().Trim();
                            code = ds.Tables[0].Rows[0][1].ToString().Trim();
                            order = ds.Tables[0].Rows[0][2].ToString().Trim();
                            name = ds.Tables[0].Rows[0][3].ToString().Trim();
                            modelPath = ds.Tables[0].Rows[0][4].ToString().Trim();
                            thumbnailpath = ds.Tables[0].Rows[0][5].ToString().Trim();
                            remark = ds.Tables[0].Rows[0][6].ToString().Trim();
                            gltfsize = ds.Tables[0].Rows[0][7].ToString().Trim();
                        }
                        catch (Exception e)
                        {
                            e.ToString();
                        }
                        DataRowCollection drc = ds.Tables[0].Rows;
						//开始读取数据
                        for (var i = 1; i < drc.Count; i++)
                        {
                            string ID1 = Guid.NewGuid().ToString("N");
                            string code1 = drc[i][1].ToString().Trim();
                            string order1 = drc[i][2].ToString().Trim();
                            string name1 = drc[i][3].ToString().Trim();
                            string modelPath1 = drc[i][4].ToString().Trim();
                            string thumbnailpath1 = drc[i][5].ToString().Trim();
                            string remark1 = drc[i][6].ToString().Trim();
                            string gltfsize1 = drc[i][7].ToString().Trim();
                            string insql = "insert into public.t_3dmodels (ID,code,order1,name1,modelPath,thumbnailpath,remark,gltfsize) values ('" + ID1 + "','" + code1 + "','" + order1 + "','" + name1 + "','" + modelPath1 + "','" + thumbnailpath1 + "','" + remark1 + "','" + gltfsize1 + "')";
                            db.Database.ExecuteSqlCommand(insql);
                        }
                    }
                }
                return "ok";
            }
        }

说说遇到的坑:

1. 表格的第一行是字段名,应该从第二行开始插入 所以从**i=1**开始
2. 由于模型路径过长,超过了32,所以会报错,致使一条数据也插入不进去