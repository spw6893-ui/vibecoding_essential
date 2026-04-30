---
name: heroui-pro
description: 当用户提到 heroui、HeroUI、nextui、NextUI 或任何包含这些词的句子时立即触发。当用户要创建新前端项目、构建 Dashboard、管理后台、SaaS 应用、AI 聊天界面、电商页面、落地页时触发。关键词：heroui、nextui、hero、ui 组件、侧边栏、导航栏、dashboard、admin、前端项目。
---

# HeroUI Pro 组件库技能

## 核心理念

**HeroUI Pro 组件可以集成到任何 Next.js 项目中。** 新项目推荐从零搭建 HeroUI 底座；已有项目只需添加依赖和配置即可渐进引入 HeroUI 组件，与现有 UI 库（shadcn、MUI、Ant Design 等）共存。

> 注意：本 Skill 的步骤针对 **Next.js (App Router)** 项目。如果是 Vite/CRA 等非 Next.js 项目，核心依赖和 Tailwind 配置相同，但 Provider 配置、路由集成、`"use client"` 指令等需自行适配。

## ⚠️ 关键避坑点

- **绝对不要用 `heroui init` CLI 初始化项目**——它会装上错乱的依赖版本，且有交互提示无法自动化
- **Tailwind CSS 必须使用 v3**——v4 与 HeroUI 不兼容，会引起 `w is not a function` 报错
- **npm install 必须加 `--legacy-peer-deps`**——避免 peer dependency 冲突
- **Pro 组件文件夹名带空格**——复制到项目时必须重命名（如 `Basic Pricing` → `BasicPricing`），否则 Next.js 会报 `Module not found`
- **Pro 组件位置**：`~/.codex/skills/heroui-pro/MyHero-main/components/`
- **搜索脚本**：`~/.codex/skills/heroui-pro/scripts/list_components.py`

---

## 路线判断（首先执行）

在开始之前，先判断项目类型：

| 情况 | 路线 |
|------|------|
| 还没有项目，需要从零开始 | → **路线 A：新项目初始化** |
| 已有 Next.js/React 项目，想引入 HeroUI 组件 | → **路线 B：已有项目集成** |

判断方法：检查项目根目录是否已有 `package.json`。如果有，走路线 B；如果没有，走路线 A。

---

## 路线 A：新项目初始化（稳定闭坑路线）

### 步骤 A1：用 create-next-app 创建项目

```bash
yes "" | npx -y create-next-app@latest <project-name> --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm
```

> `yes "" |` 前缀用于自动跳过 React Compiler 等交互提示，避免命令卡住。

### 步骤 A2：降级 Tailwind 到 v3

```bash
cd <project-name>

# 卸载不兼容的 v4，安装 v3
npm uninstall @tailwindcss/postcss tailwindcss
npm install -D tailwindcss@3 postcss autoprefixer --legacy-peer-deps

# 删除 create-next-app 生成的 postcss.config.mjs（v4 格式，与 v3 冲突）
rm -f postcss.config.mjs

# 用 v3 命令自动生成配置文件（会创建 tailwind.config.js 和 postcss.config.js）
npx tailwindcss init -p
```

> ⚠️ 新版 `create-next-app` 会生成 `postcss.config.mjs`（v4 格式），而 `npx tailwindcss init -p` 生成 `postcss.config.js`（v3 格式）。**必须先删除 `.mjs` 文件**，否则两者冲突。

### 步骤 A3：安装核心依赖

```bash
npm install @heroui/react @heroui/theme framer-motion @iconify/react next-themes --legacy-peer-deps
```

### 步骤 A4：配置 tailwind.config.ts

删除自动生成的 `tailwind.config.js`，创建 `tailwind.config.ts`：

```typescript
import {heroui} from "@heroui/react";
import type {Config} from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
    "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  darkMode: "class",
  plugins: [heroui()],
};

export default config;
```

注意：如果项目不使用 `--src-dir`，则 content 路径中去掉 `src/` 前缀。

### 步骤 A5：恢复全局样式表

**src/app/globals.css**——删掉所有内容，只保留三行 v3 语法：

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### 步骤 A6：配置 Provider

**src/app/providers.tsx**：

