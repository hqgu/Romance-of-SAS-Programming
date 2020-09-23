*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第四章 行舟来去泛纵横：变量观测
*==============================================================================================*;


*程序 4-1  DATA语句各种用法示例;
*===最偷懒的DATA语句;
data ; /*不指定数据集名自动命名为data1,data2,...,dataN*/
	set sashelp.class;
run;

*===一次同时生成多个数据集;
data class1 class2;
	set sashelp.class;
run;

*===不生成数据集;
data _null_;
	set sashelp.class;
run;


data tmp/debug;
  put _aLL_;
  set sashelp.class(drop=age);
  
run;




*程序 4-2  PROC SQL创建数据集;

*===创建一个和SAShelp.class一样的数据集;
proc sql;
	create table tmp as
	select *
	from sashelp.class;
quit;

*==创建一个与SAShelp.class结构一样的，无任何记录的数据集;
proc sql;
	create table tmp 
    like sashelp.class;
quit;


*===白手起家创建数据集;
proc sql;
  create table tmp 
   (name char(15),
    gender char(1),
    age  num,
    locaiton  char(10));  /*定义变量及其类型*/
 insert into tmp
   values('Hongqiu Gu', 'M',30,'Beijing')
   values('StatsThinking', 'M',1,'Beijing'); /*插入记录*/
select *
from tmp;
quit;
 



*程序 4-3 过程步语句与选项生成新数据集;

*===生成新数据集sortedclss已经按age排序;
proc sort data=sashelp.class out=sortedclass;
	by age;
run;

*===output语句生成新数据集获取统计过程的统计量;
proc means data=sashelp.class;
    var height weight;
	output out=outstat mean(height weight)= std(height weight)= /autoname;
run;


*===out选项生成新数据集获取四格表频数和百分比;
proc freq data=sashelp.bmt;
	table group*status/out=outfreq;
run;


*程序 4-4 ODS OUTPUT语句抓取K-M曲线数据;

ods output SurvivalPlot=SurvPlotData;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;



*程序 4-5 ODS TRACE ON语句追踪监控过程步数据;
*===ods trace 语句追踪;
ods trace on;
ods output SurvivalPlot=SurvPlotData;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;
ods trace off;



*程序 4-6 IF与WHERE语句筛选观测;

*===第一阶段：通过WHERE选项限定读入数据集;
data tmp;
	set sashlep.class(where=(sex="F"));
run;

*===第二阶段:通过IF或者WHERE语句;
*===通过where语句;
data tmp;
	set sashlep.class;
	where sex="F";
run;

*===通过求子集IF语句;
data tmp;
	set sashlep.class;
	if sex="F";
run;

*===第三阶段：通过WHERE选项限定输出数据集;
data tmp(where=(sex="F"));
	set sashlep.class;
run;



*程序 4-7 WHERE选项筛选观测;
*===WHERE选项筛选观测;
data want(where=(not missing(id)));
	set raw1(where=（age between  20 and 30）)  raw2(where=（sex="F"）);
run;



*程序 4 8 RENAME与KEEP，DROP;

*===第一阶段：读入数据集选项;
data want;
  set sashelp.class(drop=age rename=(sex=gender));
run;

*===第二阶段：语句;
data want;
  set sashelp.class;
  drop age;
  rename sex=gender;
run;

*===第三阶段：输出数据集选项;
data want(drop=age rename=(sex=gender));
  set sashelp.class;
run;



*程序 4-9 一个充满坑的错误程序;

*==第一阶段：读入数据集之错误程序演示;
data want;
  set sashelp.class(where=(sex="F")  rename=(sex=gender)keep=name gender);
run;

*==第二阶段：编程处理值错误程序演示;
data want;
  set sashelp.class;
  rename sex=gender;
  keep   name gender ;
  where gender="F";
run;

*==第三阶段：输出数据集之错误程序演示;
data want(where=(sex="F") rename=(sex=gender) keep=name gender);
  set sashelp.class;
run;



*程序 4-10 一个充满坑的错误程序的纠正;

