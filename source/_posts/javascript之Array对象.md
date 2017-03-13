---
title: javascript之Array对象
date: 2017-03-08 08:37:17
tags: JavaScript
categories: JavaScript
---
Array 对象用于在单个的变量中存储多个值,这个值可以是boolean,string,number,甚至都可以为为object,总之任何值都可以.
<!--more-->
## 构造

    var arr1 = new Array();
    var arr2 = new Array(size);
    var arr3 = new Array(element0, element1, ..., elementn);

通常用的最多的还是`var arr4 = []`
## 参数

>参数 size 是期望的数组元素个数。返回的数组，length 字段将被设为 size 的值.
参数 element ..., elementn 是参数列表.当使用这些参数来调用构造函数 Array() 时，新创建的数组的元素就会被初始化为这些值.它的 length 字段也会被设置为参数的个数.

## 返回值

>返回新创建并被初始化了的数组。
如果调用构造函数 Array() 时没有使用参数，那么返回的数组为空，length 字段为 0。
当调用构造函数时只传递给它一个数字参数，该构造函数将返回具有指定个数、元素为 undefined 的数组.
当其他参数调用 Array() 时，该构造函数将用参数指定的值初始化数组。
当把构造函数作为函数调用，不使用 new 运算符时，它的行为与使用 new 运算符调用它时的行为完全一样.

## 属性

|属性   |   描述|
| ------------- |:-------------:| -----:|
|constructor | 返回对创建此对象的数组函数的引用|
|length | 设置或返回数组中元素的数目|
|prototype  | 使您有能力向对象添加属性和方法|

## 方法

先上张图片[示例图](../../../../imgs/fangfa.png)
使用了比较容易理解的方法:
1. push: 向数组的末尾添加一个或更多元素，并返回新的长度.
2. unshift: 向数组的开头添加一个或更多元素，并返回新的长度.
3. sort: 对数组的元素进行排序.
4. valueOf: 返回数组对象的原始值.
5. toString: 返回字符串.
6. shift: 删除并返回数组的第一个元素.
7. pop: 删除并返回最后一个元素.
8. concat: 连接两个或更多的数组，并返回新的数组.
9. join: 把数组的所有元素放入一个字符串。元素通过指定的分隔符进行分隔.
10. slice:
11. splice:
这两个比较混淆,下次再写,打卡回家~