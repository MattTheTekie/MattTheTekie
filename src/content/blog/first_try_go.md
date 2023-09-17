---
title: "国内环境配置 Golang"
summary: "国内环境配置 Golang"
publishedAt: "2021-08-28"
draft: false
---

## 前言
最近在学习 Golang，但是由于网络问题安装老出错，所以稍微记录一下，比较简单。

## 版本
go 1.17

## 安装
首先就是安装，如果没有代理的话可以走 [https://golang.google.cn/](https://golang.google.cn/) 或者 [https://gomirrors.org/](https://gomirrors.org/) 这两个网站下载，有代理的话正常官网就行了。

我这里是 Windows 环境，Linux 和 mac 下估计会简单一点吧。

首先是选择安装路径，默认是在 `C:\Program Files\Go` ，不过我改成了 `C:\go` 的路径方便自己管理，当然也可以安装在其他盘符。

这里是**重点**
* 安装完成后，进入`系统环境变量`，将 `GOPATH` 的路径改成 `C:\go` 
* 之后选中 `Path` (记住是用户变量里的，不是系统变量)，点击`“编辑”`
* 看看有没有关于 Go 的环境变量，有的话就修改成 `C:\go\bin` 没有的话就加上
* 点击确定保存

## 查看版本号
接下来在终端里输入 `go version` 查看版本号
```shell
go version
```
返回正常的话说明安装没问题

之后输入 `go env` 查看环境变量是否已经改成你之前修改的了，如果没有修改成功，之后的一些操作可能会报错
```shell
go env
```

## 设置代理
因为国内网络环境问题，我们之后的一些包会安装失败，所以这个时候咱们把代理切到国内，可以选择 [goproxy.io](https://goproxy.io/zh/) 或者 [goproxy.cn](https://goproxy.cn/)

这里我选择的是 cn 的，根据教程设置一下环境变量就行，选哪个不重要，重要的是能用就行。
```shell
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

## VSCode 配置
配置好以上，接下来我们来配置 VSCode ，如果你不使用 VSCode 可以跳过这一步。

在插件中安装 `Go`

根据插件提示的 `Install:all` 就可以了，如果没有做上面的代理和环境配置，安装可能会出错

## 总结
以上完成配置，网络环境虽然很复杂，但是善用搜索还是能找到解决方案的！
