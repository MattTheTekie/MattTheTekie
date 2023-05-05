---
title: "ダンスする時のシャオンちゃんを表情豊かにしてみた。"
description: "MMD用に名前を変えたシェイプキーを設定した"
date: 2022-02-25T19:46:05+09:00
draft: false
categories: [Unity]
tags: ["Unity","VRChat",]
image: "site/thumbnail/2022-02-25-shaon-shapekey/600x200.webp"
---

## 前置き  
シャオンちゃんを魔改造している際のテストで某ダンスワールドで踊ってもらってたのですか  
デフォルトの表情のままなのが勿体ないな～と感じたので頑張りました。

注意
- Unityでシャオンちゃんを読み込める環境を作っていること  
- VRChatにシャオンちゃんをアップロード出来る条件を満たしていること  
を前提に書いています。

環境
- Unity 2019.4.31f1  
- VRCSDK3  
- [Shaon_v1.10](https://kutsushita03.booth.pm/items/2048231)


## ダウンロードするもの 
[VRCDeveloperTool](https://gatosyocora.booth.pm/items/1016739)
がとーしょこらさんが作ったツールです。感謝して使いましょう。  

## ダミーのメッシュを削除する  
VRCDeveloperToolをインポートしたら上のメニューから  
VRCDeveloperTool > メッシュ > Shapekey Deleterを選択して開きます。  
{{<figure src="https://drive.google.com/uc?export=view&id=1LXRVKKOBmqOzzjCzSNXnal6mYlFzgY0n" >}}    

Shapekey Deleterを開いたらSkinnedMeshRendererにBodyを入れて  
dummyが1つになるようにチェックを入れて削除しましょう。  
{{<figure src="https://drive.google.com/uc?export=view&id=1IWa_-Vs7mckNigcDpA41zZmcvETAdmK3" >}}    

## MMD用に名前を変更したキーを作る  
dummyを削除したらVRCDeveloperTool > メッシュ > ShapekeyName Changerを開いて  
RendererにBodyを指定します。 
  
以下のサイトを見ながらシャオンちゃんのBlendShapesをいじりつつ  
リネームしたいシェイプキーの右にあるテキストボックスにMMD用のシェイプキーを入力していきましょう。  
- [MMDモーフ一覧（TDAミク基準）](https://docs.google.com/spreadsheets/d/1DnkY4-nKIOJzpk1CPynX5_3_fznUQ-XdpVZm9mmt68o/edit#gid=0)  
- [MMD表情モーフ一覧](https://mmd15gyuunyuu.blog.jp/archives/11193436.html)  

変更を適応する際にはDuplication Shapekeysにチェックを入れてからChange ShapekeyNameを押すことをお勧めします。  
Duplication Shapekeysにチェックを入れることで既存のシェイプキーを残したままMMD用にリネームしたシェイプキーを作ることができます。  
{{<figure src="https://drive.google.com/uc?export=view&id=1_a1Yd4G2EwT55pqJKa88QPotcjUv-7bd" >}}    

## FXレイヤーにある全てのアニメーションのWrite Defaultをオンにする。  
アバターのFXレイヤーに"vrc_AvatarV3HandsLayer2_Shaon_standard"を指定した後アニメーターで開いて、  
"ResetFace","Left Hand","Right Hand"の中にある全てのアニメーションのWrite Defaultにチェックを入れてください。  
{{<figure src="https://drive.google.com/uc?export=view&id=15my_fXSQOSgm5STWpvE7ApnoqrQgyOIc" >}}    
入れ終わったらアップロードして確認してみよう！  

## ちゃんと設定できてたらこうなってるはず  
シェイプキーを設定する前は張り付いた笑顔で踊っていたシャオンちゃんが..?  
{{<figure src="https://drive.google.com/uc?export=view&id=1oaF0BiGTXHsseFnXsuXECymvfTRrdMaM" >}}    
表情豊かになった！
{{<figure src="https://drive.google.com/uc?export=view&id=1coNaFwM-00Qnv33hb1rnB6MneFE7fRax" >}}    

## 参考にした記事  
- [VRChatのMMDダンスワールドで可愛く踊らせる方法](https://note.com/yosidanue/n/n246547256460)  
- [mmd월드 쉐이프키 작동조건 정리](https://gall.dcinside.com/mgallery/board/view/?id=vr&no=1246548)　　
