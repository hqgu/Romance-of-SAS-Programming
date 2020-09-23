%macro cutdsbyvar(dsin=, dsout=, var=, cut=);
	proc  univariate data=&dsin;
		var &var;
		output  out=dspctl  
	     %if &cut eq 3 %then pctlpts=33.3 66.6;
	     %else %if &cut eq 4 %then pctlpts=25 50 75;
	     %else %if &cut eq 5 %then pctlpts=20 40 60 80;
	     pctlpre=p;
	run;

	data longdspctl;
	  set dspctl;
	  array pctl[*] _numeric_;
	 do i=1 to %sysevalf(&cut-1);
	    cutpoint=pctl[i];
	  output;
	  end;
	run;

	data _null_;
	  set longdspctl;
	  call symputx(cats("cutp",_n_),cutpoint );
	run;

	data &dsout;
	  set &dsin;
	  length &var.cutgrp  $2;
	  if missing(&var) then call missing( &var.cutgrp);

	  %if &cut=3 %then %do;
	  else if  &var<&cutp1  then &var.cutgrp="Q1";
	  else if  &var<&cutp2 then  &var.cutgrp="Q2";
	  else &var.cutgrp="Q3";
	  %end;

	  %if &cut=4 %then %do;
	  else if  &var<&cutp1  then &var.cutgrp="Q1";
	  else if  &var<&cutp2 then &var.cutgrp="Q2";
	  else if  &var<&cutp3 then &var.cutgrp="Q3";
	  else &var.cutgrp="Q4";
	  %end;


	   %if &cut=5 %then %do;
	  else if  &var<&cutp1  then &var.cutgrp="Q1";
	  else if  &var<&cutp2 then &var.cutgrp="Q2";
	  else if  &var<&cutp3 then &var.cutgrp="Q3";
	  else if  &var<&cutp4 then &var.cutgrp="Q4";
	  else &var.cutgrp="Q5";
	  %end;
	run;

%mend;








     



