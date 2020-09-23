%macro im_sav
(/*positional parameters*/
/*<libref>.SAS-data-set */ dsn
,/* fileref | "filepath" */ file

/* key-words parameters*/
,/* (blank) | REPLACE */ replace=replace
,/*  libref.format-catalog 's libref */ libref=work
,/*  libref.format-catalog 's cata */  cata=spssfmt
);

	proc import out=&dsn
	   				 datafile=&file
					 dbms=spss &replace;
					 *fmtlib=&libref..&cata.;
	run;
%mend im_sav;

