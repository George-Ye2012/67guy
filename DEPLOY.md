# 🚀 67guy 免费部署指南

全程 **零花费**，部署后永久在线，不会因关电脑而停止。

---

## 架构说明

```
浏览器 ─→ Vercel (静态网页) ─→ Supabase (数据库 + 存储 + 认证)
```

- **Vercel**：托管 HTML/CSS/JS 文件，完全免费，永不关机
- **Supabase**：PostgreSQL 数据库 + 文件存储 + 用户认证，免费额度远超需求

---

## 第一步：创建 Supabase 项目 (5 分钟)

1. 打开 [app.supabase.com](https://app.supabase.com)，注册/登录
2. 点击 **New project**
3. 填写：
   - Name: `67guy`
   - Database Password: 设置一个强密码（记下来）
   - Region: 选 **Northeast Asia (Tokyo)** 或离你最近的
4. 点击 **Create project**，等待 1-2 分钟初始化

---

## 第二步：初始化数据库

1. 进入 Supabase 项目 → 左侧菜单 → **SQL Editor**
2. 点击 **New query**
3. 复制粘贴 `supabase-setup.sql` 的全部内容
4. 点击右下角 **Run**
5. 看到 "Success" 即为完成

---

## 第三步：关闭邮箱验证

因为登录只需要昵称，不需要真实邮箱：

1. Supabase 左侧菜单 → **Authentication** → **Providers**
2. 找到 **Email** 项，展开设置
3. 把 **Confirm email** 开关 **关掉**
4. 点击 **Save**

---

## 第四步：填入 Supabase 密钥

1. Supabase 左侧菜单 → **Settings** → **API**
2. 复制 **Project URL**（例如 `https://xxxxx.supabase.co`）
3. 复制 **anon public key**（以 `eyJ` 开头的长字符串）
4. 打开 `public/index.html`，找到第 409-410 行：
   ```javascript
   const SB_URL  = 'https://YOUR_PROJECT_ID.supabase.co';
   const SB_KEY  = 'YOUR_ANON_KEY';
   ```
5. 替换为你的真实值

---

## 第五步：部署到 Vercel

### 方法 A：命令行（推荐，2 分钟）

```bash
# 安装 Vercel CLI（需要 Node.js）
npm i -g vercel

# 在项目目录执行
cd D:\67guy
vercel

# 按提示操作：
# - Login: 用 GitHub/GitLab/Email 登录
# - Set up and deploy: Yes
# - Which scope: 选你的账号
# - Link to existing project: No
# - Project name: 67guy（或自定义）
# - Root directory: public
# - 后续提示全部回车（默认）
```

部署完成后，Vercel 会给你一个 `https://xxx.vercel.app` 的地址。

以后修改代码后，运行 `vercel --prod` 即可更新。

### 方法 B：网页端

1. 打开 [vercel.com](https://vercel.com)，注册/登录
2. 点击 **Add New** → **Project**
3. 导入你的 GitHub 仓库（或拖拽 `public/` 文件夹）

---

## 第六步：测试

1. 打开 Vercel 给你的地址
2. 注册一个账号 → 登录 → 开始测试
3. 用手机也能访问（响应式适配）

---

## 免费额度总览

| 服务 | 免费额度 | 够用吗 |
|------|---------|--------|
| **Vercel** | 100GB 带宽/月，无限静态站点 | ✅ 绰绰有余 |
| **Supabase DB** | 500MB 数据库，2GB 带宽 | ✅ 够几千用户 |
| **Supabase Auth** | 5 万月活用户 | ✅ 完全免费 |
| **Supabase Storage** | 1GB 存储，2GB 带宽 | ✅ 头像够用 |

---

## 项目文件结构

```
67guy/
├── public/
│   ├── index.html          ← 主页面（需填入 Supabase 密钥）
│   ├── camera_utils.js     ← MediaPipe 相机工具
│   └── hands/              ← MediaPipe Hands WASM 文件
├── supabase-setup.sql      ← 数据库初始化脚本
├── vercel.json             ← Vercel 部署配置
├── server.js               ← 旧版后端（不再需要，可删除）
└── DEPLOY.md               ← 本文件
```
