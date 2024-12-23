---
title: "PC用アバターをQuest GoodにしてFallback Avatarにする"
summary: "PC用アバターをQuest GoodにしてFallback Avatarにする"
description: "途中で疲れた"
publishedAt: "2022-07-06"
draft: false
categories: ["Unity","Blender"]
tags: ["Unity", "VRChat","Blender"]
---

## 前置き
別のアバターをFallback対応したくなった時用に自分向けに書き殴ったメモ書きです。

## この記事を読むにあたって  
- Blenderの操作がある程度わかる人向けです。  
- 怪文書の解読に自身がある人以外は読まないほうがいいです。参考文献の方を読んだ方がいいです絶対。  

## 環境  
OS |Windows10
-|-  
Blenderのバージョン |2.93.9 
## 流れをざっくり
> - アドオンの準備  
> - アバターをインポート  
> - テクスチャの割り当て  
> - マテリアルを結合  
> - ポリゴンを減らす  
> - メッシュ結合  
> - FBXとしてエクスポート   

## アドオンの準備  
- [cats blender plugin](https://github.com/absolute-quantum/cats-blender-plugin)
- [material-combiner-addon](https://github.com/Grim-es/material-combiner-addon)  
(入れ方は)ググろうね！  

## アバターをインポート  
上のメニューからインポート>FBX(.fbx)  
ボーンの向きがおかしい場合は右の設定のアーマーチュアからボーンの自動整列をオンにしましょう。  
自分はこれで解決しました(シャオン、幽狐族のお姉様で確認)  
ボーンの向きをしっかり確認しないと後々指先が曲がる等の問題が発生する可能性があるので必ず確認しましょう。  
{{<figure src="https://drive.google.com/uc?export=view&id=1PSjvGOD0FdOpxcvrvkaiCpQs3tGI3WCi" >}}  

## テクスチャを割り当て  
ここはアバターによって違うので各自で頑張ってください。  
貼り終わったら一旦名前をつけて作業状況を保存しましょう。  
画像テクスチャで割り当てるとマテリアルの結合後に単色になることがあります。  
そうなる場合はMMD Textureの方から割り当ててあげましょう。  
  
## マテリアルを結合  
ここからは自分のキメラアバターを例に書きます。  
CATSプラグインのタブから  
最適化>アトラス>Generate Material Listでマテリアルリストを表示。  
全てのチェックボックスにチェックを入れたらSave Atlas to...でマテリアルを結合。  
保存するディレクトリを聞かれるので指定したら~~自分の環境だと12000*12000強のバケモンが生成された〜〜~~  
Atras_<ランダムな6桁の数字>.pngでテクスチャが保存されます。  

## ポリゴンを減らす  
ポリゴンを減らす前に現在のポリゴン数と目標ポリゴン数を把握しましょう。  
今回はQuest Goodにしたいので10000以下にします。  
  
顔や髪はよく見られるのでそちらを優先に他の部分を削っていくつもりでやりましょう。  
特に素体は服で見えない部分も多いのでかなり大胆にいきます。  
まずは素体の隠れる部位を編集モードで削除します。  
素体を選択したままTABキーで編集モードに切り替えます。  
切り替わったら服で隠れる部分を選択してXキー>頂点で頂点を削除していきます。  
自分は胸~足首の範囲を削除しました。  
{{<figure src="https://drive.google.com/uc?export=view&id=151xMKLYSAP-XM-kMtX9JPlQ1VX1Ic32l" >}}  

さて、シェイプキーを壊さないまま顔のポリゴンを減らしたいのですがCATSはメッシュ単位でのデシメートができないので  
顔とそれ以外でアーマーチュアを分けます。  
アーマーチュアを複製して顔とそれ以外のアーマーチュアを作りましょう。(アーマーチュアを階層ごと選択してShift+Dで複製)  
おけ  
{{<figure src="https://drive.google.com/uc?export=view&id=1uesNSURdxNIIZHN1vUQO6JY8hCNAbkjq" >}}  

複製が終わったらCATSのメニューから顔だけのアーマーチュアを選択して  
デシメーション>スマートを選択。  
トリスに先ほど設定したポリゴンの目標値を入力してQuick Decimation。  
顔がボコボコになります。  
ある程度はシェーダーを適応したら誤魔化せるので自分の心とポリゴン数と相談しながら妥協してください。  
{{<figure src="https://drive.google.com/uc?export=view&id=1UizrZX_uNvFe75RocS_h1bS4tDjFym4u" >}}  
 

他の部位はBlender標準のデシメートを使って削ります。(こっちの方が楽だから)  
メッシュを選択したらモディファイアーからデシメートを選択して比率をいじっていい感じに調整しましょう(細かい手順は割愛)  

## メッシュの結合  
CATSのメニューからカスタムモデルの作成>アーマーチュアをマージを以下の画像の設定で実行。  
{{<figure src="https://drive.google.com/uc?export=view&id=1ZxfHPoxIMYhTgFs-WkND8CHBfI0_JdKh" >}}  


## FBXとしてエクスポート  
CATSのメニューからできます。  
各自の環境に合わせて詳細設定を触ってみましょう。   

## 後書き  
これらの作業でこんな感じになりました。  

　|調整前|調整後
:-:|:-:|:-:
全体|47708|7283  

{{<figure src="https://drive.google.com/uc?export=view&id=1YG4aB1WgM9UrWVg0vobAnkNpa_V1I3-e" >}}  


失ったもの  
- 下着類  

胸のサイズが調整できるようなアバターは素体も顔同様に分割してCATSで個別にデシメーションしましょう。  
マテリアルの設定やアップロード等は割愛します。~~面倒になったので~~  
ボーンが多すぎる場合は必要のないボーンを適切に削除しましょう。  

## おまけ  
Questアバターでは頬染め等の元々透過を使用していたものは使用できません。
そこで透過素材を合成したテクスチャとマテリアルを用意してアニメーションを活用することで擬似的に透過を使用した表情を使うようにします。  
詳しくは以下に参考文献を貼るのでそちらをご覧ください(丸投げ)  


## 参考文献  
- [PC向けアバター 5000ポリまでダイエット - Quest Excellent を目指す本](https://github.com/mew-ton/teckbook_convert_lowpoly)  
- [PC向けアバター(50,000ポリ超)をポリゴン削減してFallback対応したメモ](https://zenn.dev/tsumujiwind/articles/d56c4736388d9e)  

なんならこの二つ読んだ方がわかりやすいし為になる。いやガチで  
