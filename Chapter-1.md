# C1-人生若只如初见：初识 SAS

清代词人纳兰性德曾有词曰“人生若只如初见，何事秋风悲画扇”。从初识 SAS 到如今每天的工作都和 SAS 纠缠不清，按理来说我和 SAS 应该早已过了“人生若只如初见”的美好阶段，但是每次当我有疑惑再去查阅 SAS Help 文档、琢磨 SAS 时却常有“日暮北风吹雨去，数峰清瘦出云来”的惊喜。我不知道以后我会不会将 SAS 当成秋扇束之高阁，但目前我还有些激情和热血，那就趁热记录、分享一下这一路走来和 SAS 的点点滴滴吧。

## 1.1 往事并不如烟
关于 SAS，这里面有很多有意思的往事。从简简单单的名字发音，到颇为有趣的公司历史，再到刀光剑影，快意人生的网络江湖，每一个话题都值得煮一杯清酒开怀畅谈。

###  1.1.1 逗你玩的发音
第一次听说 SAS（Statistical Analysis System）是在本科的统计软件包课上，当时我以为老师说的是 SARS（Severe Acute Respiratory Syndrome，严重急性呼吸综合征），因为老师的发音大概就是“萨死”，这不禁让我想起 2003 年刚经历的那场不堪回首的全民浩劫“非典”。

后来，我才留意到原来我们的英语发音是多么的糟糕，或者说是多么的随意。 SAS 的正式发音大概是“赛死”，所以 SAS 公司在中国注册的中文企业名用的是 “赛仕”，而SARS 的正确发音是“萨而死”，因为中间有卷舌音。更让人啼笑皆非的是 SPSS 的读法，很多统计老师即便是在大庭广众之下也毫无羞涩地脱口而出“死怕死”，其实由于 SPSS没有元音字母，正确的发音应该是“爱死辟，爱死爱死”。

### 1.1.2 有点趣的历史

关于 SAS（Statistical Analysis System）这一词可以有多种层次的解读。 SAS 可以是业界最负盛名的一个统计分析系统，也可以是一门德高望重的统计编程语言，还可以是一个颇具传奇色彩的商业分析软件与服务供应商。

SAS 作为一个统计分析系统和一门统计编程语言，要远早于其作为一家商业公司 (见图 1-1)。1966 年，美国农业部（United States Department of Agriculture , USDA）把海量农业数据的计算机化和统计分析需求委托给大学统计师南方实验站（University StatisticiansSouthern Experiment Stations），希望开发出一种具有综合用途的统计软件包，以便分析他们获取的所有农业数据。这个试验站联盟了以北卡罗莱纳州立大学（North Carolina StateUniversity, NCSU）为主的八家政府资助大学，他们从美国农业部获得科研经费，并从美国国立卫生研究院（National Institutes of Health, NIH）获得了一笔捐赠，最终的研究成果即统计分析系统（Statistical Analysis System, SAS）。北卡罗来纳州立大学的教职员工Jim Goodnight 与 Jim Barr（Jim Barr 又名 Anthony James Barr, Tony Barr ）为项目负责人，Jim Barr 创造了整个项目框架，而 Jim Goodnight 则负责实施框架之上的各种特性，并拓展了系统的功能。 1972 年 NIH 终止了资助之后，试验站联盟的成员们同意共同出资，每个成员每年出资 5000 美元， NCSU 也由此得以继续开发并维持系统运作，从而支持其统计分析需求。此后， NCSU 的统计系雇员 Jane Helwig、研究生与程序员 John Sall 也加入了该项目。1976 年，他们离开 NCSU，在大学的对面希尔博拉大街 2806 号的一幢办公楼里组建了私人公司 SAS 研究所（SAS Institute Inc.）。 SAS 公司成立早期， Jim Barr、 JimGoodnight 和 John Sall 三人负责敲代码， Jane Helwig 则负责 SAS 文档的规划和书写 （见图 1-2）。目前， Jim Goodnight 仍然是公司的 CEO， John Sall 已经是公司的二把手，他还一手缔造了 SAS 软件的兄弟产品 JMP。 Jim Barr 后来单飞，又创立了 Barr Systems 公司，关于 Jane Helwig，但网上信息寥寥。  

