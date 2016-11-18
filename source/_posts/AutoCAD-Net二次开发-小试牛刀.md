---
title: AutoCAD.Net二次开发 小试牛刀
date: 2016-11-18 14:36:38
tags: [AutoCAD,DotNet,CSharp]
categories: CAD.NET
---
正忙着学习openlayers呢,突然之间,经理说给我讲一下有关CAD.NET二次开发的东西,嗖嗖嗖的给我传来一个小项目,叫AutCad(我天,可能是由于我有强迫症的原因吧,缺个o好不舒服啊),一顿乱叨逼,天花乱坠的,把我搞得一脸懵逼,过后一想,就是vs使用AutoCAD API来开发,通过程序实现了cad制图.
<!--more-->
然而,出现了一个问题,不能实现对添加的字体改变大小和样式,这不就叽叽了吗?后来我就鼓捣鼓捣,结果还真实现了,很兴奋也很激动,也许这就是我编程的目的吧O(∩_∩)O哈哈~
我的开发环境:Visual Studio 2013和AutoCAD 2014.这两款工具安装都很简单,一直下一步即可,当然AutoCAD是需要注册使用的,注册机网上一搜一大把,也不难.
重要的来了~
1. 新建一个Class Library项目.
![看](../../../../imgs/first.jpg)
2. 添加所需的引用.**引用都在AutoCAD的安装目录下** 并将其属性复制本地改为FALSE.
![不](../../../../imgs/second.jpg)
我们可以看看引用的文件是干什么的.
![道](../../../../imgs/third.jpg)
在对象浏览器中查看.
![我](../../../../imgs/forth.jpg)
3. 引入所需的命名空间
    using Autodesk.AutoCAD.EditorInput;
    using Autodesk.AutoCAD.ApplicationServices;
    using Autodesk.AutoCAD.Runtime;
    using Autodesk.AutoCAD.DatabaseServices;
    using Autodesk.AutoCAD.Geometry;
    using Autodesk.AutoCAD.Colors;

4. 添加一个方法
    [CommandMethod("HelloWorld")]
        public void HelloWorld()
        {
            Editor ed = Application.DocumentManager.MdiActiveDocument.Editor;
            ed.WriteMessage("HelloWorld CAD！");
        }
5. 右键项目,注意目标框架需要4.0及其以上版本,并将调试改为启动外部应用
![了](../../../../imgs/tiaoshi.jpg)
6. 编译并将启动项目,会打开AutoCAD,在命令行输入netload,加载你新建的类库dll文件,会有一个安全提醒,别管他,在命令行输入HelloWorld,也就是你的项目里的方法名,在CAD的命令行就会出现 **HelloWorld CAD！** ,就是这么神奇!
注意坑: 
**两个工具的版本一定要对应好**
**两个工具的版本一定要对应好**
**两个工具的版本一定要对应好**
[可以看看这里,虽然有点老](http://blog.csdn.net/tytmty/article/details/37754449)
英语好的当然是得看官方给的文档了,[这里也不错](http://help.autodesk.com/view/ACD/2015/ENU/?guid=GUID-4E1AAFA9-740E-4097-800C-CAED09CDFF12)