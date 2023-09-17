---
title: "安卓WebView同Javascript通信"
summary: "安卓WebView同Javascript通信"
publishedAt: "2010-01-12"
draft: false
---

## 前言
最近项目里有需要用到安卓WebView和JS通信，毕竟不是安卓开发，就去了解了一下。

## 环境
用的Kotlin的原生和Vue3

### 创建项目
首先开一个原生安卓的`Empty`模板，在`activity_main.xml`中嵌入一个`WebView`
```xml
<WebView
    android:id="@+id/webview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
/>
```
在`AndroidManifest.xml`文件中写入网络权限配置，如果需要相机之类的权限，加入后再动态申请，这里只演示通信
```xml
<manifest>
    // ...
    <uses-permission android:name="android.permission.INTERNET" />
    // ...
</manifest>
```

## 配置Kotlin文件
在项目下的`MainActivity.kt`中写入
```kt
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    val webView = setWebViewSettings()
}

@SuppressLint("SetJavascriptEnabled")
private fun setWebViewSettings(): WebView {
    // 找到webview的控件
    val myWebView: WebView = findViewById(R.id.webview)
    // 启用js
    myWebView.settings.javaScriptEnabled = true
    // 与js交互，js中就用client开始调用
    myWebView.addJavascriptInterface(UserInfoInterface(this), "client")
    // 防止webview跳转到APP外的浏览器
    myWebView.webViewClient = object : WebViewClient() {
        override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
            Log.i("LogHelper", request?.url.toString())
            return super.shouldOverrideUrlLoading(view, request)
        }
    }

    return myWebView
}
```
配置完上面后，我们需要再写一个`UserInfoInterface`的类来让js调用
```kt
class UserInfoInterface(mContext: MainActivity) {
    private var context = mContext

    @JavascriptInterface
    fun getMsgFromAndroid(): String {
        return "Hello Javascript, msg from android"
    }
}
```
以上，就配置完安卓部分，接下来我们编写HTML方面

## 编写Vue.js
这边我们创建一个Vue3的项目，在`App.vue`文件中改成如下
```vue
<template>
  <p>{{inputPond}}</p>
  <button @click="onGet">Get Android</button>
</template>

<script>
export default {
  data: () => ({
    inputPond: null
  }),

  methods: {
    onGet() {
      // 同过原生注入的client调用getMsgFromAndroid方法
      this.inputPond = client.getMsgFromAndroid()
    }
  },
}
</script>
```
运行项目，把项目运行的地址复制出来，继续回到安卓部分

## WebView跳转
再次回到`MainActivity.kt`的`onCreate`中
```kt
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    val webView = setWebViewSettings()
    // webview跳转，url改成你vue启动的地址
    webView.loadUrl("http://192.168.1.223:8080")
}
```

## 运行项目
这个时候你应该会看到Vue的页面，点击按钮，如果你的页面文字内容变成**Hello Javascript, msg from android**，那么通信就成功了！

## 总结
目前安卓开发大部分都开始使用kotlin了，有时候网络上找的还是java的有点不太一样，多搞几次就会发现通信不是很难。

有些人可能会说跨平台或者uni-app不香吗，香是肯定香，但是有些项目没法用到这个东西，只能通过webview和js通信来搞。

希望对各位能有所帮助！
