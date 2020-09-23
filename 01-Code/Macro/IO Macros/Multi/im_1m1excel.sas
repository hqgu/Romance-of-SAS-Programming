
%macro im_1m1excel(RootPath,FileName,Extension);

	libname MyExcel Excel "&RootPath.\&Filename..&Extension";
	proc sql noprint;
	  select catt(trim(libname),'.',quote(trim(memname)),'n') into: namelist separated by ' ' 
	  from dictionary.tables
	  where libname in ('MYEXCEL');
	quit;
	%put &namelist;

	data  &FileName;
         set &namelist;
	run;
%mend im_1m1excel;