SAS 公司成立当年，他们做了两件大事：一是发布了第一个商用版本 SAS 软件；二是举办了第一届 SAS 用户国际组会（SAS Users Group International, SUGI）。这两件事无论是对 SAS 公司还是对 SAS 用户来说都意义深远。 SAS 软件发布一年后，便入榜Datamation 杂志举办的 DataPro 软件光荣榜，此后三年仍位列榜上。 SAS 软件系统自发布到现在，经历了很多变革。早期版本的 SAS 运行于大型机上， 1985 年 SAS 公司发布了运行于 PC DOS 版本的 SAS 5， 1988 年发布了用 C 语言全部重写的 SAS 6，并开始支持Windows 操作系统， 2000 年 SAS 8 开始支持 Linux 操作系统，目前（2017 年） SAS 软件最新版本是 9.4，包含了支持高性能统计建模、分布式内存计算、可视化统计分析等诸多适应大数据时代的新特性。更多关于 SAS 软件的历史，推荐 SAS 官方的 2 分 24 秒宣传视频：SAS Timeline: A History of the Analytics Leader。  

SUGI 自第一届成功举办以来，每年参加的人数都迅猛上升，成为全球 SAS 用户分享交流的盛宴。 2007 年 SUGI 更名为 SAS 全球论坛（SAS Global Forum, SGF）后，吸引了全球更多行业的 SAS 用户参与分享交流。现如今， SAS 公司仍然是全球最大的商业分析软件与服务供应商，据说 Jim Goodnight 为了保持公司的独立发展战略，一直拒绝上市，在传统的统计软件公司要么消失、要么被合并的洪流中， SAS 公司竟然保持了一枝独秀的状态。目前 SAS 公司全球雇员超过 1 万多名，客户遍及全球 149 个国家，应用领域涉及银行、政府、服务、保险以及生命科学等各行各业（见图 1-3）。 SAS 公司凭借其卓越的表现将诸多殊荣收入囊中，如“在职母亲最适宜公司”“全球最佳雇主”“最受欢迎的百强企业”……这与其创始人 Jim Goodnight 的人才理念不无关系： If you treat employees as if they make a difference to the company, they will make a difference。  

2000 年 SAS 公司启用新的 Logo 和标语： THE POWER TO KNOW®。通过数据，探知世界，这是数据分析的终极目的，提供探知的力量，这是 SAS 所努力的方向。关于这个宣传语，同样推荐 SAS 公司官方宣传视频： Know all the possibilities with SAS® HighPerformance Analytics。

###  1.1.3 逝不去的江湖
介绍 SAS 的历史，毕竟不是笔者分内的事，聊聊网络江湖中 SASor（SAS 爱好者）的快意恩仇，不失为乐事一件。  

在微博、微信还没有崛起的年代，网络论坛（Bulletin Board System， BBS）一统天下。在论坛里注册个名号，就像武林人士有了个绰号：比如行者武松、浪子燕青、花和尚鲁智深、一丈青扈三娘什么的，就可以在网上行走江湖了。 SAS 武林，最早可能是在 imoen 创立的 SASOR 论坛（www.sasor.com ）里，里面的风云人物如 SAS_Deam、 data _null_ 等。关于 SAS_Deam，网上的痕迹很少，目前可以找到的只有其两篇文章——《关于 SAS 的零碎印象》和《SAS 语言管窥》； data _null_ 在 UGA 大学邮件列表 SAS-L 还有活动记录。 Shiyiming 建立的 SAS 中文论坛（http://www.mysas.net/ ）和 sxlion 倒腾的 SAS 资源资讯列表（http://saslist.net/ ）也是承载了很多 SASor 记忆的地方。人大经济论坛的 SAS 专版（http://bbs.pinggu.org/forum-68-1.html ）可能是目前少有的还在和微博、微信抢流量，做垂死挣扎的网络论坛。

网络论坛里有一大批熟悉的 ID，通常为了解决一个小问题，各路大神前赴后继贴代码，只为一比高下，就像武林人士的擂台赛，好生热闹。在微博、微信一统天下后，转发和点赞成为常态，拼代码、讨论帖子已然成为过去。这正如 sxlion 所写的：“可惜美好的时光不长久，春去秋来，草长莺飞。论坛 ID 后面一个个现实生活中的 SASor，或结婚生子，或迁徙他乡，或跳槽转行，人生变幻，几度春秋，论坛里新人经常有，故人不常在。美好时光，竟成稀缺的回忆。”好在论坛里沉淀的帖子记录下了岁月的痕迹，论坛虽然逐渐消逝，但微信公众平台或者其他网络社群会随即出现， SASor 也会不断更替。常言道，有人的地方就有江湖，人就是江湖， SASor 还在， SAS 的江湖如何逝去？

