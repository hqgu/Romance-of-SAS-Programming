%macro CheckDsVar(ds =, var =);
  %local dsid check rc;
  %let dsid = %sysfunc(open(&ds.));
  %if  &dsid=0 %then %DO; %put  Dataset &ds. is not exist!;  %ABORT; %END; %else  %do;
	  %let check = %sysfunc(varnum(&dsid., &var.));
	  %let rc = %sysfunc(close(&dsid.));
	  %if &check. = 0 %then   %DO ;%put   Variable &var is not exists!  ; %ABORT; %END;
  %end;
%mend CheckDsVar;