# 《陨落之铭》设定库 · 发布站说明

这是把你的 Obsidian 设定库发布成公开网页的工程（基于 [Quartz v5](https://quartz.jzhao.xyz/)）。

**真源始终是你本地 Obsidian 里的文件夹**：`E:\desk\_notes\陨落之铭世界设定库\`
网页只是它的"只读镜像"，靠 Git 自动发布。手机/其他设备上直接开网页网址即可查阅。

---

## 目录结构

```
kusogame-wiki\
├─ content\             ← 网站内容 = 设定库的镜像（由 publish.bat 维护，别手改）
├─ quartz.config.yaml   ← 站点配置：站名 / 语言 / 主题 / 插件开关
├─ publish.bat          ← ★ 一键同步 + 发布（日常更新就双击它）
├─ .github\workflows\deploy.yml  ← push 后自动构建并上线 GitHub Pages
└─ SETUP-说明.md         ← 本文件
```

---

## 一、日常更新流程（每次改完稿）

1. 在 **Obsidian** 里正常编辑 `陨落之铭世界设定库` 下的文件；
2. 双击 `E:\desk\kusogame-wiki\publish.bat`；
3. 等屏幕提示"完成"，几十秒到几分钟后网页自动更新。

> 它做的事：把设定库里的 `.md` 全部镜像进 `content\` → `git commit` → `git push` → GitHub Actions 自动 `quartz build` 并发布到 Pages。

---

## 二、本地预览（可选，改完先看效果再上线）

```bat
cd /d E:\desk\kusogame-wiki
npx quartz build --serve
```
浏览器打开 http://localhost:8080 。关闭窗口即停止。

---

## 三、首次上线（只需做一次）

需要你的 GitHub 账号。以下用 `<你的用户名>` 和 `<仓库名>` 代替。

1. **建仓库**：打开 https://github.com/new ，仓库名填（例如）`kusogame-wiki`，
   **不要**勾选 README / license / .gitignore（会和现有文件冲突），建完留空即可。

2. **推送上线**（origin 已预先指向 `xph233-laoyi/kusogame-wiki`，直接推即可）：
   ```bat
   cd /d E:\desk\kusogame-wiki
   git push -u origin v5
   ```
   （第一次会弹出 GitHub 登录窗口，网页授权即可。）

3. **打开 Pages**：进仓库 **Settings → Pages**，在 "Build and deployment" 的 Source 下拉选 **GitHub Actions**。

4. **（已配好，可跳过）**：`quartz.config.yaml` 的 `baseUrl` 已填为
   `xph233-laoyi.github.io/kusogame-wiki`，无需改动。

5. **完事**：你的网址是 `https://xph233-laoyi.github.io/kusogame-wiki/`

> 若 push 报 "身份不明"，先执行：
> ```
> git config user.name  "你的名字"
> git config user.email "你的邮箱"
> ```

---

## 四、可调的开关（都在 quartz.config.yaml）

- 改站名：`pageTitle: ...`
- 站点界面语言：`locale: zh-CN`（已设中文，内置英文/日文等）
- 主题配色 / 字体：`theme` 段（默认浅色+深色，右上角按钮可切换）
- 右侧"关系图谱"、左栏目录、页内目录等：对应插件 `enabled: true/false`

---

## 五、常见问题

- **中文文件名打不开？** 浏览器会自动做 URL 编码，能正常打开。不要用 QQ 里的旧缓存链接。
- **本地预览先出现 git 时间戳警告？** 提交过一次后自动消失。
- **手机/另一台电脑怎么改？** 本方案是"一台真源 + 只读网页"。真源只有这一台电脑，别在网页端想改。
- **国内访问 GitHub Pages 偶尔慢？** 可后续加 Cloudflare Pages 免费镜像，或换腾讯云 COS。真需要时再说。
- **Obsidian 里把某个 .md 改名/删了？** 运行一次 publish.bat 即可同步删除/改名。

## 参考
- Quartz 官方文档：https://quartz.jzhao.xyz/
- 本项目文件与设定库的对应关系：`README.md`(已在库里更名) → `index.md` 作为网站首页，其余 `01~06` 原样。
