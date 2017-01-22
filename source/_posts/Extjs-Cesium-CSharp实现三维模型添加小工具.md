---
title: Extjs+Cesium+CSharp实现三维模型添加小工具
date: 2017-01-03 17:04:45
tags: cesium,JavaScript,open source,Extjs,CSharp
categories: Extjs
---
自从上次批量导出gltf模型后,需求便随之而来,就是在线添加模型,并且能够更改模型的参数,比如大小,位置等等,效仿的是某图的客户端添加二维模型.前端使用的是Extjs4.2,jQuery和三维引擎cesium,后端asp.net mvc.
<!--more-->
# 前端
## window显示框

    function addModel() {
    if (Ext.getCmp('modelPanel') !== null) {
        Ext.getCmp('modelPanel').destroy();
    }
    var modelWindow = Ext.create('Ext.window.Window', {
        title: '添加模型',
        width: 820,
        height: 520,
        renderTo: Ext.getBody(),
        plain: true,
        collapsible: true, //是否可以折叠
        closable: true,
        layout: 'border',
        items: [{
            region: 'west',
            xtype: 'treepanel',
            title: '模型分类',
            width: '15%',
            store: treestore,
            rootVisible: false,
            listeners: {
                itemclick: function(view, record, item, index, e) {
                    var code = record.raw.code;
                    var store = loadCode(code);
                    var gridPanles = editView(store);
                    var FartherGrid = modelWindow.getComponent('gridPanel');
                    FartherGrid.removeAll();
                    //添加面板
                    if (gridPanles != null) {
                        gridPanles = FartherGrid.add({
                            xtype: gridPanles,
                            closable: true
                        });
                        gridPanles.getStore().load();
                    }
                }
            }
        }, {
            margin: '1 1 1 1',
            region: 'center',
            width: '45%',
            itemId: 'gridPanel',
            autoScroll: true,
            items: [{
                xtype: 'dataview',
                width: '40%',
                autoScroll: true,
                itemSelector: 'div.thumb-wrap',
                tpl: imageTpl,
            }]
        }, {
            xtype: 'panel',
            region: 'east',
            itemId: 'box1',
            width: '40%',
            border: false,
            layout: 'fit',
            listeners: {
                show: function(c) {
                    pageInit3d();
                }
            },
            bodyStyle: 'background-color:#E5E3DF;',
            frame: false,
            html: '<div id="mapPic"><div class="nav">' + '<div class="up" id="up"></div><div class="right" id="right"></div>' + '<div class="down" id="down"></div><div class="left" id="left"></div>' + '<div class="zoom" id="zoom"></div><div class="in" id="in"></div>' + '<div class="out" id="out"></div></div>' + '<img id="view-image3d" src="" border="0" style="cursor: url(/Images/openhand_8_8.cur), default;" > </div>'
        }],
        listeners: {
            show: function(c) {
                pageInit3d();
            }
        },
        buttons: [{
            text: '确认',
            handler: function() {
                modelWindow.destroy();
                showmodulemessagefn("双击点选位置添加模型");
                $(document).bind("dblclick",
                    function(e) {
                        var NW = new Cesium.Cartesian2(e.pageX, e.pageY);
                        var pick1 = viewer.scene.globe.pick(viewer.camera.getPickRay(NW), viewer.scene);
                        //将三维坐标转成地理坐标
                        var geoPt1 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick1);
                        var gaodu = viewer.scene.globe.getHeight(geoPt1).toFixed(5);
                        //地理坐标转换为经纬度坐标
                        var point1 = [geoPt1.longitude / Math.PI * 180, geoPt1.latitude / Math.PI * 180];
                        // console.log(point1+","+gaodu);
                        var viewModel = {
                            jingdu: point1[0].toFixed(6),
                            weidu: point1[1].toFixed(6),
                            gaodu: gaodu,
                            heng: 0,
                            zong: 0,
                            zzz: 0,
                            size: 1
                        };
                        // Convert the viewModel members into knockout observables.
                        Cesium.knockout.track(viewModel);
                        createDiv = document.createElement("div");
                        createDiv.innerHTML = htmlStr;
                        createDiv.id = "toolbar";
                        createDiv.style.position = "absolute";
                        createDiv.style.right = "5px";
                        createDiv.style.top = "38px";
                        document.body.appendChild(createDiv);
                        var toolbar = document.getElementById('toolbar');
                        Cesium.knockout.applyBindings(viewModel, toolbar);
                        var jingdu = $("#jingdu")[0].value;
                        var weidu = $("#weidu")[0].value;
                        var gaodu = $("#height")[0].value;
                        var heng = $("#heng")[0].value;
                        var zong = $("#zong")[0].value;
                        var zzz = $("#xie")[0].value;
                        var scale = $("#size")[0].value;
                        var idid = uuid();
                        var modelMatrix = Cesium.Cartesian3.fromDegrees(point1[0], point1[1], gaodu);
                        if (typeof(entity) != 'undefined') { viewer.entities.remove(entity); }
                        var entity = AddModelss(idid, modelpath, modelMatrix, heng, zong, zzz, scale);
                        $("input").change(function() {
                            scale = $("#size")[0].value;
                            jingdu = $("#jingdu")[0].value;
                            weidu = $("#weidu")[0].value;
                            gaodu = $("#height")[0].value;
                            heng = $("#heng")[0].value;
                            zong = $("#zong")[0].value;
                            zzz = $("#xie")[0].value;
                            modelMatrix = Cesium.Cartesian3.fromDegrees(jingdu, weidu, gaodu);
                            var orientation = Cesium.Transforms.headingPitchRollQuaternion(modelMatrix, heng, zong, zzz);
                            entity.model.scale = scale;
                            entity.position = modelMatrix;
                            entity.orientation = orientation;
                        });
                        $("#no").click(function() {
                            viewer.entities.remove(entity);
                            var toolbar = document.getElementById('toolbar');
                            toolbar.parentNode.removeChild(toolbar);
                        });
                        $("#yes").click(function() {
                            Ext.Ajax.request({
                                url: '/TDGis/uploadModel',
                                params: {
                                    x: jingdu,
                                    y: weidu,
                                    z: gaodu,
                                    heng: heng,
                                    zong: zong,
                                    xie: zzz,
                                    scale: scale,
                                    id: id,
                                    idid: idid
                                },
                                method: 'POST',
                                timeout: 3000,
                                success: function(response, opts) {
                                    // Ext.Msg.alert('提示', '添加模型成功。');
                                    var toolbar = document.getElementById('toolbar');
                                    toolbar.parentNode.removeChild(toolbar);
                                }
                            });
                        });
                        $(this).unbind(e);
                    });
            }
        }, {
            text: '取消',
            handler: function() {
                modelWindow.destroy();
            }
        }]
    }).show();
    }

