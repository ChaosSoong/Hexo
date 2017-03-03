---
title: HTTP错误500.0 - Internal Server Error
date: 2017-02-23 15:12:11
tags: error
categories: error
---
北京的事算是忙过去了,就等那边来电话查看了.回过头来看看公司的主打项目,发现却不能打开了,报错:
    
        HTTP 错误 500.0 - Internal Server Error，无法在<fastCGI>应用程序配置中找到<handler> scriptProcessor.
还好IIS提示的信息够多:

        模块  FastCgiModule 通知    ExecuteRequestHandler 
        处理程序  qgis mapserver 错误代码 0x8007010b

看到 **应用程序配置** 和 **qgis mapserver**,应该是这个模块没有起作用,就找到项目下的这个文件,发现还在啊,就打开IIS管理器,找到fastCGI设置找到这个应用程序,也没问题,又打开web.config配置文件,找到scriptProcessor节点,发现路径错了,还指向原来的目录,原因是c盘不够大的,我把原来的项目移到了其他盘,然而配置文件还去找那个文件,当然会出错了.
虽然问题是小问题,但他似乎象征着一个解决问题的思路,特此记录一下,顺便表示:微软大法好!!!