---
title: "React Context用法"
summary: "React Context用法"
publishedAt: "2021-06-15"
draft: false
---

## 创建一个context
首先需要通过`React.createContext`定义一个context，一下的定义需要在函数外定义
```js
// ./src/Store.js
const StoreContext = React.createContext()
```
如果你使用TS，那么createContext中需要传入一个默认值
```ts
// ./src/Store.tsx
interface StoreProps {
  count: number
  setCount: Function
}

const StoreContext = React.createContext<StoreProps>({} as StoreProps)
// 如果不加 'as StoreProps',因为里面的参数都是必填，会报错
// 或者传入{ count: 0, setCount: () => {} }这样当做默认值
// 也可以把类型定义为 'StoreProps | null'，然后传入null，但不是很推荐
```

## 创建一个Provider
```js
export default function Store({ children }) {
  const [count, setCount] = useState(0)

  return (
    <StoreContext.Provider 
      value={{
        count,
        setCount
      }}
    >
      {children}
    </StoreContext.Provider>
  )
}
```

## 使用useContext
```js
// ./src/Store.js
const StoreContext = React.createContext()
// ...

// 导出useContext，方便在其他组件中引用
export const useStore = () => useContext(StoreContext)

// ...
export default function Store({ children }) {}
```

## 在其他组件引入
这边为了方便演示，直接在`main.js`中引入
```js
import React from 'react'
import ReactDOM from 'react-dom'
import './index.css'
import App from './App'
import Store from './Store'

ReactDOM.render(
  <React.StrictMode>
    <Store>
      <App />
    </Store>
  </React.StrictMode>,
  document.getElementById('root')
)
```
之后回到`App.js`文件中
```js
import { useStore } from './Store'

export default function App() {
  // 之后就可以使用context中创建的值了，可以动态改变
  // 可以当成一个简易的状态管理
  const store = useStore()

  return (
    <>
      <h1>{ store.count }</h1>
      <button 
        onClick={() => store.setCount(store.count + 1)}
      >Counter++</button>
    </>
  )
}
```

## 详细的Demo
[ReactContextStoreDemo](https://github.com/mrleidesen/ReactContextStoreDemo)
