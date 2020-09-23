
%macro im_csv
(/*positional parameters*/
/*<libref>.SAS-data-set*/ dsn
,/*fileref | "filepath"*/ file

/*key-word parameters*/
,/*(blank)|REPLACE */ replace=replace
,/* YES | NO*/ getnames=yes
,/* 20 | N */ guessingrows=20
,/* 2 | N */ datarow=2
);

	proc import out=&dsn
	            datafile=&file
				dbms=csv &replace;
			getnames=&getnames;
			guessingrows=&guessingrows;
			datarow=&datarow;
	run;
%mend im_csv;

