%macro ex_m1mexcel
(/*mulity dataset to 1 exel with multiy sheet*/
/*positional parameters:keep in order*/
/*<libref>*/ dslib
,/*rootpath*/rootpath

/*keyword parameters*/
,/*outfilename:(blank)|othes*/outname=outexel
,/*filetype:XLS|XLSX*/ filetype=xls
,/*(blank)|replace */ replace=replace
,/*(blank)|LABEL */label=
);

	proc sql noprint;
	    select count(distinct memname) into: dsnum
		from sashelp.vmember
		where libname=upcase("&dslib") and memtype="DATA";
		select distinct memname into:sheet1-:sheet%left(&dsnum)
		from sashelp.vmember
		where libname=upcase("&dslib") and  memtype="DATA";
	quit;

	%do i=1  %to &dsnum;
	     proc export data=&&sheet&i
		                     outfile="&rootpath.\&outname...&filetype"
							 dbms=excel replace &label;
							 sheet="&&sheet&i";
		run;
	%end ;
%mend ex_m1mexcel;