##  1.2 选择一厢情愿
如果我们只是想“放一枪”就走人，断定以后几乎再也不会“拿枪”了，那么可能用SPSS 会更合适我们；如果我们想做一个专业“抢手”，那就应该选择更专业一点儿的武器。古语有言曰“工欲善其事，必先利其器”，诚然，一个合适的统计分析工具可以让我们的统计分析工作事半功倍，而一个蹩脚的统计分析工具则有可能浪费我们大量宝贵的时间和资源。目前的统计分析软件，主要分两大类：一类基于图形用户界面（Graphical User Interface， GUI）（如 SPSS）；另一类基于命令行界面（Command Line Interface， CLI）（如SAS、 R 及 Stata）。 GUI 和 CLI 两种形式各有优劣， GUI 通过点击菜单完成数据处理和统

计分析，对于非统计人员来说，操作简单容易，但其可重复性差，也不便留痕和记录，此外，菜单式的界面能容纳的统计过程和选项有限，无法快速跟进学科的发展； CLI 则通过命令行或者编程语言完成数据处理和统计分析工作，作业过程灵活，对于自动化和重复性作业有明显优势，适合统计专业人员，更重要是非常契合现在越来流行的“可重复性研究”（Reproducible Research）的理念。

SAS 软件作为老牌的统计软件，能够称霸统计界，且至今仍然独立运营，实属罕见。在大数据时代， SAS 软件也在与时俱进，开发了很多适应大数据处理的功能和产品，如SAS 网格计算（SAS® Grid Computing）、库内计算（SAS® In-Database）和内存计算（SAS®In-Memory Analytics），等等。虽然 SAS 的安装文件庞大，安装过程也较为费劲，但是这些一劳永逸的付出会让我们在后期觉得这是值得的，至于我们所担心的昂贵的费用问题，那就交给财大气粗的雇主吧。如果没有有钱的雇主，那就用大学版（SAS University Edition）吧，如果连大学版也懒得安装，还可以尝试免费的云端统计分析平台 SODA（SAS®OnDemand for Academics）。反正作为程序员和统计师，不必为软件费用埋单的问题担忧。此外，如果希望进入生物医药领域，特别是临床试验领域，那必需赶紧倒腾 SAS，越早越好。当然，如果你已经习惯了其他 CLI 的统计软件，笔者也不是非要苦口婆心的来劝你改用 SAS，这不是本书的目的。但是，若果你要用或者正在用 SAS，那本书所讨论的一些内容，可能正是你不愿错过的。

## 1.3 软件架构
通常，大众口中所言的 SAS 软件其实是指 SAS Foundation+Windows 的视窗管理系统（Display Management System, DMS）。 SAS Foundation 包括 Base SAS、数据管理和访问、数据分析、报告和图表、可视化和发现、商业解决方案、用户界面、应用扩展以及 Web应用等组成部分，其中 Base SAS 是核心。 SAS 软件的设计思路是在 Base SAS 的基础上，再配合特定的模块完成特定的任务需求。例如，要做统计分析，那就配合使用 SAS/STAT模块；要绘制统计图形，那就配合使用 SAS/GRAPH 模块；要导入各种外部数据，那就配合使用 SAS/ACCESS 模块；要做时间序列分析，那就配合使用 SAS/ETS 模块；要做基因分析；那就搬出 SAS/GENETIC 模块。最基础的 SAS 软件，只需要 Base SAS、 SAS/STAT、 SAS/GRPAH 模块。随着数据分析需求的增加， SAS 公司不断推出各种新的模块、新的过程以及新的选项，据不完全统计，目前 9.4 版本的 SAS 功能模块总计已达 75 个。常见的 SAS 模块及其功能见表 1-1。

