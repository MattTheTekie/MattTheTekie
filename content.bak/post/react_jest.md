---
title: "React+Vite 配置 jest"
date: 2022-01-28T08:59:30+08:00
draft: false
---

## 前言
虽然通过 `create-react-app` 能自带好多 jest 的配置，但是最近开发基本都是用 `vite` ，在配置的时候遇到了点问题，特别是搭配 `typescript` 使用的时候，所以记录一下。

默认按照这个[模板](https://github.com/mrleidesen/react-vite-tailwind-template)来讲解，如果其他的话大致修改应该也差不多。

## 安装依赖
首先需要安装我们所需要的依赖
```shell
npm install jest @types/jest -D

npm install @babel/preset-env @babel/preset-react @babel/preset-typescript -D

npm install  @testing-library/jest-dom @testing-library/react identity-obj-proxy -D
```
我在使用 `pnpm` 安装依赖的时候会碰上一些报错，比如 `missing @babel/core` 之类的，可以放着不管它。

## 配置文件
### package.json
需要在文件最下方加上如下配置
```json
{
  // ...
  "scripts": {
    // ...
    "test": "jest"
  },
  // ...
  "jest": {
    "testEnvironment": "jsdom",
    "setupFilesAfterEnv": [
      "<rootDir>/jest-setup.ts"
    ],
    "moduleNameMapper": {
      "\\.(css|less)$": "identity-obj-proxy"
    }
  }
}
```

### jest-setup.ts
在根目录下新建 `jest-setup.ts`

```ts
import "@testing-library/jest-dom";
```

### babel.config.js
在根目录下新建 `babel.config.js`

```js
module.exports = {
  presets: [
    [
      "@babel/preset-env",
      {
        targets: {
          node: "current",
        },
      },
    ],
    "@babel/preset-react",
    "@babel/preset-typescript",
  ],
};
```

## 编写测试
在 `App.tsx` 中加入 h1 标签

```tsx
// App.tsx
import React from 'react';

const App: React.VFC = () => {
  return <h1>Test</h1>;
};

export default App;
```

在 `src/` 目录下创建 `App.test.tsx`

```tsx
// App.test.tsx
import { render, screen } from '@testing-library/react';
import React from 'react';

import App from './App';

test('App.tsx', () => {
  render(<App />);
  expect(screen.getByRole('heading').textContent).toBe('Test');
});
```

这个时候如果出现 `test` 这个函数报错  
> Cannot find name 'test'.

这是因为 `tsconfig.json` 没有配置好
```json
{
  // ...
  "types": ["vite/client", "jest"], // 加上 jest
  // ...
  "isolatedModules": false, // 该为 false
}
```

## 运行测试
```python
npm run test

 PASS  src/App.test.tsx
  √ App.tsx (50 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        2.098 s
Ran all test suites.
```

运行通过就说明没问题啦~

如果报错了，可根据报错信息进行排查，如果没有使用 `typescript` 配置不需要这么复杂。
