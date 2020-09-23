
%macro im_mm1excel(dir=); 
  options  symbolgen mprint noxwait noxsync; 
     %sysexec cd &dir; 
     %sysexec dir  *.xls  /b/o:n > flist.txt; 
	data _indexfile; 
		length filename $200; 
		infile "&dir.\flist.txt"; 
		input filename $; 
	run; 
	proc sql noprint; 
		select count(filename) into :filenum from _indexfile; 
		%if &filenum>=1 %then %do; 
		select filename into :file1-:file%left(&filenum) 
		from _indexfile; 
		%end; 
	quit; 
 %do i=1 %to &filenum; 
 libname excellib excel "&dir.\&&file&i"; 
	proc sql noprint; 
		create table sheetname as 
		select tranwrd(memname, "''", "'") as sheetname 
		from sashelp.vstabvw 
		where libname="EXCELLIB"; 
		select count(DISTINCT sheetname) into :sheetnum 
		from sheetname; 
		select DISTINCT sheetname into :sheet1 - :sheet%left(&sheetnum) 
		from sheetname; 
	quit; 
  data want;
  run;
 %do j=1 %to &sheetnum; 
 %let dsname=%sysfunc(compress(%sysfunc(catx( _,%sysfunc(scan(&&file&i,1,".")),&&sheet&j)),$));
 %put &dsname;
	proc import datafile="&dir.\&&file&i" 
					out=&dsname
                    dbms=excel replace; 
					sheet="&&sheet&j"; 
					getnames=yes; 
					mixed=yes; 
	run; 
   data &dsname; 
    	length _excelfilename $100 _sheetname $32; 
  	 	set &dsname; 
	 	_excelfilename="%scan(&&file&i,1)"; 
		_sheetname="&&sheet&j"; 
	run; 
    data want;
      set   want  &dsname; 
 run; 
%end; 
	libname excellib clear; 
%end; 
%mend im_mm1excel; 



