---
title: cesium之坐标问题
date: 2017-02-27 09:31:20
tags: [cesium,JavaScript]
categories: cesium
---
记录项目中能用到的坐标问题,避免再次入坑.
<!--more-->
1. 根据经纬度获取高度:

    var height = viewer.scene.globe.getHeight(Cesium.Cartographic.fromDegrees(x, y));

2. 点击屏幕获取此处的经纬度:
使用jQuery绑定了document的单击事件:

        $(document).bind("click",function(e) {
            var NW = new Cesium.Cartesian2(e.pageX, e.pageY);
            var pick1 = viewer.scene.globe.pick(viewer.camera.getPickRay(NW),viewer.scene);
            //将三维坐标转成地理坐标
            var geoPt1 = viewer.scene.globe.ellipsoid.cartesianToCartographic(pick1);
            var gaodu = viewer.scene.globe.getHeight(geoPt1);
            //地理坐标转换为经纬度坐标
            var point1 = [geoPt1.longitude / Math.PI * 180, geoPt1.latitude /Math.PI * 180];
            // console.log(point1+","+gaodu);

3. 笛卡尔坐标转换wgs84:

    //获取三维几何球体
    var ellipsoid = viewer.scene.globe.ellipsoid;
    var x = viewer.camera.position.x;
    var y = viewer.camera.position.y;
    var z = viewer.camera.position.z;
    var xyz = new Cesium.Cartesian3(x, y, z);
    var wgs84 = ellipsoid.cartesianToCartographic(xyz);
    console.log('lng=' + Cesium.Math.toDegrees(wgs84.longitude) + ',lat=' + Cesium.Math.toDegrees(wgs84.latitude) + ',alt=' + wgs84.height);




