---
title: "第二次尝试Flutter"
date: 2021-03-11T13:53:48+08:00
draft: false
---

## 前言
学了几天flutter，感觉写起来还是很香的，比原生开发速度快很多，不过以前没接触过安卓开发，思维还在Web开发上，记录一下

## 布局
一般是使用`Column`和`Row`以及`Container`来布局比较多，还有`Expanded`，类似与`flex: 1`这个效果，能把剩余的空间补充满。

在使用的时候还遇到了按钮宽度需要100%的情况，2.0废弃了1.0一些组件，按钮一般使用`ElevatedButton`，但是没法设置宽高。网上查了一下用`SizedBox`来当它的父容器，这样它就会跟着父容器的宽高走了，需要宽度100%的话就是`double.infinity`

## 如何设置width:100%
目前发现有`double.infinity`和`MediaQuery.of(context).size.width`。后续发现的话继续补充

## 路由
路由的话一般定义在`MaterialApp`里面，如下：
```dart
return MaterialApp(
    title: 'title',
    initialRoute: "/home", // 默认的路由
    routes: {
        "/home": (context) => MyHome(), // 每个路由需要默认传参context
        "/login": (context) => MyLogin()
    },
);
```
导航的话常用以下几个
```dart
Navigator.pushNamed(context, "/login"); // 跳转到/login页面
Navigator.pop(context); // 返回上一级，可传第二个参数携带回上一级
Navigator.pushReplacementNamed(context, "/login"); //重定向至/login页面，就没法返回到上一级页面了
```

## 父子组件传参
* 父组件调用子组件
```dart
// 定义一个全局key
GlobalKey<_MyMapState> mapKey = GlobalKey();

// 子组件
class MyMap extends StatefulWidget {
  MyMap({Key key}) : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}
class _MyMapState extends State<MyMap> {
    // ...
    void getItem() {
        print('get');
    }
}

// 父组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
            TextButton(
                child: Text('Click'),
                onPressed: () {
                    // 调用子组件方法
                    mapKey.currentState.getItem();
                }
            ),
            // 在引入子组件时，传入全局key
            MyMap(key: mapKey)
        ]
    );
  }
}
```
* 子组件调用父组件
```dart
// 子组件
// 父组件通过传参传入方法，子组件调用
class MyMap extends StatefulWidget {
  final changeParent;
  MyMap({Key key, this.changeParent}) : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}
class _MyMapState extends State<MyMap> {
    // ...
    void getItem() {
        // 调用父组件
        widget.changeParent();
    }
}
```

## 滚动监听
在Flutter中使用滚动监听，首先在定义一个`ScrollController`以及监听
```dart
ScrollController _controller = new ScrollController();

@override
void initState() {
super.initState();
    // 在init生命周期中
    // controller添加监听
    _controller.addListener(_listenController);
}

@override
void dispose() {
    // 在dispose生命周期中销毁controller
    _controller.dispose();
    super.dispose();
}

// 监听方法
void _listenController() {
    // 获取当前滚动组件的最大高度
    final maxHeight = _controller.position.maxScrollExtent;
    // 当前滚动的高度
    final nowScrollPosition = _controller.offset;
    // 根据需要进行判断
    // 此处计算百分比超过95，则加载下一页内容
    if ((nowScrollPosition / maxHeight) * 100 >= 95) {
      pageNum += 1;
      _fetchImages();
    }
}
```
之后将`Controller`传给`ListView`，记住`ListView`嵌套在`Scrollbar`中
```dart
return Scrollbar(
    child: ListView.builder(
        padding: EdgeInsets.all(16),
        // 加入controller
        controller: _controller,
        itemExtent: 230,
        itemCount: _images.length,
        itemBuilder: (context, index) {
            final item = _images[index];
            final id = item["id"];
            final author = item['author'];
            final url = "https://picsum.photos/id/$id/200/200";

            return Container(
            width: 300,
            height: 230,
            child: Column(
                children: [
                Image.network(
                    url,
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                ),
                Text(author)
                ],
            ),
            );
        }));
```

## 文本
输入框的话是通过`TextField`这个Widget来的
```dart
return TextField(
    onChanged: (text) {
        // 获取每次更改的值
        print(text);
    },
    decoration: InputDecoration(), // 修改输入框样式
);
```
如果我们需要清空文本框，可能就要用到controller
```dart
final _controller = TextEditingController();

// 清空输入框
void _clearTextField() {
    _controller.clear();
}

// 获取输入框的内容
void _getTextField() {
    print(_controller.text);
}

// 生命周期结束时销毁controller
@override
void dispose() {
    _controller.dispose();
    super.dispose();
}

return TextField(
    controller: _controller
);
```

## 总结
如果是Web开发，可能思想上会有点不一样，多写写就能领悟到了。用Flutter进行快速开发的话还是很香的，毕竟只是为了出成品，速度足够快。不过在原生操作上还是有不少问题，毕竟只是节约成本的一个方法，如果真正投入使用，可能最终还得转到原生开发上去。  
如果有时候代码写得正确，但是莫名其妙报错，有可能是flutter热更新的问题，试着重新启动一下，可能就好了。