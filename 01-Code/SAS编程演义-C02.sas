*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第一章 清歌苦调两不厌：夯实基础
*==============================================================================================*;

*程序 02-1 利用LIBNAME语句自建永久逻辑库;

*===带*号的行是注释行===;
*===自建永久库===；
*===取名Demo,地址：D:\03 Writting\01 SAS编程演义\02 Data\Clean;
libname  demo "D:\03 Writting\01 SAS编程演义\02 Data\Clean";




*程序 02-2 查看数据集描述信息与数据值;
*===查看数据文件的描述信息;
proc contents data=demo.class_datafile;
run;

*===查看数据文件的数据值;
proc print data=demo.class_datafile;
run;
*===查看视图的描述信息;
proc contents data=demo.class_view;
run;

*===查看视图的数据值;
proc print data=demo.class_view;
run;



*程序 02-3 SET语句建立数据数据文件;
*===自建永久库;
libname  demo "D:\03 Writting\01 SAS编程演义\02 Data\Clean";

*===建永久数据集，demo.不可省略;
data demo.class_datafile;
	set sashelp.class;
run;

*===建临时数据集，work.被省略;
data  class_datafile;
	set sashelp.class;
run;


*程序 02-4 创建SAS视图;
*===from data setp;
data demo.class_view/view=demo.class_view;
	set sashelp.class;
run;

*===from Proc sql;
proc sql;
	create view demo.class_view as 
	select * 
	from sashelp.class;
quit;



*程序 02-5 SAS日期、时间已经日期时间的本质;
data tmp;
  date="01Jan1960"d;
  time="00:00:00"t;
  datetime="01Jan1960 00:00:00"dt;
run;


*程序 02-6 SAS中文数据集和变量名;
*===中文名数据集;
*===中文名变量;

options validmemname=extend validvarname=any; 
data  中文名演示;
       SAS中文变量名="YES";
       SAS中文變量名="YES";
      '2SAS中文变量名'n="YES";
      '2SAS中文變量名'n="YES";
      'SAS空 格变量名'n="YES"; 
      'SAS空#  @ %格特殊字符变量名'n="YES";  
run;




*程序 02-7 编程风格：规范裕凌乱;

*===规范;
*===自建永久库;
libname demo "D:\03 Writting\01
SAS编程演义\02 Data\Clean";

*===建永久数据集， demo.不可省略;
data demo.class_datafile;
set sashelp.class;
run;

*===建临时数据集， work.可以省略;
data class_datafile;
set sashelp.class;
run;

*===凌乱;
libname demo "D:\03 Writting\01
SAS编程演义\
02 Data\Clean";
data demo.class_datafile;
set sashelp.class;
run; data class_datafile; set
sashelp.class;run;



*程序 02-8 SAS中的常量;
data _null_;
  *===字符常量;
  c1="Hongqiu Gu's Book";
  c2='Hongqiu Gu''s Book';

  c3='Hongqiu Gu"s Book';
  c4="Hongqiu Gu""s Book";

  *===数字常量;
  n1=123;
  n2=-123;
  n3=+123;
  n4=1.23;
  n5=0123;

  *===日期时间常量;
  d='08Sep2016'D;
  t='11:11'T;
  dt='08Sep2016:11:11'DT;

  *===在日志中输出;
  put  c1-c4 ;
  put  n1-n5 ;
  put d yymmdd10.;
  put t time.;
  put dt datetime.;
run;



*程序 02-9 SAS语言元素演示;
*====概念演示;
data test2;
   length ID $ 4;
 	input Name $  start yymmdd10.  end date8.  grade; *输入格式;
	FirstName=substr(Name,1,1);                       *函数substr;
	GivenName=substr(Name,length(Name)-1,2);          *函数substr;
	call cats(ID,FirstName, GivenName);               *CALL CATS例程;
	if grade>=2  and  start<'01Jun2016'd  then  pay=(end-start)*150; *比较、逻辑、算术运算;
	else pay=(end-start)*100;
    datalines; 
ZhangXL 2016/08/09 06SEP16 1
WangSJ 2016/07/03 09SEP16 2
WenTC 2016/05/05 02SEP16 3
LiWC 2016/04/09 10SEP16 2
 ;
run;

 options nodate;                           *系统选项;
proc print data=test2(obs=2);             *数据集选项;
  	var ID start end  pay ;
	format start yymmdd10.  end yymmdd10.;  *输出格式;
run;



*程序 02-10 IF-ELSE/THEN 示例;
data male female;
  set sashelp.class;
       if  sex="M" then output male;
  else if  sex="F" then output female;
  else put "Invalid sex :" sex ;
run;



*程序 02-11 IF-ELSE配合DO-END;
data male female;
  set sashelp.class;
       if  sex="M" then do; gender="Male "; output male; end;
  else if  sex="F" then do; gender="Female"; output female; end;
  else put "Invalid sex :" sex ;
run;



*程序 02-12 DO循环语句;
data schedule;
  do date='01Sep2016'd to '30Sep2016'd ; *日期循环;
     day=weekday(date);
	 if day in (1,7) then Activity="Running";
	 else if day in (2,4,6) then Activity="Writing";
	 else Activity="Reading";
	 output;
  end;
run;

data random;
	do i=1 to  10;
	 r=rannor(123);
	 output;
	end;
run;



*==程序 02-13 循环语句do while 与do unti;
data dowhile;
  i=0;
  do while(i<5);
      i+1;
	 output;
  end;
