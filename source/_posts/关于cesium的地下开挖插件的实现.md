---
title: 关于cesium的地下开挖插件的实现
date: 2016-08-27 15:41:35
tags: [cesium,JavaScript,plugin]
categories: cesium
---

在使用cesium渲染三维地图的时候,由于需求,想实现地下开挖的效果,正好[NICTA](https://github.com/NICTA/cesium-groundpush-plugin)提供了此功能,简单记录一下学习成果.
<!--more-->
cesium-groundpush-plugin一共有四个版本,最新的对应cesium1.2,其余版本为b26,b27,b28.然而现在最新的cesium为25了,并且NICTA也不再更新这个插件了,所以暂用1.2版本测试.
## 下载插件
主要是四个js文件

	git clone https://github.com/NICTA/cesium-groundpush-plugin.git
## 在html中导入js

	<script type="text/javascript" src="[your path to Cesium]/Cesium.js"></script>
	<script type="text/javascript" src="GroundPushGlobeSurfaceShaderSet.js"></script>
	<script type="text/javascript" src="GroundPushGlobeVS.js"></script>
	<script type="text/javascript" src="GroundPushGlobeFS.js"></script>
	<script type="text/javascript" src="GroundPush.js"></script>

## 脚本初始化

	var options = {
    pushRectangle : new Cesium.Rectangle( 0.0, 0.0, 0.1, 0.1 ), // 挖掘区域
    pushDepth : -10000,   //挖掘深度(米)                                 
    pushSidesTint : new Cesium.Cartesian3( 0.7, 0.6, 0.5 )  // 挖掘区域的边界颜色RGB
	};
	
	var gp = new GroundPush(Cesium, options);
## 添加图层

在挖掘区域可以添加另一个图层,以区别显示

	var imageryLayers = globe.imageryLayers;
	var imageryProvider = new Cesium.TileMapServiceImageryProvider({
    url : 'http://cesium.agi.com/blackmarble',
    maximumLevel : 8,
    credit : 'Black Marble imagery courtesy NASA Earth Observatory',
    rectangle : gp.getOuterRectangle()
	});
	imageryLayers.addImageryProvider(imageryProvider);

	imageryLayers.get(1).showOnlyInPushedRegion = true;

另外可以设置挖掘深度: 	` gp.pushDepth = -20000; `
## cesium1.24

当我想在我的项目中使用这个插件时,由于我的cesium是1.24的,有很多方法被重写,或是遗弃,比如:

- `Rectangle.intersectWith`在1.5中被`Rectangle.intersection`替换
- `Rectangle.isEmpty`方法被彻底抛弃
- `Camera.viewRectangle`方法被`Camera.setView({destination: rectangle})`代替
- 在添加图层时,抛弃`TileMapServiceImageryProvider`,取而代之的是`createTileMapServiceImageryProvider`

当我修改了这些方法后仍然不能使用,cesium.js报错,可能是我太菜鸟了吧,根本调试不出来,一再努力之下,仍不能解决,故放弃.
## 改变思维
 虽然不能使用这个插件,但能不能模拟一下开挖呢,额,就这么干.
思路就是添加一个矩形选框,点击鼠标渲染出一个矩形,矩形内部的区域即为挖掘区域,区域内显示实体,区域外隐藏实体.
### 禁用视图
	scene.screenSpaceCameraController.enableRotate = false;
    scene.screenSpaceCameraController.enableTranslate = false;
	scene.screenSpaceCameraController.enableZoom = false;
	scene.screenSpaceCameraController.enableTilt = false;
	scene.screenSpaceCameraController.enableLook = false;

### JQuery增加div
	var x = y = 0;
    var mousekey = false;
	$(document).bind("mousedown",
        function(e) {
            if (isSelect) {
                mousekey = true;
                //var currObj = e.originalEvent.srcElement; //这里是获取当前鼠标所在对象
                $('body').css("cursor ", "crosshair").append('<div id="divSelectArea" style="position: absolute;background-color: #111111;"></div>');
                x = e.pageX;
                y = e.pageY;
                $('#divSelectArea').css({
                    top: e.pageY,
                    left: e.pageX
                }).fadeTo(12, 0.2); //点击后开始拖动并透明;
            }
        }).mousemove(function(e) {
            if (mousekey) {
                $('#divSelectArea').css({
                    top: e.pageY > y ? y: e.pageY,
                    left: e.pageX > x ? x: e.pageX,
                    height: Math.abs(e.pageY - y),
                    width: Math.abs(e.pageX - x)
                }).html(e.originalEvent.srcElement.tagName);
            }
        }).mouseup(function() {
            if (mousekey) {
                var offsetTop = $('#divSelectArea').offset().top;
                var offsetLeft = $('#divSelectArea').offset().left;
                var offsetHeight = $('#divSelectArea').outerHeight();
                var offsetWidth = $('#divSelectArea').outerWidth();
                var NW = new Cesium.Cartesian2(offsetLeft, offsetTop);
                var NE = new Cesium.Cartesian2(offsetLeft + offsetWidth, offsetTop);
                var SE = new Cesium.Cartesian2(offsetLeft + offsetWidth, offsetTop + offsetHeight);
                var SW = new Cesium.Cartesian2(offsetLeft, offsetTop + offsetHeight);
                getpos(NW, NE,SE,SW);
                x = y = mousekey = 0;
                $('#divSelectArea').remove();
                $('body').css("cursor ", "default ");
                scene.screenSpaceCameraController.enableRotate = true;
                scene.screenSpaceCameraController.enableTranslate = true;
                scene.screenSpaceCameraController.enableZoom = true;
                scene.screenSpaceCameraController.enableTilt = true;
                scene.screenSpaceCameraController.enableLook = true;
                isSelect = false;
            }
        });


### 由div屏幕值为转换为经纬度,选取区域

	function getpos(p1,p2,p3,p4) {
        var pick1 = viewer.scene.globe.pick(viewer.camera.getPickRay(p1), viewer.scene);
        var pick2 = viewer.scene.globe.pick(viewer.camera.getPickRay(p2), viewer.scene);
        var pick3 = viewer.scene.globe.pick(viewer.camera.getPickRay(p3), viewer.scene);
        var pick4 = viewer.scene.globe.pick(viewer.camera.getPickRay(p4), viewer.scene);
        //将三维坐标转成地理坐标
        var geoPt1 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick1);
        var geoPt2 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick2);
        var geoPt3 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick3);
        var geoPt4 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick4);
        //地理坐标转换为经纬度坐标
        var point1 = [geoPt1.longitude / Math.PI * 180, geoPt1.latitude / Math.PI * 180];
        var point2 = [geoPt2.longitude / Math.PI * 180, geoPt2.latitude / Math.PI * 180];
        var point3 = [geoPt3.longitude / Math.PI * 180, geoPt3.latitude / Math.PI * 180];
        var point4 = [geoPt4.longitude / Math.PI * 180, geoPt4.latitude / Math.PI * 180];
        //console.log(point1 + '.....' + point2);
        var NW = new Cesium.Cartesian3.fromDegrees(point1[0], point1[1], 15);
        var NE = new Cesium.Cartesian3.fromDegrees(point2[0], point2[1], 15);
        var SE = new Cesium.Cartesian3.fromDegrees(point3[0], point3[1], 15);
        var SW = new Cesium.Cartesian3.fromDegrees(point4[0], point4[1], 15);
        if(Cesium.defined(greenWall)){
          viewer.entities.remove(greenWall);
        }
        if(Cesium.defined(greenredRectangle)){
          viewer.entities.remove(greenredRectangle);
        }
         greenWall = viewer.entities.add({
            wall: {
                positions: [NW, NE, SE, SW, NW],
                material: Cesium.Color.GREEN
            }
        });        
         greenredRectangle = viewer.entities.add({
            polygon: {
                hierarchy: [NW, NE, SE, SW],
                material: Cesium.Color.GREEN,
            },
        });
    };

ok,大功告成,菜鸟一枚,欢迎指正.
