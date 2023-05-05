---
title: "Huawei P30にlineageOS 18.1をインストールした話"
description: "EMUIに愛想が尽きたのでHuawei端末で脱Huaweiを試みる。"
date: 2021-10-11T10:12:31+09:00
draft: false
categories: [Android]
tags: ["Android", "カスタムROM"]
---

## 前置き  
再起動する度に画面の明るさ自動調整が勝手にONになるのが地味に面倒だなと感じたので、別にEMUIを使う理由もないということでカスタムROMを焼こうとなりました。  

⚠注意  
この作業に取り掛かる前に必ずデータのバックアップを取ってください。  
ここに書いていることを真似する場合は自己責任でお願いします。  
この記事の内容を実践して生じた損害等の一切の責任を負いかねますので、ご了承ください。  
~~あなたの大切なスマホが文鎮になっても私は責任を取れません。~~  


## 前提条件  
- BootloaderがunlockされているHuawei P30(自分はDC-Unlockerのライセンスを購入して解除しました。 )  
- fastbootコマンドが使用できる環境。  

P30はEMUI9.1にしておいてください。(EMUI10以降はfastbootコマンドが使えなくされているためです。~~ふざけんな~~)  

## romの選択とダウンロード  
今回使用するromを選びましょう。  
私は[LineageOS 18.1](https://sourceforge.net/projects/andyyan-gsi/files/lineage-18.x/lineage-18.1-20211010-UNOFFICIAL-treble_arm64_bvS.img.xz/download)にしました。  
~~本当はOctaviOSを使用したかったのですが自分の環境ではflash出来なかったので断念しました。~~  
~~P30のsystemパーティションよりOctaviOSのイメージの方が大きかったのでsystem領域を拡張しようと思ったのですが~~  
~~delete-logical-partitionを実行しようとしても~~  
``` cmd
$ fastboot delete-logical-partition product
Deleting 'product'                                 FAILED (remote: 'Command not allowed')
fastboot: error: Command failed
```

~~とエラーを吐いてしまい素人な自分ではどうにもならなかったからです。たすけて~~  
~~自分だけなのか他の人もこうなってるのかはわからないですが、~~  
~~そもそもの話P30をBLUしている人が少数なので全く情報が無かったです。~~  

system領域の拡張が上手く行ったので近いうちに[まとめました](/p/huawei-p30-ele-l29-のsystem領域を拡張した話-その1/)。  
追記  
そもそもfastbootdに対応していなかったってオチでした。  
~~ちゃんと文章は読もうねというお話~~  
{{< tweet 1449012464603975681 >}}  

system領域は2.25GBくらいでした。
{{< tweet 1449017523542708230 >}}  
  
flashするROMの候補としては
- [CAOS11](https://sourceforge.net/projects/treblerom/files/CAOS11/2021.10.10/caos-v313%2B211010-arm64-bvZ.img.xz/download)  
- [LineageOS 18.1](https://sourceforge.net/projects/andyyan-gsi/files/lineage-18.x/lineage-18.1-20211010-UNOFFICIAL-treble_arm64_bvS.img.xz/download)  
- [AOSP 11.0 v313](https://github.com/phhusson/treble_experimentations/releases/tag/v313)(system-roar-arm64-ab-vndklite-vanilla.img or system-roar-arm64-ab-vanilla.img)

ここ辺りでしょうか。


## romをflashする  
ダウンロードしたファイルが圧縮されていた場合は展開しておいてください。  
イメージファイルのディレクトリでターミナルを開いて
```cmd
$ fastboot --disable-verity --disable-verification flash system (file_name).img
```
と実行してください。  
flashが完了したらファクトリーリセットをしましょう。  
ケーブルを抜いてからVolume+と電源を長押しして起動、  
Huaweiロゴが表示されたらボタンを離してください。  
リカバリーが起動します。  

## 実際に使ってみる  

数十分使ってみましたが動作はすごく良かったです。  
EMUIよりも軽量で使いやすかったです。  
しかしながら~~1つ~~2つだけ大きな欠点がありました。  
LineageOSが画面内指紋認証に対応していないようで  
頑張って指紋を登録してもロック画面で使うことができないみたいです...。  
背面か物理ボタンにセンサーが搭載されているタイプしか使えないみたいです。  
顔認証も使用出来ないようなので流石に厳しいってことで画面内指紋認証を採用している機種ではカスタムromは厳しいのかもしれないです。  
もう1つは端末や環境との相性問題かもしれませんが  
windowsとP30を接続しても認識されない問題が発生しました。  

{{< tweet 1447494835682758656 >}}

流石に~~面倒になったので~~これは厳しいってことで一回休むことにしました😩。  
Mate 20 XのTWRPがP30でも動作したので(唐突)  
時間があればこれを使ってsystem領域の拡張に挑戦しようかなと思っています。  


Lineageを入れた際にスクリーンショットをいくつか撮影しておいたので供養しておきます。  

- home  
{{<figure src="https://drive.google.com/uc?export=view&id=1wls2coc_ArmllhfwA-0PSsn9ADeOHO4P"width="190" >}}   
- 設定  
{{<figure src="https://drive.google.com/uc?export=view&id=1t61yJjeKylKHBeWoRgyjYdd3E3GGhakd"width="190" >}}  
- 本体情報  
{{<figure src="https://drive.google.com/uc?export=view&id=1qYD-m8IhYqftt79Om1BQYI_fGkfS0HGn"width="190" >}}  
{{<figure src="https://drive.google.com/uc?export=view&id=1Hc5M8Pzbowu-rtionu8BuymzUvqWTVXH"width="190" >}}  
- ステータスバー
{{<figure src="https://drive.google.com/uc?export=view&id=1FjJREiZYrCyqeq8I46OyTcpehDEqAJ1i"width="190" >}}  

## 参考にした記事  
- [Generic System Image  |  Android オープンソース プロジェクト](https://source.android.com/setup/build/gsi?hl=ja#flashing-gsis)  
- [LOSQ/LiR - LineageOS 17.1/18.1-UNOFFICIAL-GSI](https://forum.xda-developers.com/t/losq-lir-lineageos-17-1-18-1-unofficial-gsi.4219291/)  