*==第一阶段：读入数据集之正确程序演示;
data want;
  set sashelp.class(where=(gender="F") rename=(sex=gender) keep=name sex);
run;

*==第二阶段：编程阶段之正确程序演示;
data want;
  set sashelp.class;
  rename sex=gender;
  keep   name sex ;
  where sex="F";
run;

*==第三阶段：输出数据集之正确程序演示;
data want( where=(gender="F")  rename=(sex=gender) keep=name sex);
  set sashelp.class;
run;


*程序 4-11  PROC SQL实现变量与观测的筛选;

proc sql;
	create table want as
	select name, sex as gender, height,weight
	from sashelp.class
	where sex="F";
quit;




*程序 4-11  PROC SQL实现变量与观测的筛选;
*===条件赋值生成新变量;
*===计算体重指数BMI，依据BMI判定肥胖状态;
*===BMI=体重（Kg）/ 身高（m）的平方;
data Obese;
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;

proc print data=obese;
run;



*程序 4-13 循环语句批量赋值;
data hyp;
  *===定义数组;
  array sbp{7} sbp1-sbp7 (163 104 167 131 155 128 154);
  array hyp{7} hyp1-hyp7;
  *==-循环赋值;
  do i=1 to 7;
    if sbp{i}>=140 then hyp{i}=1;
	else hyp{i}=0;
  end;
run;

proc print data=hyp;
run;



*程序 4-14 LENGTH语句生成新变量;
*===LENGTH语句生成新变量;
*===计算体重指数BMI，依据BMI判定肥胖状态;
*===BMI=体重（Kg）/ 身高（m）的平方;
data Obese;
    length  status $ 15; /*指定字符长度*/
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;

proc print data=obese;
run;



*程序 4-15 用编程方法获取数据集观测数;

*===PROC SQL获取观测;
proc sql;
  select count(name) as N
  from sashelp.class;
quit;

*===_N_获取观测数;
data _null_;
  set sashelp.class end=last;
if last then put _n_;
run;

*===编译变量获取观测数;
 data _null_;
   if 0 then  set sashelp.class nobs=n;
   put _all_;
run;



*程序 4-17 利用编译变量与临时变量完成随机抽样;
*==随机抽样;
 data sample;
  do i=1 to 5; /*随机抽5个观测*/
    PickNo=ceil(ranuni(123)*N); /*获取一个位于1-N的随机的观测号*/
   set sashelp.class nobs=N point=PickNo; /*获取总观测数N,随机挑选的观测号PickNo*/
   output; /*把抽中的观测输出到新数据集*/
  end;
  stop; /*由于使用了Point，观测是非顺序读取，需要用STOP语句强制停止*/
run;

proc print data=sample;
run;



*程序 4-18 CALL例程生成新变量;
*===CALL 例程;
data rand;
 seed=123;
do i=1 to 10;
 x=rannor(seed); /*用函数赋值*/
 call rannor(seed,y); /*用CALL例程*/
 output;
end;
run;

proc print data=rand;
run;



*程序 4-19 变量类型的转换;
data ConvertVar;
  d_n=123;
  d_c="123";

  *==数字型转字符型;
  d1_n2c=put(d_n,best.);
  d2_n2c=put(d_n,3.) ;

  *==字符型转数字型;
  d3_c2n=input(d_c,best.);
  d4_c2n=input(d_c,3.);
run;

*===查看结果;
proc contents data=ConvertVar;
run;



*程序 4-20 IF-ELSE创建分组变量;

data Obese;
    length  status $ 15; /*指定字符长度*/
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;


*程序 4-21 SELECT-WHEN 创建分组变量;
data obese;
	length  status $ 15; /*指定字符长度*/
	 set sashelp.class;
	 BMI= weight*0.4536/(height*0.0254)**2;  
	select ;
		when(BMI<18.5) Status="Underweight";
		when(BMI<25) Status="Normal";
		when(BMI<30) Status="Overweight";
		other Status="Obese";
	end;
run;


*程序 4-22 PROC SELECT-CASE创建分组变量;

