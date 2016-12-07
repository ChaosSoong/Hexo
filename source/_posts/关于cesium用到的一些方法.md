---
title: 关于cesium用到的一些方法
date: 2016-11-28 10:23:53
tags: [cesium,JavaScript,open source]
categories: cesium
---
在学习cesium时,除了看官方文档外,网上还有很多关于cesium的教程,但也都是基于官方文档的,比如:
1. [三维引擎cesium学习经验](http://blog.sina.com.cn/s/blog_d1000bfb0102wmtt.html)
2. [Super洛伽的博客](http://blog.csdn.net/u013929284/article/category/6543215)
3. 这系列很不错,有原理篇,也有应用篇[法克鸡丝](http://www.cnblogs.com/fuckgiser/p/5706842.html)
<!--more-->
    有了基础教程,就要实际应用起来.下面就是用到的渲染官网信息的方法.

    var PipeLine = function() {
    //私有成员，存储管道、管件等三维对象
        this._primitives = new Cesium.PrimitiveCollection();
    };
    //下面声明一个属性，返回私有成员_primitives。该函数需要较新版本浏览器支持
    Object.defineProperties(PipeLine.prototype, {
        Primitives: {
            get: function() {
                return this._primitives;
            }
        }
    });

添加gltf模型(主要是各种类型的管点):

    PipeLine.prototype.AddModel = function(pointId, modelUrl, centerPoint, scale) {
    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(centerPoint);
    //加入模型列表中
    var model = this._primitives.add(Cesium.Model.fromGltf({
        id: pointId,
        //管点id，用于点选
        url: modelUrl,
        modelMatrix: modelMatrix,
        scale: scale
    }));
    };

添加管道模型:

        function computeCircle(radius) {
        var positions = [];
        for (var i = 0; i < 360; i++) {
            var radians = Cesium.Math.toRadians(i);
            positions.push(new Cesium.Cartesian2(radius * Math.cos(radians), radius * Math.sin(radians)));
        }
        return positions;
    };

    PipeLine.prototype.addDuandian2 = function (id, x, y, z, x1, y1, z1, w1, color) {
    var polylineVolumeGeometry = new Cesium.PolylineVolumeGeometry({
        polylinePositions: Cesium.Cartesian3.fromDegreesArrayHeights([x1, y1, z1 - w1, x, y, z - w1]),
        shapePositions: computeCircle(w1),
    });
    var polylineInstance = new Cesium.GeometryInstance({
        //标注管线id，用于点选   
        id: id,
        geometry: polylineVolumeGeometry,
        vertexFormat: Cesium.EllipsoidSurfaceAppearance.VERTEX_FORMAT,
        attributes: {
            color: Cesium.ColorGeometryInstanceAttribute.fromColor(color)
        }
    });
    //加入列表中
    this._primitives.add(new Cesium.Primitive({
        geometryInstances: [polylineInstance],
        asynchronous: false,
        appearance: new Cesium.PerInstanceColorAppearance({
            translucent: false,
            closed: true
        })
    }));
    }
