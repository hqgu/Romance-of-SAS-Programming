*===================================================
 %ggBaseline1 paramter: for one group baseline infor
 Author:Hongqiu Gu
 Contact: guhongqiu@yeah.net
 Date: V20161220
 For details, please see Ann Transl Med, 2018, 6(16): 326.
 
 Copyright: CC BY-NC-SA 4.0 
 In short: you are free to share and make derivative 
 works of the work under the conditions that you appropriately 
 attribute it, you use the material only for non-commercial 
 purposes, and that you distribute it only under a license 
 compatible with this one.
 --------------------------------------------------
 
Usage example: 
%ggBaseline1(
data=, 
var=var1|CTN|label1\
    var2|CTG|label2,
exmisspct=Y|N,	
filetype=RTF|PDF, 
file=&ProjPath\05-Out\01-Table\, 
title=, 
footnote=,
fnspace=20,
page=PORTRAIT|LANDSCAPE,
deids=Y|N,
)


Log:
7.20190320 Change param name exmissing to exmisspct
6.20190320 Universe encoding for en dash and plus or minus
5.20181019 Fix nmiss(%)
4.20180806 Change nMISS to nmiss(%)
3.20180725 Add exmissing parameter
2.20161220 Finsh the macro
1.20161130 Get the idea
====================================================;

%macro ggBaseline1(
data=, 
var=,
exmisspct=Y, 
filetype=rtf, 
file=, 
title=, 
footnote=,
fnspace=,
page=portrait,
deids=Y
);

options minoperator nofmterr;
dm odsresults 'clear' continue;

/*===Delete last time report data===*/
proc datasets lib=work memtype=data;
	delete Base1 desc: dslabel: merge:;
run;


/*===Get Libname and memname===*/
  %let ndsn=%sysfunc(countw(&data,.));

  %if  &ndsn eq 1  %then %do;
      %let libname=WORK;
	  %let memname=%scan(&data,1, "(");
  %end;

  %else %do;
      %let libname=%scan(&data,1,.);
	  %let memname=%scan(%scan(&data,2,.),1, "(");
  %end;



/*===Loop every var===*/
%let nvar=%sysfunc(countw(&var,%str(\)));

%do n=1 %to &nvar;	
	%let var&n=%scan(%qscan(&var,&n,%str(\)),1,|);
	%let vartype&n=%scan(%qscan(&var,&n,%str(\)),2,|);
	%let varlabel&n=%scan(%qscan(&var,&n,%str(\)),3,|);
        

/*===Check the existance of dataset and var==*/
  %local dsid check rc;
	  %let dsid = %sysfunc(open(&libname..&memname));
	  %if  &dsid=0 %then %do; 
			%put  ERROR: Dataset &libname..&memname is not exist!;  
            %abort; 
      %end; 
	  %else  %do;
		    %let checkvar = %sysfunc(varnum(&dsid.,&&var&n));
		    %let rc = %sysfunc(close(&dsid.));
		     %if &checkvar. = 0 %then   %do;
               %put  ERROR: Variable &&var&n does not exists!; 
               %abort; 
             %end;
	 %end;


/* Get vtype for format */
   data _null_;
    set sashelp.vcolumn;
	where upcase(libname)=upcase("&libname") and upcase(memname)=upcase("&memname") and  upcase(name)=upcase("&&var&n");
	call symputx(cats("vtype",&n),type);
   run;

	%descB1(data=&data, var=&&var&n, vtype=&&vtype&n, vartype=&&vartype&n,varlabel=%quote(&&varlabel&n),n=&n)
%end;

data Base1;
 format order label col1;
 set merge:;
 if strip(label)="^{nbspace 6}" then label="^{nbspace 6}Missing";
run;

proc sort data=Base1;
	by order;
run;

proc sql noprint;
	   select count(*) into: ntotal
	   from &data;
quit;


%ggReportB1(data=Base1,filetype=&filetype, file=&file, title=&title, footnote=&footnote, fnsapce=&fnspace, page=&page)


/*===Delete tmp data==*/

%if %upcase(&deids) EQ Y %then %do;
proc datasets lib=work memtype=data;
	save  Base1;
quit;
%end;

%mend ggBaseline1;



%macro descB1(data=, var=, vtype=, vartype=,varlabel=,n=);
  %if %upcase(&vartype) EQ CTG  %then %do;
   %desc_ctg_b1(data=&data, var=&var,vtype=&vtype, varlabel=&varlabel,n=&n, exmisspct=&exmisspct)
  %end;

  %else %if %upcase(&vartype) EQ CTN  %then %do; 
   %desc_ctn_b1(data=&data, var=&var, varlabel=&varlabel,n=&n)
  %end;
%mend descB1;



