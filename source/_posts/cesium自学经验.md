---
title: cesium自学经验
date: 2016-06-17 18:19:29
tags: [cesium,JavaScript,open source]  
categories: cesium
---
由于工作需要,在对比threejs和cesiumjs后,决定使用cesiumjs更合适,现开一篇cesium的学习历程,记录一下.
## 概述
Cesium是一个基于JavaScript的开源框架,可用于在浏览器中绘制3D的地球,并在其上绘制地图（支持多种格式的瓦片服务）,该框架不需要任何插件支持,但是浏览器必须支持WebGL,当然最合适的当属Google chrome了,其次Firefox,至于Safari和其他的一些浏览器没有测试,没资格说.
<!--more-->
## 使用
首先[下载cesium](http://cesiumjs.org/downloads.html)

![我是目录](../../../../imgs/cesium-content.jpg)
主要包括开发用的包,文档,和各种小应用示例.

使用cesium,必须搭建一个本地服务器,官方使用的是node.js,[点我node.js入门教程](http://www.runoob.com/nodejs/nodejs-tutorial.html),当然我用的是IIS,只要host我们的文件即可.
## Hello World
身为一个初学者,一切都从Hello World开始.

1. 第一步就是引入Cesium.js，他里面定义的Cesium对象有我们想要的一切

    <script src="Cesium/Cesium.js"></script>

2. 第二步，为了使用Cesium widget，我们需要引入CesiumWidget.css

	@import url(Cesium/Widgets/CesiumWidget/CesiumWidget.css);

3. 第三步，在body中，创建一个div来给我们的Cesium widget使用

	 <div id="cesiumContainer"> </div>
     
4. 第四步，创建一个widget的实例，收工。
    
    var cesiumWidget = new Cesium.CesiumWidget('cesiumContainer');

当然多功能的View:

    var viewer = new Cesium.Viewer('cesiumContainer', {});

其中可以添加各种配置项,具体详见[这里](http://cesiumjs.org/refdoc.html)

如若简单的测试小例子,官方自带[在线版](http://cesiumjs.org/Cesium/Apps/Sandcastle/index.html?src=Hello%20World.html&label=Showcases)左边编辑,右边展示,很强大.
![helloworld](../../../../imgs/helloworld.jpg)
## 结束语
到此为止只是简单地入门应用,若要开发自己的应用,还要自己鼓捣*Documentation*,若果有时间,在开几篇进阶版,好了,闲暇时间打打字也挺好,敲代码去了

知乎淘来的二次元壁纸一张,哈哈
![二次元](https://pic2.zhimg.com/786a0100d7bc47948df50eaa2f806f35_r.jpg)