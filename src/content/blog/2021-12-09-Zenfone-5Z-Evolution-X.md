---
title: "Zenfone 5Zを買ったのでEvolution Xを入れてみる"
summary: "Zenfone 5Zを買ったのでEvolution Xを入れてみる"
description: "詰まったところがあったのでまとめる"
publishedAt: "2010-01-12"
draft: false
categories: [Android]
tags: ["Android", "カスタムROM"]
---


## 前置き  
Asus関連の項目が邪魔だったのでカスタムROMを使おう！というのが動機。  
なかなかブートロゴにお目にかかれなかったりブートロゴでスタックしたりとで自分的にかなり詰まったのでまとめます。  
この記事は公式アンロックなZenfone 5ZにOFFICIALなEvolution Xをインストールする人向けなので他のROMを焼くのであれば[こちら](https://forum.xda-developers.com/t/guide-noob-friendly-custom-rom-flashing-guide.3944849/)を参考にした方が絶対に良いです。  

 ⚠注意  
 この作業に取り掛かる前に必ずデータのバックアップを取ってください。  
 また、ここに書いてることを真似する場合は自己責任でお願いします。  
 この記事の内容を実践して生じた損害等の一切の責任を負いかねますので、ご了承ください。  
~~あなたの大切なスマホが文鎮になっても私は責任を取れません。~~  


## 前提条件  
- BootloaderがunlockされているZenfone5Z(この記事は公式アンロックな端末向けに書かれています。 )  
- fastbootコマンドが使用できる環境。  

## ダウンロードするもの  
- [EvolutionX_5.8_Z01R](https://sourceforge.net/projects/evolution-x/files/Z01R/EvolutionX_5.8_Z01R-11-20210612-0637-OFFICIAL.zip/download)  
- [evolution_Z01R-ota](https://sourceforge.net/projects/evolution-x/files/Z01R/evolution_Z01R-ota-rq3a.210905.001-09171152-unsigned.zip/download)  
- [q_vbmeta.img](https://forum.xda-developers.com/attachments/q_vbmeta-img.4961371/)
- [Encrypted Vendor](https://sourceforge.net/projects/custom-romeo/files/Evolution-X/vendor_20_3.img/download)
- [ABL.zip](https://www.mediafire.com/file/k551ecf62vdebfh/ABL.zip/file)  
- [dfe.zip](https://www.mediafire.com/file/xhm1kf0korurp69/dfe.zip/file)  
- [twrp-3.4.0-0-Z01RD.img](https://dl.twrp.me/Z01RD/twrp-3.4.0-0-Z01RD.img.html)  
- [twrp-installer-3.4.0-0-Z01RD.zip](https://dl.twrp.me/Z01RD/twrp-installer-3.4.0-0-Z01RD.zip.html)  

多分こんな感じになっていると思います。  
よく確認しておきましょう。  
{{<figure src="https://drive.google.com/uc?export=view&id=1aEBKbHMsxVQckCXh_oDsuqf3JiOIVmrH" >}}  

## 下準備  
電源+volume upでbootloaderを起動してPCと接続。  
そしてダウンロードしたフォルダのある場所でターミナルを開いて以下のコマンドを実行し、ユーザーデータを削除した後にvbmetaをflash。  
```cmd
$ fastboot -w
$ fastboot --disable-verity --disable-verification flash vbmeta q_vbmeta.img
```
コマンドの実行が完了したらここで1回画面の方にご注目！  
ACTIVE SLOTの項目を確認してください。  
```cmd
#アクティブなスロットがaなら
$ fastboot set_active b

#bの場合は
fastboot set_active a

#そしてbootloaderを再起動
$ fastboot reboot bootloader
```
ACTIVE SLOTが先ほどとは別のスロットに変更されているはずです。

## TWRPを焼く  
以下のコマンドを実行した後リカバリーモードに移行。  
```cmd
$ fastboot flash boot twrp-3.4.0-0-Z01RD.img
```
## ROMをflash  
リカバリーが起動したら、「Wipe」>「ADVANCED WIPE」と進んでsystem、Dalvik(Cache)、DataをWipeしてください。  
完了したら、
- EvolutionX_5.8_Z01R
- evolution_Z01R-ota
- Encrypted Vendor
- ABL.zip
- dfe.zip
- twrp-installer-3.4.0-0-Z01RD.zip  
を本体に転送してください。(Magiskを導入する場合は"Magisk.apk"を"Magisk.zip"にリネームして一緒に転送してください。)  
したらばROM焼きを開始しましょう。  

EvolutionX_5.8_Z01R > evolution_Z01R-ota > twrp-installer-3.4.0-0-Z01RD.zip  
の順番でflashしてリカバリーを再起動しましょう。  
自動的にアクティブなスロットに切り替わって起動します。  

無事リカバリーが起動したら最後の仕上げです。  
Encrypted Vendor > ABL.zip > dfe.zip  
の順番でファイルをflashしてください。
完了したらsystemを再起動、Evolution Xのロゴが表示された後セットアップ画面が出てくるはずです。  

## 最後に
Volteが不安定ですが全体的に動作も良好なので使いやすいですね。  