
/*===use it instead of run and quit statements===*/

%macro RunQuit();
  ;run;quit;
  %if &syserr. ne 0 %then %do;
     %abort cancel;
	 %end;
 %mend; 
	 
