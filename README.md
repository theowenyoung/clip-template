# Clip

这是 <https://clip.owenyoung.com/> 项目的模版项目，如果你想复制一个类似的项目请从这里开始。

## 流程

使用 <https://github.com/theowenyoung/markdownload> 浏览器扩展，把网页的文章，按日期保存到本地，然后用<https://rust-lang.github.io/mdBook/> 生成网页，并使用[Vercel](https://vercel.com/dashboard)发布。

Online Demo: <https://clip-template.vercel.app/>

## 如何使用？

> 注意，当前我只测试了 macos 和 linux，没有 windows 机器，但是欢迎贡献～

1. 点此[Fork](https://github.com/theowenyoung/clip-template/fork) 本项目到你的自己的 Github 账户, 你可以改名为`clip`。

2. 本地克隆你 fork 后的项目，记得要克隆到`Downloads`目录，因为浏览器扩展下载的文章只允许下载到`Downloads`目录：

> 记得把下面的地址换成你的 repo 地址

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
