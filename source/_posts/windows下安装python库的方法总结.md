---
title: 'windows下安装python库的方法总结 '
date: 2016-08-09 08:28:59
tags: [python,windows]
categories: python
---

以前在学校就接触过Python,但也只是拿来玩玩,没做过研究,这些天有时间就接着研究研究,感觉Python的风格很好,而且库特别多,现在就记录一下安装库的方法,我的测试机子是windows64位的,Python版本2.7的.
<!--more-->
我记得在安装Python时除了自带添加Python到PATH外,好像有一个添加pip选项,记不太清了,若果没有,概不负责,啧啧.当然你也可以自己安装pip.

## 安装Setuptools
从[官网下载Setuptools](http://peak.telecommunity.com/dist/ez_setup.py) 复制页面上的代码到ez_setup.py,在当前目录启用cmd,输入命令以下命令即可:

	python ez_setup.py
以后就可以直接在命令行进行在线安装

	easy_install package_name //你要安装的包名
然而好多包都不能用此法安装了,被pip渐渐替代
## pip命令
首先安装[pip](https://pypi.python.org/pypi/pip#downloads)下载压缩包后解压,在解压目录打开cmd命令,输入:

	python setup.py install
安装好之后,需要添加环境变量,然后我们就可以使用pip命令玩耍了:

	pip list //查看安装包列表
	pip install package_name   //安装你需要的库

## exe,msi
最简单的安装库的方法,直接下载双击安装,当然支持的包不多,我们的python就是这么安装的.
## egg,whl
egg,whl包也需要setuptools的支持

	easy_install xxxxxxx.egg  //egg包名
	pip install xxxxxxx.whl   //whl包名
## 推荐库

- 图像处理的[pillow](https://pypi.python.org/pypi/Pillow)
- 解析html,xml的[lxml](http://lxml.de/)和[beautifusoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc.zh/)
- numpy 科学计算
- 爬虫框架[scrapy](http://scrapy.org/)
- web框架[Djang](https://www.djangoproject.com/)
- 模板引擎[jinja2](http://jinja.pocoo.org/)
- 数据库[MySQL](https://pypi.python.org/pypi/MySQL-python)

太多太多了,以后有的学了



	

