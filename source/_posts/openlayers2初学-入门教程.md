---
title: openlayers2初学 入门教程
date: 2016-11-16 11:11:29
tags: [openlayers,JavaScript,open source]
categories: openlayers
---
一直以来都在使用[cesium](http://cesiumjs.org)这个三维引擎,完成了三维模型添加工具,本来想使用官方的3Dtiles技术加载模型,但官方说这种技术还不成熟加载了1亿多模型还不成熟,我感觉这种核心技术应该不会开源)所以就只能动态加载和剔除模型,效果也还算不错.现在呢闲了下来,就想学习一下openlayers,因为公司的二维地图使用的就是这个,然而是[openlayers2](http://openlayers.org/two/),现在已经升级到[ol3](http://openlayers.org/)了,重新进行了架构,依我的性格肯定会使用3的,然而公司就是不更新,所以只好学习2(有时间一定会搞搞3的),现记录一下学习.代码地址[github](https://github.com/ChaosSoong/Openlayers)
<!--more-->
##概述
和cesium一样,OpenLayers是一个开源的js框架，用于在您的浏览器中实现地图浏览的效果和基本的zoom，pan等功能。OpenLayers支持的地图来源包括了WMS，GoogleMap，KaMap，MSVirtualEarth等等，您也可以用简单的图片作为源，在这一方面OPenLayers提供了 非常多的选择。
##安装
首先需要下载需要的文件[官方地址](http://openlayers.org/two/),(也可以在我的git仓库下载)下载压缩包,点击解压.*openlayers.js文件,img目录和theme目录一定要在同一目录下*
##Hello openlayers
秉着所有的入门教程都从hello world开始,咱也不例外.推荐一款编辑器sublime text,当然不是免费的,但我大天朝什么黑科技没有,就是不差注册码之类的.

1. 新建index.html,引入脚本
    <script type="text/javascript" src="你自己的目录/OpenLayers.js"></script>

2. 在body中，创建一个div来给我们的openlayers使用
    <div id="map" style="width: 100%;height: 100%;">

3.对body标签,绑定onload事件,初始化地图.
    <body onload="init()">
在脚本中编写init方法:

             function init() {
                var map;
                var lon =120;
                var lat = 39;
                var zoom = 6;
                 map = new OpenLayers.Map('map',{});
                 //创建叠加图层
                 var new_wms = new OpenLayers.Layer.WMS(
                         'New OpenLayers WMS',
                         'http://vmap0.tiles.osgeo.org/wms/vmap0',
                         {
                             layers: "clabel,ctylabel,statelabel", transparent: true
                         },
                         {
                             //visibility:false,
                             opacity: 1
                         }
                 );
                 //创建基底图层
                 var wms = new OpenLayers.Layer.WMS(
                         'OpenLayers WMS',
                         'http://vmap0.tiles.osgeo.org/wms/vmap0',
                         {
                             layers: "basic"
                         },
                         {
                             isBaseLayer: true
                         }
                 );

                 var wms_state_lines = new OpenLayers.Layer.WMS(
                           "State Line Layer",
                           "http://labs.metacarta.com/wms/vmap0",
                           { layers: "stateboundary", transparent: true },
                           { displayInLayerSwitcher: false, minScale: 13841995.078125 }
                               );
                 //创建depthcontour图层
                 //设置opacity:.8
                 var wms_water_depth = new OpenLayers.Layer.WMS(
                            "Water Depth",
                            "http://labs.metacarta.com/wms/vmap0",
                            {
                                layers: "depthcontour", transparent: true
                            },
                            { opacity: .8 }
                            );
                 //创建一些road图层,包括一级公路、二级公路和铁路
                 //设置options的transitionEffect: "resize"，使图层放大或缩小时产生调整大小的动画效果
                   var wms_roads = new OpenLayers.Layer.WMS(
                            "Roads",
                             "http://labs.metacarta.com/wms/vmap0",
                              {
                                 layers: "priroad,secroad,rail", transparent: true
                               },
                               {
                                   transitionEffect: "resize"
                               }
                               );
                 map.addLayers([wms, new_wms, wms_state_lines, wms_water_depth);
                 //设置地图的中心位置
                 map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
                 //添加Switcher Control
                 map.addControl(new OpenLayers.Control.LayerSwitcher());
                 if (!map.getCenter()) {
                     map.zoomToMaxExtent();
                 }
             }

效果图:
![openlayers2](../../../../imgs/ol2.jpg)
