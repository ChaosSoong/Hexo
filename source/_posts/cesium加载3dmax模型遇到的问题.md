---
title: cesium加载3dmax模型遇到的问题
date: 2017-02-15 15:36:02
tags: cesium
categories: cesium
---
北京的项目中,拿到了.max格式的模型,记录一下.max文件导出gltf的正确方式.
<!--more-->
## 安装准备
[3ds Max 2014](),[COLLADAMax.dle插件](https://github.com/ChaosSoong/daeTogltf_tool)[daeTogltf工具](https://github.com/ChaosSoong/daeTogltf_tool)
![插件](../../../../imgs/collada2gltf.png)
,Autodesk自家的dae格式导出后无法使用,用这个格式才可以,至于为什么,标准问题吧.
然后把这个文件放到3dmax安装目录的stdplugs文件夹下,打开3dmax/自定义下的插件管理器,加载该插件,准备完毕.
![插件管理器](../../../../imgs/插件管理.png)
## 导出选项
![导出格式](../../../../imgs/导出格式.png)
1. 打开max文件,导出obj格式的文件,注意导出选项:
![obj选项](../../../../imgs/obj选项.png)
2. 打开导出的obj文件,导出open格式
![dae选项](../../../../imgs/dae选项.png)
3. dae转换为gltf文件,**dae和转换文件最好在同一目录下**
打开命令行输入`collada2gltf.exe your_dae.dae` 等待完成
## 加载

    var p = Cesium.Cartesian3.fromDegrees(116, 39, 10);
    var modelEntity = viewer.entities.add({
            position: p,
            model: {
                uri: 'your_gltf_url.gltf',
                scale: 1
            }
        }); 
    viewer.trackedEntity = modelEntity;//加载后直接定位到模型查看
![效果](../../../../imgs/效果.png)
# 导出目录千万别有中文
# 导出目录千万别有中文
# 导出目录千万别有中文