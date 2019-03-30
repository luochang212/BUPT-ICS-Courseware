---
title: 用Python解置换群小题目
date: 2019-03-16 06:45:10
categories: computer science
tags: Pycharm
mathjax: true
thumbnail: /img/20190316094941.jpg
---

室友问了我一道题目，把我难住了，想不出解法，于是写了个小程序暴力求解。

<!-- more -->


题目如下

![字小伤眼](/img/20190316065412.jpg)

A permutation is applied to the string SUPERBGOLDHAT. The same permutation is applied to the output from this operation. The second output is OGTHLEPDSUARB. What was the first output? (Note: as an example, the permutation(1 3 4) applied to WOLF gives FOWL. Write your answer in capital letters inside quotation marks, e.g. "BEARDPLUGHOST".)

> 它说的是，一个变换规则作用于字符串SUPERBGOLDHAT, 生成一个新字符串。再次将相同的变换规则作用于这个新字符串，得到一个经过两次变换的字符串OGTHLEPDSUARB. 求第一次变换后的字符串。

首先简单说明一下什么是置换，学过近世代数的同学可以跳过这部分

首先给定一个序列
$a =\{1, 2, 3, 4, 5, 6\} $ 
然后给定一个置换
$$\sigma =  \left\{\begin{matrix}1 & 2 & 3 & 4 & 5 & 6 \\ 3 & 5 & 2 & 6 & 4 & 1\end{matrix}\right\} $$ 
那么，置换 $\sigma$ 的作用就是，把序列 $a $ 中的1变成3，2变成5，3变成2，4变成6 $\ldots$ 
以此类推
第一次: 3 5 2 6 4 1
第二次: 2 4 5 1 6 3
第三次: 5 6 4 3 1 2
上面表示置换的方法叫**两行式**，此外，我们还可以用**轮换**来表示一个置换
举个例子，如下是一个两行式表示的置换
$$\tau =  \left\{\begin{matrix}1 & 3 & 4 \\ 3 & 4 & 1 \end{matrix}\right\} $$ 
它表示成是轮换是 $\tau = (1 3 4) $ 
以上的 $\tau $ 和 $\sigma $ 都属于 k-循环置换
如果一个变换将 i<sub>1</sub> $\rightarrow$ i<sub>2</sub>, i<sub>2</sub> $\rightarrow$ i<sub>3</sub>, $\ldots $ i<sub>k</sub> $\rightarrow $ i<sub>1</sub>, 而其他各元不变，那么该置换称为**k-循环置换**(k-cycle)，写作 ( i<sub>1</sub>,i<sub>2</sub>,i<sub>3</sub> $\ldots $ i<sub>k</sub> ). 
除了k-循环置换之外，还有一种置换叫做非循环置换
一个k-循环置换, 总是可以表示为一个轮换
一个**非循环置换**，则总是可以表示成几个轮换的积
例如，非循环置换 $ \upsilon $ 就可以表示成
$$\upsilon =  \left\{\begin{matrix}1 & 2 & 3 & 4 & 5 & 6 \\ 6 & 4 & 2 & 3 & 5 & 1\end{matrix}\right\} = (1 6)(2 4 3)(5) = (1 6)(2 4 3) ​$$ 
(以上参考自: [置换群题目汇总](https://blog.csdn.net/y990041769/article/details/45172095),  [《近世代数》杨子胥](http://idl.hbdlib.cn/book/00000000000000/pdfbook/o/o01/index0069.pdf) ) 

放上代码

```python
import numpy as np
import itertools


# a is something like index
# b is the second output you want
# C (capital) is the first output we guess
a = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
a = a-1
b = np.array([8, 7, 13, 11, 9, 4, 3, 10, 1, 2, 12, 5, 6])
b = b-1
c = np.zeros([a.size])

# traverse all permutations of a
for C in itertools.permutations(a, a.size):
    print(C)
    for num in C:
		# c (lower case) is the second output in this iteration
        c[num] = C[C[num]] 
    if (b == c).all():
        C = [x+1 for x in C]
        print('The answer is ', C)
        break

```

最精髓的部分是那句 $c[num] = C[C[num]], ​$ 之前为了实现相同的功能写了十几行代码，还是我看了CSDN那篇博文以后，才发现了这个规律。如果问题改成根据third output, 去猜first output也很简单。就是把$C[C[num]]​$ 加多一层就可以了， $c[num] = C[C[C[num]]]. ​$ 如果题目是不同的数字，就把b和a的长度改一下，so easy.

这个程序大概跑了一天，最后跑出来了(巨汗)，给大家展示一下

![运行结果](/img/20190316091702.png) 

输出为 $[6, 12, 9,10, 3, 8, 5, 4, 13, 11, 2, 7, 1]. ​$ 

它的含义是, 序列a $[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] $ 表示原始输入 SUPERBGOLDHAT 的对应的index，即1代表S，2代表U，以此类推。而输出序列$[6, 12, 9,10, 3, 8, 5, 4, 13, 11, 2, 7, 1], $ 代表first output的序列。

到这里就解出来了，按index逐字翻译，答案是 BALDPORETHUGS. 

Over！


但计算机真的算得太慢了，补上我新学的人脑解法 ^ _ ^

![不知道为什么PO上来就歪了](/img/20190316094941.jpg)

 