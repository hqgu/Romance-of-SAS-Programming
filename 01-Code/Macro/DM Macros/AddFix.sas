%macro AddVarFix(dsname=,dsout=,prefix=,suffix=,fromno=,tono=) ;
/*===================================

Exmaple: 

%renamevar(dsname=sashelp.class,dsout=work.class,prefix=,suffix=suf,fromno=,tono=);

===================================*/
ods trace on;
	ods output variables=varlist  ;
	proc contents data=&dsname;
run;

proc sql;
  select  cats(variable,"=", %if  &prefix ne  %then "&prefix._"; %else "";,variable, %if  &suffix ne  %then "_&suffix"; %else "";)
            into : renamelist  separated by " "
 from   varlist
%if &fromno ne and &tono ne %then 
 where  num between &fromno and &tono ;;
quit;

%put &renamelist;

%let dslib1=%scan(&dsname,1,.);
%let dsn1=%scan(&dsname,2,.);

%let dslib2=%scan(&dsout,1,.);
%let dsn2=%scan(&dsout,2,.);

proc datasets  lib=&dslib2;
	copy  out=&dslib2   in=&dslib1 memtype=data;
	select &dsn1;
	change  &dsn1=&dsn2;
    modify  &dsn2;
  		rename &renamelist;
quit;
%mend  AddVarFix;