%macro desc_ctg_b1(data=, var=, vtype=, varlabel=, n=, exmisspct=);
	proc freq data=&data noprint;
	     table &var/ missing outcum out=desc&n._n;
		 
	    %if %upcase(&exmisspct) eq Y %then %do;
		 table &var/outcum out=desc&n._y;
		%end;	
		
				
        %if &vtype eq char %then %do;
          format &var  $&var.fmt.;
		%end;
		%else %do;
          format &var  &var.fmt.;
		%end;
	run;
	
	%if %upcase(&exmisspct) eq Y %then %do;
	  data desc&n;
	    update desc&n._n desc&n._Y;
		by &var;
	  run;
	%end;	

	%else %do;
		data desc&n;
		 set desc&n._n;
		run;
	%end;	

	data desc&n;
	 set desc&n;
	 length value $25;
     value = compress(put(count,6.)) || ' (' ||compress(put(percent,4.1))||')';
 
    run;

	proc sort data=desc&n;
		by &var;
	run;

	proc transpose data=desc&n  out=desc&n (drop=_name_) prefix=col;
		by &var;
		var value;
	run;

	data dslabel&n;
	 length label $ 85;
	 label = cats("^S={font_weight=bold}" , "&varlabel");
   run;


   data merge&n;
     keep order label col1;
   	 length label $ 85;
	 set dslabel&n desc&n;	 
	 if _n_ > 1 then label= "^{nbspace 6}" || put(&var,&var.fmt.);
	 order=&n;
   run;

%mend desc_ctg_b1;


%macro desc_ctn_b1(data=, var=, varlabel=, n=);
    ods output summary=desc&n;
	proc means data=&data n nmiss mean std min max median q1 q3 maxdec=1;
		var &var;
	run;

	data desc&n(keep= nnmiss meanstd  minmax  medianIQR);
		set desc&n;
		format nnmiss meanstd  minmax  medianIQR;
		
		if &var._nmiss ^=0 then do;
		nnmiss = compress(put(&var._nmiss,6.))||" ("||compress(put(&var._nmiss/nobs*100,4.1))||")";
	    end; 
		
		minmax = cats(put(&var._min,12.1),unicode("&#8211;","ncr"), put(&var._max,12.1));
		meanstd = cats(put(&var._mean,12.1), byte(177), put(&var._stddev,12.1));
		medianIQR = compress(put(&var._median,6.1))|| " ("||compress(put(&var._q1,6.1))||unicode("&#8211;","ncr")||compress(put(&var._q3,6.1))||")";
	run;

	proc transpose data=desc&n  out=desc&n  prefix=col;
		var nnmiss meanstd  minmax  medianIQR;
    run;

    data dslabel&n;
	  length label $ 85;
	  label = cats("^S={font_weight=bold}" , "&varlabel");
   run;


   data merge&n;
    keep order label col1 ;
    length label $ 85  ;
	set dslabel&n desc&n(where=(not missing(col1)));    
	if _n_ > 1 then
	select;
		when(_NAME_ = 'nnmiss')     label = "^{nbspace 6}Nmiss (%)"; 
		when(_NAME_ = 'minmax')     label = "^{nbspace 6}Min"||unicode("&#8211;","ncr")||"Max";
		when(_NAME_ = 'meanstd')    label = "^{nbspace 6}Mean%sysfunc(byte(177))SD";
		when(_NAME_ = 'medianIQR')  label = "^{nbspace 6}Median (IQR)";
		otherwise;
	end;
	order=&n;
  run;


%mend desc_ctn_b1;



%macro ggReportB1(data= ,filetype=, file=, title=, footnote=, fnsapce=, page=);

options nodate nonumber  orientation=&page missing = '';
ods escapechar='^';

%if %upcase(&filetype) EQ  RTF %then %do;
	ods tagsets.rtf style=journal3a file="&file..&filetype";
%end;
%if %upcase(&filetype) EQ  PDF %then %do;
	ods pdf style=journal3a file="&file..&filetype";
%end;

title j=center height=12pt "^{nbspace &fnspace}&title";

proc report data=&data nowindows spacing=1 headline headskip split = "|" ; 
     columns (order label col1);
	 define order/order  noprint;
	 define label /display " Variables";
     define col1 /display  %sysfunc(compress("Statistics |(N=&ntotal)")) right ;



	%if &footnote NE %str() %then %do;
		footnote1 j=left height=10pt "^{nbspace &fnspace}Note: &footnote";
	%end;
run;

%if %upcase(&filetype) EQ  RTF %then %do;
	ods tagsets.&filetype close;
%end;
%if %upcase(&filetype) EQ  PDF %then %do;
	ods pdf close;
%end;

title;
footnote1;
footnote2;

%mend ggReportB1;









