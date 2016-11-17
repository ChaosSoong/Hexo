---
title: Cesium 键盘绑定平移旋转视角事件
date: 2016-09-29 15:12:25
tags: [cesium,JavaScript,open source]
categories: cesium
---
在使用cesium进行三维显示的时候,可能官方还不够完善,鼠标平移,旋转事件不稳定,经常会有所偏差,甚至飞出地球,所以就绑定键盘进行操作,参考官方[Camera-Tutorial](http://cesiumjs.org/tutorials/Camera-Tutorial/)和文档[Camera](http://cesiumjs.org/refdoc.html)
<!--more-->
直接上代码,复制贴贴即可使用

	var canvas = viewer.canvas;
	canvas.setAttribute('tabindex', '0'); 
	canvas.onclick = function() {
    canvas.focus();
	};
	var ellipsoid = scene.globe.ellipsoid;

	var startMousePosition;
	var mousePosition;
	var flags = {
    looking : false,
    moveForward : false,
    moveBackward : false,
    moveUp : false,
    moveDown : false,
    moveLeft : false,
    moveRight : false,
    rotateDown : false,
    rotateRight: false,
    rotateLeft :false,
    rotateUp:false,
    rotateForward:false,
    rotateBackward:false
	};
	var handler = new Cesium.ScreenSpaceEventHandler(canvas);

**这代码应该容易理解吧**

	function getFlagForKeyCode(keyCode) {
    switch (keyCode) {
    case 'W'.charCodeAt(0):
        return 'moveForward';
    case 'S'.charCodeAt(0):
        return 'moveBackward';
    case 'Q'.charCodeAt(0):
        return 'moveUp';
    case 'E'.charCodeAt(0):
        return 'moveDown';
    case 'D'.charCodeAt(0):
        return 'moveRight';
    case 'A'.charCodeAt(0):
        return 'moveLeft';
    case 'K'.charCodeAt(0):
        return 'rotateDown';
    case 'I'.charCodeAt(0):
        return 'rotateUp';
    case 'J'.charCodeAt(0):
        return 'rotateLeft';
    case 'L'.charCodeAt(0):
        return 'rotateRight';
    case 'O'.charCodeAt(0):
        return 'rotateForward';
    case 'U'.charCodeAt(0):
        return 'rotateBackward';
    default:
        return undefined;
    }
	}
**添加事件监听**

	document.addEventListener('keydown', function(e) {
    var flagName = getFlagForKeyCode(e.keyCode);
    if (typeof flagName !== 'undefined') {
        flags[flagName] = true;
    }
	}, false);

	document.addEventListener('keyup', function(e) {
    var flagName = getFlagForKeyCode(e.keyCode);
    if (typeof flagName !== 'undefined') {
        flags[flagName] = false;
    }
	}, false);

	viewer.clock.onTick.addEventListener(function(clock) {
    var camera = viewer.camera;

    if (flags.looking) {
        var width = canvas.clientWidth;
        var height = canvas.clientHeight;
        var x = (mousePosition.x - startMousePosition.x) / width;
        var y = -(mousePosition.y - startMousePosition.y) / height;
        var lookFactor = 0.05;
        camera.lookRight(x * lookFactor);
        camera.lookUp(y * lookFactor);
    }

    var cameraHeight = ellipsoid.cartesianToCartographic(camera.position).height;
    var moveRate = cameraHeight / 100.0;
    var rotateRate=1.5*Math.PI/60.0;

**监听键盘,调用平移旋转方法**

    if (flags.moveForward) {
        camera.moveForward(moveRate);
    }
    if (flags.moveBackward) {
        camera.moveBackward(moveRate);
    }
    if (flags.moveUp) {
        camera.moveUp(moveRate);
    }
    if (flags.moveDown) {
        camera.moveDown(moveRate);
    }
    if (flags.moveLeft) {
        camera.moveLeft(moveRate);
    }
    if (flags.moveRight) {
        camera.moveRight(moveRate);
    }
    if (flags.rotateRight) {
        camera.lookRight();
    }
    if (flags.rotateDown) {
        camera.lookDown();
    }
    if (flags.rotateUp) {
        camera.lookUp();
    }
    if (flags.rotateLeft) {
        camera.lookLeft();
    }
    if (flags.rotateForward) {
        camera.look(camera.direction,rotateRate);
    }
    if (flags.rotateBackward) {
        camera.look(camera.direction,-rotateRate);
    }
	});
