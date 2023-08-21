<div align="center">

# OMSLS

</div>

已重构准备大更ing，介绍还没写完（） <br/>

# 当前支持范围和策略

|版本|GC|状态|
|:-|:-|:-|
|Java8|G1GC|✅|
|Java11|G1GC|✅|
|Java17|ZGC|✅|
|Java21|ZGC Gen|dev|

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
提示：在Windows平台建议把服全部关闭后再更新，这个涉及到win对bat读取的逆天机制/BUG

# 启动

|文件|说明|
|:-|:-|
|omsls|不应该自己启动的核心脚本|
|omsls8|Java8专版的启动脚本|
|omsls11+|Java11+版本的启动脚本|
|omslsxx.ls|已将yggdrasil更改为littleskin的启动脚本|

- 命令格式

  omsls\<8/11/...\> \<jar\> \<Xmx\> \[Xms\]

- 运行例子

  1.分配固定4G堆大小
  ```
  omsls17 purpur.jar 4G
  ```
  2.最高分配4G堆大小，闲时尽可能缩减至2G（需要使用ZGC）
  ```
  omsls17 purpur.jar 4G 2G
  ```

# 学习参考

- <a href="https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/">Aikar's Flags</a>
- <a href="https://github.com/brucethemoose/Minecraft-Performance-Flags-Benchmarks">brucethemoose/Minecraft-Performance-Flags-Benchmarks</a>
- <a href="https://www.bilibili.com/read/cv2883377">TIS</a>
- 群友大佬提供的参数
