---
title: "Zenfone8 Project Blaze"
description: "メモ書きと詰まったところの小話と愚痴"
date: 2022-09-10T23:11:01+09:00
draft: false
categories: ["Android","カスタムROM"]
tags: ["Android", "カスタムROM"]
image: "https://user-images.githubusercontent.com/87426352/157710326-991ecb31-65cf-460b-b3ec-d6ddad1edbdb.png"
---

## ProjectBlazeって？  
カスタムROMの一種で様々なカスタム機能を持ち合わせています。  
またAndroid12で変更されたQSパネルのデザインが11以前のものになるようにカスタマイズされています。~~多分一番の目玉機能~~  

## リンク  
[sourceforge.net](https://sourceforge.net/projects/any-artifact/files/sake/projectblaze/)  
Gappsビルドは無いのでサイドロードでNikGappsを入れてください。  

## How 2 install?  
※事前にAndroid12にしておいてください。  

### 必要なもののダウンロード  
boot.img,Blaze-v1.x-sake-xxxxxxxx-xxxx-VANILLA-UNOFFICIAL.zip,[vendor_boot.img](https://mirror.math.princeton.edu/pub/lineageos/full/sake/20220909/vendor_boot.img)をダウンロード。  
### リカバリのダウンロード  
ブートローダーに入って以下のコマンドを実行してリカバリとvendor_bootを書き込む。  
```
fastboot flash vendor_boot <vendor_boot>.img  
fastboot flash boot boot.img  
```
### インストール  
Lineage RecoveryでBlaze-v1.x-sake-xxxxxxxx-xxxx-VANILLA-UNOFFICIAL.zipをサイドロードしてインストール。  
GappsやMagiskが必要な場合はこの段階で一緒にサイドロードしとくと楽です。  
Magisk.zipはapkの拡張子をzipに変更することで使用できます。(公式的にはこの使い方は[非推奨](https://topjohnwu.github.io/Magisk/install.html#custom-recovery))  


## 不具合とか  
- NFCが動作しない(ビルド時になんかエラーを吐かれたので一時的に無効化していますそのうち何とかします。)  
- バッテリー残量を検出できない

## Changelog  
```  
20220918-1405  
1.5-EOLの不具合修正版に更新 
[詳細](https://t.me/projectblaze/45825)

20220910-1119  
ベースバンドがおかしかったのでカーネルをArrowOSのものからLineage19.1に変更  

20220909-1317  
初めてのビルド
```  

## ちょっとした小話  
ビルド時に詰まったところ  
- "generated_kernel_includes ": cmd: unknown variable '$(PATH_OVERRIDE_SOONG)  
GSIビルドしてる時にもここで詰まった。  
結論としては、lunchではなくbreakfast sakeを叩いてあげるとエラーが出なかった。理由は知らん。  

- clang-12: error: no such file or directory: 'aarch64-linux-android-'  
こいつに4日くらい悩んでた気がする。  
Blazeのofficial deviceのツリーに習ってBoardconfig.mkに以下を記入することで解決した。  
```
TARGET_KERNEL_CLANG_COMPILE := true
```

- qcom hardware関連のエラー  
android_hardware_qcom_bootctrl,android_hardware_qcom_commonのブランチをarrow-12.1-cafに、
sm8350のandroid_hardware_qcom_audio,android_hardware_qcom_display,android_hardware_qcom_mediaのブランチをarrow-12.1-caf-sm8350に変更することで対処。  


GSIのほうのお話  
- Gapps同梱ビルドについての悩み  
GappsはGoogleの製品なので最初は同梱しない方針だったけど  
Gapps同梱して！みたいな話が短時間で数件来てTelegramでも~~晒されて~~関係のないphhusson氏のコミュニティでも若干迷惑をかけてしまったので  
~~渋々~~同梱ビルドを配布していますが良くないよなぁってのが最近の悩み。  
GSIを使っている人の中にはカスタムリカバリがない端末を使用している人もいるだろうからちょっと同情してしまったのもありますが。  
Magisk GappsもA12.1用のものはAlphaリリースで挙動も怪しいので何とも言えません。  

- 機種名を書かないままissueを飛ばしてくる人が多かったのでテンプレを作成して強制的に機種を書かせるようにしたら知らない機種の話を聞く羽目になった話。  
お悩み相談には乗ってあげたいけど正直わからんもんはわからん。  


- あと金欠でツユさんのライブ行けなくて瀕死です。~~あの世行きのバスに乗ってさらば~~