表 1-1 常见 SAS 模块及其功能简介
|模块名称 |功能简介|主要过程|
| ------------- |:-------------:| -----:|
| Base SAS    |  SAS 系统的核心模块，是运行 SAS 必须的模块。由 DATA 步、 PROC 步、 MACRO、ODS 以及 SAS 的窗口环境组成    |  基 础 的 统 计 过 程 FREQ、 MEAN、 CORR及 UNIVARIATE； ODS 绘图过程 SGPLOT、SGPANEL、 SGRENDER   |
|  SAS/ACCESS   |  与第三方数据源（各种关系型数据库）进行交互的模块；不同的数据源，需要单独的软件使用许可，如与 Excel 数据交互需要 ACCESS TO PC FILES 组件的许可   |  导 入 导 出 过 程 IMPORT、 EXPORT 以 及ACCESS 和 DBLODAD 过 程， LIBNAME语句   |
|  SAS/STAT   |   统计分析模块，总计已有 75 个统计分析过程，还在不断更新补充中。 SAS 的“权威”性就在于这些统计分析过程  |  经 典 统 计 分 析 过 程 t 检 验（TTEST）、方 差 分 析（ANOVA）、 回 归（REG）、一般线性回归（GLM）、广义线性回归（GENMOD）、混合效应模型（MIXED）、聚 类（CLUSTER、 VARCLUSTER、FASTCLUS）、判别（DISCRIM）、因子（FACTOR）、 主 成 分（PRINCOMP）、Logistic 回 归（LOGISTIC）、 生 存 分 析（LIFETEST、 LIFEREG、 PHREG）   |
|   SAS/GRAPH  |   绘图模块，绘制常见统计图形  |  GCHART、 GPLOT、 GBARLINE、 G3D 等   | 
|  SAS/ETS   |  时间序列分析模块   |  ARIMA、 AUTOREG、 COUNTREG、QLIM、 ESM、 UCM、 MODEL 等   |
| SAS/IML    | 矩阵语言模块    | IML    |
|   SAS/GENETIC  |  基因分析模块   | ALLELE、 CASECONTROL、 FAMILY、PSMOOTH 等    |
| SAS/OR    |  运筹与优化模块   |  LP 、 NLP 、 OPTLP 、 OPTMILP 、OPTNET、 OPTMODEL 等   |

在大数据时代的浪潮下， SAS 不断扩展其功能组件和产品， SAS® Visual Analytics,  SAS® Visual Statistics, SAS® Cloud Analytics,SAS® Viya 等一大批迎接大数据时代数据分析处理需求的产品也逐渐进入程序员、数据挖掘人员、统计分析师以及数据科学家的视野。不过，对于常规的程序员和统计分析师而言， Base SAS +SAS/ACCESS + SAS/STAT+SAS/GRAPH 已基本能满足需求。

## 1.4  安装与许可
SAS 可以安装在本地，也可以部署在服务器上，无论哪种方式，要想使用 SAS 软件及其模块，需要：①安装模块：比如想要导入 Excel 文件，就必须安装 SAS/ACCESS to PC files 模块；②获得许可：光是安装了模块还不行，还必须有使用此模块的权限。关于模块的使用权限，可以通过 SAS 安装数据文件（SAS Installation Data, SID）获得， SID 就相当于其他软件的注册码。

SAS 公司在销售策略上是，将基础的功能模块打包（SAS/BASE、 SAS/ACCESS、SAS/STAT、 SAS/GRAPH），并提供相应模块的 SAS 安装数据文件，用户以租赁的形式获得软件安装包和许可文件，这就是坊间流传的“SAS 只租不卖”。如果需要更多的功能模块，则需要在订单中增加相应的模块才可以获得其安装介质和 SID。

SAS 公司给安装介质时，一般会邮寄安装光盘。光盘的数量可能会与订购的模块多少有一定关系，一般在 6 ～ 7 张，每张约 4GB 大小。安装时，建议先用 UltralISO 软件把光盘里的内容直接抓取出来打包成 ISO 文件（见图 1-4）：一则可防止光盘损坏；二则也方便安装，因为用虚拟光驱安装，免去了在光驱里来回更换安装光盘的麻烦。

