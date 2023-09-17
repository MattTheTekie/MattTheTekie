---
title: "uni-app安卓调用前置摄像头并自动拍照"
summary: "uni-app安卓调用前置摄像头并自动拍照"
publishedAt: "2021-04-19"
draft: false
---

# uni-app安卓调用前置摄像头并自动拍照
> 最近有个uni-app打包成安卓APP的项目，需要拍照后去人脸验证，但是uni提供的只有调起相机，手动切换之后再点拍照，这样操作非常繁杂，就想着有没有啥方法

## 问题
和小程序不同，原本小程序中使用腾讯的人脸识别，但是现在需要把项目移植到安卓上去，不仅没有人脸识别了，也没法直接调起前置摄像头。  
查了一下`H5+`的方法，发现直接调起前置的方法在安卓不兼容，这么坑吗？  
然后去插件市场找了一下发现都没有合适的，最后发现`H5+`的直播方法居然能用，还有`nvue`的直播推流也是能直接调起前置摄像头

## nvue
`nvue`的方式我在新开的项目中可以用，但是不知道为什么在原本的项目中会出现编译失败，不过这边也写一下。
* 通过`live-pusher`组件搭配`LivePusherContext`的API来搭配
* 不过注意`nvue`的各种限制
* 新建文件`scan.nvue`
```html
<template>
  <view class="content">
    <live-pusher id='livePusher' ref="livePusher" class="livePusher" url=""
      mode="SD" :muted="true" :enable-camera="true" :auto-focus="true" :beauty="1" whiteness="2"
      aspect="9:16"
    ></live-pusher>
  </view>
</template>

<script>
export default {
  onReady() {
      // 注意：需要在onReady中 或 onLoad 延时
      // 因为不需要推流，只需要用到预览画面和快照功能
      this.context = uni.createLivePusherContext("livePusher", this);
      this.startPreview();
  },
  methods: {
      // 快照接口，需要倒计时的话可以根据需要调用这个接口
      snapshot: function() {
        this.context.snapshot({
          success: (e) => {
            console.log(e);
          }
        });
      },
      startPreview: function() {
        this.context.startPreview({
          success: (a) => {
            console.log("livePusher.startPreview:" + JSON.stringify(a));
          }
        });
      },
  }
}
</script>
```

### h5 plus
`nvue`的方法应该是APP中最好的，但是不知道我的项目跑不起来，所以改用了`H5+`的接口
* 新建文件`scan.vue`
```html
<script>
  export default {
    onReady() {
      const currentWebview = this.$mp.page.$getAppWebview()  
      // 创建流，如果需要修改画面大小等配置，需要在后面的参数中调整
      this.context = plus.video.createLivePusher("livePusher", {    
        url:'rtmp://testlivesdk.v0.upaiyun.com/live/upyunb', // 地址没关系
        width: '200px',
        height: '200px',
        top: '100px',
        left: '23%',
        position: 'static',
        muted: true
      });    
      currentWebview.append(this.context);

      this.startPreview()
    },
    methods: {
      // 快照
      snapshot: function() {
        this.context.snapshot((res) => {
          // 通过plus的接口拿到的临时图片文件
          // 无法通过uni的接口来获取，只能通过
          // plus的接口拿到路径后放到uni中使用
          plus.io.getImageInfo({
            src: res.tempImagePath,
            success: ioCallback => {
              // 通过plus.io.getImageInfo能拿到
              // uni接口可用的路径地址
              const path = ioCallback.path
              uni.compressImage({
                src: path,
                success: cb => {
                  console.log(cb)
                },
                fail: err => {
                  console.log(err)
                }
              })
            }
          })
          
        })
      },
      // 这边还是预览
      startPreview: function() {
        this.context.preview()
      },
    }
  }
</script>
```
