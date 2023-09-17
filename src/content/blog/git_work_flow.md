---
title: "关于 Git 的一些操作"
summary: "关于 Git 的一些操作"
publishedAt: "2021-08-17"
draft: false
---

## 前言
在上一家公司上班的时候，很少多人协同开发，所以 `Git` 上的操作仅限于 `add`, `commit`, `push` 等等简单的。

但是目前这家公司，多人协同就非常的频繁，所以稍微记录一下操作，免得自己以后忘记了。

一般公司都是用 `GitLab` 比较多，所以这里也按照 `GitLab` 来写。

## Git WorkFlow

### Fork/Clone
首先我们在需要多人协作的项目中将项目 `Fork` 到我们自己的仓库（当然也可以直接 `Clone`，但是防止对源仓库误操作，最好还是 `Fork`）

### 添加 Remote
添加远端仓库的 `Remote`
```shell
git remote add <远程仓库名（自己取）> <远程仓库地址>
# 举例 :git remote add dev https://remote.repo.address
```

### 本地 Pull
```shell
git switch master # or git checkout master
git pull <远程仓库名> <远程分支>:<本地分支>
# 举例 :git pull dev master:master
```
建议本地的 `master(main)` 分支只做同步，代码修改在新建分支上，确保不破坏主分支

### 新建分支
如果你的公司比较严格，需要每个 `Feature/Fix` 都要新建一个分支，那就按照需求新建分支，如果没有特别要求，就按照自己名字新建分支也可以。
```shell
git checkout -b <分支名>
# 举例 :git checkout -b fix-type
```

### 处理冲突
多人开发中，肯定是每个人开发自己的部分先后提交。如果各自管各自的部分，不会改到别人的部分，基本上没什么冲突。但是一旦出现两人同时修改了一个文件的情况，就要开始处理冲突了。

假设现在有这么一个文件 `index.js`
```js
const foo = () => {
  console.log('main')
}
```

你在开发中写成这样
```js
const foo = () => {
  console.log('main!!')
  console.log('me')
}
```

你的同事修改成这样
```js
const foo = () => {
  console.log('my change!')
}
```

并且同事代码已经提交并且 merge 到主分支，你的代码提交就会出现冲突无法合并，需要在本地或者网页上处理冲突才能继续合并。

首先询问你的主管（或者你自己就是主管），要留谁的代码，或者都留下，确认好之后，你就开始解决冲突

```shell
git switch master # 切到本地主分支同步一下代码
git pull dev master:master # 如果同步到当前分支的话可以省略后面的 :master
```

之后切换到需要解决的分支
```shell
git switch fix-type
git rebase master # 与 master 分支进行 rebase 操作
```

做完上面的操作，你的 IDE 中应该会出现冲突解决的操作，你可以保留对方的代码，或者保留自己的代码，修改妥当之后
```shell
git add .
git rebase --continue
git push origin fix-type
```

以上，冲突就解决了，之后提交 `merge request` 等待合并。

看起来有点复杂，但实际操作过一次之后，就会了解了。