proc sql;
	create table obese as
	select *,  weight*0.4536/(height*0.0254)**2 as BMI,
	case when(calculated BMI<18.5 ) then "Underweight"
	     when(calculated BMI<25) then "Normal"
		 when(calculated BMI<30) then "Overweight"
		 else "Obese"
	end as Status
	from sashelp.class;
quit;


*程序 4-23 自定义格式创建分组变量;

proc format;
  value obefmt low-18.5="Underweight"
               18.5-<25="Normal"
			   25-<30="Overweight"
			   30-high="Obese";
run;

data obese;
	length  status $ 15;
	 set sashelp.class;
	 BMI= weight*0.4536/(height*0.0254)**2;
	 Status=put(BMI,obefmt.);
run;

*程序 4-24 查找缺失变量;

*===生成示例数据;
data demo;
  id="S01";   name="StatsThinking";gender="";  age=2;Location="BJ";output; 
  id="";   name="统技思维";gender="";  age=2;Location="BJ";output;
  id="S03"; name="Hongqiu Gu";gender="M";age=.;Location="";output;
run;

*===查找缺失变量;
data demo(drop=n c);
  set demo;
  length mvarlist $ 300;
  array num{*} _numeric_;  /*定义数字型数组，纳入所有数字型变量*/
  array char{*} _character_; /*定义字符型数组，纳入所有字符型变量*/

  do n=1 to dim(num);
   	if missing(num{n}) then mvarlist=catx("," ,mvarlist,vname(num{n})); /*数字型变量缺失清单*/
  end;

  do c=1 to dim(char);
   	if missing(char{c}) then mvarlist=catx(",", mvarlist,vname(char{c})); /*字符型变量缺失清单*/
  end;

run;

proc print data=demo;
run;




*程序 4-25 DATA步累积语句求均值;

*====纵向累加;
*===创建测试数据集;
  data class;
    set sashelp.class;
  run;

*==求累加到目前人数的平均体重;
data want;
  set class end=last;
  cum_weight+weight;  /*累加体重存储到变量cum_weight*/
  cnt_weight+1;      /*累加计数存储到变量cum_weight*/
  avg_weight=cum_weight/cnt_weight; /*求累加到目前人数的平均体重*/
run;


*程序 4-26  Retain和赋值语句求均值;
*==求累加到目前人数的平均体重;
data want;
  set class end=last;
  retain cum_weight cnt_weight   (0 0 );
  cum_weight=cum_weight+weight ; 
  cnt_weight=cnt_weight+1;      
  avg_weight=cum_weight/cnt_weight; 
run;



*程序 4-27 分组累加;
*===分组平均体重;
proc sort data=class;
	by sex;
run;

data want;
  set class end=last;
  by sex;
  if first.sex then do;
   cum_weight=0;
   cnt_weight=0;
  end;

  cum_weight+weight;
  cnt_weight+1;

  *===只输出每组最后一条;
  if last.sex then  do;
    avg_weight=cum_weight/cnt_weight;
	output;
  end;
run;



*程序 4-28 BY语句产生的FIRST.VAR 和LAST.VAR;
data want;
  set class;
  by sex;
  put (_n_  name  sex  first.sex  last.sex) (=);
run;


*程序 4-29 PROC SQL 实现纵向操作;

*===PROC SQL;
*===PROC SQL实现求分组平均体重;
proc sql;
	select sex, sum(weight) as cum_weight, count(weight) as cnt_weight, avg(weight) as avg_weight
	from sashelp.class
	group by sex;
quit;


*程序 4-30 PROC MEANS实现纵向操作;
proc means data=sashelp.class sum n mean;
   var weight;
   class sex;
run;



*程序 4-31 LAG与DIF函数隔行取物;
*===隔行取物;
data want;
  set sashelp.class;
  *===前面三人是谁;
  pre1name=lag1(name);
  pre2name=lag2(name);
  pre3name=lag3(name);
  *===身高差多少;
  dif1height=dif1(height);
  dif2height=dif2(height);
  dif3height=dif3(height);
run;

proc print;
run;




