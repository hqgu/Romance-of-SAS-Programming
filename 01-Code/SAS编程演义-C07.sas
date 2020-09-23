*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第七章 翩跹翠袖拂云裳：巧用格式
*==============================================================================================*;



*程序 7-1 输入输出格式;

data tmp;
	input data  date7.;
	format data  yymmdd10.;
datalines;
11FEB17
20AUG16
;
run;

proc print data=tmp;
run;



*程序 7-2 SAS内置格式清单;

proc sql;
 create table SysFormats as
 select distinct fmtname from dictionary.formats;
quit;

proc print data= SysFormats;
run; 


*程序 7-3 PROC FORMAT自定义格式；

*===自定义格式;
proc format ;
  value $sexf F="女性"
              M="男性";
  value level  1="低"
               2="中"
			   3="高";
run;


*程序 7-4 PROC FORMAT的CNTLOUT选项导出格式定义数据;
proc format library=work cntlout=fmt;
run;


data fmt;
  set fmt;
run;

*程序 7-5 用数据集定义格式;
proc format library=work cntlin=fmt(keep=fmtname start end label type);
run;



*程序 7-6 格式的使用范围;
*===Data步 PUT语句中指定;
data _null_;
  set sashelp.class(obs=5);
  put name sex $sexf.;
run;

*===Proc步Format语句指定;
proc print data=sashelp.class(obs=5);
	var name sex ;
	format sex $sexf.;
run;

*===Proc sql中format选项;
proc sql;
  select name , sex  format=$sexf.
  from sashelp.class(obs=5);
quit;



*程序 7-7 自定义格式用于变量重分类;

*===创建测试数据集;
data obese;
length  status $ 15;
 set sashelp.class;
 BMI= weight*0.4536/(height*0.0254)**2;
run;


*===自定义格式;
proc format;
  value obefmt low-18.5="Underweight"
               18.5-<25="Normal"
			   25-<30="Overweight"
			   30-high="Obese";
run;

*===原变量+格式直接统计新分类的频数;
proc freq data=obese;
	table bmi ;
	format bmi obefmt.;
run;




*程序 7-8 统计过程中加载自定义格式;
proc format;
  value obefmt  low-18.5="Underweight"
			    18.5-high="Normal or above";
run;

proc logistic data=obese;
     class sex;
	model bmi(event="Underweight")=age sex ;
	format bmi obefmt.;
run;



*程序 7-9 利用自定义格式统计缺失、非缺失观测数;
*===自定义格式;
proc format;
	value $ missfmt ' '="Missing"
	        other="Not Missing";
	value   nmissfmt . ="Missing"
	        other="Not Missing";
run;

*===创建测试数据集;
data class;
  set sashelp.class;
  if rannor(123)<0.5 then call missing(sex);
  if rannor(456)<0.05 then call missing(age);
run;
  
*===统计缺失、非缺失频数;
proc freq data=class;
	table sex  age/missing;
    format sex $missfmt. age nmissfmt.;
run;
	


*程序 7-10 自定义格式用于条件显示;

proc format;
  value obefmt  low-18.5="red"
			    18.5-high="black";
run;

proc report data=obese nowd split='~'
    style(report)=[background=white foreground=black];
	column name sex age bmi;
	define name/display;
	define sex/display;
	define age/display;
	define bmi/format=4.1 style=[foreground=obefmt.];
run;
