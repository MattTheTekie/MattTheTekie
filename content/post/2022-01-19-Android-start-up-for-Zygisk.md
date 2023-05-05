---
title: "Androidに必ず入れたいモノをメモる(Zygisk環境)"
description: "自分が入れているアプリやモジュール等々(2022/5/20更新)"
date: 2022-01-19T16:17:12+09:00
draft: false
categories: [Android]
tags: ["Android","Magisk","Xposed"]
---


##前置き  
[Androidに必ず入れたいモノをメモる(Riru環境)](/p/androidに必ず入れたいモノをメモるriru環境/)をZygisk環境向けに編集したついでに  
新しく使用するようになったアプリ等々を追加した感じです。  
前記事から特に変化していない項目は省略しています。    
・環境  
機種: Zenfone 5z  
OS: Android11(EvolutionX 5.9)  
Magisk Canary 23016 & Zygisk  

## Magisk関連  
[Magisk](https://github.com/topjohnwu/Magisk/releases)  
これがないと何も始まらない。  
### モジュール  
- [Advanced Charging Controller](https://github.com/VR-25/acc/)
充電周りを見直そうと思って入れた。  
でもあまり触ってないので使いこなせていない。  

- [audiohq module](https://github.com/Alcatraz323/audiohq_module)  
アプリ別音量をコントロールを可能にするモジュール。  
[こちら](/p/アプリ別音量コントロールを可能にするaudio-headquarterを使ってみた/)に詳細書いてます。  

- [CloudflareDNS4Magisk](https://github.com/Magisk-Modules-Repo/CloudflareDNS4Magisk)  
気になったので使ってるだけ。  

- [Koruri Font](https://github.com/AndroPlus-org/magisk-module-koruri-font/releases)  
見やすいので愛用しています。  

- [Shamiko](https://github.com/LSPosed/LSPosed.github.io/releases)
Magiskを隠すのに使用しています。  
  
- [Twemoji replacer](https://github.com/Magisk-Modules-Alt-Repo/ttf-twemoji/)
FontManager使うのやめました。  
  
- [UnityFPSUnlocker](https://github.com/nishuoshenme/UnityFPSUnlocker)
ウ*娘60FPS👊👊

- [Zygisk - InternalBrowserRedirect](https://github.com/AndroPlus-org/Zygisk-InternalBrowserRedirect)  
Lineの内臓ブラウザが嫌いだからこれ使ってる。

- [Zygisk - LSPosed](https://github.com/LSPosed/LSPosed/actions)  
Xposedの後継。  

### モジュールの管理  
- [Fox's Magisk Module Manager](https://github.com/Fox2Code/FoxMagiskModuleManager)  
Magisk CanaryでモジュールのDLが出来なくなったため。  

## ブラウザ  
- [Iceraven Browser](https://github.com/fork-maintainers/iceraven-browser/releases)  
PC版Firefoxのようにアドオンのインストールに制限が無いfirefox。  

