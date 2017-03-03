---
title: 谈谈JavaScript的灵活性
date: 2017-02-10 13:02:14
tags: JavaScript
categories: JavaScript
---
javascript是现在最流行,应用最广泛的语言,也是在github上开源项目使用最多的语言,很大的原因得益于其强大的灵活性,JavaScript程序员可以把程序写得很简单,同样也可以把他写的很复杂.这种语言也支持不同的编程风格,可以采用函数式编程风格,也可以面向对象式的编程风格.下面就简单聊聊我眼中的JavaScript的灵活性.
<!--more-->
来一个用不同方法来实现同样任务的例子:写文档和改bug,例子可能不够贴切,尽量理解好伐.
## 1
面向过程是的程序设计,就像这样:

    function writeDocument(){
        console.log("这是一件很烦的事");
    };
    fuction fixBug(name){
        console.log(name + "说这是一件很有意思的事情");
    }
## 2
有意思的是在ＥＳ６里加入了箭头函数，类似这样:`(param1, param2, …, paramN) => { statements }`改写上面两个方法就简单多了：

    ()=>{"这是一件很烦的事";}
    (name)=>{name+"说这是一件很有意思的事情";}
确实省了不少代码吧,其实箭头函数返回的也是Function.
## 3
这种方法简单易懂,但无法创建可以保存状态并且具有一些斤对其内部状态进行操作的方法的对象,所以就产生了这种:

    var Coder = function(){
        ...
    }
    Coder.prototype.writeDocument = function(){
        console.log("这是一件很烦的事");
    }
    Coder.prototype.fixBug = function(name){
        console.log(name+"说这是一件很有意思的事情");
    }
使用如下:

    var coder = new Coder();
    coder.writeDocument();
    coder.fixBug("fuck");
## 4
上述代码定义了一个Coder类,并把两个方法赋值给他的prototype属性,当然你也可以封装在一条声明中,就像这样:

    var Coder = function(){
        ...
    }
    Coder.prototype = {
       writeDocument : function(){
        console.log("这是一件很烦的事");
        }
       fixBug : function(name){
        console.log(name+"说这是一件很有意思的事情");
        } 
    } 
## 5
接下来吧类的方法的声明内潜在类的声明中:

    Function.prototype.method = function(name,fn){
        this.prototype[name] = fn;
    }
    var Coder = function(){};
    Coder.method("writeDocument",function(){});
    Coder.method("fixBug",function(name){});
Function.prototype.method用于为类添加新的方法,第一个参数为字符串,表示新的方法的名称,第二个参数即为函数.
##　６
可也以进一步修改Funtion.prototype.method方法,使其可被链式调用,就像jQuery一样,只需让他返回this即可:

    Function.prototype.method = function(name,fn){
        this.prototype[name] = fn;
        return this;
    }
    var Coder = function(){};
    Coder.method("writeDocument",function(){});
    Coder.method("fixBug",function(name){});

使用如下:

    var Coder = function(){};
    Coder.
        method("writeDocument",function(){
            console.log("这是一件很烦的事");
            }).
        Coder.method("fixBug",function(name){
            console.log(name+"说这是一件很有意思的事情");
            });

## 7
ES6用了关键字class,就感觉熟悉多了:
    
    class Coder(){
        //构造器
        constructor(name){
            this.name = name;
        };
        writeDocument(){
            console.log("这是一件很烦的事");
        };
        fixBug(){
            console.log(this.name+"说这是一件很有意思的事情");
        }
    }
使用如下:

    var coder = new Coder("fuck");
    fuck.writeDocument();
    fuck.fixBug();

这几种编程风格哪一种适合你呢?
以上仅是个人理解,如有错误,还请请教.


