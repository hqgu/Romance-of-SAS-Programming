# 0-作者序
蠢蠢欲动一年，奋指敲键三月，夜深人静百天，所幸的是这本书稿没有胎死腹中，终于写完了。动笔之前，我曾异常兴奋，我自以为满腹经纶无处释放的日子从此结束。完稿以后，我却沉静了，在接连填了一个又一个自己挖的坑以后，猛然抬头，发现后面其实还有更大的坑要去填，于是乎内心不禁更加焦虑。不过我很感激这份焦虑，虽然它不足以保证我所写出来的文字和代码是字字珠玑，篇篇精华，但是因为它，我可以挺起胸膛，拍着胸脯说：10 章专题 10 多万字，近 180 张图片、 30 多张表格和 200 多段代码， 20 多张语法卡片、 30个原创实用宏程序，这些都是热血铸就的良心作品，最起码它对得起我当初出发时的那份心意。

## 缘起
我还记得初学 SAS 编程时，因为看不懂 SAS Help 而懊恼，因为不理解 @ 与 @@ 的区别而苦恼，因为分不清宏变量的 %STR 、 %NRSTR、 %QUOTE、 %BQOTE、 %NRQUOTE以及 %NRBQUOTE 等诸多 quoting 函数而哀伤。然而，光阴似箭，似水流年，这才不过几年光景，那个曾经面对这些“简单问题”而烧心的少年，在面对后来同样烧心的学弟学妹时竟然一脸诧异：“啊？这个应该很容易理解的吧！” 你看，时间是多么的狡诈，它就这样轻易地抹平了我们学习过程中的苦与痛，当我们走得越远，当初的苦与痛就忘记得越多。庆幸的是，我不是什么大神，走得也不远，那些苦与痛还没有忘得一干二净，那就趁现在，赶紧记录下来，分享出来吧。

## 问题
此前知乎里有一个提问： SAS 入门书籍有哪些值得推荐？在回答里我把 SAS 学习分成了三类（点到即止，套 PROC 型；深入应用，编程统计型；走火入魔，开发工具型）并推荐了相应的书籍。在整理市面上 SAS 相关的书籍时，我总结了三个缺陷：①专门介绍数据整理与图表呈现的书太少、太零碎，即便有，也鲜有高质量者；②几乎都采用语法关键词按字典式的编排方式论述，缺乏从实际问题凝练的良好专题；③编程技术与使用场景割裂，讲技术者纯讲技术，缺少对应的应用场景带入感.

## 特色
本书试图在数据整理与图表呈现的内容上、编排方式上以及论述形式上有所突破和改进。

在内容上，顾名思义，专门讨论数据整理和统计图表的制作，不贪大求全、忌蜻蜓点水。精心提炼的 10 个专题总计 10 万字，涉及 SAS 的八卦见闻、 SAS 的基础知识、数据的导入导出方式、变量与观测的各种操作、数据集的各种操作与管理、函数与例程、输入输出格式、统计表格的制作、统计图形的绘制原则、选择方法以及各系列统计图形的绘制实例，此外对 SAS宏变量、宏程序以及开发宏程序的原则、步骤、技巧等内容均有较为详细的论述。在编排上，推陈出新，打破按语法关键字的字典式编排方式，精心挑选的 10 个专题构成 10 个既相对独立又互相联系的章节。小节与小节之间、例子与例子之间，尽量由问题层层引入，逐步推进，减少割裂与唐突感，增加使用场景的带入感。

此外，很多 SAS 用户虽然都了解、接受甚是已经受益于 SAS 在数据整理和统计分析方面毋庸置疑的优势，但是在统计结果的呈现上，尤其是统计表格，特别是统计图形方面都或多或少存在不甚了解抑或是误解的情况。因此，本书在统计表格的制作，尤其是统计绘图方面花了大量的笔墨做串讲——是的，用一个又一个层层递进的疑问来串讲，避免单
纯的介绍绘图语法和 SAS 技术，这在其他书中是很少见的。

