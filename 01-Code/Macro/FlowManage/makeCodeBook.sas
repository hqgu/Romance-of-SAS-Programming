%macro MakeCodeBook(dslib=sashelp,dsname=class,outdir=);
	ods output Variables=CodeBook;
	proc contents data=&dslib..&dsname;
	run;

	proc sort data=CodeBook;
	  by num;
	run;

	proc export  data=CodeBook
	              outfile="&outdir/&dsname._CodeBook.csv"
				  dbms=csv replace;
	run;
%mend MakeCodeBook;
