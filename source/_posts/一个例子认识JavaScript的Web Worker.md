---
title: 一个例子认识JavaScript的Web Worker
date: 2017-03-02 18:20:02
tags: JavaScript
categories: JavaScript
---
JavaScript是单线程的,至于为什么,简单地说,JavaScript在进行DOM操作的时候就显得明显了,这个线程修改节点,而另一个线程又删除此节点,这就显得棘手了.但是有了HTML5的web worker特性就出现了类似的多线程.
`web worker 是运行在后台的 JavaScript，独立于其他脚本，不会影响页面的性能。您可以继续做任何愿意做的事情：点击、选取内容等等，而此时 web worker 在后台运行。`
一般来做耗费CPU的事情,比如复杂计算,下面就举一个小例子,记录web worker的使用.
<!--more-->
## 主线程

    if (typeof(Worker) !== "undefined"){//检测浏览器是否支持web worker
            var w = new Worker("myworker.js"); //定义一个worker对象
            w.postMessage(num);//向子线程中传递消息 var num = 2
            w.onmessage = function(event) { //onmessage事件接受子线程传来的数据
                console.log(event.data);
            };
            w.onerror = function(err){  //出错处理
                w.terminate();//关闭子线程
            }
        }else{
            console.log("您的浏览器不支持Web Workers");
        }

## 子线程
myworker.js中:

    // importScripts('fn.js');//引入外部脚本,不允许跨域
    var num;
    onmessage = function(event) {   //子线程中也是利用onmessage事件接受消息
        num = event.data;
        function add(a) {    //在子线程中耗费CPU的计算
            var count = a * 2;
            postMessage(count);
        }
        add(num);
        // add(num,num);    //
    };

fn.js :// 3.24更新

    function add (a,b) {
        return a+b;
    }
so easy!
注:由于 web worker 位于外部文件中，它们无法访问下例 JavaScript 对象：
1. window 对象
2. document 对象
3. parent 对象

我们可以做什么：
　　1. 可以加载一个JS进行大量的复杂计算而不挂起主进程，并通过postMessage，onmessage进行通信.
　　2. 可以在worker中通过importScripts(url)加载另外的脚本文件.
　　3. 可以使用 setTimeout(), clearTimeout(), setInterval(),  clearInterval().
　　4. 可以使用XMLHttpRequest来发送请求.
　　5. 可以访问navigator的部分属性.

