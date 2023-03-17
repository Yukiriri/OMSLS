<div align="center">

# OMSLS

</div>

参考了各种社区提供的优化参数并合并整理的启动脚本，可对默认无调优带来显著提升。 <br/>
其中：G1GC的消耗时间短；ZGC的消耗时间长，但回收好像更彻底一些，嗯，也可能没有（ <br/>
脚本内有一些JDK17才具备的参数，如果你需要在更低的JDK版本使用，删除无法使用的参数即可。 <br/>

# 安装

- 1.下载合适的启动脚本
- 2.安装到可以启动的地方

# 启动

- 参数格式
  - omsls &lt;jar&gt; &lt;Xmx&gt; [Xms]
    - jar: 服务端.jar
    - Xmx: 最大堆内存
    - Xms: 最小堆内存（可选，不填则等于Xmx）
- 用法例子
  - 分配固定4G大小的堆：omsls purpur.jar 4G
  - 分配最大4G最小1G的堆：omsls purpur.jar 4G 1G
  - （推荐使用固定堆大小）

# 参考数据

- 环境

  | OS | Ubuntu 22 |
  | :-: | :-: |
  | JDK | <a href="https://dragonwell-jdk.io/">Alibaba Dragonwell</a> 17 |
  | 服务端核心 | <a href="https://purpurmc.org/">Purpur</a> 1.19.3 |
  | 测试方式 | 330实体混战（掠夺者，旅商+羊驼） |

- 数据

  | | 分配(Xmx,Xms) | 启动内存 | 游玩内存 | mspt(avg,max) | GC平均暂停 | GC平均用时 |
  | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
  | G1GC | 4G | 4.5G | 4.7G | 6.5,14.4 | 12ms | 12ms |
  | G1GC | 4G,1G | 1.4G | 1.9G | 7.6,21.7 | 4ms | 4ms |
  | ZGC | 4G | 4.5G | 4.7G | 7.4,21.1 | 0ms | 353ms |
  | ZGC | 4G,1G | 3.1G | 1.8G | 7.9,17.0 | 0.1ms | 353ms |

# Credits

- <a href="https://docs.papermc.io/paper/aikars-flags">Aikar's Flags</a>
- <a href="https://www.bilibili.com/read/cv2883377">TIS</a>
- 群友大佬提供的参数
