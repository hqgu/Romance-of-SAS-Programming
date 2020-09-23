*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第六章 间有山川亦奇秀：函数例程
*==============================================================================================*;



*程序 6-1 SAS函数实例;

data _null_;
  x=100;
  y=log10(x);
  put x= y=;
 run;



 *程序 6-2 例程示例;
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



*程序 6-3 暴力求均值VS.函数求均值;
 data _null_;
   array  ex{7} (95 93 92 99 98 85 94);
   *===暴力计算均值;
   sum=0;
   cnt=0;
   do i=1 to 7;
   	sum=sum+ex{i};
	cnt=cnt+1;
   end;
   avg_force=sum/cnt;

   *===函数计算均值;
   avg_function=mean(of ex:);

   put  avg_force=;
   put  avg_function=;
  run;


  *程序 6-4 暴力法排序 VS. 例程 排序

 data _null_;
   array  ex1{7} (95 93 92 99 98 85 94);
   array  ex2{7} (95 93 92 99 98 85 94);
   *===暴力排序-选择排序法;
  do i=1 to dim(ex1)-1;
   min=i;
	  do j=i+1  to dim(ex1);
	      if (ex1[min]>ex1[j])  then  do; 
			min=j;
			tmp=ex1[i]; 
	        ex1[i]=ex1[min];
	        ex1[min]=tmp;
	      end;
	   end;
  end;
 *===巧用例程;
  call sortn(of ex2:);

 *==输出结果比较;
 do i=1 to dim(ex1);
    put "选择排序法："ex1[i]  "例程排序：" ex2[i] ;
 end;
 run;





*程序 6-5 函数语法举例;

  data _null_;
   array  ex{7} (95 93 92 99 98 85 94);
 
   *===单个单个参数;
   avg_function1=mean(ex1, ex2, ex3, ex4, ex5, ex6, ex7);
   *===变量清单;
   avg_function2=mean(of ex1 ex2 ex3 ex4 ex5 ex6 ex7);
   avg_function3=mean(of ex1-ex7);
   avg_function4=mean(of ex:);
   *===数组名;
   avg_function5=mean(of ex[*]);
   put (avg_function1  avg_function2 avg_function3 avg_function4 avg_function5) (=);
  run;


  *程序 6-6  CALL例程语法举例;

  data tmp;
   array  str{3} $20 ("统技思维","SAS编程演义","数据整理与图表呈现");
   length result1-result5 $50;
   *===单个单个参数;
   call catx("-",result1,str1,str2,str3);
   *===变量清单;
   call catx("-",result2,of str1 str2 str3);
   call catx("-",result3,of str1-str3);
   call catx("-",result4,of str:);
   *===数组名;
   call catx("-",result5,of str[*]);;
   put (result1  result2  result3  result4  result5) (=);
 run;
 


 *程序 6-7 PROC FCMP 自定义函数;
*===定义函数study_day;
 proc fcmp outlib=sasuser.funcs.trial;
           function study_day(intervention_date, event_date); 
	           n=event_date - intervention_date;
	           if n >= 0 then
	            n=n + 1;
	            return(n);
		    endsub;
run;

*===使用函数studay_day;
options cmplib=sasuser.funcs;
data _null_;
   start='15Feb2010'd;
   today='27Mar2010'd;
   sd=study_day(start, today);  
put sd=;
run;
