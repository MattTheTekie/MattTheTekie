---
title: "Xperia ZR用のLineage 18.1をビルドした"
summary: "Xperia ZR用のLineage 18.1をビルドした"
description: "Xperia ZR用のLineage 18.1をビルドした"
publishedAt: "2010-01-12"
draft: false
categories: [Android]
tags: ["Android", "カスタムROM"]
---


## 前置きと注意  
実機を持ってないので動作確認してません。  
Xperia ZR用のLineageOS 18.1です。  
※こちらのromはXperia ZR用なのでSO-04eでは使用出来ません。  

## リンク  
[Lineage-18.1-dogo](https://drive.google.com/drive/folders/1xH97o3F_hUxgZ1yeYg2i8MXCNS0c63XN)

## manifests
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project name="fusion3-common/android_device_sony_dogo" path="device/sony/dogo" remote="github" revision="lineage-17.1"/>
    <project name="sony-fusion3-dev/android_device_sony_fusion3-common"  path="device/sony/fusion3-common" remote="github" revision="lineage-18.1"/>
    <project name="sony-fusion3-dev/android_kernel_sony_apq8064" path="kernel/sony/apq8064" remote="github" revision="lineage-18.1"/>
    <project name="LineageOS/android_device_sony_common"  path="device/sony/common" remote="github"/>
    <project name="LineageOS/android_hardware_sony_DASH" path="hardware/sony/DASH" remote="github"/>
    <project name="LineageOS/android_hardware_sony_thermanager" path="hardware/sony/thermanager" remote="github"/>
    <project name="sony-fusion3-dev/proprietary_vendor_sony" path="vendor/sony" remote="github" revision="lineage-18.1"/>
</manifest>
```