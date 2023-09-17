---
title: "在Flutter2.0中使用高德地图"
summary: "在Flutter2.0中使用高德地图"
publishedAt: "2021-03-17"
draft: false
---

## 前言
在学习过程中需要用到地图组件，但是迫于国内环境，无法使用封装好的Google地图，只能使用国内目前有的百度和高德。因为老项目用的是高德，所以这边踩高德的坑。

## 文档地址
[官方文档](https://developer.amap.com/api/flutter/gettingstarted)

## 开始使用
### 申请Key
首先是申请高德的Key，这一步比较简单，跟着官方文档走一般没有问题。

### 配置SDK
因为flutter插件默认不带地图SDK，我们需要通过原生的方式来引入SDK，官方也是通过Android的文档来告诉我们怎么做的，可能有些小伙伴第一次接触有点看不懂，我这里也写一下方便自己记忆。
* 根据[文档](https://developer.amap.com/api/android-sdk/guide/create-project/android-studio-create-project)我们跳转到这个页面。有`拷贝添加`和`Gradle继承`两种方法，这边我们为了方便使用`Gradle`
* 正常情况下仓库地址已经配置好了，所以配置仓库可以跳过
* 之后在项目下的`android/app/build.gradle`文件中找到`dependencies`添加以下几行
```
dependencies {
    //...
    compile fileTree(dir: 'libs', include: ['*.jar'])
    //3D地图so及jar
    compile 'com.amap.api:3dmap:latest.integration'
    //定位功能
    compile 'com.amap.api:location:latest.integration'
    //...
}
```
* 到这配置SDK这一步就完成了
* 不过还是有可能会出现网络异常的情况，没找到其他解决方案，只能多试试或者代理

### 集成Flutter插件
* 在flutter项目中引入`amap_flutter_map: ^1.0.0`(版本号可不填，默认最新)
* 编写widget
```dart
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  static const AMapApiKey amapApiKeys =
      AMapApiKey(androidKey: '填入你申请的key');

  AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String mapContentApprovalNumber =
        await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String satelliteImageApprovalNumber =
        await _mapController?.getSatelliteImageApprovalNumber();
    print("$mapContentApprovalNumber and $satelliteImageApprovalNumber");
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      apiKey: amapApiKeys,
      onMapCreated: onMapCreated,
      initialCameraPosition:
          CameraPosition(target: LatLng(39.83309, 116.290176), zoom: 15),
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );
  }
}
```
* 之后调用`MyMap`这个widget就可以成功引入地图啦

### Markers
生成点标记和印象里Web端的操作不同，这边需要提前在地图上定义好一个Marker的集合
```dart
// 提前定义
final Map<String, Marker> _initMarkerMap = <String, Marker>{};

final AMapWidget map = AMapWidget(
  apiKey: amapApiKeys,
  onMapCreated: onMapCreated,
  // 使用
  markers: Set<Marker>.of(_initMarkerMap.values),
  initialCameraPosition:
      CameraPosition(target: LatLng(28.000575, 120.672111), zoom: 15),
);
```
后续的增删改Marker通过`setState`来实现
```dart
void createMarkers(LatLng target) {
  // 创建marker时没法携带id
  // 创建后会自动携带一个随机生成的id
  final Marker marker = Marker(
      position: target);

  setState(() {
    // 通过id来判断是新marker还是旧marker
    _initMarkerMap[marker.id] = marker;
  });
}
```
不过大部分情况下我们需要修改marker的位置，所以我们会重新生成一个`Marker`，但是此时marker的id会重新生成，建议各位在初始化各个点位前，自己赋值在`_initMarkerMap`中
```dart
void createMarkers(LatLng target) {
  final Marker marker = Marker(
      position: target);

  setState(() {
    // 自己赋值一个000的id
    // 后续修改这个marker，只需要找到000就可以了
    _initMarkerMap["000"] = marker;
  });
}
```

### 小结
* 通过`Gradle`的方式来引入SDK可能会因为网络问题导致打包慢，可以耐心等等，只要没报错，应该是正常在跑的，实在觉得慢可以通过拷贝的方式。
* 如果没引入sdk，在运行的时候项目会直接奔溃停止，之前没引入被整了半天看不懂
* 官方的demo写得是真的乱，什么东西都往上面放
