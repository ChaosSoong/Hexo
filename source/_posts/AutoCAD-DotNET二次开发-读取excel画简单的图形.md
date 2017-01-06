---
title: 'AutoCAD DotNET二次开发,读取excel画简单的图形'
date: 2016-12-10 17:27:09
tags: [AutoCAD,DotNet,CSharp]
categories: CAD.NET
---
继上一篇AutoCAD开发环境搭建完毕之后,现实现一个避免手动画图,减少工作量,局限,暂时只能画一些简单的图形,还要深入挖掘.
需要引入的命名空间:

    using System.Threading.Tasks;
    using Autodesk.AutoCAD.EditorInput;
    using Autodesk.AutoCAD.ApplicationServices;
    using Autodesk.AutoCAD.Runtime;
    using Autodesk.AutoCAD.DatabaseServices;
    using Autodesk.AutoCAD.Geometry;
    using System.Data.OleDb;
    using System.Data;
    using Autodesk.AutoCAD.Colors;
<!--more-->
        // 获取当前文档及数据库

                Document acDoc = Application.DocumentManager.MdiActiveDocument;
                Database acCurDb = acDoc.Database;
                string filenameurl = "excel表格url";
                string strConn = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + filenameurl + ";Extended Properties='Excel 12.0; HDR=NO; IMEX=1'";
                OleDbConnection conn = new OleDbConnection(strConn);
                System.Threading.Thread.Sleep(500);//为什么sleep一会儿,有时这里会报错,睡一会就好了,也不知道为什么
                conn.Open();
                string strExcel = "";
                OleDbDataAdapter myCommand = null;
                DataSet ds = null;
                // 得到包含数据架构的数据表
                System.Data.DataTable dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                if (dt == null)
                {
                    return ;
                }else
                {
                    String[] Sheets = new String[dt.Rows.Count];
                    // 添加工作表名称到字符串数组
                    foreach (DataRow row in dt.Rows)
                    {
                        string strSheetTableName = row["TABLE_NAME"].ToString();
                        if (strSheetTableName == "sheet_NAME$")
                        {
                            //过滤无效SheetName
                            if (strSheetTableName.Contains("$") && strSheetTableName.Replace("'", "").EndsWith("$"))
                            {
                                strExcel = "select * from [" + strSheetTableName + "]";
                                myCommand = new OleDbDataAdapter(strExcel, conn);
                                ds = new DataSet();
                                myCommand.Fill(ds, "table1");
                                string name, x, y, type;
                                try
                                {//表格数据
                                    name = ds.Tables[0].Rows[0][0].ToString().Trim();
                                    x = ds.Tables[0].Rows[0][1].ToString().Trim();
                                    y = ds.Tables[0].Rows[0][2].ToString().Trim();
                                    type = ds.Tables[0].Rows[0][3].ToString().Trim();
                                }
                                catch (System.Exception e)
                                {
                                    e.ToString();
                                }
                                DataRowCollection drc = ds.Tables[0].Rows;
                                // 启动事务
                                using (Transaction acTrans = acCurDb.TransactionManager.StartTransaction())
                                {
                                    // 为图层定义颜色数组
                                    Color[] acColors = new Color[2];
                                    acColors[0] = Color.FromColorIndex(ColorMethod.ByAci, 1);
                                    acColors[1] = Color.FromRgb(23, 54, 232);//rgb
                                for (var i = 1; i < drc.Count; i++)
                                {
                                    string name1 = drc[i][0].ToString().Trim();
                                    double x1 = double.Parse(drc[i][1].ToString().Trim());
                                    double y1 = double.Parse(drc[i][2].ToString().Trim());
                                    string type1 = drc[i][3].ToString().Trim();
                                        // 以读模式打开 Block 表
                                        BlockTable acBlkTbl;
                                        acBlkTbl = acTrans.GetObject(acCurDb.BlockTableId, OpenMode.ForRead) as BlockTable;
                                        // 以写模式打开 Block 表记录 Model 空间
                                        BlockTableRecord acBlkTblRec;
                                        acBlkTblRec = acTrans.GetObject(acBlkTbl[BlockTableRecord.ModelSpace],
                                        OpenMode.ForWrite) as BlockTableRecord;
                                        //绘圆
                                        Circle acCirc = new Circle();
                                        acCirc.Center = new Point3d(x1, y1, 0);
                                        acCirc.Radius = 0.0001;
                                        acCirc.ColorIndex = 4;
                                        acCirc.Color = acColors[1];
                                        // 创建一个单行文字对象
                                        DBText acText = new DBText();
                                        acText.Position = new Point3d(x1, y1, 0);
                                        acText.Height = 0.0001;
                                        acText.TextString = name1;
                                        acText.Color = acColors[0];
                                        // 添加到模型空间
                                        acBlkTblRec.AppendEntity(acCirc);
                                        acBlkTblRec.AppendEntity(acText);
                                        acTrans.AddNewlyCreatedDBObject(acText, true);
                                        acTrans.AddNewlyCreatedDBObject(acCirc, true);
                                    }
                                // 保存修改，关闭事务
                                acTrans.Commit();
                                }
                            string strDWGName = acDoc.Name;
                            object obj = Application.GetSystemVariable("DWGTITLED");
                            //图形命名了吗？ 0-没呢
                            if (System.Convert.ToInt16(obj) == 0)
                            {
                                // 如果图形使用了默认名 (Drawing1、 Drawing2 等)，
                                // 就提供一个新文件名
                                strDWGName = "d:\\MyDrawing.dwg";
                            }
                            // 保存图形
                            acDoc.Database.SaveAs(strDWGName, true, DwgVersion.Current, acDoc.Database.SecurityParameters);
                        }
                    }
                }
            }
        }