```tsx
"use client";

import {HeroUIProvider} from "@heroui/react";
import {ThemeProvider as NextThemesProvider} from "next-themes";
import {useRouter} from "next/navigation";

export function Providers({children}: {children: React.ReactNode}) {
  const router = useRouter();

  return (
    <NextThemesProvider attribute="class" defaultTheme="dark">
      <HeroUIProvider navigate={router.push}>
        {children}
      </HeroUIProvider>
    </NextThemesProvider>
  );
}
```

> `navigate={router.push}` 让 HeroUI 的 Link 组件能正确使用 Next.js 客户端路由，而不是触发整页刷新。

**src/app/layout.tsx**：

```tsx
import {Providers} from "./providers";
import "./globals.css";

export default function RootLayout({children}: {children: React.ReactNode}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

注意：`<html>` 上**不要**硬编码 `className="dark"`，主题由 `next-themes` 管理。`suppressHydrationWarning` 必须保留。

### 步骤 A6.1（可选）：深色/浅色主题切换按钮

**在项目初始化时询问用户**：是否需要深色/浅色模式切换功能？如果需要，创建以下主题切换组件，并放到导航栏等合适位置。

**src/components/theme-switch.tsx**：

```tsx
"use client";

import {useTheme} from "next-themes";
import {useEffect, useState} from "react";
import {Button} from "@heroui/react";
import {Icon} from "@iconify/react";

export default function ThemeSwitch() {
  const {theme, setTheme} = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => setMounted(true), []);

  if (!mounted) return null;

  return (
    <Button
      isIconOnly
      radius="full"
      variant="light"
      onPress={() => setTheme(theme === "dark" ? "light" : "dark")}
    >
      {theme === "dark" ? (
        <Icon icon="solar:sun-2-linear" width={22} />
      ) : (
        <Icon icon="solar:moon-linear" width={22} />
      )}
    </Button>
  );
}
```

使用方式——在导航栏中引入：
```tsx
import ThemeSwitch from "@/components/theme-switch";

// 在导航栏合适位置放入
<ThemeSwitch />
```

### 步骤 A7：验证项目运行

```bash
npm run dev
```

确认页面能正常显示且无报错。

---

## 路线 B：已有项目集成（渐进引入 HeroUI）

适用于：项目已有代码和 UI，想引入 HeroUI 基础组件或 Pro 组件。HeroUI 可以与现有 UI 库共存。

### 步骤 B1：检测 Tailwind 版本

```bash
# 检查当前 Tailwind 版本
npx tailwindcss --help 2>&1 | head -1
# 或查看 package.json 中的 tailwindcss 版本
```

**三种情况：**

| Tailwind 状态 | 操作 |
|---------------|------|
| **v4（4.x）** | 必须降级到 v3，否则 HeroUI 报 `w is not a function` |
| **v3（3.x）** | 直接进入步骤 B3，只需添加 HeroUI 配置 |
| **未安装** | 安装 v3 |

**如果是 v4，降级操作：**

⚠️ **降级前必须告知用户**：Tailwind v4 → v3 会影响现有样式，需要确认。如果项目大量依赖 v4 特性，建议用户评估影响。

```bash
# 卸载 v4
npm uninstall @tailwindcss/postcss tailwindcss

# 安装 v3
npm install -D tailwindcss@3 postcss autoprefixer --legacy-peer-deps

# 生成 v3 配置文件（如果没有）
npx tailwindcss init -p
```

同时需要将 globals.css 中的 v4 语法改为 v3：
```css
/* v4 语法（删除这些） */
@import "tailwindcss";

/* v3 语法（替换为这些） */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

**如果未安装：**
```bash
npm install -D tailwindcss@3 postcss autoprefixer --legacy-peer-deps
npx tailwindcss init -p
```

### 步骤 B2：安装 HeroUI 依赖

```bash
npm install @heroui/react @heroui/theme framer-motion @iconify/react --legacy-peer-deps
```

注意：`next-themes` 是可选的，仅在需要主题切换时安装。

### 步骤 B3：合并 Tailwind 配置（⚠️ 不要覆盖）

**关键：不要删除或覆盖已有的 tailwind.config，只在现有配置上追加。**

需要追加的三项内容：

```typescript
// 1. 在文件顶部添加导入
import {heroui} from "@heroui/react";

// 2. 在 content 数组中追加一行（不要删除已有路径）
"./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}",

// 3. 添加 darkMode（如果没有）
darkMode: "class",

// 4. 在 plugins 数组中追加（不要删除已有插件）
heroui(),
```

