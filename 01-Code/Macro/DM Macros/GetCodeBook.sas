%macro getCodeBook(data=,outdir=);

  %let ndsn=%sysfunc(countw(&data,.));

  %if  &ndsn eq 1  %then %do;
      %let libname=WORK;
	  %let memname=%scan(&data,1, "(");
  %end;

  %else %do;
      %let libname=%scan(&data,1,.);
	  %let memname=%scan(%scan(&data,2,.),1, "(");
  %end;

	ods output Variables=CodeBook;
	proc contents data=&libname..&memname;
	run;

	proc sort data=CodeBook;
	  by num;
	run;

	proc export  data=CodeBook
	              outfile="&outdir\&memname._codeBook.csv"
				  dbms=csv replace;
	run;
%mend;
