---
title: "Huawei P30 (ELE-L29) のsystem領域を拡張した話 その1"
description: "system領域が小さいので拡張してみる。"
date: 2021-10-17T17:31:45+09:00
draft: false
categories: [Android]
tags: ["Android", "カスタムROM"]
---

## 前置きと注意  
 [Huawei P30にlineageOS 18.1をインストールした話](/p/huawei-p30にlineageos-18.1をインストールした話/)の続きです。  
P30にGSIなカスタムROMをflashしようとしたところ  
system領域が小さい！と怒られて大敗北しました。  
今回はsystem領域の拡張に成功したのでメモ帳代わりにまとめることにしました。  

  
 ⚠注意  
 この作業に取り掛かる前に必ずデータのバックアップを取ってください。  
また、ここに書いてることを真似する場合は自己責任でお願いします。  
 この記事の内容を実践して生じた損害等の一切の責任を負いかねますので、ご了承ください。  
~~あなたの大切なスマホが文鎮になっても私は責任を取れません。~~  
また、この方法で拡張した場合はeRecoveryを使って純正ROMに戻す場合はパーティションを元に戻さないとエラーを吐くので注意してください。  

## 前提条件  
- BootloaderがunlockされているHuawei P30(自分はDC-Phoneix&HCUの時限ライセンスを購入して解除しました。 )  
- fastbootコマンドが使用できる環境  
- USB Type C to USB A 変換アダプタ  
- USBマウス  

P30はEMUI9.1にしておいてください。(EMUI10以降はfastbootコマンドが使えない&強制的にBootloaderにロックがかけられるため。)  
eRecoveryを使用すると強制的にEMUI10にされますが、HCUでアンロックした場合は、HisuiteでEMUI9.1に戻すとbootloaderがアンロックされた状態に戻るはずなので慌てないでください。  
(自分の場合はちゃんと戻りました)  

