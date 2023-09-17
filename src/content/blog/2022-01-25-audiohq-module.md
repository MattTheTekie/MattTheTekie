---
title: "アプリ別音量コントロールを可能にする『Audio HeadQuarter』を使ってみた"
summary: "アプリ別音量コントロールを可能にする『Audio HeadQuarter』を使ってみた"
description: "便利でとても気に入りました。"
publishedAt: "2010-01-12"
draft: false
categories: [Android]
tags: ["Android","Magisk",]
---

## 前置き  
Z01RのOSをAndroid11(Evolution X 5.9)からAndroid12(crDroid8.0)に変更しました。  
動作も良好で安定していたのですが1つ問題があって、  
Evolution Xにはあったアプリ別に音量を調整する機能が無かったので不便だな～と思ってググったら  
良さそうなものを見つけたので使ってみたところかなり良かったので自分用に書き残すことにしました。  

・環境  
機種: Zenfone 5z  
OS: Android12(crDroid8.0)  
Magisk Canary 23018 & Zygisk  

 ⚠注意  
 この作業に取り掛かる前に必ずデータのバックアップを取ってください。  
 また、ここに書いてることを真似する場合は自己責任でお願いします。  
 この記事の内容を実践して生じた損害等の一切の責任を負いかねますので、ご了承ください。  
~~あなたの大切なスマホが文鎮になっても私は責任を取れません。~~  


## ダウンロードするもの  
- [audiohq_combined_1.zip](https://github.com/Alcatraz323/audiohq_module/releases/tag/api31_r1)  

## インストール  
Magisk Managerでaudiohq_combined_1.zipをインストールして再起動。  
再起動すると『Audio HeadQuarter』という名前のアプリがあるので起動する。  
あとは注意書きやらなんやらを読みつつbattery optimizationと他のアプリの上に重ねて表示を有効にすればセットアップは完了。  

Settings > Float windowと進んでFloat Serviceにチェックを入れる。  

## 使ってみよう  
音量ボタンを押すと左上に音量マークが出てくるのでそれをタップすると起動しているアプリの音量が0~100%で調整できる。  
{{< tweet 1485880208393908225 >}}  

## 最後に  
多分一番お勧めできる神モジュール