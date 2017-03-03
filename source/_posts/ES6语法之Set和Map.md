---
title: ES6语法之Set和Map
date: 2017-02-22 15:00:48
tags: JavaScript,ES6
categories: JavaScript
---
空闲下来,读了读<<ECMAScript 6入门>>,全面介绍了ES6语法的新特性.
<!--more-->
# Set
类似于数组,只是值都是唯一的
1. 构造
    
    let set = new Set();
    set.add(1).add(2).add(1).add(3);//Set { 1, 2, 3 }
    set.size;   //3

也可以传一个数组
    
    let set = new Set([1,2,3,1]);
注: 两个NaN是相等的,两个对象总是不等的
2. 方法
    
    set.add(value);//添加
    set.has(value);//true or false
    set.delete(value);//ture or false
    set.clear();//清除
3. 遍历

keys()和values()效果一样:

    set.keys();//SetIterator { 1, 2, 3 }
    for(let a of set.keys()){
        console.log(a);//1,2,3
    }

entries():返回的遍历器包括键名和键值:

    for(let of set.entries()){
        console.log(a);//[ 1, 1 ][ 2, 2 ][ 3, 3 ]
    }
forEach()回调函数:
    
    set.forEach((value,key)=>{
        console.log(value);
    })
# Map
比object强大的多,一种键值对,他的键不仅可以为字符串,还可以是对象,直接放栗子

1. 构造

    let map = new Map();
    let o = {v:"key"};
    map.set(o,'first');//Map { { value: 'key' } => 'first' }

也可以传一个数组:
    
    let map = new Map([['name','chao'],['age',23]]);//Map { 'name' => 'chao', 'age' => 23 }

2. 方法: 
    
    map.set(value,key);//添加
    map.get(value);//key or undefined
    map.has(value);//true or false
    map.delete(value);//ture or false
    map.clear();//清除


注:字符串的true和布尔的true不是同一个键.
3. 遍历

keys(): 键
    
    for(let key of map.keys()){console.log(key);}

values():值

    for(let key of map.keys()){console.log(value);}

entries():

    for(let [k,v] of map.entries()){console.log(k+':'+v);}
    结果:name:chao
         age:23

forEach():   

    map.forEach(function(k,v,map){console.log(k,v,map)}
结果:

        chao name Map { 'name' => 'chao', 'age' => 23 }
        23 'age' Map { 'name' => 'chao', 'age' => 23 }

# 类型装换
1. Map转数组
使用扩展运算符(...)
2. 数组转Map
把数组传入Map的构造函数
3. Map转对象

    function map2obj(map){
        let obj = Object.create(null);
        for(let [k,v] of map){
            obj[k] = v;
        }
        return obj;
    }

4. 对象转Map:
    
    function obj2map(obj){
        let map = new Map();
        for(let k of Object.keys(obj)){
            map.set(k,obj[k]);
        }
        return map;
    }

就酱紫~