---
title: 总结的postGIS函数
date: 2017-03-07 11:09:13
tags: postGIS
categories: postGIS
---
还记得初到公司的时候,就让我看postGIS函数,大概有2000多个,记下来谈何容易,[这是官网](http://www.postgis.org/),看了有大概两天,记录一下经常用到的,描述可能不够贴切,还需自己亲自实践一下.
<!--more-->
## Management Functions

1.  AddGeometryColumn(<schema_name>, <table_name>, <column_name>, <srid>, <type>, <dimension>) 
给一个已存在属性数据表增加一个几何字段(geomtry column)。schema_name 指表的模式的名字，table_name 表名，srid 必须是一个整数指对应于 SPATIAL_REF_SYS 表，type必须是一个大写的字符串，用来描述几何类型，例如：'POLYGON' 或者 'MULTILINESTRING'，dimension空间维度。Return text
2. DropGeometryColumn()移除表中的几何列。Return text
3. DropGeometryTable()移除表和它关联的几何列。Return Boolean
4. PostGIS_Full_Version()返回完整版的postgis及相关构建配置信息。return text
5. PostGIS_GEOS_Version()返回GEOS的版本号。Return text
6. PostGIS_LibXML_Version()返回LibXML的版本号。Return text
7. PostGIS_Lib_Build_Date()，返回建库的日期。Return text
8. PostGIS_Lib_Version()，返回库的版本号。Return text
9. PostGIS_PROJ_Version()，返回PROJ4的版本号。Return text
10. PostGIS_Scripts_Build_Date()，返回建立postgis的脚本日期，return text
11. PostGIS_Scripts_Installed()，脚本升级的日期。Return text
12. UpdateGeometrySRID()，更新SRID。Return text 

## Geometry Constructors

1. ST_BdPolyFromText()构建一个多边形给定的任意集合的关闭线作为MultiLineString WKT表示。
2. ST_BdMPolyFromText ()构建多个多边形任意的集合MultiLineString文本WKT表示。
3. ST_GeogFromText ()从WKT表示返回一个指定的地理值。
4. ST_GeographyFromText()从WKT表示返回一个指定的地理值。
5. ST_GeogFromWKB()创建一个地理实例从WKB或EWKB。
6. ST_GeomCollFromText()让一组几何与给定集合WKT SRID。 如果SRID 不给,它默认为-1。
7. ST_GeomFromEWKB ()返回一个指定ST_Geometry值扩展EWKB。
8. ST_GeomFromEWKT ()返回一个指定ST_Geometry值扩展EWKT。
9. ST_GeometryFromText()返回一个指定从著名的文本表示ST_Geometry值。 这是一个为ST_GeomFromText别名
10. ST_GeomFromGML()需要作为输入的GML表示几何和输出PostGIS几何对象
11. ST_GeomFromKML()需要作为输入的KML表示几何和输出PostGIS几何对象
12. ST_GMLToSQL()返回一个指定从GML ST_Geometry值表示。 这是一个为ST_GeomFromGML别名
13. ST_GeomFromText()返回一个指定从著名的文本表示ST_Geometry值。
14. ST_GeomFromWKB ()创建一个几何实例从WKB和可选的SRID。
15. ST_LineFromMultiPoint 一个LineString()创建从一个多点几何学。
16. ST_LineFromText ()使几何与给定的WKT表示SRID。 如果SRID 不,它默认为-1。
17. ST_LineFromWKB()了 LINESTRING 从WKB SRID
18. ST_LinestringFromWKB()几何与给定的WKB SRID。
19. ST_MakeBox2D()创建一个BOX2D定义为给定的点 几何图形。
20. ST_MakeBox3D() 创建一个BOX3D定义为给定的3 d点几何图形。
21. ST_MakeLine()创建从几何图形。
22. ST_MakeEnvelope ()创建一个矩形多边形由给定的极限和最大值。 输入指定的值必须在SRID中。
23. ST_MakePolygon ()创建一个多边形由给定的壳。 输入几何图形必须关闭线。
24. ST_MakePoint ()创建一个2 d,3 dz或4 d点几何。
25. ST_MakePointM ()创建一个点几何x y和m坐标。
26. ST_MLineFromText ()返回一个指定从WKT ST_MultiLineString值表示。
27. ST_MPointFromText ()几何与给定的WKT SRID。 如果SRID 不给,它默认为-1。
28. ST_MPolyFromText()使多个多边形几何与给定的WKT SRID。 如果SRID 不给,它默认为-1。
29. ST_Point()返回一个ST_Point与给定的坐标值。 OGC ST_MakePoint别名。
30. ST_PointFromText ()使几何与给定的WKT SRID。 如果SRID 不给出,它默认为-1。
31. ST_PointFromWKB()几何与给定的WKB SRID
32. ST_Polygon()返回一个多边形由指定linestring和SRID。
33. ST_PolygonFromText()几何与给定的WKT SRID。 如果SRID 不给,它默认为-1。
34. ST_WKBToSQL ()返回一个指定从WKB表示ST_Geometry值。 这是一个别名,ST_GeomFromWKB srid
35. ST_WKTToSQL()返回一个指定从WKT表示ST_Geometry值。 这是一个为ST_GeomFromText别名

## Geometry Accessors

1. GeometryType(geometry geomA)，return text
2．ST_Boundary(geometry geomA)，几何类型的边界，return geometry
3. ST_CoordDim(geometry geomA)，返回几何的维度，2、3、4维return integer
4. ST_Dimension(geometry g)几何图形的最大维度，例如，点返回1，线返回2，不知名的则返回null
5. ST_EndPoint(geometry g)，线的最后一个点，return Boolean
6. ST_Envelope(geometry g1)，几何图形的边框，geometry
7. ST_ExteriorRing(geometry a_polygon)，必须是polygon，否则返回null
8. ST_GeometryN(geometry geomA, integer n)，从1开始的第n个图形，不是geometry则返回null
9. ST_GeometryType(geometry g1)，g1类型的值，return text
10. ST_InteriorRingN(geometry a_polygon, integer n)，第n的位置插入a_polygon,如果不是polygon或超出界限，则返回null
11. ST_IsClosed(geometry g)，g是闭合的返回true，例如：线-起点终点重合，多面体表面闭合
12. ST_IsCollection(geometry g)如果g是GEOMETRYCOLLECTION
MULTI{POINT,POLYGON,LINESTRING,CURVE,SURFACE} COMPOUNDCURVE任意其中一个，返回true，否则false
13. ST_IsEmpty(geometry geomA)，判断geometryA是否使一个几何体的集合
14. ST_IsRing(geometry g)判断g是否是闭合的简单的linestring
15. ST_IsSimple(geometry g)判断g是否有异常点，相交或相切
16. ST_IsValid(geometry g)，判断g是否很好的形成
17. ST_IsValidReason(geometry g)返回g很好形成的原因声明或没有很好形成的原因声明
18. ST_IsValidDetail(geometry g)返回g很好形成与否的细节，如果无效，指出原因的出错地点
19. ST_M(geometry a_point)返回点的坐标，输入必须为点，float
20. ST_NDims(geometry g)几何图形g的维度，2、3或4
21. ST_NPoints(geometry g)返回g中点的个数
22. ST_NRings(geometry g) polygon or multi-polygon中圈的个数
23. ST_NumGeometries(geometry g)如果g是GEOMETRYCOLLECTION (or MULTI*)则返回图形的个数，单一则返回1，没有则返回0
24. ST_NumInteriorRings(geometry a_polygon)必须是POLYGON或 MULTIPOLYGON，返回第一个多边形的环数，否则返回null
25. ST_NumInteriorRing(geometry a_polygon)和上边的同义
26. ST_NumPatches(geometry g1)多面体表面的面数，没有则返回null
27. ST_NumPoints(geometry g)g中点数，同ST_NPoints(geometry g)
28. ST_PatchN(geometry geom, integer n)，从1开始的第n个面，没有面就返回null
29. ST_PointN(geometry a_linestring, integer n)，几何图形a_linestring中第n个图形，没有线串或圆弧就返回null
30. ST_SRID(geometry g)，srid
31. ST_StartPoint(geometry geom)线穿图形的第一个点
32. ST_Summary(geometry g)，g的摘要，比如有几个点，几个环等
33. ST_X(geometry a_point)必须是一个点，点的X坐标
34. ST_Y(geometry a_point) 必须是一个点，点的Y坐标
35. ST_Z(geometry a_point) 必须是一个点，点的Z坐标
36. ST_XMax(box3d aGeomorBox2DorBox3D)最大的X坐标
37. ST_YMax(box3d aGeomorBox2DorBox3D)最大的Y坐标
38. ST_ZMax(box3d aGeomorBox2DorBox3D)最大的Z坐标
39. 同样还有最小的坐标
40. ST_Zmflag(geometry geomA) 0=2d, 1=3dm, 2=3dz, 3=4d，smallint

##　Geometry Editors

1. ST_AddPoint(geometry linestring, geometry point, <integer position>)在线串中添加一个点，第三个参数可以省略或设置为-1
2. ST_Affine(geometry geomA, float a, float b, float c, float d, float e, float f, float g, float h, float i, float xoff, float yoff,
float zoff)对几何图形进行3D变换，翻转、旋转、缩放等
3. ST_Force_2D(geometry geomA)强制转换成2维模式，输出只有XY坐标
4. ST_Force_3D(geometry geomA)3D模式
5. ST_Force_4D(geometry geomA)XYZM模式
6. ST_Force_3DM(geometry geomA)XYM模式同ST_Force_3D(geometry geomA)
7. ST_Force_3DZ(geometry geomA)XYZ模式
8. ST_Force_Collection(geometry geomA)强制转换成GEOMETRYCOLLECTION
9. ST_ForceRHR(geometry g)强制顶点的方向在多边形中遵循右手定则
10. ST_LineMerge(geometry amultilinestring)线串的合并，如果不能被合并，返回原始数据
11. ST_CollectionExtract(geometry collection, integer type)返回包含特定类型type的元素
12. ST_CollectionHomogenize(geometry collection)返回collection中最简化形式，比如，一个点则返回一个点，两个点则返回一条线
13. ST_Multi(geometry g)，如果g不是multi(*)类型，则返回multi（*）类型，如果是，则不发生改变
14. ST_RemovePoint(geometry linestring, integer offset)移除linestring中的点，offset为偏移量从0开始
15. ST_Reverse(geometry g)将g 中顶点顺序颠倒
16. ST_Rotate(geometry geomA, float rotRadians)关于原点逆时针旋转rotradians角度
ST_Rotate(geometry geomA, float rotRadians, float x0, float y0) 关于（x0,y0）逆时针旋转rotradians角度
ST_Rotate(geometry geomA, float rotRadians, geometry pointOrigin)基于pointOrigin图形旋转
17. ST_RotateX(geometry geomA, float rotRadians)绕X轴旋转
18. ST_RotateY(geometry geomA, float rotRadians) 绕Y轴旋转
19. ST_RotateZ(geometry geomA, float rotRadians) 绕Z轴旋转
20. ST_Scale(geometry geomA, float XFactor, float YFactor, float ZFactor)缩放XYZ
21. ST_Segmentize(geometry g, float max_length)返回g中不大于max_length长度的形状，只适合2D
22.　ST_SetPoint(geometry linestring, integer zerobasedposition, geometry point)替换linestring中的点，位置从0开始
23. ST_SetSRID(geometry geom, integer srid)设置srid值
24. ST_SnapToGrid(geometry geomA, float originX, float originY, float sizeX, float sizeY)捕捉输入的XYZ点到网格
ST_SnapToGrid(geometry geomA, float sizeX, float sizeY)
ST_SnapToGrid(geometry geomA, float size);
ST_SnapToGrid(geometry geomA, geometry pointOrigin, float sizeX, float sizeY, float sizeZ, float sizeM)
25. ST_Snap(geometry input, geometry reference, float tolerance)
26. ST_Transform(geometry g, integer srid)返回一个新的几何图形，g的坐标引用srid中的参数
27. ST_Translate(geometry g1, float deltax, float deltay)将g1平移deltax,deltay位置
geometry ST_Translate(geometry g1, float deltax, float deltay, float deltaz)将g1平移XYZ轴deltax,deltay,deltaz位置
28. ST_TransScale(geometry geomA, float deltaX, float deltaY, float XFactor, float YFactor)只在2D中使用，XY轴平移参数deltaX、deltaY，XY轴缩放参数Xfactor，Yfactor

##　Geometry Outputs

1. ST_AsBinary(geometry g1，<text NDR_or_XDR>)返回g1的WKB形式,不带srid参数，第二个参数可选，编码格式NDR或XDR
2. ST_AsEWKB(geometry g1)用法同上，只是加上srid参数
3. ST_AsEWKT(geometry g1)返回带有srid参数的WKT形式
4. ST_AsGeoJSON(geometry geom, integer maxdecimaldigits=15, integer options=0)，以json形式返回几何体类型，2D、3D都支持
5.　ST_AsGML(<integer version>，geometry geom, integer maxdecimaldigits=15, integer options=0)以GML形式返回几何体类型，GML版本2或3，默认的是2
6. ST_AsHEXEWKB(geometry g1, text NDRorXDR)返回g1的HEXEWKB格式，编码方式可选NDR或XDR
7. ST_AsKML(integer version, geometry geom, integer maxdecimaldigits=15, text nprefix=NULL) 以KML形式返回几何体类型
8. ST_AsSVG(geometry geom, integer rel=0, integer maxdecimaldigits=15)
ST_AsSVG(geography geog, integer rel=0, integer maxdecimaldigits=15)返回geom或geog的svg路径数据，第二个参数默认为0（relative move），也可设置为1（absolute move）
9. ST_AsX3D(geometry g1, integer maxdecimaldigits=15, integer options=0)以ISO-IEC-19776-1.2-X3DEncodings-XML格式返回g1
10. ST_GeoHash(geometry geom, integer maxchars=full_precision_of_point)返回geom的GeoHash形式，第二个参数最大字符个数
11. ST_AsText(geometry g1)
ST_AsText(geography g1)返回g1不带srid的WKT表示
12. ST_AsLatLonText(geometry pt, text format)返回给定点的degrees,minutes,seconds, cardinal direction,第二个参数为格式

##　Operators

1. &&( geometry A , geometry B )A的2D边框相交B的2D边框则返回true
2. &&&( geometry A , geometry B )A的3D边框相交B的3D边框则返回true
3. &<( geometry A , geometry B )A的边框重叠B或在B的左边返回true
4. &<|( geometry A , geometry B ) A的边框重叠B或在B的下边返回true
5. &>( geometry A , geometry B ) A的边框重叠B或在B的右边返回true
6. <<( geometry A , geometry B ) A的边框严格地在B的左边返回true
7. <<|( geometry A , geometry B ) A的边框严格地在B的下边返回true
8. =( geometry A , geometry B )如果A的几何边框和B一样，则返回true，双精度边框使用
9. >>( geometry A , geometry B ) A的边框严格地在B的右边返回true
10. @( geometry A , geometry B )A的边框完全被包含在B中返回true
11. |&>( geometry A , geometry B ) A的边框重叠B或在B的上边返回true
12. |>>( geometry A , geometry B ) A的边框严格地在B的上边返回true
13. ~( geometry A , geometry B )A的边框包含了B则返回true
14. ~=( geometry A , geometry B )A的边框是否和B的边框一样
15. <->( geometry A , geometry B )返回两点之间的距离，浮点精度
16. <#>( geometry A , geometry B )边框间的距离，应用于距离排序

##　Spatial Relationships and Measurements

1. ST_3DClosestPoint(geometry g1, geometry g2)返回g1和g2中最近的一个点，可以是线和点之间，线和多点，多线和多边形之间，3D2D都适用
2. ST_3DDistance(geometry g1, geometry g2)返回g1和g2之间三维最小笛卡尔距离
3. ST_3DDWithin(geometry g1, geometry g2, double precision distance_of_srid)适用于3d(z)模型，判断g1和g2是否在所给距离范围之内
4. ST_3DDFullyWithin(geometry g1, geometry g2, double precision distance)判断g1和g2是否完全在给定的距离范围之内
5. ST_3DIntersects( geometry geomA , geometry geomB )判断是否在空间上相交，仅适用于空间的points和linestrings
6. ST_3DLongestLine(geometry g1, geometry g2)空间上返回g1和g2之间最长的line，return geometry
7. ST_3DMaxDistance(geometry g1, geometry g2)返回空间上g1和g2之间最大的距离，return float
8. ST_3DShortestLine(geometry g1, geometry g2)g1和g2之间最短的line，return geometry
9. ST_Area(geography geog, boolean use_spheroid=true)多边形或多个多边形的表面积，第二个参数可选，默认是true
10. ST_Azimuth(geometry A, geometry B)垂直方向上从A到B的基于北方向的顺时针方位角度，return float
11. ST_Centroid(geometry g1)返回g1的几何中心，return geometry
12.　ST_ClosestPoint(geometry g1, geometry g2)二维中g1中距离g2最近的点，line中的第一个点
13.　ST_Contains(geometry A, geometry B) 返回true当且仅当没有B位于一个的A外部，和B的内部的至少一个点的点在于A的内部
14. ST_ContainsProperly(geometry geomA, geometry geomB)如果AB相交于A的内部而不是边界或外部，则返回true
15. ST_Covers(geometry geomA, geometry geomB)如果B中的点没有在A的外部则返回true
16. ST_CoveredBy(geometry geomA, geometry geomB)如果A中的点没有一个在B的外部则返回true
17. ST_Crosses(geometry g1, geometry g2)如果g1中的点或线在g2中则返回true
18.ST_LineCrossingDirection(geometry linestringA, geometry linestringB)给定两个linestring ，返回二者的交叉行为，-3，-2，-1,0,1，2,3
19. ST_Disjoint( geometry A , geometry B )如果AB空间没有相交，或没有共用同一个空间则返回true
20. ST_Distance(geometry g1, geometry g2)返回g1和g2几何体在投影上的笛卡尔最小距离。Return float
21. ST_MaxDistance(geometry g1, geometry g2)返回最大距离
22. ST_Distance_Sphere(geometry geomlonlatA, geometry geomlonlatB)返回两个经纬度几何体之间的距离
23. ST_Distance_Spheroid(geometry geomlonlatA, geometry geomlonlatB, spheroid measurement_spheroid)用法同上，加上个参数，特别适用于球体
24. ST_DFullyWithin(geometry g1, geometry g2, double precision distance)，如果g1完全在指定距离的g2中则返回true
25.ST_DWithin(geometry g1, geometry g2, double precision distance_of_srid)几何对象g1在g2描述的距离内则返回true
26. ST_Equals(geometry A, geometry B) 如果两个空间对象相等，则返回TRUE，忽略方向
27. ST_HasArc(geometry geomA)如果geomA中包含circular string则返回true
28. ST_Intersects( geometry geomA , geometry geomB ) 判断两个几何空间数据是否相交,如果相交返回true,不要使用GeometryCollection作为参数
29. ST_Length(geometry a_2dlinestring)线或多线的长度return float
30. ST_Length2D(geometry a_2dlinestring)同上，他的别名
31. ST_3DLength(geometry a_3dlinestring)3D中返回线的长度，2D同ST_Length（）
32. ST_Length_Spheroid(geometry a_linestring, spheroid a_spheroid)返回a_linestring的2D或3D的长度，多用于经纬度，不需要投影的
33. ST_HausdorffDistance(geometry g1, geometry g2) 返回 g1和g2几何之间的Hausdorff距离
34. ST_Length2D_Spheroid(geometry a_linestring, spheroid a_spheroid)计算2D长度
35. ST_3DLength_Spheroid(geometry a_linestring, spheroid a_spheroid)计算3D的长度，ST_Length_Spheroid（）的别名
36. ST_LongestLine(geometry g1, geometry g2) 返回两个几何的2维的线最长点
37. ST_OrderingEquals(geometry A, geometry B) 如果给定的几何表示相同的几何形状，点是在相同的方向顺序则返回true
38. ST_Overlaps(geometry A, geometry B) 如果两个几何空间数据存在交迭,则返回 TRUE,不要使用GeometryCollection作为参数。
39. ST_Perimeter(geometry g1) ST_Surface 或ST_MultiSurface几何图形的周长
40. ST_Perimeter2D(geometry geomA)2维周长
41. ST_3DPerimeter(geometry geomA)返回周长
42. ST_PointOnSurface(geometry g1)返回一个保证在平面内的点
43. ST_Project(geography g1, float distance, float azimuth)返回一个点，距离distance之内，azimuth旋转角度范围的投影
44.　ST_Relate(geometry A,geometry B, text intersectionMatrixPattern)，
45.　ST_RelateMatch(text intersectionMatrix, text intersectionMatrixPattern)前者模式隐含后者则返回true
46. ST_ShortestLine(geometry g1, geometry g2)返回g1和g2中最短的线
47. ST_Touches(geometry g1, geometry g2)g1和g2存在接触但他们的内部不相交则返回true
48. ST_Within(geometry A, geometry B)如果A完全在B的内部则返回true

##　Geometry Processing

1.　ST_Buffer(geometry g, float radius_of_buffer integer num_seg_quarter_circle)第一个参数是要操作的空间几何数据，第二个参数长度（距离），第三个参数为一个整型，这个函数返回一个空间数据类型，以当前第一个参数空间几何数据为参考点，返回小于等于距离的空间几何数据点，最后由这些点组成一个多边形空间数据，
2. ST_BuildArea(geometry A) 创建由给定的几何线条组成的形成面几何
3. ST_Collect(geometry[] g1_array)返回由多个g1_array组成的集合
4.ST_ConcaveHull(geometry geomA, float target_percent, boolean allow_holes=false)
5. ST_ConvexHull(geometry geomA)包裹geomA的最小几何体
6.　ST_CurveToLine(geometry curveGeom)将CIRCULAR STRING转换为普通的 LINESTRING 或CURVEPOLYGON 转换为POLYGON
7. ST_Difference(geometry geomA, geometry geomB) 返回一个几何空间数据A不同于空间数据B的几何空间数据类型
8. ST_Dump(geometry g)返回组成g的路径数组
9. ST_DumpPoints(geometry geom)返回组成geom的所有的点
10. ST_DumpRings(geometry a_polygon)返回组成a_polygon的所有的环
11. ST_FlipCoordinates(geometry geom)返回坐标点
12. ST_Intersection( geometry geomA , geometry geomB )geomA和geomB的交集的点集，如果没有交集则返回empty geometry collection
13. ST_LineToCurve(geometry geomANoncircular)强转LINESTRING/POLYGON 成 CIRCULARSTRING, CURVED POLYGON
14. ST_MakeValid(geometry input)试图使输入的无效集合体有效而不丢失顶点
15. ST_MemUnion(geometry set geomfield) 与ST_Union（）相同，但耗费更少的内存
16.　ST_MinimumBoundingCircle(geometry geomA, integer num_segs_per_qt_circ=48)返回最小的circle polygon，并且包裹几何体geomA
17. ST_Polygonize(geometry[] geom_array) 使几何体多边形化
18. ST_Node(geometry geom) 将geom分成一系列的linestring，数目最少的同时保持原来的集合体
19.　ST_OffsetCurve(geometry line, float signed_distance, text style_parameters=”)第一个参数必须为linestring，第二个参数偏移距离，第三个参数风格，quad_segs=#或join=round|mitre|bevel或mitre_limit=#.#
20. ST_RemoveRepeatedPoints(geometry geom)返回geom去除他的重复点
21. ST_SharedPaths(geometry lineal1, geometry lineal2)返回包含相同路径的几何体，必须为（multi）linestring
22. ST_Shift_Longitude(geometry geom)读取geom中的每一个顶点，如果经度坐标小于0，就加上360，结果在0~360之间
23. ST_Simplify(geometry geomA, float tolerance) 返回给定几何使用道格拉斯 - 普克算法“简化”版本
24. ST_SimplifyPreserveTopology(geometry geomA, float tolerance) 返回使用道格拉斯 - 普克算法给出的几何形状的“简化”版本。将避免创建衍生的无效的几何形状（尤其是多边形）
25. ST_Split(geometry input, geometry blade)返回几何体input被blade分割后的集合
26. ST_SymDifference(geometry A, geometry B)返回A和B不相交的几何体，两个参数可以互换位置
27. ST_Union(geometry g1, geometry g2) 返回一系列几何体的集合，比如两个point返回multipoint,不同类型的几何体返回GEOMETRYCOLLECTION
28. ST_UnaryUnion(geometry geom)和ST_Union类似，不过一般working at the geometry component level

##　Linear Referencing

1. ST_Line_Interpolate_Point(geometry a_linestring, float a_fraction)第一个参数必须是linestring，第二个参数是0到1的float，返回线中的一个点
2. ST_Line_Locate_Point(geometry a_linestring, geometry a_point)点在线中的所在位置的比例
3. ST_Line_Substring(geometry a_linestring, float startfraction, float endfraction)截取线，从第二个参数开始，到第三个参数结束
4. ST_LocateAlong(geometry ageom_with_measure, float a_measure, float offset)
5.ST_LocateBetween(geometry geomA, float measure_start, float measure_end, float offset)衍生的一个几何体，第二个参数开始点，第三个参数截止点，第四个参数偏移量
6.　ST_LocateBetweenElevations(geometry geom_mline, float elevation_start, float elevation_end)仅支持3D, 4D LINESTRINGS 和 MULTILINESTRINGS
7. ST_InterpolatePoint(geometry line, geometry point)
8.　ST_AddMeasure(geometry geom_mline, float measure_start, float measure_end) 仅支持LINESTRINGS和MULTILINESTRINGS类型

##　Long Transactions Support 

1. AddAuth(text auth_token)在当前事务中添加一个授权
2.　CheckAuth(text a_schema_name, text a_table_name, text a_key_column_name)为表创建一个触发器，防止基于授权的删除和更新一列
3. DisableLongTransactions()
    EnableLongTransactions()
4. LockRow(text a_schema_name, text a_table_name, text a_row_key, text an_auth_token, timestamp expire_dt)锁定特定表的一列
5.　UnlockRows(text auth_token)解锁

##　Miscellaneous Functions

1.  ST_Accum(geometry set geomfield)
2.  Box2D(geometry geomA)返回geomA中最大程度的BOX2D表示
3.  Box3D(geometry geomA)返回geomA中最大程度的BOX3D表示
4.  ST_Estimated_Extent(text schema_name, text table_name, text geocolumn_name)
5. ST_Expand(geometry g1, float units_to_expand)几何体g1的边框向外扩展
6. ST_Extent(geometry set geomfield)返回边框return box2d
7. ST_3DExtent(geometry set geomfield)return box3d
8. Find_SRID(varchar a_schema_name, varchar a_table_name, varchar a_geomfield_name)返回srid 模式名、表名、地理字段名return integer
9. ST_Mem_Size(geometry geomA)返回geomA话费空间量
10. ST_Point_Inside_Circle(geometry a_point, float center_x, float center_y, float radius)几何体是一个点，并且在指定的圈内返回true

##　Exceptional Functions

1.  PostGIS_AddBBox(geometry geomA)给geomA添加一个边框，仅支持Circular Strings和Curves类型
2.  PostGIS_DropBBox(geometry geomA)删除边框
3.  PostGIS_HasBBox(geometry geomA)判断是否有边框
