%macro ex_mmcsv
(/*positional parameters:keep in order*/
/*<libref>*/ dslib
,/*rootpath*/rootpath

/*keyword parameters*/
,/*filetype:XLS|XLSX*/ filetype=csv
,/*(blank)|replace */ replace=replace
,/*(blank)|LABEL */label=
);

	proc sql noprint;
	    select count(distinct memname) into: dsnum
		from sashelp.vmember
		where libname=upcase("&dslib") and memtype="DATA";
		select distinct memname into:csv1-:csv%left(&dsnum)
		from sashelp.vmember
		where libname=upcase("&dslib") and  memtype="DATA";
	quit;

	%do i=1  %to &dsnum;
	     proc export data=&&csv&i
		                     outfile="&rootpath.\&&csv&i...&filetype"
							 dbms=csv replace &label;
		run;
	%end ;
%mend ex_mmcsv;