用虚拟光驱软件 Daemon Tools Lite 打开第一张光盘，在 SAS 安装文件夹 install_doc文件夹下，可以看到一个以数字和字母组合而成的 6 位字符命名的文件夹，此即订单号文件夹，其中的 SOI.HTML 文件即 SAS 订单信息（SAS Order Information）文件，里面包含了购买的 SAS 产品和模块的摘要信息，通过此文件可以了解到用户购买了哪些模块，也即安装文件包含了哪些模块。例如，某研究中心的 SOI 信息如图 1-5 所示，通过此文件可以看到该中心不仅订购了可以导入 Excel 文件的 SAS/ACCESS Interface to PC Files，还购买了 DB2、 Hadoop、 MySQL 等其他众多数据库接口，在统计分析模块里，除了常规的统
计分析模块 SAS/STAT、还购买了矩阵运算模块 SAS/IML、时间序列模块 SAS/ETS 以及运筹模块 SAS/OR 等。

如果 SAS 软件已安装完成，则可以通过编程的方法（PRODUC_STATUS 和 SETINIT过程，详见程序 1-1）查看安装了哪些模块（见图 1-6），获得了哪些模块的许可（见图 1-7）。如果希望查看更完整的安装报告，可以在网上搜宏程序 %sasinstallreporter，运行此程序，即可在 Log 文件中看到 SAS 已经安装的模块、许可的模块及其有效日期（如果现在还对运行代码感到陌生，可以等读完 1.6 后回过头再来测试）。

程序1-1 查看SAS安装、许可的模块
```SAS
*===带*号的行是注释行===;
*===查看SAS已安装的模块;
proc product_status;
run;
*===查看SAS已许可的模块;
proc setinit;
run;
*===查看完整安装报告;
*===SAS程序文件地址依据存储位置自行修改;
%include " D:\03 Writting\01 SAS编程演义\03 Code\fusion_20390_1_
sasinstallreporter4u.sas";
%sasinstallreporter;
```

## 1.5  运行模式
SAS 有多种运行模式——窗口环境模式、非交互式模式、批处理模式及交互式行模式，各模式简要介绍如下:
* 窗口环境模式：是在SAS的视窗管理系统（Display Management System, DMS）下，用户编写SAS程序、提交运行SAS程序、查看日志及结果的模式，这是Windows平台优势模式，也是广大用户最为常用和熟知的模式。
* 非交互式模式：主要用于在不启动DMS的情境下，直接运行保存在SAS软件外部文件中的SAS程序，并将结果和日志保存在指定的位置。
* 批处理模式：可以对SAS 作业进行预定执行，如定期自动运行某程序，在商业智能解决方案中这种模式较为常用。
* 交互式行模式：是UNIX操作系统使用的一种顺序地输入程序语句的运行模式，是一种使用较少的模式。

## 1.6  编程界面
]本书将以最为常用的、 SAS 自带的窗口环境模式为例进行展示。在窗口环境模式下，编程环境和界面其实也有多种选择：①视窗管理系统（Display Management System，DMS）；② SAS 企业版（Enterprise Guide， EG）；③ SAS 工作室（SAS Studio）。如果安装完全，在 Windows「开始」菜单下，可以看到三种界面的启动链接，如图 1-9 所示。

### 1.6.1 DMS界面
DMS（Display Management System, 视窗管理系统）是 SAS 初学者最为常见的编程界面，如图 1-10 所示。 DMS 的五大部分为 Eidtor（编辑器窗格）、 Log（日志窗格）、Ouput（输出窗格）、 Results（结果窗格）以及 Explorer（资源管理器），可以通过底部的选项卡切换。

### 1.6.2 EG界面
SAS EG （Enterprise Guide）是基于客户端 / 服务器（Client/Server）架构的客户端，可从从项目工程角度管理相关资源，其界面主要由项目树、工作区、资源窗格组成，如图 1-11 所示。与 DMS 中类似的 Code（程序）、 Log （日志）、 Results（结果）均在工作区内。

### 1.6.3 SAS Studio 界面
SAS Studio 基于浏览器 / 服务器（Browser/Server， B/S）架构的浏览器来实现与SAS 本机服务器的交互。 SAS Studio 由左侧的导航面板和右侧的工作区组成，如图 1-12所示。工作区同 SAS EG 类似，有与 DMS 中类似的 Code（程序）、 Log （日志）、Results（结果）。

