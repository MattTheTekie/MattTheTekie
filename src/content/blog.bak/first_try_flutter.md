---
title: "第一次尝试Flutter"
summary: "第一次尝试Flutter"
publishedAt: "2010-01-12"
draft: false
---

## 前言
听闻**Flutter2.0**很强，作为前端刚好对APP有点兴趣，整起来试试

## 环境
公司用的是Windows，先下载Flutter的SDK，迫于墙，所以在国内站下载，[地址](https://flutter.cn/docs/get-started/install/windows)  
跟着配置，我是用`VSCode`开发的，所以下面都是基于VSCode

## 创建项目和启动项目
创建项目还好，直接Flutter插件创建就好了，但是使用模拟器启动的时候就遇到问题了，会一直卡在
```
Running Gradle task 'assembleDebug'...
```
google了一下大家都说是墙的问题，然后改了一下阿里的源，直接起飞！下面和大家讲一下如何修改。  
首先找到项目下`android/build.gradle`这个文件，修改以下内容：
```
buildscript {
    repositories {
        // 下面两行是注释的，maven开头的是新增的
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }
}
```
然后重新运行一下`main.dart`就能跑了<strike>（万恶的墙啊）</strike>

## 总结
以上就是安装到运行的一些问题，等初步写个Demo出来熟悉了，再写一篇