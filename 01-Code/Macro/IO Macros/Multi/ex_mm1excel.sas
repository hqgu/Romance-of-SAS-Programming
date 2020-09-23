%macro ex_mm1excel
(/*positional parameters:keep in order*/
/*<libref>*/ dslib
,/*rootpath*/rootpath

/*keyword parameters*/
,/*filetype:XLS|XLSX*/ filetype=xlsx
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
		                     outfile="&rootpath.\&&sheet&i...&filetype"
							 dbms=excel replace &label;
							 sheet="&&sheet&i";
		run;
	%end ;
%mend ex_mm1excel;


%ex_mm1excel(work,d:\12 tst)