run;

data dountil;
  i=0;
  do until(i>=5);
      i+1;
	 output;
  end;
run;



*程序 02-14 定义数组;

 *===定义数组;
 *===sbp1-sbp7是sbp1到sbp7的缩略写法;
 array sbp{7} sbp1-sbp7;
 array dbp{1:7} dbp1-dbp7;


 *===带初始值;
 array sbp{7} sbp1-sbp7 (163 164 167 171 155 158 154);
 array dbp{7} dbp1-dbp7 (98 99 92 94 95 93 93);


 *===定义二维数组;
 array bp{2,1:7} sbp1-sbp7 dbp1-dbp7 ;
 array bp{2,7} sbp1-sbp7 dbp1-dbp7 (163 164 167 171 155 158 154 98 99 92 94 95 93 93);



 
 *程序 02-15 访问数组元素;

data tmp;
  input sbp1-sbp7 dbp1-dbp7;
  datalines;
163 164 167 171 155 158 154 98 99 92 94 95 93 93
164 165 163 161 165 168 164 99 98 96 99 95 91 96
;
run;


*===遍历数组元素;
data tmp;
*===定义数组;
  array sbp{7} sbp1-sbp7 (163 164 167 171 155 158 154);
  array dbp{7} dbp1-dbp7 (98 99 92 94 95 93 93);
  array bp{2,7} sbp1-sbp7 dbp1-dbp7 (163 164 167 171 155 158 154 98 99 92 94 95 93 93);
 *===遍历一维数组;
  do i=1 to 7;
    put "第" i "次测量的SBP为：" sbp{i};
    put "第" i "次测量的DBP为：" dbp{i};
  end;
 *===遍历二维数组;
  do m=1 to 2;
    do n=1 to 7;
	  put "血压类型为：" m "，血压测量次数为：" n  "，血压测量值为：" bp{m,n};
	end;
  end;
run;

 
 
 *程序 02-16 函数与列程应用示例; 
 
data _null_;
   length  FullName_ByFunction FullName_ByRoutine $10;
   FamilyName="Gu";
   GivenName="Hongqiu";

   *===用函数生成全名;
   FullName_ByFunction=catx(" ",GivenName, FamilyName);

   *===用列程生成全名;
   call catx(" ",FullName_ByRoutine, GivenName, FamilyName );

   *===Log中查看结果;
   put "Fullname Generatedy by Function: " FullName_ByFunction;
   put "Fullname Generatedy by Routine: " FullName_ByRoutine;

run;



*==程序 02-17 最简单一个SQL过程;
proc sql;
	select name, sex, age
	from sashelp.class;
quit;



*==程序 02-18 PROC SQL SELECT语句全从句示例;

proc sql;
	select sex, count(name) as cnt_name ,mean(height) as m_height
	from sashelp.class
    where age>=12
	group by sex
	having m_height>62
    order by cnt_name;
quit;




*===程序 02-19 宏变量;

*===自定义;
%let PUMC=Peking Union Medical College;

*===查看系统自带;
%put &sysdate;

*===查看自定义;
%put &PUMC;




*程序 02-20  定义和调用Macro;

*===定义Macro;
%macro prtdsvar(data=, var=);
proc print data=&data;
	var &var;
run;
%mend;

*===调用Macro;
%prtdsvar(data=sashelp.class, var=name sex)




*程序 02-21 DPV演示程序;

data demoPDV;
	input ID $  Chinese  Math  English;
	Sum=Chinese+Math+English;
datalines;
S001  80  99  93
S002  90  85  95
S003  83  88  81
;
run;


*程序 02-22 验证PDV;

data demoPDV;
    put "第" _n_ "次运行前：" _all_;
	input ID $  Chinese  Math  English;
	Sum=Chinese+Math+English;
    put  "第" _n_ "次运行后：" _all_;
datalines;
S001  80  99  93
S002  90  85  95
S003  83  88  81
;
run;



*程序 02-23 @与@@示例程序;
*===数据列数=变量数=4;
data test1;
	 input id x y z;
	 datalines;
 1 98 99 97
 2 93 91 92
 ;
run;


*===数据列数=变量数，多个input语句;
data test1;
	 input id@;
	 input x@;
	 input y@;
	 input z@;
	 datalines;
 1 98 99 97
 2 93 91 92
 ;
 run;


*=== 数据列数=k*变量数;
data test3;
 input id x y z @@;
 datalines;
 1 98 99 97 2  93 91 92
 ;
run;


 
 
 *程序 02-24 @与@@的叹息;
data test;
    input x @;       /*单个@，能H住，有效期到下一个input语句*/
    input y;         /*没有@，H不住，下一个input语句会去读新的一行*/
    input z @@;      /*两个@，H住没问题，有效期延长到Data步下一圈*/
datalines;
1 2 3
4 5 6
7
;
run;

data test;
    input x;      
    input y@@;         
    input z @;      
datalines;
1 2 3
4 5 6
7
;
run;



*===select语句语法;
SELECT <DISTINCT | UNIQUE> object-item-1 <, object-item-2, ...>
<INTO macro-variable-specification-1 <, macro-variable-specification-2, ...>>
FROM from-list
<WHERE sql-expression>
<GROUP BY group-by-item-1 <, group-by-item-2, ...>>
<HAVING sql-expression>
<ORDER BY order-by-item-1 <, order-by-item-2 <ASC | DESC>, ...>>; 

