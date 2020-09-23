%macro ex_excel
(/*positional parameters:keep in order*/
/*<libref>.SAS-data-set*/ dsn
,/*filepath*/filepath

/*keyword parameters*/
,/*DBMS types: EXCEL | EXCELCS | XLS | XLSX */ dbms=excel
,/*replace: (blank) | REPLACE */ replace=replace
,/*sheet of  spreedsheet: 
   (blank) | sheetname*/sheet=sheet1
,/*(blank)|LABEL */label=
,/*NO|YES*/newfile=no
);

	proc export  data=&dsn
	 				  outfile="&filepath"
					  dbms=&dbms  &replace 	&label;
			sheet="&sheet";
		    newfile=&newfile;      
	run; 
%mend ex_excel;



