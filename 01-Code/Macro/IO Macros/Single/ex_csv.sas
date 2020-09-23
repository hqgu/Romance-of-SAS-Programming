
%macro ex_csv
(/* positional parameters */
/* <libref>.SAS-data-set  */ dsn
,/* filepath */ filepath

/* key-word parameters */
,/*(blank)|REPLACE */ replace=replace
,/* YES | NO*/ putnames=yes
);

	proc export data=&dsn
	                  outfile="&filepath"
					  dbms=csv  &replace;
			putnames=&putnames;
	run;
%mend ex_csv;