## window中的方法
1.最左侧的tree
    
    var treestore = new Ext.data.TreeStore({
    proxy: {
        type: 'ajax',
        url: '/TDGis/modelType',
        reader: "json"
    },
    autoLoad: true
    });

2.单击模型树生成模型列表

    //store
    function loadCode(code) {
    gridstore = Ext.create('Ext.data.Store', {
        fields: ['name1', 'thumbnailpath', 'gltfsize', 'modelpath', 'id'],
        proxy: {
            type: 'ajax',
            reader: 'json',
            url: "/TDGis/modelGrid?code=" + code
        },
        //extraParams:{"code":"01"},
        autoLoad: true
    });
    return gridstore;
    }

    //dataview
    function editView(store) {
    var selectLineGridPanel = Ext.create('Ext.view.View', {
        store: store,
        tpl: imageTpl,
        itemSelector: 'div.thumb-wrap', //store tpl itemSelector必选项
        emptyText: '暂无图片',
        margin: '1 1 1 1',
        multiSelect: true,
        height: 310,
        autoScroll: false,
        overItemCls: 'x-item-over',
        trackOver: true,
        listeners: {
            itemclick: function(view, record, item, index, e) {
                thumbnailpath = record.raw.thumbnailpath;
                modelpath = record.raw.modelpath;
                id = record.raw.id;
                gltfsize = record.raw.gltfsize;
                //动态更新只需要获取到刚才建立的box的dom的src  
                var image = Ext.get('view-image3d');
                image.dom.src = thumbnailpath;
            }
        }
    });
    return selectLineGridPanel;
    }
    );

