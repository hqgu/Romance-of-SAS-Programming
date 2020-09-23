*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第五章 亦应帷幄运鸿筹：数据库集
*==============================================================================================*;



*程序 5-1 MODIFY语句修改所有观测;

*==创建测试数据集;
data class;
  set sashelp.class;
run;

*==SET语句修改;
data class1;
 set class;
 weight=weight*0.4536;
 height=height*0.0254;
run;

*==MODIFY语句修改;
data class;
 modify class;
 weight=weight*0.4536;
 height=height*0.0254;
run;





*程序 5-2 MODIFY语句修改匹配观测;

*===创建主数据集;
data raw;
   name="统技思维";gender=""; age=2; Location="BJ";output;
   name="GUHQ";gender="M";    age=.; Location="BJ";output;
run;

*===创建事物数据集;
data new;
	name="统技思维";gender="M";output;
	name="GUHQ";age=35;output;
	name="GUHQ";age=30;output;
run;

*===用事物数据集更新主数据集;
data raw;
 modify raw new;
 by name;
run;


*程序 5 3 MODIFY语句修改匹配观测补全默认省略的语句;

data raw;
 modify raw new;
 by name;
 replace;
run;



*程序 5-4 MODIFY语句OUTPUT, REMOVE以及REPLACE用法;

data class;
  set sashelp.class;
run;

data class class_female;
  	modify class;
	*===如果为女性
	   则输入到class_female数据集
	   并把此条观测从原数据集移除;	   
	if sex="F" then do;
      output class_female;
	  remove class;
	end;
    *===修改Height数据
	    替换CLASS数据集里height数据;
	else do;
      height=height+5;
      replace class ;	 
	end;
run;


*程序 5 5 UPDATE语句更新数据集;

*===创建主数据集;
data raw;
   name="统技思维";gender="";  age=2;Location="BJ";output;
   name="GUHQ";gender="M";age=.;Location="BJ";output;
run;

*===创建事物数据集;
data new;
	name="统技思维";gender="M";output;
	name="GUHQ";age=30;output;
run;

*===排序;
proc sort data=raw;
 	by name;
run;

proc sort data=new;
	by name;
run;

*===用事物数据集更新主数据集，补全性别，年龄变量;
data want;
 update raw new;
 by name;
run;



*程序 5 6 PROC TRANSPOSE与ARRAY实现行转列;
*===创建宽的考试成绩数据集;
data wide;
input SID $  Programming  Stats  English;  
datalines;
S01  98 100 80
S02  84 98 94
S03  89  92 88
;
run;


*===proc transpose转置;
proc transpose data= wide out=long(rename=(_name_=Coursename col1=Score));
   var Programming  Stats  English; /*需要转置的变量*/
   by  SID;                         /*重复的分组变量*/
run;


*===do循环+array;
data long(keep=SID Coursename Score);
    set wide;
    array scores{*} Programming  Stats  English;
	do i=1 to dim(scores);
	  Coursename=vname(scores{i});
	  Score=scores{i};
	  output;
	end;
run;
  

*程序 5 7 PROC TRANSPOSE与ARRAY实现列转行;

*====还原宽表;
*===proc transpose转置;
proc transpose data=long out=Rewide(drop=_name_);
	var Score;       /*需要转置的变量*/
	by SID;
	id Coursename; /*标示列转行后的字段名*/
run;

*===do循环+array;
data Rewide(keep=SID Programming  Stats  English);
format SID  Programming  Stats  English;
  array Course{3} Programming  Stats  English;
  do i=1 to 3;
     set long;
	 Course{i}=Score;
  end;
run;




*程序 5-8 一对一读入;

*创建测试数据集;
data class1(keep=name sex)  class2(keep=age height weight);
	set sashelp.class ;
	output class1;
    output class2;
run;
   
*===一对一读入;
data class;
	set class1;
	set class2;
run;


*程序 5-9 一对一并接;
*===一对一并接;
data class;
  merge class1 class2;
run;


*程序 5-10 Merge+by语句匹配并接数据集;
*===创建测试数据集;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    output class2;
run;

*===匹配并接;
proc sort data=class1;
	by name;
run;

proc sort data=class2;
	by name;
run;

data class;
	merge class1 class2;
    by name;
run;


*程序 5-11 Merge语句实现各种连接类型;
*===创建测试数据集;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    if _n_ in (1, 5, 10, 15) then output class2;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;

*===排序准备;
proc sort data=class1;
	by name;
run;

proc sort data=class2;
	by name;
run;

data class_left;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1; /*左连接*/
run;

data class_right;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds2; /*右连接*/
run;
 

data class_innner;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1 and ds2; /*内连接*/
run;

data class_full;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1 or ds2; /*全连接*/
run;




*程序 5-12 PROC SQL实现各种连接;

*===左连接;
proc sql;
	create table class_left as
	select a.*,b.*
	from class1 as a left join class2 as b
	on a.name=b.name;
quit;

*===右连接;
proc sql;
	create table class_right as
	select a.*,b.*
	from class1 as a right join class2 as b
	on a.name=b.name;
quit;

*===内连接;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a inner join class2 as b
	on a.name=b.name;
quit;


*===全连接;
proc sql;
	create table class_full as
	select a.*,b.*
	from class1 as a full join class2 as b
	on a.name=b.name;
quit;



*=程序 5 13 Set语句串接数据集;

*===创建测试集;

**===创建测试数据集;
data class1  class2   class3(keep=name sex)  class4(keep=name age  height weight);
	set sashelp.class ;
    if _n_<=10 then do;
      output class1;
	  output class3;
	end;
	else do;
      output class2;
	  output class4;
	end;