最后，为了便于读者理解 SAS 运行机制与原理，本书在论述时都尽量采用小数据、小实例以便清晰简洁地说明问题，避免因行业背景的不同陷入具体实例的大坑。同时，为了方便读者练手测试，几乎所有数据均就地取材，采用 SASHelp 库中自带的数据集。

## 心得
SAS Help 文档是学习 SAS 不可多得的手边精品材料，如果还没有深刻体会到这一点，那么赶紧去读读 R 包的 Help 文档。很多 SAS 书籍取材于 SAS Help 文档却闭口不提，这是一个巨大的失误。因此，本书会专门引导，鼓励读者去多读 SAS Help 文档、多查 SASHelp 文档。

学习知识的理想状况是单调线性、循序渐进的推进，然而现实情况却是：知识本身是错综复杂的网状结构。因此，我们经常需要迂回包抄、循环往复地学习。在介绍知识点时，本书努力做到直线推进、循序渐进，但由于作者精力、能力有限，加之知识网状结构的客观的、存在的现实，希望读者能有一个迂回包抄、循环往复的学习心态。当然，我也有一个迂回包抄、循环往复、精进迭代的心态。本书还有很多的话题，比如 SAS 的综合矩阵语言（Integrated Matrix Language ， IML）、输出传递系统（Output delivery System, ODS）、正则表达式等没能在此版付诸实践；已经付诸实践的，也会因笔者的见识、学识以及精力受限，而有所欠缺。因此，诚恳地欢迎诸位读者给出您的建设性建议以及批评性意见，送达地址 guhongqiu(at)yeah(dot)net。有您的反馈，下一版（如果有的话），肯定会更好。

## 致谢
如果您读到这里了，请不要嫌我啰唆，因为一路走来，需要感谢的人特多，而且感谢应该是一个严肃的话题，因此，下面是一本正经的致谢。

感谢北京中医药大学曾光教授、刘仁权教授带我叩开流行病与卫生统计领域的大门；感谢中国疾病预防控制中心吴尊友教授教我公共卫生的大义；感谢北京协和医学院李卫教授携我走进临床研究的大门；感谢国家神经系统疾病临床医学研究中心王拥军、王伊龙教授给我机会在实践中提升临床研究思维与技能。感 谢《The Little SAS Book》 的 作 者 Lora D. Delwiche 女 士， 著 名 SAS 绘 图 博 客Graphically Speaking 的博主、众多 SAS 绘图专著的作者 Sanjay Matange 先生，以及《The DS2 Procedure: SAS Programming Methods at Work》的作者 Peter Eberhardt 先生在本书写作
过程中给予的支持和帮助。

感谢 SAS 中国研发中心总经理刘政先生；感谢 SAS 中国研发中心分析产品开发部总监高燕女士、 SAS 中国研发中心商业智能和可视化分析产品部技术总监巫银良先生、 SAS中国区培训经理赵丹先生、 SAS 大中华区市场总监蒋顺利先生的于我准备书稿过程给予的支持；感谢 SAS 中文论坛创始人、前海征信副总经理施亦明先生， SAS 中文资讯网的创始人 sxlion 以及人大经济论坛里的一大波 ID（jingju11、 pobel、 hopewell、 davil2000、kuhasu、 ahuige、soporaeternus、 YueweiLiu、 oloolo、 bobguy、 Imasasor、 playmore、crackman、 dxystata）在 SAS 的江湖里传道解惑。感谢本书的编辑，清华大学出版社的刘洋先生。没有他的信任，这本书可能会散落于江湖；没有他的信任，写作可能会被无数次的催稿打断。还好，他对我和这本书稿一直保持足够的耐心。再次感谢清华大学出版社编辑部，精心挑选每章首页的山水画，配合标题，意境深远。

来北京十多年，感谢中国气象科学研究院谷湘潜研究员、首都医科大学附属北京地坛医院江宇泳教授给予的各方面关照；感谢中南大学谷潜平教授的建议；感谢国家神经系统疾病临床医学研究中心的王彩云主任早上的烤红薯——无上美味、香甜至极。最后，感谢因为 SAS、因为此书，和我有了交集的你。

谷鸿秋
2017 年 5 月 17 日