dataview 的tpl模板,es6语法 ``

    var imageTpl = new Ext.XTemplate(
    '<tpl for=".">',
    '<div style="float: left;margin: 4px; margin-right: 0;padding: 5px" class="thumb-wrap">',
    '<img src="{thumbnailpath}" width="70" height="70">',
    '<span style="text-align: center;display: block;overflow: hidden;" class="x-editable">大小:{gltfsize}</span>',
    '</div>',
    '</tpl>'

3.添加模型的提示框(出现三秒后消失)

    function showmodulemessagefn(message) {
    //获取显示区域的大小
    var width = Ext.getBody().getViewSize().width;
    var trim = '&nbsp;&nbsp;';
    //设置div中显示的文字，并渐变显示，然后三秒后渐变隐藏
    $("#showmodulemessage").html(trim + message + trim).show(300).delay(3000).hide(300);
    //获取有多少个文字，然后根据文字多少算出中间宽度，加40上因为左右各两个空格
    var messagewidth = message.length * 10 + 40;
    //设置提示框的显示位置，不平在屏幕中间，垂直在工具条下面。
    $("#showmodulemessage").css({
        left: width / 2 - messagewidth,
        top: 110
    });
    }

4.动态添加div节点,用于显示调整模型信息

    //多行字符串
    function hereDoc(f) {　
    return f.toString().replace(/^[^\/]+\/\*!?\s?/, '').replace(/\*\/[^\/]+$/, '');
    }
    var htmlStr = hereDoc(function() {
    /*
    <table>
        <tbody><tr>
            <td width="65px"><font color="white">经度</font></td>
            <td>
                <input id="jingdu" type="range" min="-180" max="180" step="0.000001"  data-bind="value: jingdu, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: jingdu">
            </td>
        </tr>
        <tr>
            <td><font color="white">纬度</font></td>
            <td>
                <input id="weidu" type="range" min="-90" max="90" step="0.000001" data-bind="value: weidu, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: weidu">
            </td>
        </tr>
        <tr>
            <td><font color="white">高度</font></td>
            <td>
                <input id="height" type="range" min="-50" max="1000" step="0.01" data-bind="value: gaodu, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: gaodu">
            </td>
        </tr>
        <tr>
            <td><font color="white">横向旋转<font></td>
            <td>
                <input id="heng" type="range" min="0" max="7" step="0.0001" data-bind="value: heng, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: heng">
            </td>
        </tr>
        <tr>
            <td><font color="white">纵向旋转</font></td>
            <td>
                <input id="zong" type="range" min="0" max="7" step="0.0001" data-bind="value: zong, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: zong">
            </td>
        </tr>
        <tr>
            <td><font color="white">斜旋转<font></td>
            <td>
                <input id="xie" type="range" min="0" max="7" step="0.0001" data-bind="value: zzz, valueUpdate: 'input'">
                <input type="text" size="5" data-bind="value: zzz">
            </td>
        </tr>
        <tr>
            <td><font color="white">大小<font></td>
            <td>
                <input id="size" type="range" min="0" max="50" step="0.0001" value = "5" data-bind="value: size, valueUpdate: 'input'">
                <input type="text" size="5" value = "5" data-bind="value: size">
            </td>
        </tr>
        <tr>
            
            <td>
                <button id="yes" class="cesium-button1">添加</button>
            </td>
            <td>
                <button id="no" class="cesium-button1">取消</button>
            </td>
        </tr>
    </tbody></table>
    */
    });

5.生成唯一值

    //生成UUID
    function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";
    uuid1 = s.join("");
    return uuid1;
    }

