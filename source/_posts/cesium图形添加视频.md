---
title: cesium图形添加视频
date: 2017-01-13 16:13:57
tags: [cesium,JavaScript,open source]
categories: cesium
---
前两天总经理接到一个北京的小项目,需要展示立交桥的地理位置,需求就是展示北京一处立交桥的地理信息,包括航拍图,立交桥模型,地形图.正好也总结一下用到的技术.
<!--more-->
## 初始化
项目初始化参照[这一篇](https://chaossoong.github.io/2016/06/17/cesium%E8%87%AA%E5%AD%A6%E7%BB%8F%E9%AA%8C/)
## 航拍图
使用qgis的插件

    var layers = viewer.imageryLayers;
    layers.addImageryProvider(new Cesium.WebMapServiceImageryProvider({
        url: '/qgis/bin/qgis_mapserv.fcgi?map=c:/maps/bj.qgs',
        layers: 'CQDOM',//图层名称
        parameters: {
            transparent: 'true',
            format: 'image/png'
        }
    }));

这样加载出来的地图整体为蓝色的,难看,就又加载了一个离线的圈球缩略图.(一个切片地图)这是cesium官网提供的一个示例

    var tms = Cesium.createTileMapServiceImageryProvider({
        url: Cesium.buildModuleUrl('/Assets/Textures/NaturalEarthII')
    });
    layers.addImageryProvider(tms);

## 三维模型
我拿到的模型是.max格式的,需要转化为gltf格式,[参考博客](http://blog.csdn.net/l491453302/article/details/46766909) ,加载模型:

    var position = Cesium.Cartesian3.fromDegrees(116.0645, 39.9288, 45);
    var entity = viewer.entities.add({
        position: position,
        allowPicking: false,//禁止点选
        model: {
            uri: 'model/li/li.gltf',
            scale: 1,
        }
    });

## 地形图
地形图需要单独启动一个服务

    var terrainProvider = new Cesium.CesiumTerrainProvider({
        url: 'http://localhost:8000/tilesets/test/',
        requestWaterMask: true,
        requestVertexNormals: true
    });
    viewer.terrainProvider = terrainProvider;

## entity加视频
这是用html5的video标签,暂时支持三种格式webm,mp4,mov
定义标签:

    <video id="trailer" style="display: none;" autoplay="" loop="" crossorigin="" controls="">
        <source src="http://cesiumjs.org/videos/Sandcastle/big-buck-bunny_trailer.webm" type="video/webm">
        <source src="http://cesiumjs.org/videos/Sandcastle/big-buck-bunny_trailer.mp4" type="video/mp4">
        <source src="http://cesiumjs.org/videos/Sandcastle/big-buck-bunny_trailer.mov" type="video/quicktime"> Your browser does not support the <code>video</code> element.
    </video>

获取标签:

    var videoElement = document.getElementById('trailer');

添加视频:
polygon的material值为video元素

    var Polygon = viewer.entities.add({
        allowPicking: false,
        polygon: {
            hierarchy: Cesium.Cartesian3.fromDegreesArray([
                116.34266424258673,39.888246814172334,
                116.34283551162602,39.888246814172334,
                116.34283551162602,39.88803778840221,
                116.34266424258673,39.88803778840221,
                116.34266424258673,39.888246814172334
            ]),
            material: videoElement,
            height: 37      //高度
        }
    });

大功告成,累了写篇文章记录一下,还是蛮可以的嘛,最近在搞vue.js,继续学习去了.


