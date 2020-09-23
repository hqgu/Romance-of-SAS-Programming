%macro im_excel
(/*positional parameters:keep in order*/
/*<libref>.SAS-data-set*/ dsn
,/*fileref | "filepath"*/file

/*keyword parameters*/
,/*DBMS types: EXCEL | EXCELCS | XLS | XLSX */ dbms=excel
,/*replace: (blank) | REPLACE */ replace=replace
,/*range of spreedsheet:(blank) | rangename|sheet$ | sheet$UR:LR  */range=
,/*firstobs : N*/ firstobs=1
,/*obs: N */ obs=1048576
,/*YES|NO */ getnames=yes
,/*YES|NO */ scantext=yes
,/*YES|NO */ scantime=yes
,/*YES|NO */ usedate=yes
,/*YES|NO */ mixed=no
);

proc import  out=&dsn
	 			 datafile=&file
				 dbms=&dbms  &replace;
			range="&range";
			dbdsopts="firstobs=&firstobs  obs=&obs";
            getnames=&getnames;
            scantext=&scantext;
            scantime=&scantime;
			usedate=&usedate;
			mixed=&mixed;
run;
%mend im_excel;


