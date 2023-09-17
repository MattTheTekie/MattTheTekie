---
title: "通过接口下载文件"
summary: "通过接口下载文件"
publishedAt: "2022-04-29"
draft: false
---

## 前言

今天接了个需求，用文件名去请求，然后后端返回数据回来，前端下载。以前都是 location 直接跳转下载。

## 下载

下载通过原生的 fetch 接口来进行，[相关文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch)。因为原来请求是用 `umi-request` ，拦截器做了配置都不针对下载相关，所以会出问题，懒得改直接就封装一个 fetch 更方便

正常请求如下

```ts
export function downloadFileLink(link: string, fileName: string) {
  const a = document.createElement("a");
  document.body.appendChild(a);
  a.href = link;
  a.target = "_blank";
  a.download = fileName;
  a.click();
  a.remove();
  window.URL.revokeObjectURL(link);
}

async function downloadFile(url: string) {
  try {
    const result = await fetch(url, {
      method: "GET",
      headers: {}, // 自己的一些 token 相关
    });

    const blob = result.blob();
    const link = window.URL.createObjectURL(blob);
    downloadFileLink(blob, "下载名");
  } catch {
    // 相关的 catch 可以自行封装，fetch 只有在出现网络错误时会 catch
  }
}
```
