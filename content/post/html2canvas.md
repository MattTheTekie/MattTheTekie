---
title: "html2canvas 坑"
date: 2022-05-07T21:38:30+08:00
draft: false
---

## 前言
群里卷仔的代码，用了 html2canvas ，但是保存成 canvas 时出现了文字下移的问题。

## 讨论 & 解决
老板 Sakura 给出了源码级解决方案，给[源码这里](https://github.com/niklasvh/html2canvas/blob/master/src/render/font-metrics.ts#L34)加上 `img.style.display = 'inline'` 就能解决。

后来发现禁用样式 `@tailwind base` 也能解决问题，所以从样式入手解决。

最后发现是

```css
img {
  display: block;
}
```
导致的问题。原因应该与 Sakura 给出的源码问题差不多，因此解决方案就是加上样式重置回默认
```css
img {
  display: unset;
}
```

## 总结
Sakura 真是太强啦！