<div align="center">

# OMSLS

</div>

一个自动化选择MC通用优化的启动脚本，在同等内存分配的情况下可以比无任何优化降低更多负载<br/>
并且在使用Java21 ZGC时可以有效缓解区块内存泄漏，能控制住膨胀，这也得益于ZGC各种新设计<br/>
以我的长期测试下来，涵盖了Java11到Java21，对比了三大热门GC（G1GC SGC ZGC），测试了原版插件服到重型整合包服，可以结论出，无论是服务端还是客户端MC，Java21的分代ZGC已经可以开始接任G1GC<br/>

# 当前支持范围和策略

|版本|GC|状态|
|:-|:-|:-|
|Java8|G1GC|已完成|
|Java11|G1GC|已完成|
|Java17|G1GC|已完成|
|Java21|ZGC|已完成，等待进一步优化|

|MC版本|建议|
|:-|:-|
|1.7+|Java8|
|1.16+|Java11|
|1.17+|Java17|
|1.20.5+|Java21|

推荐JDK：
<a target="_blank" href="https://adoptium.net/zh-CN/temurin/releases/">Adoptium JDK</a>
<a target="_blank" href="https://bell-sw.com/pages/downloads/">Liberica JDK</a>
<a target="_blank" href="https://www.azul.com/downloads/?package=jdk#zulu">Zulu JDK</a>

# 安装
1.下载仓库
```
git clone https://github.com/Yukiriri/OMSLS.git
```
2.将目录添加到环境变量或者其他可以直接启动的地方

# 更新
```
cd OMSLS
git pull
```
提示：在Windows平台建议把服关闭后再更新，这个涉及到win对bat读取的逆天机制/BUG

# 启动
|文件|说明|
|:-|:-|
|omsls     |不应该自己启动的核心脚本|
|omsls(xx)   |Java(xx)预设的启动脚本|
|omsls(xx)-ls|已将yggdrasil更改为littleskin的启动脚本|

- 命令格式

  omsls\<8/11/...\> \<jar\> \<Xmx\>
  - 例子
    ```
    omsls21 purpur.jar 4G
    ```
  - 提示：使用littleskin版本需要在上级目录放置authlib-injector.jar

# 学习参考
- <a target="_blank" href="https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft">Aikar's Flags</a>
- <a target="_blank" href="https://github.com/YouHaveTrouble/minecraft-optimization">YouHaveTrouble/minecraft-optimization</a>
- <a target="_blank" href="https://flags.sh">flags.sh</a>
- 群友大佬提供的参数

# 经验总结建议
  - 关于Java进程内存占用：
    - Java进程不仅仅只包括堆内存，还有非堆内存，以及外界API管理的内存
    - 例如：
        - 给服务端分配4G内存，在进程运行时候的内存占用大概是（堆4G + 非堆1G+ = 5G+占用）
        - 给客户端分配4G内存，在进程运行时候的内存占用大概是（堆4G + 非堆1G+ + OpenGL 2G+ = 7G+占用）

  - 关于开启大页内存：如果你的Host OS已经开启了大页，那么Container OS开不开都一样。如果你直接在Host OS运行服务端，那就需要自己手动配置LargePages

  - 其实Java17也可以用ZGC，但由于不能分代，每一次GC都等价于Full GC，对性能消耗比较大，所以我放弃了Java17开启ZGC

  - 关于TPS消耗：可以使用<a target="_blank" href="https://spark.lucko.me/download">spark</a>采集并导出插件/MOD占用耗时堆栈图，找出tick占用高的堆栈顺序里最先出现的插件/模组，然后怎么办不用我说（）

# 无用的吐槽

MC的内存管理着实差劲，而且再叠上JVM臭名昭著的GC这个debuff就更是双倍**，我已经不求MC的内存占用能低了，只要不内存泄漏就是万幸<br/>
其次我对垃圾回收语言也开始感到厌恶（尤其是基于JVM的语言），我不觉得延缓内存释放可以提升吞吐量，因为内存回收这种事逃不了，早回收晚回收都得回收，
全部集中在一起回收不还是把之前提升的吞吐量给还了回去，而且这一回收就会造成CPU占用尖峰，如果是常居CPU高占用的情况，这一尖峰会损失什么我不好说<br/>
然后就是垃圾回收语言的对象内存开辟一直都是向后地址开辟，不会在已回收对象的老地址上重新利用（除非后面的空间不够用），这种大缓冲区循环滚写式设计也注定内存占用不可能下去<br/>