6.添加模型的方法

    function AddModelss(id, modelUrl, center, zzz, yyy, xxx, scale) {
    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(center);
    // var position = Cesium.Cartesian3.fromDegrees(-123.0744619, 44.0503706); //位置  
    var heading = Cesium.Math.toRadians(zzz); //绕垂直于地心的轴旋转  摇头 
    var pitch = Cesium.Math.toRadians(yyy); //绕纬度线旋转  点头
    var roll = Cesium.Math.toRadians(xxx); //绕经度线旋转  歪头
    var orientation = Cesium.Transforms.headingPitchRollQuaternion(center, heading, pitch, roll);
    var entity = viewer.entities.add({
        id: id,
        position: center,
        orientation: orientation,
        model: {
            uri: modelUrl,
            scale: scale
        }
    });
    return entity;
    }

7.图片操作方法

    /**  
     * 初始化  
     */
    function pageInit3d() {
    var image = Ext.get('view-image3d');
    if (image !== null) {
        Ext.get('view-image3d').on({
            'mousedown': { fn: function() { this.setStyle('cursor', 'url(/Images/openhand_8_8.cur),default;'); }, scope: image },
            'mouseup': { fn: function() { this.setStyle('cursor', 'url(/Images/openhand_8_8.cur),move;'); }, scope: image },
            'dblclick': {
                fn: function() {
                    zoom3d(image, true, 1.2);
                }
            }
        });
        new Ext.dd.DD(image, 'pic');
        //image.center();//图片居中   
        //获得原始尺寸   
        image.osize = {
            width: image.getWidth(),
            height: image.getHeight()
        };
        Ext.get('up').on('click', function() { imageMove3d('up', image); }); //向上移动   
        Ext.get('down').on('click', function() { imageMove3d('down', image); }); //向下移动   
        Ext.get('left').on('click', function() { imageMove3d('left', image); }); //左移   
        Ext.get('right').on('click', function() { imageMove3d('right', image); }); //右移动   
        Ext.get('in').on('click', function() { zoom3d(image, true, 1.5); }); //放大   
        Ext.get('out').on('click', function() { zoom3d(image, false, 1.5); }); //缩小   
        Ext.get('zoom').on('click', function() { image.center(); }); //还原   
    }
    }

    /**  
     * 图片移动  
     */
    function imageMove3d(direction, el) {
    el.move(direction, 50, true);
    }

    /**  
     *   
     * @param el 图片对象  
     * @param type true放大,false缩小  
     * @param offset 量  
     */
    function zoom3d(el, type, offset) {
    var width = el.getWidth();
    var height = el.getHeight();
    var xy = el.getXY();
    var nwidth = type ? (width * offset) : (width / offset);
    var nheight = type ? (height * offset) : (height / offset);
    var left = type ? -((nwidth - width) / 2) : ((width - nwidth) / 2);
    var top = type ? -((nheight - height) / 2) : ((height - nheight) / 2);
    el.animate({
        from: {
            x: xy[0],
            y: xy[1],
            height: height,
            width: width,
        },
        to: {
            //left: left,
            //top: top,
            x: xy[0] + left,
            y: xy[1] + top,
            height: nheight,
            width: nwidth
        }
    });
    }

    /**  
     * 图片还原  
    */
    function restore3d(el) {
    var size = el.osize;
    //自定义回调函数   
    function center(el, callback) {
        el.center();
        callback(el);
    }
    el.fadeOut({
        callback: function() {
            el.setSize(size.width, size.height, {
                callback: function() {
                    center(el, function(ee) { //调用回调   
                        ee.fadeIn();
                    });
                }
            });
        }
    });
    }

