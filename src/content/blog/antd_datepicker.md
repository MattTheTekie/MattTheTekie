---
title: "antd datepicker 报错问题"
summary: "antd datepicker 报错问题"
publishedAt: "2022-08-30"
draft: false
---

## 前言
这两天开发同事碰到一个问题，他开发环境下 antd 的 DatePicker 组件会报一个错
```
antd datepicker cannot be used as a jsx component
```
搜了一下网上也有不少问题 [issue链接](https://github.com/ant-design/ant-design/issues/34952)

因为我们项目中用得还是 4.20.x 版本的 antd ，所以没有办法测试新版是否修复了问题，目前按照我们自己的方式找到了解决方法

## 解决方法
其实和上面 issue 里的解决方法一样，在 package.json 中加入 `resolutions`
```json
"resolutions": {
  "@types/react": "17.0.44",
  "@types/react-dom": "17.0.17"
}
```

在我们项目中，这个版本的 types 能很好的解决这个问题，但是还会出现一个问题。

因为用到了 resolutions ，所以 node 14 左右的 npm install 会没法成功，导致报错依旧。
而 node 16 的版本会因为版本不兼容导致 npm install 失败，需要 --force 才能继续安装

所以这边建议使用 yarn 来进行项目的运行和安装。

如果你们项目中还是使用 npm ，可以参考在 scripts 中加入如下
```json
"scripts": {
  "preinstall": "npx npm-force-resolutions",
}
```
或者 npm install --force ，实测也是没有报错，但不知是否有其他副作用