SAS DMS、 SAS EG 和 SAS Studio 三种编程环境，究竟有何区别？如何选择呢？其实三者在编程语言上并没有什么区别，不过后两者在编程界面、功能上有很多的改进。三者间更多的区别，可见表 1-2 的总结。

表 1-2 SAS 三大编程环境简要比较
|  维 度  |  SAS DMS  | SAS EG  |SAS Studio   |
| --- |--- |--- | --- |
|  界面组成   | 五大窗格：编辑器、日志、输出、结果、资源管理器    |  三大窗格：工作区、项目树以及资源窗格   |   两大区域：工作区和导航面板  |
|  软件架构  |  图形用户界面（GUI），集数据存取、代码执行和结果交付为一体的编程环境客户端   | 客户端 / 服务器（C/S）架构，需要 SAS 服务器（可以在本地）存取数据、执行代码    |  浏览器 / 服务器（B/S）架构   |
|  平台支持    |  Windows、 UNIX、 Linux、 Z/OS   | Windows    |  Windows、 UNIX、 Linux、MacOS   |
| 语法提示  | 除了语法着色，作为一款编程编辑器，在很多方面确实差强人意    | 语法着色、自动补全、语法提示、格式化代码、警告及错误定位    |  语法着色、自动补全、语法提示、警告及错误定位   |
|  优势   |  支 持 % WINDOW、 DDE、 X 命令以及 DM 命令等；反应速度比C/S、 B/S 架构快；自定义宏键盘   |存储过程、工作流、代码生成器；图形化的菜单操作比DMS 更丰富，也更方便     |   工作区与 EG 类似；导航面板功能丰富；任务模板，代码片段比较有特色  |
|  不足   | 语法编辑器功能太单一，基本只有语法着色一项功能    | 反应速度慢，部分 DMS 支持的功能如 % WINDOW、DDE、 X 命令、 DM 命令等它不支持    |  反应速度较慢，部分 DMS 支持 的 功 能 如 % WINDOW、DDE、 X 命 令、 DM 命 令 等它不支持   |

总体而言， SAS DMS最为传统，速度最快。SAS EG和 SAS Studio具有良好的语法提示、自动补全等功能，可以在学习 SAS 代码，提升编程效率方面给初学者更多帮助。如果是初学者，建议不妨多在 SAS Studio 里尝试编程，如果追求测试效率，建议在 DMS 里开发，当然，至于最终的选择，可以依据个人喜好和具体业务而定.

## 1.7  版本
SAS 在启动时会在日志窗格中显示软件版本号以及相应模块的版本号。在启动后，我们也可以通过宏变量 &SYSVER 或者 &SYSVLONG 获得其版本号，如图 1-13 所示。

程序1-2 获取SAS版本号

```
%put SAS 版本号： &SYSVER;
%put SAS 版本号（长）： &SYSVLONG;
```
一直以来， SAS 的版本更新比较谨慎，甚至可以说是缓慢。胡江堂和 Rick Wicklin 曾 17经在博客上统计过 SAS 8.0 到 SAS 9.4m4 的发布日期，并制成了图片，如图 1-14 所示，近年来 SAS 虽然没有大版本的更新，但是小版本更新的速度却在不断加快。

### 1.7.1 购买版与大学版
除了上面介绍的版本区别， SAS 还有购买版与大学版的区别（不知道官方具体的称谓，姑且这样描述），以及启动时加载各种语言配置版本的区别。

SAS 购买版按模块收取年费，而 SAS 的大学版（SAS University Edition）是免费供大家下载使用的。 SAS 大学版本质上是用虚拟机打包的 Redhat 系统里的 SAS，采用 B/S 架构的 SAS Studio 连接，包含了 BASE、 STAT、 ACCESS、 IML 以及 HPS 模块，但是遗憾的是，没有 GRAPH 模块，不过如果熟悉 ODS GRAPH 的话，基本可以不用 GRAPH 模块画图 ，具体可参见本书第 8 章的介绍。

### 1.7.2 免费云端版
如果既没有购买 SAS，也不愿意下载大学版，甚至连安装都嫌麻烦，我们还有什么办法可以用 SAS 吗？确实有，那就是 SODA——一个免费云端版的 SAS，只要有网络，我们就可以随时随地用 SAS 写代码。