**合并示例——假设原有配置是这样的：**

```typescript
// 原有配置
import type {Config} from "tailwindcss";

const config: Config = {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: { brand: "#FF6B00" },
    },
  },
  plugins: [require("@tailwindcss/typography")],
};

export default config;
```

```typescript
// 合并后（只追加，不删除）
import {heroui} from "@heroui/react";
import type {Config} from "tailwindcss";

const config: Config = {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
    "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}",  // ← 追加
  ],
  theme: {
    extend: {
      colors: { brand: "#FF6B00" },  // 保留原有自定义
    },
  },
  darkMode: "class",  // ← 追加
  plugins: [require("@tailwindcss/typography"), heroui()],  // ← 追加 heroui()
};

export default config;
```

### 步骤 B4：添加 HeroUIProvider（合并到现有 Provider）

**不要替换已有的 Provider 结构。** 将 HeroUIProvider 包裹在已有 Provider 层之内。

**如果项目已有 providers.tsx**，在最内层添加 HeroUIProvider：

```tsx
// 假设原有 providers.tsx
"use client";
import {QueryClientProvider} from "@tanstack/react-query";
import {SessionProvider} from "next-auth/react";
// ...其他已有 Provider

// ← 追加导入
import {HeroUIProvider} from "@heroui/react";

export function Providers({children}: {children: React.ReactNode}) {
  return (
    <SessionProvider>
      <QueryClientProvider client={queryClient}>
        {/* 在最内层包裹 HeroUIProvider */}
        <HeroUIProvider>
          {children}
        </HeroUIProvider>
      </QueryClientProvider>
    </SessionProvider>
  );
}
```

**如果项目没有 providers.tsx**，创建一个并在 layout.tsx 中引入：

```tsx
// 新建 providers.tsx
"use client";
import {HeroUIProvider} from "@heroui/react";

export function Providers({children}: {children: React.ReactNode}) {
  return <HeroUIProvider>{children}</HeroUIProvider>;
}
```

然后在 layout.tsx 的 `<body>` 内用 `<Providers>` 包裹 `{children}`。

### 步骤 B5：确保 globals.css 包含 Tailwind 指令

检查 globals.css 是否已有以下三行。**如果有就跳过，不要删除已有的自定义样式：**

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* ↓ 保留项目已有的自定义样式 ↓ */
```

### 步骤 B6：验证集成

```bash
npm run dev
```

在任意页面尝试使用一个 HeroUI 组件验证：
```tsx
import {Button} from "@heroui/react";

<Button color="primary">Test HeroUI</Button>
```

如果按钮正常显示样式，集成成功。之后可以直接进入第二阶段（使用基础组件）或第三阶段（集成 Pro 组件）。

### ⚠️ 已有项目的特别注意事项

1. **与其他 UI 库共存**：HeroUI 组件和 shadcn/MUI/Ant Design 等可以在同一项目中使用，不会冲突。它们各自有独立的样式系统。
2. **不要动已有组件**：集成 HeroUI 不需要把已有的组件改写成 HeroUI 版本。只在新增功能时选择用 HeroUI。
3. **Tailwind v4 降级影响**：如果项目已大量使用 Tailwind v4 特性（如 `@theme`、`@utility` 等 v4 语法），降级会有破坏性。此时应告知用户评估影响，或考虑只在独立页面/路由中使用 HeroUI。
4. **`"use client"` 指令**：HeroUI 组件需要在客户端运行。如果已有项目是 Server Component 为主，需要在使用 HeroUI 的文件顶部加 `"use client"`，或将 HeroUI 组件封装在独立的客户端组件文件中。

---

## 第二阶段：使用基础组件

项目初始化完成后，所有 HeroUI 基础组件（50+）都可以直接使用：

```tsx
import {Button, Card, Input, Modal, Table, Tabs, Navbar} from "@heroui/react";
```

可用组件完整列表：Accordion、Autocomplete、Alert、Avatar、Badge、Breadcrumbs、Button、Calendar、Card、Checkbox、Chip、CircularProgress、Code、DateInput、DatePicker、DateRangePicker、Divider、Dropdown、Drawer、Form、Image、Input、InputOTP、Kbd、Link、Listbox、Modal、Navbar、NumberInput、Pagination、Popover、Progress、RadioGroup、RangeCalendar、ScrollShadow、Select、Skeleton、Slider、Snippet、Spacer、Spinner、Switch、Table、Tabs、Toast、Textarea、TimeInput、Tooltip、User

---

## 第三阶段：集成 Pro 组件

当需要高级组件（侧边栏布局、认证页面、AI 聊天界面、数据表格等）时，从 Pro 组件库中集成。

### 3.1 搜索合适的 Pro 组件

```bash
cd ~/.codex/skills/heroui-pro
python3 scripts/list_components.py search <关键词>
```

常用搜索示例：
- `search sidebar` → 19 种侧边栏变体
- `search login` / `search sign` → 认证页面
- `search message` / `search prompt` → AI 聊天组件
- `search table` → 数据表格
- `search pricing` → 定价页面
- `search filter` → 筛选器
- `search card` → 各种卡片
- `search checkout` → 结账流程
- `search navbar` → 导航栏

按分类浏览：
```bash
python3 scripts/list_components.py category ai
python3 scripts/list_components.py category application
python3 scripts/list_components.py category ecommerce
python3 scripts/list_components.py category marketing
python3 scripts/list_components.py category charts
```

### 3.2 读取组件源码

每个 Pro 组件的结构：
```
组件名（可能带空格）/
├── js/          # JavaScript 版本
│   ├── app.js   # 主入口
│   └── *.js     # 辅助文件
└── ts/          # TypeScript 版本（优先使用）
    ├── app.tsx  # 主入口
    └── *.tsx    # 辅助文件
