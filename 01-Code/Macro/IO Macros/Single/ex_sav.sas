%macro ex_sav
(/*positional parameters*/
/*<libref>.SAS-data-set */ dsn
,/* filepath */ filepath

/* key-words parameters*/
,/* (blank) | REPLACE */ replace=replace
,/*  libref.format-catalog 's libref */ libref=work
,/*  libref.format-catalog 's cata */  cata=spssfmt
);

	proc export data=&dsn
	   				 outfile="&filepath"
					 dbms=spss &replace;
					 *fmtlib=&libref..&cata.;
	run;
%mend ex_sav;




