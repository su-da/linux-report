# Linux 简单文件操作

日期：2015.10.11 21:26

网址：<http://www.jianshu.com/p/7a271eea2da1>

---

这个星期自己通过网络资源，在萌萌哒的！潘旭！同学帮助下，学习了基本的文件
操作，诸如进入文件夹，新建、删除文件、文件夹，转移文件夹。

其中拷贝命令刚开始没有完全理解，在自己的实践操作中，弄懂了其原理。

将 file1 复制进入 file2 中

    6002@go:~/work$ cp -r file1 file2
    6002@go:~/work$ ls
    Makefile  file2      media01  report.pdf  work02.md
    file1    header.md  media02  work01.md  work99.md

进入 file1 文件夹

```
6002@go:~/work$ cd file1
6002@go:~/work/file1$ ls
6002@go:~/work/file1$ ls（里面神马都没有）
```

进入 file2

    6002@go:~/work/file1$ cd file2
    -bash: cd: file2: No such file or directory

（直接进，进不去，很低级的一个错误）

返回上一个文件夹

```
6002@go:~/work/file1$ cd ..
6002@go:~/work$ ls
Makefile  file2      media01  report.pdf  work02.md
file1     header.md  media02  work01.md   work99.md
```

进入file2

    6002@go:~/work$ cd file2
    6002@go:~/work/file2$ ls
    file1（发现文件file1)

好吧，就这样了。
