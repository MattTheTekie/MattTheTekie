---
title: "Vue2对比Vue3组合式API写法"
date: 2021-04-25T09:13:56+08:00
draft: false
---

## 前言
Vue3已经基本上成熟了，很多开源项目也开始往Vue3上迁移了，新增的`组合式API`确实非常好用，这里稍微写一下Vue2原本模式和Vue3组合式API的写法有哪些不同

## 对比
### Data和Methods
* Vue2
```js
export default {
  data: () => ({
    count: 0,
    user: {
      name: 'Jack',
      age: 23
    }
  }),

  methods: {
    onClick() {
      this.count++
    }
  }
}
```
* Vue3
```js
import { ref, reactive } from 'vue'
export default {
  setup() {
    const count = ref(0) // 定义普通的类型
    const user = reactive({
      name: 'Jack',
      age: 23
    }) // 定义对象

    const onClick = () => {
      count.value++
    }

    return {
      count,
      user,
      onClick
    } // 需要返回
  }
}
```

### Computed
* Vue2
```js
export default {
  data: {
    count: 0
  },
  computed: {
    getPlusOneCount() {
      return this.count + 1
    }
  }
}
```
* Vue3
```js
import { ref, computed } from 'vue'
export default {
  setup() {
    const count = ref(0)

    const getPlusOneCount = computed(() => count.value + 1)

    return {
      count,
      getPlusOneCount
    }
  }
}
```

### Watch
* Vue2
```js
export default {
  data: {
    count: 0,
  },
  watch: {
    count(newVal, oldVal) {
      console.log(newVal, oldVal)
    }
  }
}
```
* Vue3
```js
import { ref, watch } from 'vue'
export default {
  setup() {
    const count = ref(0)

    watch(count, (newVal, oldVal) => {
      console.log(newVal, oldVal)
    })

    return {
      count
    }
  }
}
```

### Filter
`filter`在Vue3中已经去掉，建议用`computed`替代

## 组合式API替代Vuex
目前使用时发现组合式API可以代替Vuex（不过不确定用法是否正确），定义好的响应式数据，可在任意组件引入，并且共享相同数据
* 创建`store/index.js`
```js
import { reactive } from 'vue'

export const state = reactive({
  isLogin: false,
  showMenu: true
})

export const setIsLogin = (val) => {
  state.isLogin = val
}

export const setShowMenu = (val) => {
  state.showMenu = val
}
```
* 当成vuex使用
```js
import { state, setIsLogin } from '../store'
export default {
  setup() {
    return {
      state, // 当成data
      setIsLogin, // 当成methods
    }
  }
}
```