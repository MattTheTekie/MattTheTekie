---
title: "在项目中引入ESLint"
summary: "在项目中引入ESLint"
publishedAt: "2021-07-09"
draft: false
---

## 前言
在项目开发过程中，随着团队成员的增加以及项目体量的增大，我们需要更加规范我们的代码，除了一些概念性的规范(如 Airbnb 规范)，我们还需要通过引入 ESLint 来自动化规范我们的代码。

## 引入
首先确保我们的项目中使用 `Webpack`，先引入`ESLint Webpack Plugin`
```shell
yarn add eslint-webpack-plugin -D
# or
npm install eslint-webpack-plugin --save-dev
```
之后在 Webpack 配置中引入
```js
const ESLintPlugin = require('eslint-webpack-plugin')

// ...
module.exports = {
  // ...
  plugins: [
    // ...
    new ESLintPlugin()
    // ...
  ]
  // ...
}
```

如果使用的编辑器是 VSCode，记得安装插件 `ESLint`

## 生成规范
ESLint 会通过本地文件 `.eslintrc.js` 来判断规则，我们可以自己编写规则，也可以直接引入现成的规则，比如: Airbnb, Standard 等。

通过命令生成文件
```shell
npx eslint --init
# 如果 eslint 全局安装了，可以如下
eslint --init
```

根据提示来进行选择就可以了，选择好之后再运行项目，就会发现项目会报一些 error/warning 了，这些都是正常的，我们可以通过命令行 `--fix` 来修复一些简单的规范问题

## 自动代码格式化
我们可以通过在 `package.json` 中编写脚本
```json
{
  // ...
  "scripts": {
    "lint": "eslint --fix"
  }
  // ...
}
```
如果是格式化特定的格式，可以加上 `--ext .js`

那么我们在运行这个命令之后，一些简单的（比如结尾逗号/函数之间空格等）问题都会自动修复啦，不过如果碰上`定义了函数没有使用`这种，就需要自己手动去改啦。

## 保存时格式化
一般有`eslint`和`prettier`两种，既然我们讲 eslint 就按照eslint来吧。前提是要确保编辑器或者 IDE 支持保存时格式化的功能，这边以 VSCode 为例。

我们安装了 ESLint 插件之后，在 VSCode 设置中设置以下的参数
```json
{
  "eslint.format.enable": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```
保存后就可生效，也可以写入到 `.vscode/settings.json` 的文件，这样别人使用项目如果也是 VSCode 那么也可以直接生效。

那么同理，有些项目中推荐使用的插件，也可以写在 `.vscode/extensions.json` 中，别人打开后会推荐插件安装。
