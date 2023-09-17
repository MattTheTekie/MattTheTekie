---
title: "Vue3踩坑经历"
date: 2021-06-01T10:01:22+08:00
draft: false
---

## ref
在`setup()`中，如果你声明了一个`ref`变量
```js
setup() {
  const activeId = ref(0)
}
```
除了重新赋值需要加上`.value`，其他取值的情况下也要加上`.value`
```js
const activeId = ref(1)
const list = [{ name: 'jack' }]

// 正常赋值
activeId.value = 0

// 以下错误的取值方式
// console.log(list[activeId])

// 正确方式
console.log(list[activeId.value]) // { name: 'jack' }
```
如果你在`reactive`中也赋值了`ref`，那么在取值的时候，也要使用`.value`

## reactive
正常使用，我们一般用对象
```js
const book = reactive({
  author: 'jack'
})
```
但有时候我们要用数组
```js
const books = reactive([{
  author: 'jack'
}])
```
响应式不能直接赋值，如果是对象，我们得修改字段，或者使用`Object.assign`
```js
// 方法一
book.author = "jojo"
//方法二
Object.assign(book, {author: 'jojo'})
```
修改数组的话，同样得修改原始数据的，比如`splice`, `push`等方法
```js
// 方法一
books[0] = {author: "jojo"}
// 方法二
books.push({ author: 'jojo' })
// 方法三
books.splice(0, 1)
```

## 最后
`setup`目前刚用起来感觉有点怪怪的不是很习惯，可能因为用惯了普通写法和`React Hooks`导致的不习惯，多用用或许会习惯吧