---
layout: post
title: "Git 命令小结"
date: 2017-09-07 15:02:36
comments: true
tags: [技术, Git]
---

## 一、Configuration:配置

* 列举所有的别名与配置
```bash
$ git config --list
```

* 编辑配置文件
```bash
格式：git config [–local|–global|–system] -e
$ git config -e 默认是编辑仓库级的配置文件
```

<!-- more -->

## 二、分支
查看分支：
```bash
$ git branch
```

创建分支：
```bash
$ git branch <name>
```

切换分支：
```bash
$ git checkout <name>
```

创建+切换分支：
```bash
$ git checkout -b <name>
```

合并某分支到当前分支：
```bash
$ git merge <name>
```

删除分支：
```bash
$ git branch -d <name>
```

## 三、版本回退
* 查看版本历史记录：
```bash
$ git log
```

* 回退到某个版本(使用HEAD)
```bash
git reset --hard HEAD 
git reset --hard HEAD^
```
首先，Git必须知道当前版本是哪个版本，在Git中，用HEAD表示当前版本，也就是最新的提交。
上一个版本就是HEAD^，上上一个版本就是HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100

* 回退到某个版本(具体ID)
```bash
$ git reset --hard 3628164
```
版本号没必要写全，前几位就可以了，Git会自动去找。当然也不能只写前一两位，因为Git可能会找到多个版本号，就无法确定是哪一个了。
当然还能重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本。

### 想了解更多，可以去看相关资料：
* [Git中文文档](http://git-scm.com/book/zh/v2)
* [Git教程 - 廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)