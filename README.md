<div align="center">

# OMCSL

</div>

一个自动化选择MC通用优化的启动脚本，在同等内存分配的情况下可以比无任何优化降低更多负载<br/>
并且在使用Java21 ZGC时可以有效缓解区块内存泄漏，能控制住膨胀，这也得益于ZGC各种新设计<br/>
以我的长期测试下来，涵盖了Java11到Java21，对比了三大热门GC（G1GC SGC ZGC），测试了原版插件服到重型整合包服，可以结论出，无论是服务端还是客户端MC，Java21的分代ZGC已经可以开始接任G1GC<br/>

# 当前策略范围

|MC版本|Java标准|对应GC|
|:-|:-|:-|
|1.7+|Java8|G1GC|
|1.16+|Java11|G1GC|
|1.17+|Java17|G1GC|
|1.20.5+|Java21|ZGC|

推荐JDK：
<a href="https://adoptium.net/zh-CN/temurin/releases/">Adoptium JDK</a>
<a href="https://bell-sw.com/pages/downloads/">Liberica JDK</a>
<a href="https://www.azul.com/downloads/?package=jdk#zulu">Zulu JDK</a>

# 效果参考

- G1GC
  ![](https://github.com/Yukiriri/OMCSL/blob/main/res/vanilla_g1gc.png?raw=true)
- ZGC
  ![](https://github.com/Yukiriri/OMCSL/blob/main/res/vanilla_zgc.png?raw=true)

# 待实现功能

- 自动判断大页开关来启用透明大页

# 安装

1.下载仓库
```
git clone https://github.com/Yukiriri/OMCSL.git
```
2.将目录添加到环境变量或者其他可以直接启动的地方

# 启动

|脚本文件|说明|
|:-|:-|
|omcsl|常规启动脚本|
|omcsl-ls|已将yggdrasil更改为littleskin的启动脚本|

提示：使用littleskin版本需要在上级目录放置authlib-injector.jar

|脚本参数|格式|传入方式|是否必须|
|:-|:-|:-|:-|
|jar|服务端jar文件名|命令行|必须|
|Xmx|堆内存大小|命令行|必须|
|JAVA_BIN|自定义java路径|环境变量|可选|

命令样例：
  - 使用命令行
    ```
    omcsl purpur.jar 4G
    ```
    ```
    omcsl-ls purpur.jar 4G
    ```
  - 使用环境变量
    - Windows bat脚本
      ```
      set JAVA_BIN=C:\Java\bin\java
      omcsl purpur.jar 4G
      ```
    - Linux shell脚本
      ```
      export JAVA_BIN=/opt/Java/bin/java
      omcsl purpur.jar 4G
      ```

# 更新

```
cd OMCSL
git pull
```
提示：在Windows平台建议把服关闭后再更新，这个涉及到win对bat读取的逆天机制

# 经验总结建议
  - 关于Java进程内存占用：
    - Java进程不仅仅只包括堆内存，还有非堆内存，以及外界API管理的内存
    - 例如：
        - 给服务端分配4G内存，在进程运行时候的内存占用大概是（堆4G + 非堆1G+ = 5G+占用）
        - 给客户端分配4G内存，在进程运行时候的内存占用大概是（堆4G + 非堆1G+ + OpenGL 2G+ = 7G+占用）

  - 其实Java17也可以用ZGC，但由于不能分代，每一次GC都等价于Full GC，对性能消耗比较大，所以我放弃了Java17开启ZGC

  - 关于TPS消耗：可以使用<a href="https://spark.lucko.me/download">spark</a>采集并导出插件/MOD占用耗时堆栈图，找出tick占用高的堆栈顺序里最先出现的插件/模组，然后怎么办不用我说（）

# 学习参考

- <a href="https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft">Aikar's Flags</a>
- <a href="https://github.com/YouHaveTrouble/minecraft-optimization">YouHaveTrouble/minecraft-optimization</a>
- <a href="https://dev.java/learn/jvm/tool/garbage-collection/zgc-overview/">https://dev.java/learn/jvm/tool/garbage-collection/zgc-overview/</a>
- <a href="https://flags.sh">flags.sh</a>

# 无用的吐槽

MC的内存管理着实差劲，而且再叠上JVM臭名昭著的GC这个debuff就更是双倍**，我已经不求MC的内存占用能低了，只要不内存泄漏就是万幸<br/>
其次我对垃圾回收语言也开始感到厌恶，我不觉得延缓内存释放可以提升吞吐量，因为内存回收这种事逃不了，早回收晚回收都得回收，全部集中在一起回收不还是把之前提升的吞吐量给还了回去<br/>
然后就是垃圾回收语言的对象内存开辟一直都是向后地址开辟，不会在已回收对象的老地址上重新利用（除非后面的空间不够用），这种大缓冲区循环滚写式设计也注定内存占用不可能下去<br/>