```

**必须读取 ts/ 目录下的所有文件**，不能只看 app.tsx。辅助文件包含关键逻辑（如 sidebar.tsx、sidebar-items.tsx、types.ts 等）。

### 3.3 复制到项目中（⚠️ 注意重命名）

将 Pro 组件的所有文件复制到项目的 `components/` 目录下（如果项目使用 `--src-dir`，则为 `src/components/`）。

**⚠️ 重大注意：Pro 源码的文件夹名带空格（如 `Basic Pricing`、`Sidebar With Sections`），复制到项目时必须重命名为不带空格的驼峰格式（如 `BasicPricing`、`SidebarWithSections`），否则 Next.js 构建会报 `Module not found`！**

**核心原则：**
- 完整复制所有文件，不要重写或"改进"
- 保持所有 className 和样式不变
- 只修改业务数据（菜单项、文本内容、API 地址等）
- 更新导入路径以适配项目结构

### 3.4 修改数据，不改样式

只修改数据文件，例如：

```tsx
// sidebar-items.tsx - 只改这里的菜单数据
export const sectionItems = [
  {
    key: "content",
    title: "内容管理",
    items: [
      {key: "materials", icon: "solar:document-text-outline", title: "素材管理", href: "/materials"},
      {key: "articles", icon: "solar:pen-new-square-outline", title: "文章管理", href: "/articles"},
    ],
  },
];
```

### 3.5 更新导入

确保组件中的导入路径正确：
- `@heroui/react` → HeroUI 组件（路线 A 步骤 A3 / 路线 B 步骤 B2 已安装）
- `@iconify/react` → 图标（同上）
- `framer-motion` → 动画（同上）
- 相对路径 → 同目录下的辅助文件

### 3.6 在页面中使用

Pro 组件复制到项目后，按正常组件导入即可。注意：**不要保留 Pro 源码的深层目录结构**，将文件平铺到合理的位置。

```tsx
// 示例：将 Pro 组件的文件复制到 components/pricing/ 目录
// 文件结构：
//   components/pricing/pricing.tsx      ← 原 app.tsx（重命名为语义化名称）
//   components/pricing/pricing-tiers.ts ← 数据文件
//   components/pricing/pricing-types.ts ← 类型文件

// 在页面中使用
import PricingComponent from "@/components/pricing/pricing";