# 后端(asp.net mvc)
1.模型树

    public ActionResult modelType()
        {
            List<modelType> dataList = new List<modelType>();
            gasgisEntities db = new gasgisEntities();
            string selectsql = "SELECT distinct code FROM public.t_3dmodels order by code";
            var ssqueryss = db.Database.SqlQuery<modelType>(selectsql);
            List<modelType> kkk = ssqueryss.ToList();
            for (var i = 0; i < kkk.Count; i++)
            {
                switch (kkk[i].code)
                {
                    case "01": modelType daolu = new modelType
                    {
                        code = kkk[i].code,
                        text = "道路",
                        leaf = true
                    }; dataList.Add(daolu); break;
                    case "03": modelType gongchang = new modelType
                    {
                        code = kkk[i].code,
                        text = "工厂",
                        leaf = true
                    }; dataList.Add(gongchang); break;
                    case "02": modelType jumin = new modelType
                    {
                        code = kkk[i].code,
                        text = "居民楼",
                        leaf = true
                    }; dataList.Add(jumin); break;
                    case "04": modelType shangye = new modelType
                    {
                        code = kkk[i].code,
                        text = "商业楼",
                        leaf = true
                    }; dataList.Add(shangye); break;
                    case "05": modelType weiqiang = new modelType
                    {
                        code = kkk[i].code,
                        text = "围墙",
                        leaf = true
                    }; dataList.Add(weiqiang); break;
                    case "06": modelType zhengfu = new modelType
                    {
                        code = kkk[i].code,
                        text = "政府",
                        leaf = true
                    }; dataList.Add(zhengfu); break;
                    case "07": modelType others = new modelType
                    {
                        code = kkk[i].code,
                        text = "其他建筑",
                        leaf = true
                    }; dataList.Add(others); break;
                    case "08": modelType caoping = new modelType
                    {
                        code = kkk[i].code,
                        text = "草坪",
                        leaf = true
                    }; dataList.Add(caoping); break;
                    case "09": modelType huachi = new modelType
                    {
                        code = kkk[i].code,
                        text = "花池",
                        leaf = true
                    }; dataList.Add(huachi); break;
                    case "10": modelType lvhuadai = new modelType
                    {
                        code = kkk[i].code,
                        text = "绿化带",
                        leaf = true
                    }; dataList.Add(lvhuadai); break;
                    case "11": modelType shu = new modelType
                    {
                        code = kkk[i].code,
                        text = "树",
                        leaf = true
                    }; dataList.Add(shu); break;
                    case "12": modelType qita = new modelType
                    {
                        code = kkk[i].code,
                        text = "其他设施",
                        leaf = true
                    }; dataList.Add(qita); break;
                }
            }
            JsonResult result = new JsonResult();
            result.Data = dataList;
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            return result;
        }

2.模型列表

    public ActionResult modelGrid(string code )
        {
            gasgisEntities db = new gasgisEntities();
            string selectsql = "";
            if (code == null || code == "")
            {
                selectsql = "SELECT id,name1,modelpath,thumbnailpath,gltfsize FROM public.t_3dmodels order by order1";
            }
            else
            {
                selectsql = "SELECT id,name1,modelpath,thumbnailpath,gltfsize FROM public.t_3dmodels where code ='" + code + "' order by order1";
            }
            var ssqueryss = db.Database.SqlQuery<modelGrid>(selectsql);
            List<modelGrid> kkk = ssqueryss.ToList();
            JsonResult result = new JsonResult();
            result.Data = kkk;
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;//必选允许get请求
            return result;
        }

3.上传模型

    public string uploadModel(string idid, string id, decimal x, decimal y, decimal z, string heng, string zong, string xie, string scale)
        {
            gasgisEntities db = new gasgisEntities();
            string ins = "insert into public.t_3dgismodels (idid,id,x,y,z,heng,zong,xie,scale) values ('" + idid + "','" + id + "'," + x + "," + y + "," + z + ",'" + heng + "','" + zong + "','" + xie + "','" + scale + "')"; ;
            db.Database.ExecuteSqlCommand(ins);
            modelInd(); 
            return "ok";
        }
        生成索引,用于动态加载的剔除模型,加快速度
        public void modelInd()
        {
            gasgisEntities saveSystemCodeDB = new gasgisEntities();
            string insql = "UPDATE public.t_3dgismodels SET ind='x:'|| CAST(TRUNC(x,4) as varchar) || ',' || 'y:' || CAST(TRUNC(y,4) as varchar) ;";
            saveSystemCodeDB.Database.ExecuteSqlCommand(insql);
            //return "ok";
        }

数据库使用的是postgisgreSQL,后台使用的asp.net提供数据,前端使用了jQuery,Extjs的各种信息展示,三维cesium引擎,一切都是开源免费的产品,这样一个功能,很好的展示了从后台到前端是如何工作的,也是入职以来的第一个实现的功能,虽然小,但是很有意义.