SODA（SAS® OnDemand for Academics）是 SAS 为学术界人士免费提供的在线的、基于 SAS 私有云上的应用服务环境。利用 SODA，我们可以随时随地地在 SAS Studio中编写运行 SAS 代码，而且所有数据和代码都可以存储在云端，所有结果均可以下载保存，每个账号用户有 5120MB 的存储空间。 SODA 可以说是懒人学习 SAS 最方便、快捷的低成本途径了。如果你手头还没有 SAS，而有了 SODA，照样可以一起愉快地学习 SAS。

要 使 用 SODA， 首 先 需 要 到（https://odamid.oda.sas.com） 进 行 注 册（ 如 果 以 前有 SAS 社区的账号则可直接登录）。注册流程非常简洁，只需姓、名、邮箱、国籍几项信息即可。注册成功后，稍等片刻会收到一封名为 You are ready to start using SASOnDemand for Academics 的邮件，里面有登录 SODA 的用户名（通常是邮箱的前缀）。登录后，单击 SAS Stduio 应用（见图 1-15），即可进入 SAS Studio 编程环境，开启免费云端之旅。

此 SAS Studio 的界面（见图 1-16）同本机 SAS Studio 的界面结构（上端的菜单栏、左侧的导航面板、右侧的工作区）几乎一致。不过，其内核可能是不同的，单击右上角问号，查看关于 SAS Studio 的信息，可见此 SAS Studio 的后台是 Linux 系统下的 SAS 9.04.01M3版本，这已经是目前最新版的 SAS 了。我们在程序标签页下运行「Proc setinit; run;」，看看许可了哪些模块。测试结果发现除了常规的 BASE SAS、 SAS/STAT、 SAS/GRAPH、 SAS Enterprise Guide 外， SAS/IML、SAS/ETS、 SAS/OR、 SAS/QC、 SAS/CONNECT 等模块也都赫然在列，甚至连数据挖掘和文本挖掘的产品 SAS Enterprise Miner、 SAS Text Miner 以及可视化分析产品 SAS VisualAnalytics Hub、 Visual Analytics Explorer、 SAS Visual Analytics Services 都囊括其中，不得不说， SAS 公司此举诚意满满。

如图 1-17 所示，通过右击左侧的「文件（主目录）」，我们还可以上传自己的数据文件到云端，然后在右侧工作区写代码、运行代码、获取分析结果。数据和代码可以保存在云端，下次登录后仍可利用，而分析结果和中间数据则可以下载到本地，具体可参考SAS 公司大数据与可视化分析产品线负责人巫银良先生的文章：《从程序员到数据科学家：SAS 编程基础 （04）》，本节不再赘述。

### 1.7.3 各操作系统平台版
SAS 目前支持的操作系统平台包括 z/OS、 UNIX、 Linux 以及 Windows，各操作系统版本与其兼容的 SAS 版本具体可在 SAS 官网（http://support.sas.com/supportos/list）页面System Requirements 下的 Supported Operating Systems 里查阅。苹果电脑 MacOS 系统目前没有相应的 SAS 版本，如果想在苹果系统中使用 SAS，有三种策略可供参考：①虚拟机软件 +Windows+SAS；②虚拟机软件 +SAS University Edition；③免费在线云端版本 SODA。或者干脆选用 SAS 兄弟产品 JMP 软件。

### 1.7.4 各语言版
如果在安装过程中，选择了中文语言包，配置了 Unicode Support 的话，在开始菜单里我们就可以有多种语言版本的 SAS 可供选择：①英文版；②中文版；③带 DBCS 的英文版；④ Unicode Support 版，如图 1-18 所示。需要留意的是，如果希望我们的 SAS 支持中文字符的话，那么就选择后面三个吧；如果我们希望既能支持中文字符，又想在英文环 21境下使用 SAS，那就选择带 DBCS 的英文版，带 DBCS 的英文版的优势是可以获得英文版的提示信息，方便后续在 SAS Help和搜索工具里检索相关信息，因此，笔者个人推荐此版本。

## 1.8  本章小结
本章从闲聊 SAS 的八卦和历史开始，谈及选择 SAS 的理由，并着重对 SAS 软件进行了一个概要式的说明。通过本章的介绍，希望我们能够从感性上对 SAS 软件的架构、安装技巧、许可文件、运行模式、编程界面以及版本有一个初步的了解。
