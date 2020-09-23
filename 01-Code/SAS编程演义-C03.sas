*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第三章 苔点狂吞纳线青：读取数据
*==============================================================================================*;




*程序 03-1 libname语句访问db2数据文件;

libname  mydb2  db2 user=guhq password="88guhq88" datasrc=datadb;

proc export data=sashelp.class
             outfile="d:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\myspssdata.sav"
			 dbms=spss replace;
run;


*程序 03-2 导入SPSS文件;

*==IMPORT过程;
proc import out=mysasdata 
             datafile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\myspssdata.sav" ;
run;


*==LIBNAME语句;
libname  mysav spss "D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\myspssdata.sav";




*程序 3-3 读入规整的 EXCEL 文件;

*===读入EXCEL文件;
filename myxlsx "d:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\class.xlsx";

libname  myexcel xlsx "d:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\class.xlsx";

proc import out=myxls datafile=myexcel
             dbms=excel replace;
run;


*程序 3-4 读入特定区域数据的 EXCEL 文件;
*===读入指定范围的EXCEL文件;
proc import out=myxls datafile=myexcel
             dbms=excel replace;
			 range="'sheet1$A1:E20'n";  /*读入sheet1的A1~E20区域的数据*/
			 getnames=yes;
run;

*===读入指定起止行;
proc import out=myxls datafile=myexcel
             dbms=excel replace;
			 dbdsopts="firstobs=3  obs=18"; /*读入sheet1的3~8行区域的数据*/
			 getnames=yes;
run;



*程序 3-5 PROC IMPORT 读入 CSV 文件;
filename mycsv "D:\03 Writting\01 SAS编程演义\02 Data\Raw\class.csv";
proc import out=tmp datafile=mycsv
			 dbms=csv replace;
			 getnames=yes;
			 guessingrows=20;
			 datarow=2;
run;


*程序 3-6 PROC IMPORT 导入制表符和空格分隔的文本;
*===关联文件;
filename mytxttab "D:\03 Writting\01 SAS编程演义\02 Data\Raw\class_tab.txt";
filename mytxtblk "D:\03 Writting\01 SAS编程演义\02 Data\Raw\class_blk.txt";

*==导入制表符分隔文本;
proc import out=tmp datafile=mytxttab
			dbms=dlm replace;
			delimiter='09'x;
			getnames=yes;
run;

*==导入空格分隔文本;
proc import out=tmp datafile=mytxtblk
				dbms=dlm replace;
				delimiter='20'x;
				getnames=yes;
run;



*程序 3-7 INPUT 语句输入四格表数据;
data trial;
  do group="T","C";
  	do Survive="Yes","No";
	  input freqs@@;  /*从Dataline读入数据*/
	 output;           /*写入数据到数据集*/   
	end;
 end;
datalines;
95 5 90 10
;
run;


*检查四个表结果;
proc freq data=trial;
	table group*survive/nopercent norow nocol ;
	weight freqs;
run;


*程序 3-8 INPUT 列表读入式案例;

*==变量列上不齐整;
data tmp;
  input name $  gender$  age location $;
  datalines;
GHQ M 30 Beijing
TJSW M 1 Beijing
  ;
run;

*===字符name不齐整且字符长度过8;
data tmp;
  input name :$13.  gender$  age location $; /* :表示碰到空格或者第13列，读完name变量的数据 */
  datalines;
GHQ M 30 Beijing
GuHongqiu M 30 Beijing
StatsThinking M 1 Beijing
  ;
run;

*===字符name里有空格;
data tmp;
  input name & $  gender$  age location $; /* &碰到一个空格不会认为此变量结束，还会继续读入 */
  datalines ;
HQ Gu  M 30 Beijing
TJ SW  M 1 Beijing
  ;
run;

*===字符name里有空格且字符长度过8;
data tmp;
  input name : & $10. gender$  age location $;
  datalines ;
  HQ Gu  M 30  Beijing
  Hongqiu Gu  M 30  Beijing
  ;
run;

*===其他分隔符数据,字符affiliation含有分隔符;
data tmp;
  infile datalines delimiter=',' dsd;
  input name $  gender$  age location $ affiliation $12.;
  datalines ;
  HQ Gu,M,30,Beijing,"PUMC,CAMS"
  Hongqiu Gu,M,30,Beijing,"PUMC,CAMS"
  ;
run;



*程序 3-9 INPUT语句列读入案例;

*===列读入;
data tmp;
  input name $ 1-10  gender $ 12  age 14-15 location $ 17-23;
  datalines ;
HQ Gu      M 30 Beijing
Hongqiu Gu M 30 Beijing
  ;
run;


*程序 3-10 INPUT语句格式读入案例;

*===格式读入; 
*===gender虽然这有1列，但是申明时要带上其后面的一个空格，age,locaiotn类似;
data tmp;
  input name : & $10. gender$2.  age 3.  location $8. fee comma6. ;
  datalines ;
  HQ Gu  M 30 Beijing 12,345
  Hongqiu Gu  M 30 Beijing 54,321
  ;
run;


*程序 3 11 INPUT语句命名读入案例;
*===命名式;
data tmp;
  input name= $  gender= $  age= location= $;
  datalines;
name=GHQ gender=M age=30  location=Beijing
name=TJSW gender=M age=1 location=Beijing
;
run;


*程序 3-12 INPUT语句组合式读入案例;

*===综合案例;
data tmp;
  input name : & $10. gender $  age location $ 17-24 +1 fee comma6. ;
  datalines ;
HQ Gu       M 30 Beijing 12,345
Hongqiu Gu  M 30 Beijing 54,321
;
run;



*程序 3-13 PROC EXPORT导出实例;

*===导出TXT文件;
proc export data=sashelp.class
             outfile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\class_tab.txt"
			 dbms=dlm replace;
			 delimiter='09'x;
run;


proc export data=sashelp.class
             outfile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Raw\class_blk.txt"
			 dbms=dlm replace;
			 delimiter='20'x;
run;


*===导出为EXCEL文件;
proc export data=sashelp.class
             outfile="D:\03 Writting\01 SAS编程演义\02 Data\Raw\class.xlsx"
			 dbms=excel replace;
run;

*===导出为CSV文件;
proc export data=sashelp.class
             outfile="D:\03 Writting\01 SAS编程演义\02 Data\Raw\class.csv"
			 dbms=csv replace;
run;