export default function Home() {
  return (
    <main>
      <PricingComponent />
    </main>
  );
}
```

> 提示：Pro 源码的入口文件统一叫 `app.tsx`，复制到项目时建议重命名为语义化名称（如 `pricing.tsx`、`sidebar.tsx`），避免多个 `app.tsx` 混淆。

---

## Pro 组件分类速查

### AI 组件 (`ai/`)
| 子类 | 用途 |
|------|------|
| messages | 消息卡片（助手消息、用户消息、完整对话） |
| prompt-inputs | 提示输入框（11种变体：基础、带字符计数、带操作按钮、支持图片上传等） |
| prompt-containers | 聊天容器（空状态、带对话、带侧边栏、带历史记录） |
| playgrounds | AI 游乐场 |
| features | 特性卡片 |

### 应用组件 (`application/`)
| 子类 | 用途 |
|------|------|
| sidebars | 侧边栏（19种：基础、紧凑、响应式、带搜索、带团队切换、可折叠等） |
| authentication | 认证页面（9种：登录、注册、两步注册、带背景图等） |
| navbars | 导航栏（3种） |
| cards | 卡片（18种：用户资料、安全设置、通知、支付方式等） |
| tables | 带筛选的表格 |
| forms | 多步骤向导表单 |
| calendar | 日历预订（预订、表单、确认） |
| command-menus | 命令菜单 |
| feedbacks | 反馈组件 |
| layouts | 布局组件 |
| navigation-headers | 导航头部 |
| scrolling-banners | 滚动横幅 |
| steppers | 步骤条 |

### 电商组件 (`ecommerce/`)
| 子类 | 用途 |
|------|------|
| filters | 筛选器（9种：基础、带侧边栏、弹出框、颜色、评分、价格等） |
| product-list | 商品列表（9种：网格、带评分、带颜色选项、地点列表等） |
| checkouts | 结账（4种：单列、双列、多步骤、支付） |
| reviews | 评价（6种：评论卡片、评分摘要、带搜索排序等） |
| product-view | 商品详情 |

### 营销组件 (`marketing/`)
| 子类 | 用途 |
|------|------|
| hero-sections | 首屏（4种：基础、带截图、带导航） |
| pricing | 定价（8种变体） |
| pricing-comparison | 定价对比（8种变体） |
| footers | 页脚（4种） |
| banners | 横幅（8种） |
| faqs | FAQ（4种） |
| cookie-consents | Cookie 同意（8种） |
| teams | 团队页面 |

### 图表组件 (`charts/`)
| 子类 | 用途 |
|------|------|
| KPI-stats | KPI 统计卡片（9种） |
| Graphs | 图表（2种） |
| Bars-and-Circles | 条形图和圆形图 |

---

## 图标系统

Pro 组件使用 Iconify 图标库，主要用 `solar` 和 `gravity-ui` 图标集：

```tsx
import {Icon} from "@iconify/react";

<Icon icon="solar:home-2-linear" width={24} />
<Icon icon="gravity-ui:check" />
```

浏览图标：
- Solar: https://icon-sets.iconify.design/solar/
- Gravity UI: https://icon-sets.iconify.design/gravity-ui/

---

## 常见问题排查

| 问题 | 原因 | 解决 |
|------|------|------|
| `w is not a function` 报错 | Tailwind v4 不兼容 | 卸载 v4 并安装 `tailwindcss@3`，用 `npx tailwindcss init -p` 重建配置 |
| 组件样式完全错乱 | Tailwind v4 | 降级到 Tailwind v3 |
| 组件没有样式 | 缺少 HeroUI 插件 | 检查 tailwind.config.ts 的 plugins 中有 `heroui()` |
| 组件不渲染 | 缺少 Provider | 确认 layout.tsx 包含 HeroUIProvider |
| `Module not found` | 文件夹名带空格 | 将带空格的文件夹重命名为驼峰格式 |
| 图标不显示 | 缺少 @iconify/react | `npm install @iconify/react --legacy-peer-deps` |
| 动画不生效 | 缺少 framer-motion | `npm install framer-motion --legacy-peer-deps` |
| 暗色模式不工作 | 缺少 darkMode 配置 | tailwind.config.ts 中设置 `darkMode: "class"` |
| content 路径错误 | heroui theme 路径缺失 | content 数组加入 `./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}` |
| npm 安装报错 peer conflict | peer dependency 冲突 | 所有 npm install 命令都加 `--legacy-peer-deps` |
| `createContext only works in Client Components` | 页面文件是 Server Component 但引用了 HeroUI 组件 | 在使用 HeroUI 组件的页面文件顶部加 `"use client"` 指令，或将 HeroUI 组件封装在独立的 `"use client"` 文件中再导入 |
