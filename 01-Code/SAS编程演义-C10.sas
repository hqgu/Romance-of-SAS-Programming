*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第十章 一缕檀烟万佛名：宏中奥秘
*==============================================================================================*;




*=程序 10-1 快速获取系统信息;

%put 《SAS编程演义》手稿完成的操作系统： &sysscpl.，SAS系统：&sysver.，完成日期：&sysdate9.。;


*程序 10-2 宏程序重复执行SAS程序;

*==假定csv命名规则;
%macro importcsv;
%do i=1 %to 100;
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
%end;
%mend;

%importcsv



*程序 10-3 宏程序条件执行SAS程序;
%macro report;
	%if &sysday EQ FRIDAY %then %do;
	  proc print data=reportdata;
	  run;
	%else %put Not Friday, No report.;
%mend;

%report;




*程序 10-4 定义宏变量;

*==文本;
%let bookname1=Romance of SAS Programming;
%let bookname2=SAS编程演义;
%let address1=%str(Author%'s address);
%let address2=%nrstr(PUMC&CAMS);

*==数字;
%let  phone1=13800137000;
%let  phone2=;

*==算术表达式;
%let ex1=99+1;
%let ex2=99.9+0.1;

*==计算算术表达式;
%let ex3=%eval(99+1);
%let ex4=%sysevalf(99.9+0.1);

*==程序;
%let  prg=%str(proc print data=sashelp.classr;run;);

*==查看结果;
%put _user_;




*程序 10-5 PROC SQL创建宏变量;
*==单个宏变量;
proc sql noprint;
	select count(name) into:nname
	from sashelp.class;
quit;
%put &nname;

*==宏变量列表;
proc sql noprint;
	select name into:namelist separated by ","
	from sashelp.class;
quit;
%put &namelist;



*程序 10-6 CALL SYMPUTX与SYMPUTX创建宏变量;

*==单个宏变量;
data _null_;
	set sashelp.class end=last;
	if last then call symput('nname',_n_);
run;
%put &nname;

*==系列宏变量;
data _null_;
	set sashelp.class;
	call symputx(cats('name',_n_), name);
run;
%put &name1 &name19;


*程序 10 7 查看宏符号表以及判断宏作用域;
%macro testMacroVar(a=,b=);
%global c;
%let c=Hi;

%put 所有自定义宏变量:;
%put  _user_; 

%put 所有局部宏变量:;
%put  _local_;

%put 所有自定义全局宏变量:;
%put _global_;

%put a是否全局宏变量： %symglobl(a);
%put c是否全局宏变量： %symglobl(c);

%put b是否局部宏变量：%symlocal(b);
%mend;

%testMacroVar(a=Stats, b=Thinking);





*程序 10 8 宏变量掩蔽演示;

%let address1=PUMC&CAMS;
%let address2=%nrstr(PUMC&CAMS);

%put &address1;
%put &address2;


%put &address1;
WARNING: Apparent symbolic reference CAMS not resolved.
PUMC&CAMS
%put &address2;
PUMC&CAMS  ;


*程序 10-9 系统选项SYMBOLGEN显示宏变量值;


options symbolgen;
%let title1=SAS编程演义;
%let title2=数据整理与图表呈现;
%let title=&title1.:&title2;

 *程序 10 10 %PUT语句显示宏变量值;
options nosymbolgen;
%let title1=SAS编程演义;
%let title2=数据整理与图表呈现;
%let title=&title1.:&title2;
%put title1和title2 合并后的title解析为：&title;



*程序 10-11 %PUT语句分类显示宏变量值;
*显示所有宏变量;
%put _all_; 

*显示所有自动宏变量;
%put _automatic_; 

*显示所有自定义宏变量;
%put _user_; 

 *显示所有全局宏变量;
%put _global_;

*显示所有局部宏变量;
%put _local_;





*=程序 10-12 直接引用宏变量;

%let bookname2017=SAS编程演义;
%let year=2017;

data tmp;
  name="&bookname2";
  year=&year;
run;


*程序 10-13 间接引用宏变量;
data tmp;
 name="&&bookname&year";
run;


*程序 10-14 宏变量与文本的分隔;
%let lib=sashelp;
data class;
	set &lib..class;
	bookname="&bookname2017.：数据整理与图表呈现";
run;



*程序 10-15 宏程序定义与调用示例;

*==一个示例;

*==定义宏程序;
%macro printds(dataset, obs=5);
  proc print data=&dataset(obs=&obs);
  run;
%mend printds;

*==调用宏程序;
%printds(sashelp.class, obs=5)



*程序 10-16 存储与加密宏程序;

*==定义;
options mstored sasmstore=demo; 
%macro printds(dataset, obs=5)/store;
  options nomprint nosource;
  proc print data=&dataset(obs=&obs);
  run;
%mend printds;

*==调用;
options mstored sasmstore=demo; 
%printds(sashelp.class, obs=5)


  filename maccat catalog 'demo.sasmacr.printds.macro';
  data _null_;
    infile maccat;
    input;
    list;
  run;

*程序 10-17 宏函数应用示例;

%macro macro_name <(parameter_list)> </ option(s)>; 
	<macro_text>
%mend <macro_name>; 

%macro_name<(parameter_list)>;


*===宏语句;

%macro printds(dataset, sex=F,obs=5,);
  %if &sex eq F %then %str( title "First &obs record for female";);
  %else %if &sex eq M %then %str(title "First &obs record for male";);
  %else  %str(title "Wrong gender"; %abort;);
  proc print data=&dataset(obs=&obs where=(sex="&sex"));
  run;
%mend printds;


%printds(sashelp.class,sex=M,obs=5)



*===循环;

*==%do %while;
%macro importcsv;
%let i=1;
%do %while(&i<=100);
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
	%let i=&i+1;
%end;
%mend;

%importcsv;


*==%do until;


%macro importcsv;
%let i=1;
%do %until(&i<=99);
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
	%let i=&i+1;
%end;
%mend;

%importcsv;

%let title=SAS编程演义：数据整理与图表呈现;
%let n=%length(&title);
%let main_title=%scan(&title,1,：);

%put 长度： &n ;
%put 主标题：&main_title;




*程序 10 18 S1：硬代码初步实现宏任务;
*==S1;

*==导出SAV;
proc export data=sashelp.class
			 outfile="D:\01 SAS编程演义\02 Data\Raw\class.sav"
			 dbms=sav replace;
run;

*==导出xls;
proc export data=sashelp.class
			 outfile="D:\01 SAS编程演义\02 Data\Raw\class.xls"
			 dbms=xls replace;
run;

*==导出xlsx;
proc export data=sashelp.class
			 outfile="D:\01 SAS编程演义\02 Data\Raw\class.xlsx"
			 dbms=xlsx replace;
run;

*==导出csv;
proc export data=sashelp.class
			 outfile="D:\01 SAS编程演义\02 Data\Raw\class.csv"
			 dbms=csv replace;
run;

*==txt;
proc export data=sashelp.class
			 outfile="D:\sashelp.class.txt"
			 dbms=tab replace;
run;


*程序 10 19 S2：硬代码初步宏变量化;
*==S2-1;

%let dsname=sashelp.class;
%let filelocation=D:\01 SAS编程演义\02 Data\Raw;
%let filetype=sav;

proc export data=&dsname
			 outfile="&filelocation\&dsname..&filetype"
			 dbms=&filetype replace;
run;



*程序 10 20  S2：硬代码初步宏参数化;
*===s2-2;

*==硬代码宏化;
%macro exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=sav);
proc export data=&dsname
			 outfile="&filelocation\&dsname..&filetype"
			 dbms= %if %upcase(&filetype) NE TXT %then &filetype ;
                   %else TAB; 
             replace;
run;
%mend exfile;


*程序 10 21 S3：宏代码测试优化;
*==测试各种数据类型;
options mprint symbolgen mlogic;
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=sav)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=xls)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=xlsx)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=csv)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS编程演义\02 Data\Raw, filetype=txt)