## 準備  
- [Mate20 XのTWRP](https://androidfilehost.com/?fid=11410963190603905658)
- P30のRecovery_ramdisk  
- [parted_gdisk_fdisk_mkfs-ext4-aarch64-zip](https://forum.xda-developers.com/attachments/parted_gdisk_fdisk_mkfs-ext4-aarch64-zip.4494670/)
- flashするROM(今回は[DotOS](https://droidontime.com/devices/arm64)を選択しました)  
- P30(~~当たり前ですね~~)  

## TWRPをflashする  
Mate20 XのTWRPイメージがあるディレクトリでターミナルを開いてください。  
開いたら
```cmd
$ fastboot flash recovery_ramdisk twrp-3.2.1-0-everest-unofficial-v3.img
```
と入力してTWRPをflashしましょう。  

## 下準備
再起動してTWRPを起動しましょう。(電源+Volume Up)  
タッチ操作は出来ないのでUSBマウスを接続して操作します。  
作業が長引くかもしれないのでスリープを無効にして画面の明るさを最低にしましょう。  


マウスの接続を解除してPCに接続してください。  
接続したら一度
```cmd
$ adb devices
```
と入力してちゃんと接続されているかを確認しましょう。  

接続が確認出来たらpartedとgdiskをP30にコピーしましょう。  
parted_gdisk_fdisk_mkfs.ext4-AARCH64.zipを展開してターミナルで開きましょう  
```cmd
$ adb push parted /
$ adb push gdisk /
```
コピーが終わったら端末のシェルを起動します。  
```cmd
$ adb shell
```
シェルを起動したらpartedとgdiskがコピーされているかを確認してください。  
```cmd
~ #  ls
acc                         　　 init                        patch_hw                      splash2
acct                        　   init.rc                     plat_file_contexts          storage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
file_contexts.bin           parted                      sec_storage
gdisk                           patch                       sepolicy
```
partedとgdiskがあることを確認したら実行権限を付与しましょう。  
```cmd
~ # chmod +x parted
~ # chmod +x gdisk
```  

## 拡張  
ここまで来たらあと一息！  
パーティションを操作しましょう。  
partedでsddを開きます。  
```cmd
/parted /dev/block/sdd
GNU Parted 3.2
Using /dev/block/sdd
Welcome to GNU Parted! Type 'help' to view a list of commands.
```
まずはパーティションテーブルを確認しましょう。  
```cmd
(parted) unit MiB
(parted) p
Error: The backup GPT table is corrupt, but the primary appears OK, so that will
be used.
OK/Cancel? ok
Model: HISI SS6100GBCV100MBD (scsi)
Disk /dev/block/sdd: 122000MiB
Sector size (logical/physical): 4096B/4096B
Partition Table: gpt
Disk Flags:

Number  Start    End        Size       File system  Name                 Flags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
62      2928MiB  3016MiB    88.0MiB                 cust_a               msftdata
63      3016MiB  5328MiB    2312MiB    ext4         system_a             msftdata
64      5328MiB  7480MiB    2152MiB                 product_a            msftdata
65      7480MiB  8056MiB    576MiB                  version_a            msftdata
66      8056MiB  9200MiB    1144MiB                 preload_a            msftdata
67      9200MiB  122000MiB  112800MiB  ext4         userdata             msftdata
```
確認ができたら適当なテキストファイルにコピペしておきましょう。  
メモを忘れた人用に自分のパーティションテーブルを貼っておきます。[Google Drive](https://drive.google.com/file/d/1udu6zJOhqdF3KGqjez9y3yI2fYaiY6Vx/view)  
今回はproduct_aとsystem_aを削除して新しくsystem_aを作成します。
この記事の場合は63,64ですね。  
注意  
ここで間違ったパーティションを削除してしまうと再起不可になってしまう可能性があるので必ず手作業でやるようにしましょう。  
コピペはしないようにね。    
```cmd
(parted) rm
Partition number? 63
(parted) rm
Partition number? 64
```
削除が終わったらgdiskに移動します。  
一度partedを閉じてから  
```cmd
~ # /gdisk /dev/block/sdd
GPT fdisk (gdisk) version 1.0.3

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.

Command (? for help):
```
ここからパーティションを追加します。  
この記事の場合は63ですね。  
```cmd
Command (? for help): n
Partition number (63-128, default 63): 63
First sector (34-1914879, default = 772096) or {+-}size{KMGTP}:
Last sector (772096-1914879, default = 1914879) or {+-}size{KMGTP}: +4464MiB
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): 0700
Changed type of partition to 'Microsoft basic data'

Command (? for help):
```  
作成したパーティションの名前を変更します。  
```cmd
Command (? for help): c
Partition number (1-67): 63
Enter name: system_a
```
作業が終わったら書き込みをする前に一度変更後のパーティションテーブルを確認しましょう。  
```cmd
Command (? for help): p
Disk /dev/block/sdd: 31232000 sectors, 119.1 GiB
Sector size (logical/physical): 4096/4096 bytes
Disk identifier (GUID): F9F21FFF-A8D4-5F0E-9746-594869AEC34E
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 5
First usable sector is 34, last usable sector is 31231999
Partitions will be aligned on 128-sector boundaries
Total free space is 94 sectors (376.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  62          749568          772095   88.0 MiB    0700  cust_a
  63          772096         1914879   4.4 GiB     0700  system_a
  65         1914880         2062335   576.0 MiB   0700  version_a
  66         2062336         2355199   1.1 GiB     0700  preload_a
  67         2355200        31231999   110.2 GiB   0700  userdata
```
確認して大丈夫だったらパーティション情報の書き込みをしましょう。  
```cmd
Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): Y
OK; writing new GUID partition table (GPT) to /dev/block/sdd.
Warning: The kernel is still using the old partition table.
The new table will be used at the next reboot or after you
run partprobe(8) or kpartx(8)
The operation has completed successfully.
```
書き込みが終わったらgdiskを閉じてpartedを開いてください。  
```cmd
~ # /parted /dev/block/sdd
GNU Parted 3.2
Using /dev/block/sdd
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted)
```

Flagの設定
```cmd
(parted) set 63
Flag to Invert? msftdata
New state?  on/[off]? on
```

ext4にフォーマット
```cmd
~ # make_ext4fs /dev/block/sdd63
Creating filesystem with parameters:
    Size: 3472883712
    Block size: 4096
    Blocks per group: 32768
    Inodes per group: 8160
    Inode size: 256
    Journal blocks: 13248
    Label:
    Blocks: 847872
    Block groups: 26
    Reserved block group size: 207
Created filesystem with 11/212160 inodes and 28026/847872 blocks
```

変更がちゃんとできているかの確認
```cmd
~ # /parted /dev/block/sdd
GNU Parted 3.2
Using /dev/block/sdd
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: HISI SS6100GBCV100MBD (scsi)
Disk /dev/block/sdd: 128GB
Sector size (logical/physical): 4096B/4096B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name                 Flags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
62      3070MB  3163MB  92.3MB               cust_a               msftdata
63      3163MB  7843MB  4681MB  ext4         system_a             msftdata
65      7843MB  8447MB  604MB                version_a            msftdata
66      8447MB  9647MB  1200MB               preload_a            msftdata
67      9647MB  128GB   118GB                userdata             msftdata
```
これで拡張作業はおしまい。  

## ROMをflashしよう  
これでようやく好きなROMが焼けるはず...。  
```cmd
fastboot --disable-verity --disable-verification flash system dotOS-R-v5.2-arm64-ab-GAPPS-OFFICIAL.img
Sending sparse 'system' 1/8 (458752 KB)            OKAY [  3.193s]
Writing 'system'                                   OKAY [  1.051s]
Sending sparse 'system' 2/8 (458752 KB)            OKAY [  9.784s]
Writing 'system'                                   OKAY [  1.050s]
Sending sparse 'system' 3/8 (458752 KB)            OKAY [  9.894s]
Writing 'system'                                   OKAY [  1.051s]
Sending sparse 'system' 4/8 (458752 KB)            OKAY [  9.541s]
Writing 'system'                                   OKAY [  1.789s]
Sending sparse 'system' 5/8 (458752 KB)            OKAY [  9.920s]
Writing 'system'                                   OKAY [  4.190s]
Sending sparse 'system' 6/8 (458752 KB)            OKAY [  9.487s]
Writing 'system'                                   OKAY [  4.602s]
Sending sparse 'system' 7/8 (458752 KB)            OKAY [  9.500s]
Writing 'system'                                   OKAY [  1.034s]
Sending sparse 'system' 8/8 (233220 KB)            OKAY [  4.879s]
Writing 'system'                                   OKAY [  0.807s]
Finished. Total time: 81.857s
```
わーい。
この後初期化するので一度stock recoveryに戻してください。  
```cmd
fastboot flash recovery_ramdisk recovery_ramdiS.img
Sending 'recovery_ramdisk' (32768 KB)              OKAY [  0.232s]
Writing 'recovery_ramdisk'                         OKAY [  0.077s]
Finished. Total time: 0.341s
```
リカバリーを起動してファクトリーリセットをしたらいよいよ起動！  

## いよいよ起動  
まぁ普通に起動するはずです。  
{{< tweet 1449644900442464258 >}}  
後はmagiskを入れるなりなんなりで自由にやっちゃってください！  
~~USB接続してもWindowsが認識できない不具合(?)はこちらでも残ってました~~


## 参考にした記事  
- [Android端末にカスタムROMを焼くにシステム領域が足りないためパーティションを拡張する](https://ysss.hateblo.jp/entry/20200425/1587793352#parted%E3%81%A8gdisk%E3%81%AE%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89)
- [Android: how to increase system partition and decrease data partition?](https://android.stackexchange.com/questions/216123/android-how-to-increase-system-partition-and-decrease-data-partition)