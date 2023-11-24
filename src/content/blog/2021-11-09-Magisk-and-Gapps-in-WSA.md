---
title: "MagiskとGappsを入りのWSA(Windows Subsystem for Android)をインストールする話"
summary: "MagiskとGappsを入りのWSA(Windows Subsystem for Android)をインストールする話"
description: "米国リージョン以外でも可"
publishedAt: "2021-11-09"
draft: false
categories: [Android,Windows11]
tags: ["Android","Windows","Magisk","WSA"]
---

##前置きと注意と筆者の環境  
Win11の発表時からWSAを楽しみにしていたのにお預けをくらって待ちきれなかったのでネットサーフィンをしていたら、  
なんか凄そうなのを発見したので実行してみました。  

⚠注意  ここに書いてることを真似する場合は自己責任でお願いします。  
この記事の内容を実践して生じた損害等の一切の責任を負いかねますので、ご了承ください。  
~~無いとは思うけど~~万が一Windowsが吹っ飛んだ時のために  
不安ならバックアップを取っておこうね。  
また、Hyper-Vを有効にするためMemuやBS5 32bit等々のエミュレーターが動作しなくなります、ご注意を。 

- 筆者の環境  
CPU: Ryzen5 3600  
GPU: GTX1060 6GB  
RAM: DDR4 4GB×2  16GB×1
OS: Windows 11 Pro 21H2 22000.282


## 必要なもの  
Windows11  
Githubのアカウント  
仮想化支援機能に対応したCPU  

- あると嬉しい  
ADBが使用できる環境

(試していないので真偽は不明ですがプレビュービルドでなくてもできるそうです。~~誰か人柱になって~~)  

## 下準備  
- Windowsの機能の有効化または無効化からHyper-V、Windows ハイパーバイザー プラットフォーム、仮想マシンプラットフォームを有効にして再起動する。  
これ↓  
{{<figure src="https://drive.google.com/uc?export=view&id=1ETXjwPUrAkITQ9hLIXr0fYfsn-nATdub" >}}
- Biosの設定から仮想化支援機能を有効にする。(マザーボードのメーカーによってBiosの入り方等々が異なるので割愛)  

## 必要なファイルの用意  
[MagiskOnWSA](https://github.com/LSPosed/MagiskOnWSA)のリポジトリをForkしてActionsを開きましょう。  
Workflowsの中にあるMagiskの項目を選択して
{{<figure src="https://drive.google.com/uc?export=view&id=119rTrJS3EwmLtn6xsVPLoUL6I1byzvS3" >}}  
Run workflowを開いてRun workflowのボタンを押します。  
{{<figure src="https://drive.google.com/uc?export=view&id=1GWceZHZRIWWTNP9j0KDKQ3LrkV9Z63w_" >}}  
(この時にGappsの種類を選べるのでnoneのところを入れたいGappsの種類に書き換えてあげましょう)  
自分でやるのが面倒！って人はGapps nanoが入ったものをビルドしているので[私がForkしたリポジトリ](https://github.com/j7b3y/MagiskOnWSA/actions/workflows/magisk.yml)からDLしてください。  

ビルドが終わったらWorkflowを開いてArtifactsの一覧にあるWSA-with-Magisk-GApps-〇〇_x64をDLしましょう。  
{{<figure src="https://drive.google.com/uc?export=view&id=1Yknyh8kmzSiKTsQkc4osoqZkllgd04-O" >}}  

## WSAをインストール  
DLが終わったら自分の好きな場所に展開してください。 
展開している間にWindows設定から開発者モードを有効にしてあげましょう。  
プライバシーとセキュリティ > 開発者向け と開いて一番上にある  
"圧縮されていないファイルも含め、任意のソースからのアプリをインストールします。"  
のスイッチをオンにしましょう。  
展開が終わったら展開したフォルダーを開いて中にあるInstall.ps1をshift+右クリックからのpowershellで開くを選択。  
{{<figure src="https://drive.google.com/uc?export=view&id=1HrvPLuTpF0SkzFVSa1x9W9eYmsOqaCZB" >}}   
インストールが開始します。  

## 5.いざ起動  
スタートメニューの検索に"アプリ: android"と入力すると  
Windows Subsystem for Androidが出てくるので実行するとこんなメニューが出てきます。  
{{<figure src="https://drive.google.com/uc?export=view&id=1ompHWjdTc9_fRigsjtVDoQW2ac4gBRMl" >}}
Developer modeをOnにしてからManage developer settingsをクリックしてWSAを起動してみましょう。  
"2.下準備"でちゃんと機能が有効になっているなら起動するはずです。  
有効にしたのに*Unable to start Windows Subsystem for Android.*と言われる！って人は  
"7.Unable to start Windows Subsystem for Androidと言われて動かない！"を見てみてください。  

## Magisk Managerをインストール  
- adbを使用する場合  
ターミナルで以下を実行
```cmd
adb connect localhost:58526
adb install magisk.apk
```

- adbを使用しない場合  
スタートメニューで"アプリ: play ストア"と検索してplayストアを開いてGoogleアカウントにログイン、  
適当なブラウザをダウンロードして[ここ](https://github.com/topjohnwu/Magisk)からMagisk Canaryのapkをダウンロードしてインストールしてください。  

## Unable to start Windows Subsystem for Androidと言われて動かない！  
ちゃんと設定したのに動かない！って人向けです。
自分もここで一回詰まりました。    
管理者として実行されたターミナルで以下を実行。  
```cmd
bcdedit /set hypervisorlaunchtype auto
```
そして再起動。  
多分起動するはずです。  
これで起動しないのなら他に何か原因があるのかもしれないです。  

## 後書き  
動作は良好で結構いい感じだったのですが思ったよりメモリを食うので飽きたらBS5に戻るのかな～って感じです。  
生のAndroidが動くってのはロマンがあるのですが逆にそれ以外は何もないな～と思いました。  
Hyper-Vを有効にしたのでBS5 32bitやMemuが動作しなくなるのもかなり痛いし多分今後は使わないかな～というのが自分の結論です。  

~~スクショ供養のコーナー~~
{{<tweet 1457247747153666049>}}
{{<tweet 1457248305482592259>}}
{{<tweet 1457206889020723201>}}  

## 参考にした記事
多分こっちを翻訳したほうが分かりやすいと思います。  
- [MagiskOnWSA](https://github.com/LSPosed/MagiskOnWSA)
