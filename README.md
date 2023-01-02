# Clip

这是 <https://clip.owenyoung.com/> 网站的模版，里面收集了我觉得值得收藏的文章全文。本来是个人在使用，但是有朋友也想复制这个流程，所以我就抽出了这个干净的模板，让想用这套流程的朋友方便一点～

## 大概流程

1. 浏览网页，比如 <https://www.owenyoung.com/inspires/>
2. (可选)如果是英文文章，我会使用 [Immersive Translate](https://github.com/immersive-translate/immersive-translate) 浏览器扩展将网页翻译为双语文章
3. 用[markdownload](https://github.com/theowenyoung/markdownload) 浏览器扩展，把双语文章保存下来。
4. 使用 Git 把本地文件同步到远程仓库
5. [Vercel](https://vercel.com/dashboard)会自动部署并发布。

Online Demo: <https://clip-template.vercel.app/>

## 如何初始化

> 注意：当前我只测试了 macOS 和 Linux，我没有 windows 机器，所以没有写 Windows 的脚本，但是欢迎贡献～

1. 点此[Fork](https://github.com/theowenyoung/clip-template/fork) 本项目到你的自己的 Github 账户, 名称修改为`clip` (如果是其他的名字，后面的步骤中安装的插件的配置需要同步修改下)

2. 把你 fork 后的项目克隆到本地，记得要克隆到本地的`~/Downloads`目录 (浏览器默认下载目录），

   > 如果你自定义了其他目录作为浏览器的下载目录，那就克隆到你自定义的下载目录下。

   > 这么做是因为浏览器只允许浏览器扩展将文件下载到`Downloads`目录，所以我们收藏的文章默认会保存到下载目录下的某个目录。

   > 记得把下面的地址换成你 fork 后的 repo 地址：

   ```bash
   cd ~/Downloads
   git clone git@github.com:theowenyoung/clip.git
   ```

3. 本地安装依赖，依赖的二进制完美都会安装在当前项目目录下的`bin`目录内，这样不会污染别的地方，这个命令会安装`mdbook`,`deno`到本地目录：

   ```bash
   cd ~/Downloads/clip
   make install
   ```

4. 本地启动运行

   ```bash
   make serve
   ```

   此时，打开 <http://localhost:8000> 应该就能看到文章。

   文章会保存在`content/2022/11/14/{slug}/index.md`，如果有图片，图片也会保存在该目录下。我使用我修改的一个[Markdownload 扩展](https://github.com/theowenyoung/markdownload)，它负责把文章保存到本地目录下。

   ![](https://i.imgur.com/pTvQQ1h.png)

5. 安装插件，请在<https://github.com/theowenyoung/markdownload/releases> 下载最新版插件，firefox 浏览器可以打开`about:addons`页面，选择从文件安装。 chrome 浏览器手动安装步骤请参考[这里](https://github.com/immersive-translate/immersive-translate/blob/main/readme.md#chrome-%E6%89%8B%E5%8A%A8%E5%AE%89%E8%A3%85)

6. 安装后，可以从浏览器的扩展管理页面，进入该扩展的配置页面，拉到最后面，导入我的[配置文件](https://raw.githubusercontent.com/theowenyoung/clip-template/main/markdownload-config.json)，之后，可以按照你自己的需求修改配置。

   现在可以打开一篇文章,比如：

   <https://www.owenyoung.com/inspires/>

   试试使用插件保存文章,保存后，本地运行：

   ```bash
   make serve
   ```

   就可以在浏览器中打开<http://localhost:8000> 看到预览页面。

7. 发布到 Vercel，直接在 <https://vercel.com/dashboard> 新建一个项目，然后选择从 Github 中导入项目，不需要做额外配置，你可以在首次部署完成后，在 Vercel 的后台设置自定义域名。

## 初始化之后的常规操作

1. 看到想收藏的文章，点击扩展图标保存到本地
2. 使用 Git 同步到远程仓库即可，Vercel 会自动部署最新的项目。

## RSS 地址

Mdbook 本身的目标是制作电子书，所以并不支持 RSS，但为了方便，我添加了输出 RSS 的功能，地址是根目录下的`feed.xml`，比如该 demo 的 RSS 地址：

<https://clip-template.vercel.app/feed.xml>

## 配置

网站的标题之类的配置都在`book.toml`下，照猫画虎修改即可。 查看所有可配置的东西，请参阅[这里](https://rust-lang.github.io/mdBook/format/configuration/index.html)

主要是修改你的网站名称，网址，作者以及 Git Repo 相关配置等等。

如果你有静态文件需要提交放在网站根目录到话，可以放在`template/archive` 下，现在有一个 `robots.txt`, 默认只允许搜索引擎收录首页，其他页面一律不允许，因为考虑到 clip 的文章大都是收藏别人的文章，所以不让搜索引擎收录是一个合理的默认选择，你可以根据自己的需要修改。

项目根目录下的`README.md` 文件被用于作为网站的首页。如果你不想用这个`README.md`,也可以在添加`template/archive/README.md`文件。

## 插件配置

我默认的 Markdown Frontmatter 遵循的是 [zola](https://www.getzola.org/) 的格式：

```
---
title: "{pageTitleWithoutSiteName}"
date: {date:YYYY-MM-DDTHH:mm:ss}+08:00
updated: {date:YYYY-MM-DDTHH:mm:ss}+08:00
taxonomies:
  tags: {tags}
extra:
  source: {baseURI}
  hostname: {hostname}
  author: {byline}
  original_title: "{title}"
  original_lang: {lang}
---
```

如果你需要别的 tags 的格式，可以改为：

```
---
title: "{pageTitleWithoutSiteName}"
date: {date:YYYY-MM-DDTHH:mm:ss}+08:00
updated: {date:YYYY-MM-DDTHH:mm:ss}+08:00
tags: {tags}
extra:
  source: {baseURI}
  hostname: {hostname}
  author: {byline}
  original_title: "{title}"
  original_lang: {lang}
---
```

## Epub 相关配置(可选，默认不启用)

我在这个项目里会使用 Github Actions，把当日的文章汇总成一个 epub 文件，然后发送 email 到我的 kindle 邮箱里，这样就能在 kindle 阅读这些保存下来的文章。

如果你不修改相关配置的话，默认是不开启的。

如果你想启用的话，需要把`.github/workflows/build-daily.yml`里面的注释去掉

> 发送 email 需要用到 <https://www.mailjet.com/>的 API，免费额度每日 200 封，足够个人使用。 你需要注册一个账户，然后拿到 API ID 和 Secret

我使用<https://orly.nanmu.me/>生成 epub 的封面图，你可以生成一个，然后替换 `templates/archive/cover.jpg` 以及 `templates/cover.jpg`

本地测试生成 epub 文件可以运行如下命令：

```bash
make today
```

```bash
make yesterday
```

```bash
make day day=2022-11-21
```

具体配置可以参考我的 [clip 配置](https://github.com/theowenyoung/clip/blob/main/.github/workflows/build-daily.yml)，等有人需要，我再完善这部分文档吧，或者欢迎你贡献呀！
