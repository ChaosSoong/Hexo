---
title: python scrapy install
date: 2016-08-13 13:49:54
tags: [python,scrapy]
categories: python
---
在学习[Python基础](http://www.liaoxuefeng.com/article/001432619295115c918a094d8954bd493037b03d27bf9a9000)时,学会了使用urllib和urllib2库进行简单的爬虫,,但有太基础,后来就找了一个[scrapy框架](http://scrapy.org/),首先遇到的困难就是如何安装,由于官网全是英文版的,只过了四级的我,但是也强读下来[安装教程](http://doc.scrapy.org/en/master/intro/install.html#windows),然而按照教程并没有安装成功,以下是官网提供的:

1. 安装完Python2.7后,配置环境变量
	C:\Python27\;C:\Python27\Scripts\;
	c:\python27\python.exe c:\python27\tools\scripts\win_add2path.py
2. [安装pywin32](http://sourceforge.net/projects/pywin32/)这里要适合你的系统版本(win32 或 amd64)我的机子是AMD64的
3. [安装pip](https://pip.pypa.io/en/latest/installing/),测试是否成功:
	pip --version
4. 最后使用pip包管理scrapy
	pip install Scrapy
<!--more-->
一步一步跟下来后却发现安装失败,原因提示 Microsoft Visual C++库没安装,后来百度到[静觅](http://cuiqingcai.com/912.html)提供了scrapy框架的安装配置,又按照这里的教程安装,当安装lxml时,又提示libxml2没有安装,使用以下命令:

	pip install libxml2

安装未成功,又找可执行文件安装,但是这个又只更新到Python2.6版本,依然无法使用,导致''' pip install Scrapy '''仍无法安装成功,最后在stackoverflow中找到解决方案,直接下载相关版本的lxml的可执行文件即可.
所有需要的安装文件都在[github](https://github.com/ChaosSoong/py_spider)上.

注:我的电脑配置:AMD64,Python2.7