---
title: linux下mysql的学习之路
date: 2016-06-18 10:18:24
tags: [linux,Mysql]
categories: mysql
---
由于毕业设计的需要,基于安卓的智慧云班的设计与实现,客户端采用Eclipse+adt,服务器端采用MyEclipse,数据库使用过微软的sql server和Oracle公司的oracle的Oracle,当然由于只是用来学习,不涉及商用,找来的破解版,但是对于毕业设计,电脑配置的原因,让我不得不放弃这两款数据库,光使用Eclipse和MyEclipse这俩IDE,内存都已经吃不消了,所以就接触了小巧开源的MySQL,当然是在windows下.现在[实验楼](https://www.shiyanlou.com/courses/running)发现linux下的学习教程,记录两种操作系统下的差异.
<!--more-->
## Ubuntu下安装配置MySQL
最简单的方法就是在线安装:

	sudo apt-get install mysql-server     //安装MySQL服务端、核心程序
	sudo apt-get install mysql-client          //安装MySQL客户端
在安装过程中会提示确认输入YES，设置密码（之后也可以修改）等，稍等片刻便可安装成功。

安装结束后，用命令验证是否安装成功：
	sudo netstat -tap | grep mysql

对于windows系统,MySQL安装文件分为两种，一种是msi格式的，一种是zip格式的。如果是msi格式的可以直接点击安装，按照它给出的安装提示进行安装（相信大家的英文可以看懂英文提示），一般MySQL将会安装在C:\Program Files\MySQL\MySQL Server 5.6 该目录中；zip格式是自己解压，解压缩之后其实MySQL就可以使用了，但是要进行配.

##打开MySQL
使用如下两条命令，打开MySQL服务并使用root用户登录：

	sudo service mysql start             //打开MySQL服务
	mysql -u root                        //使用root用户登录
windows系统,打开MySQL的话要现在服务中启用MySQL服务,这个坑了我好久( ⊙ o ⊙ )啊！
##MySQL命令(注意分号)
	显示数据库: show databases; 
	连接数据库: use database_name;
	显示数据表: show tables;
	退出数据库: quit   //等同于exit,无分号
像sql server和oracle都使用的是图形化界面,突然间使用命令行,还真有点不习惯,不过感觉离计算机系统更近了,后来发现MySQL也有图形化界面.
##over
至于sql语句,比如创建数据库,创建数据表,对数据表进行各种约束,对数据的增删改查,所有的数据库语句大同小异.语句太多,慢慢积累.
