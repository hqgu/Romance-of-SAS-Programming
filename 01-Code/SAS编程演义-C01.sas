*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第一章 人生若只如初见：初始SAS
*==============================================================================================*;


*程序 01-1 查看SAS安装、许可的模块;
*===带*号的行是注释行===;
*===查看SAS已安装的模块;
proc product_status;
run;

*===查看SAS已许可的模块;
proc setinit;
run;


*===查看完整安装报告;
%include  "D:\03_Publishig\SAS编程精要\03 Code\Core\fusion_20390_1_sasinstallreporter4u.sas";
%SASinStallReporter;




*程序 01-2 获取SAS版本号;
*===查看版本号;
%put SAS 版本号： &SYSVER;
%put SAS 版本号（长）：&SYSVLONG;



*程序 01-3 版本号发布历史;
data Releases;
	format Date DATE7.;
	input Category $13. Release $9. Date DATE9. StatRelease $5.;
datalines;
Ancient      8.0      01Nov1999 
Ancient      8.1      01Jul2000 
Ancient      8.2      01Mar2001 
Ancient      9.0      01Oct2002 
Ancient      9.1      01Dec2003 
Ancient      9.1.3    01Aug2004 
Ancient      9.2      01Mar2008 9.2
Old          9.2m2    01Apr2010 9.22
Old          9.3      12Jul2011 9.3
Old          9.3m2    29Aug2012 12.1
Recent       9.4      10Jul2013 12.3
Recent       9.4m1    15Dec2013 13.1
Recent       9.4m2    05Aug2014 13.2
Recent       9.4m3    14Jul2015 14.1
Recent       9.4m4    16Nov2016 14.2
;
 
Proc format;
 value $ vfmt Ancient="古老"
       Old="旧版"
       Recent="最近";
run;

title "SAS软件和分析产品的主要版本及发布日期";
proc sgplot data=Releases noautolegend ;
	styleattrs datacolors=(red yellow green);
	block x=date block=category / transparency = 0.8;
	scatter x=date y=release / datalabel=StatRelease datalabelpos=right
	                           markerattrs=(symbol=CircleFilled size=14);
	xaxis grid type=time offsetmin=0 label="年份";
	yaxis type=discrete offsetmax=0.1 label="版本";
	format category  $vfmt.;
run;
