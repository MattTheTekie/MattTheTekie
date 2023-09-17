---
title: "Androidに必ず入れたいモノをメモる(Riru環境)"
description: "自分が入れているアプリやモジュール等々"
date: 2021-11-06T23:08:18+09:00
draft: false
categories: [Android]
tags: ["Android","Magisk","Xposed"]
---


##前置き  
初期化する度に入れていたアプリ等々を思い出すのも面倒なので自分用にまとめます。  
・環境  
機種: Huawei P30  
OS: Android11(DotOS 5.2 arm64 Vanilla)
Magisk 23.0 & Riru v26


## Magisk関連  
[Magisk](https://github.com/topjohnwu/Magisk/releases)  
これがないと何も始まらない。  
### モジュール
-  [Busybox for Android NDK](https://www.androidacy.com/downloads/?fm_rdme_links=&view=%2540Magisk-Modules%2540Busybox_for_Android_NDK)  
これが必要なアプリがいくつかあるので(後述)  

- [Font Manager](https://www.androidacy.com/downloads/?fm_rdme_links=&view=%2540Magisk-Modules%2540Font_Manager)  
システムの絵文字をTwemojiに変更するのに使用。  

- [Koruri Font](https://github.com/AndroPlus-org/magisk-module-koruri-font/releases)  
見やすいので愛用しています。  

- [Magisk GApps Core](https://sourceforge.net/projects/magiskgapps/files/r/Core/)  
使用しているROMがVanillaなのでGMSを使用するために使用。(Android R限定)  

- [MagiskHide Props Config](https://github.com/Magisk-Modules-Repo/MagiskHidePropsConf/releases)  
出来ることが多くて何を書けばいいのか分からない。  

- [Riru](https://github.com/RikkaApps/Riru/releases)  
LSPosedやHide My Applist(後述)を使用するために入れている。Zygiskなるものが出たので今後は不要になるかもしれない。  

- Riru - Hide My Applist  
Hide My Applistのアプリからインストールできるやつ。  

- [Riru - LSPosed](https://github.com/Magisk-Modules-Repo/riru_lsposed/releases)  
Xposedの後継。今後はZygisk版を使うかもしれない。    

- [Universal SafetyNet Fix](https://github.com/kdrag0n/safetynet-fix/releases)  
おま環かもしれないがDotOSは初期状態でもSafetyNetが通るので必要ないと思うが一応。

## Root権限が必要なアプリ  
- [Vanced Manager](https://vancedapp.com/)  
消されちまった😂  
真面目な話広告ブロックは必要ないからその他の便利機能だけ詰め込んだやつが欲しい。  
結局オフライン再生の為にpremium使うしな～。
- [Pakage Disabler](https://drive.google.com/file/d/1g6PZ_H1FlH92BRr5DCqwNAKUkhDczioA)  
邪魔なアプリは全部これで無効化している。
- [Lucky Patcher](https://www.luckypatchers.com/download/)  
万能Patcher。自分は主に邪魔な広告を~~潰す~~消すのに使用している。(主にLINEのトークリスト広告ですね。現在は対策されています。)
- [Island](https://github.com/oasisfeng/island/releases)  
早い話EMUIで言うツインアプリだったりOne UIで言うデュアルメッセンジャーみたいなもの。  

### Xposedモジュール
- [Core Patch](https://github.com/LSPosed/CorePatch/releases)  
署名検証を無効にしてくれる。  
アプリのダウングレードなどができるようになる。
- [Hide My Applist](https://github.com/Dr-TSNG/Hide-My-Applist/releases)  
XposedモジュールやLSPosed、LPを隠すのに使っています。
- [Twitter Ad Eater](https://github.com/ppawel/twitter-ad-eater/releases)  
プロモツイートを非表示にしてくれる。~~でもタイムラインがバグるのであまり使ってない~~解決しました。

### ブラウザ  
- [Brave](https://brave.com/ja/)  
筆者が愛用していたブラウザ。  
簡単にweb上の広告をブロックしたりオンラインのプライバシーを保護出来たりと優秀。  
かなり軽いのでPC、Androidともにおすすめできる。
- [Firefox Nightly](https://play.google.com/store/apps/details?id=org.mozilla.fenix)  
筆者が最近使い始めたメインブラウザ。  
条件付きではあるがPC版と同じ拡張機能が使えるので重宝している。    
~~翻訳系の拡張機能も使えるので英語弱者な自分でも安心~~  
PC版はかなり軽かったのだがAndroid版はそうでもなかった。  
## [Firefox アドオン](https://addons.mozilla.org/ja/firefox/collections/17097905/my-addon/)
- [uBlock Origin](https://addons.mozilla.org/ja/firefox/addon/ublock-origin/)
軽量広告ブロッカー。道端で**漫画広告に出会いたくない人は使おう。  
- [ウェブページを翻訳](https://addons.mozilla.org/ja/firefox/addon/traduzir-paginas-web/)
英語弱者にはうれしい翻訳くん。Chromiumブラウザ向けの拡張機能版Google翻訳より有能。  

###  その他  
- [Bitwarden](https://bitwarden.com/)  
オープンソースなパスワードマネージャー(基本無料)  
パスワード生成、支払情報の保存、パスワードが漏洩していないかの確認、セキュアメモ等々、  
無料なのに機能が多くとても有能。  
- $10/年な有料プランに入るとOTPや1GBの暗号化ストレージが付いてくるぞ！  
ちなみにPCのクライアントやブラウザ版もあるのでスマホが急死しても安心。  
- [QuickPic Gallery](https://github.com/WSTxda/QP-Gallery-Releases)  
Android初期の頃にあったQuickPicの改造版らしい。使いやすい。  
- [ES file explorer](https://es-file-explorer.jp.uptodown.com/android)  
昔から愛用しているもの。Google playから消えてからは怪しい広告などが絶えないのでLPで消している。  
移行先が見つかればなと思いつつも探すのも面倒。  