run;

*===Set语句串接实例1;
data class;
  	set class1 class2;
run;

*===Set语句串接实例2;
data class;
  set class3 class4;
run;



*程序 5-14 proc append串接数据集;
*===串接实例1;
proc append base=class1 data=class2;
run;

*===串接实例2;
proc append base=class3 data=class4 force;
run;
 


*程序 5-15 proc sql串接数据集;
proc sql;
	create table class as
	select *
		from class1
	union
	select *
    	from class2;
quit;

*===保留所有的变量;
proc sql;
	create table class as
	select *
		from class3
	outer union 
	select *
    	from class4;
quit;

*===只保留相同的变量;
proc sql;
	create table class as
	select *
		from class3
	union corr
	select *
    	from class4;
quit;





*=程序 5-16 Proc SQL左连接;

*===创建测试数据集;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    if _n_ in (1, 5, 10, 15) then output class2;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;


*===左连接;
proc sql;
	create table class_left as
	select a.*,b.*
	from class1 as a left join class2 as b
	on a.name=b.name;
quit;



*程序 5-17 Proc SQL右连接;
*===右连接;
proc sql;
	create table class_right as
	select a.*,b.*
	from class1 as a right join class2 as b
	on a.name=b.name;
quit;


*程序 5-18 Proc SQL内连接;
*===内连接;
*===实例1;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a inner join class2 as b
	on a.name=b.name;
quit;

*===实例2;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a , class2 as b
	where a.name=b.name;
quit;


*程序 5-19 Proc SQL全连接;
*===全连接;
proc sql;
	create table class_full as
	select a.*,b.*
	from class1 as a full join class2 as b
	on a.name=b.name;
quit;




*程序 5-20 Proc SQL Except运算;

*===创建测试数据;
data class1  class2   class3(keep=name sex)  class4(keep=name age  height weight);
	set sashelp.class ;
    output class1;
    output class3;	
	if _n_<=10 then do;
      output class2;
	  output class4;
	end;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;


*===Except;
proc sql;
	create table class as
	select *
		from class1
	except 
    select *
		from class2;
quit;


*程序 5-21 Proc SQL Union运算;

*===Union;
proc sql;
	create table class as
	select *
		from class1
	union 
    select *
		from class2;
quit;



*程序 5-22 Proc SQL Intersect运算;
*===Intersect;
proc sql;
	create table class as
	select *
		from class1
	intersect 
    select *
		from class2;
quit;



*程序 5-23 Proc SQL Outer Union运算;
*===Outer Union;
proc sql;
	create table class as
	select *
		from class3
	outer union 
    select *
		from class4;
quit;




*程序 5 24 制作变量字典表;
ods output Position=codebook;
proc contents data=sashelp.cars order=varnum ;
run;

proc export data=codebook
             outfile="d:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\codeBook.csv"
			 dbms=csv replace;
run;



*程序 5-25 Proc Datasets获取描述信息;

*===创建测试数据集;
data class;
 set sashelp.class;
run;

*===获取描述信息;
proc datasets lib=work;
	contents data=class;
quit;



*程序 5-26  Proc Datasets 修改数据集标签及权限;
*===修改描述信息;
proc datasets lib=work;
	modify class(label="学生测试数据集"  read=r2017);
quit;


proc datasets lib=work;
	contents data=class;
quit;




*程序 5-27 Proc Datasets 选择，拷贝，改名，删除数据集;

proc datasets ;
	 copy  in=sashelp out=work; /*数据集整体拷贝*/
	 select class;	            /*选择数据集*/
quit;

proc datasets lib=work;
	change class=student;    /*数据集改名*/
quit;

proc datasets lib=work;
	delete student;        /*删除数据集*/
quit;



*程序 5-28 程序 05 25 Proc Datasets 保留，删除数据集;

proc datasets lib=work kill memtype=data; /*删除Work库中所有数据集*/
run;

proc datasets lib=work;
	save class; /*仅保留class*/
run; 



*程序 5-29 Proc Datasets获取变量信息;
*===修改描述信息;
proc datasets lib=work;
	contents data=class;
quit;




*程序 5-30 Proc Datasets修改变量信息;
proc datasets lib=work;
	modify class;
	  format height weight 3.0;
	  rename sex=gender;
	  label name="姓名"
	        gender="性别";
quit;

proc datasets lib=work;
	contents data=class varnum;
quit;



*===SAS数据字典;

  proc sql;
    title "Dictionary库中所有的表";
    select  unique memname,memlabel
 	from dictionary.dictionaries;
   quit;   


proc contents data=sashelp._all_ memtype=view;
run;


*程序 5-31 Proc SQL查看数据字典表的结构;
proc sql; 
   describe table dictionary.columns;
quit;



*程序 5 32 获取SASHELP库下所有数据集信息;
*===从字典库中获取;
proc sql;
	create table desds as
	select memname, nobs ,nvar
	from dictionary.tables
	where libname="SASHELP" and memtype="DATA";
quit;

*===从视图中获取;
proc sql;
	create table desds as
	select memname, nobs ,nvar
	from sashelp.vtable
	where libname="SASHELP" and memtype="DATA";
quit;



*程序 5-33 获取数据集Cars的所有变量信息;

*===从字典库中获取;
proc sql;
	create table varlist as
	select name, type ,length,label
	from dictionary.columns
	where libname="SASHELP" and memname="CARS";
quit;

*===从视图中获取;
proc sql;
	create table varlist as
	select name, type ,length, label
	from sashelp.vcolumn
	where libname="SASHELP" and memname="CARS";
quit;


