*===================================================
 %ggBaseline2 : for two or more group baseline infor
 Author:Hongqiu Gu
 Contact: guhongqiu@yeah.net
 Date: V20161220
 
 For details, please see and ref Ann Transl Med, 2018, 6(16): 326.
 
 Copyright: CC BY-NC-SA 4.0 
 In short: you are free to share and make derivative 
 works of the work under the conditions that you appropriately 
 attribute it, you use the material only for non-commercial 
 purposes, and that you distribute it only under a license 
 compatible with this one.
 --------------------------------------------------
  
=======================================================
%ggBaseline2(
data=, 
var=var1|test|label1\
    var2|test|label2,
grp=grpvar,
grplabel=grplabel1|grplabel2,  
stdiff=N,
totcol=N, 
pctype=COL|ROW, 
exmisspct=Y|N,
showP=Y|N,
filetype=RTF|PDF, 
file=&ProjPath\05-Out\01-Table\, 
title=,
footnote=, 
fnspace=20,
page=PORTRAIT|LANDSCAPE
deids=Y|N
)

for categorical variables, 
test should be one of the follow:
CHISQ|CMH1|CMH2|TREND|FISHER|

for continuous  variables, 
test should be one of the follow:
TTEST|ANOVA|WILCX|KRSWLS


Log:
10.20190320 Change param name exmissing to exmisspct
9.20190320 Universe encoding for en dash and plus or minus
8.20181019 Fixed nmiss(%)
7.20181010 Add P value display control
6.20180929 Fixed exmisspct in chisq test
5.20180919 Fixed the HL calculation
4.20180806 Change NNmiss to nmiss(%) 
3.20180725 Exclude missing value from statistical percent
2.20161220 Finish the development of the  macro
1.20161130 Get the idea
====================================================;

%macro ggBaseline2(
data=, 
var=, 
grp=,
grplabel=,  
stdiff=N,
totcol=N, 
pctype=col,
exmisspct=Y,
showP=Y, 
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
	delete  Base2 grplevel desc: eq: tt: hov: anova: dslabel:  pvalue: merge: ;
quit;



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


/*===Check the existance of dataset and grpvar==*/
  %local dsid check rc;
	  %let dsid = %sysfunc(open(&libname..&memname));
	  %if  &dsid=0 %then %do; 
			%put  ERROR: Dataset &libname..&memname is not exist!;  
            %abort; 
      %end; 
	  %else  %do;
		    %let checkvar = %sysfunc(varnum(&dsid.,&grp));
		    %let rc = %sysfunc(close(&dsid.));
		     %if &checkvar. = 0 %then   %do;
               %put  ERROR: Variable &grp does not exists!; 
               %abort; 
             %end;
	 %end;

	 
/*===Set each grp label===*/
%let ngrplabel=%sysfunc(countw(&grplabel,%str(|)));

%do i=1 %to &ngrplabel;
  %let grplabel&i=%scan(&grplabel,&i,|);
%end;

%let grplabel0=Total;



/*===Set a new group var===*/
proc sql;
    create table grplevel as
    select distinct &grp as &grp
	from &data;
quit;

data grplevel;
	set grplevel;
	ngrp+1;
run;

proc print data=grplevel;
run;


proc sql;
  create table ads as 
  select a.*, b.ngrp
  from &data as a left join grplevel as b
  on a.&grp= b.&grp;
quit;


/*===Set total group===*/
%if %upcase(&totcol) EQ Y %then %do;
 data ads;
     set ads;
	 output;
	 ngrp=0;
	 output;
run;
%end;

%let data=ads;
%let grp=ngrp;


/*===Get freqs for each grp===*/
proc sql noprint;
	   select n( distinct &grp) into: ngrp
	   from &data;
	   select count(*) into: nbygrp separated by " "
	   from &data
	   group by &grp;
quit;


%if %upcase(&totcol) EQ Y %then %do;
	%do g=0 %to %sysevalf(&ngrp-1);
		%let n&g=%scan(&nbygrp,%sysevalf(&g+1));
	%end; 
%end;

%if %upcase(&totcol) EQ N %then %do;
	%do g=1 %to &ngrp;
		%let n&g=%scan(&nbygrp,&g);
	%end; 
%end;



/*===Loop each var===*/
%let nvar=%sysfunc(countw(&var,%str(\)));
%do n=1 %to &nvar;	
	%let var&n=%scan(%qscan(&var,&n,%str(\)),1,|);
	%let test&n=%scan(%qscan(&var,&n,%str(\)),2,|);
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
               %put  ERROR: Variable &&var&n is not exists!; 
               %abort; 
             %end;
	 %end;


/* Get vtype for format */
  data _null_;
    set sashelp.vcolumn;
	where upcase(libname)=upcase("&libname") and upcase(memname)=upcase("&memname") and  upcase(name)=upcase("&&var&n");
	call symputx(cats("vtype",&n),type);
  run;

	%descB2(data=&data, var=&&var&n, vtype=&&vtype&n, grp=&grp, test=&&test&n, n=&n)
	%testB2(data=&data, var=&&var&n, vtype=&&vtype&n, grp=&grp, test=&&test&n, n=&n)
	%mergeB2(var=&&var&n, test=&&test&n, varlabel=%quote(&&varlabel&n), n=&n)

%end;



/*===Set dspreort dataset===*/
data Base2;
 %if %upcase(&totcol) eq Y %then %do; 
    format order label %do j=0 %to %sysevalf(&ngrp-1); col&j  %end;  pvalue;
 %end;

 %if %upcase(&totcol) eq N %then %do; 
    format order label %do j=1 %to &ngrp; col&j  %end;  pvalue;
 %end;

 set merge:;
 if strip(label)="^{nbspace 6}" then label="^{nbspace 6}Missing";
run;

proc sort data=Base2;
	by order;
run;


%ggReportB2(data=Base2,filetype=&filetype, file=&file, title=&title, footnote=&footnote, fnspace=&fnspace, page=&page)

%if %upcase(&deids) EQ Y %then %do;
proc datasets lib=work memtype=data;
	save ads grplevel Base2;
quit;
%end;

%mend ggBaseline2;



%macro descB2(data=, var=,vtype=, grp=, test=,n=);
  %if %upcase(&test) in CHISQ  CMH  TREND FISHER  %then %do;
   %desc_ctg_b2(data=&data, var=&var,vtype=&vtype, grp=&grp,n=&n, exmisspct=&exmisspct);
  %end;

  %else %if %upcase(&test) in TTEST  ANOVA WILCX  KRSWLS %then %do;
   %desc_ctn_b2(data=&data, var=&var, grp=&grp,n=&n);
  %end;
%mend descB2;



%macro desc_ctg_b2(data=, var=, vtype=, grp=,n=, exmisspct=);
	proc freq data=&data noprint;
	    table &var*&grp/missing nopercent outpct out=desc&n._n;
		
	    %if %upcase(&exmisspct) eq Y %then %do;
		 table &var*&grp/nopercent outpct out=desc&n._Y;
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
		by &var &grp;
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
	%if %upcase(&pctype) EQ COL %then %do;
        value = compress(put(count,6.)) || ' (' ||compress( put(pct_col,4.1))||')';
	%end;

	%if %upcase(&pctype) EQ ROW %then %do;
        value = compress(put(count,6.)) || ' (' || compress(put(pct_row,4.1))||')';
	%end;

    run;

	proc sort data=desc&n;
		by &var;
	run;

	proc transpose data=desc&n  out=desc&n (drop=_name_) prefix=col;
		by &var;
		var value;
		id &grp;
    run;

	%if &ngrplabel EQ  2 and &stdiff EQ Y %then %do;
	     data desc&n(drop=Psc Pnsc);
           set desc&n;
          if not missing(col1) and not missing(col2) then do;
		   Psc=input(scan(scan(col1,2,"("),1,")"),4.1)/100;
		   Pnsc=input(scan(scan(col2,2,"("),1,")"),4.1)/100;
           stdiff=abs(100*(Psc-Pnsc)/sqrt((Psc*(1-Psc)+ Pnsc*(1-Pnsc))/2));
		  end;
         run;
	%end;

%mend desc_ctg_b2;


%macro desc_ctn_b2(data=, var=, grp=, n=);
    ods output summary=desc&n;
	proc means data=&data n nmiss mean std min max median q1 q3 maxdec=1;
		var &var;
		class &grp;
	run;
	
	proc npar1way data=&data(where=(&grp in (1,2))) hl noprint;
		class &grp;
		var &var;
	    output out=hl&n hl;
	run;
	
	data _null_;
	  set hl&n;
	 if not missing(_HL_) then call symputx("hl&n", _HL_);
	 else call symputx("hl&n", "NA");
	
	run;


	data desc&n(keep= &grp  nnmiss meanstd  minmax  medianIQR);
		set desc&n;
		format nnmiss meanstd  minmax  medianIQR;
		if &var._nmiss ^=0 then do;
		 nnmiss = compress(put(&var._nmiss,6.))||" ("||compress(put(&var._nmiss/nobs*100,4.1))||")";
	    end; 
		minmax = cats(put(&var._min,12.1),unicode("&#8211;","ncr"), put(&var._max,12.1));
		meanstd = cats(put(&var._mean,12.1), unicode("&#177;","ncr"), put(&var._stddev,12.1));
		medianIQR = compress(put(&var._median,6.1))|| " ("||compress(put(&var._q1,6.1))||unicode("&#8211;","ncr")||compress(put(&var._q3,6.1))||")";
	
	run;

	proc transpose data=desc&n  out=desc&n  prefix=col;
		id &grp;
	    var nnmiss meanstd  minmax  medianIQR;
    run;

	%if  &ngrplabel EQ  2 and &stdiff EQ Y  %then %do;
	     data desc&n;
           set desc&n;
	       if _name_="meanstd" then stdiff= 100* ((input(scan(col1,1, unicode("&#177;","ncr")),12.1)-input(scan(col2,1, byte(177)),12.1))/sqrt(( input(scan(col1,2, unicode("&#177;","ncr")),12.1)**2 + input(scan(col2,2,unicode("&#177;","ncr")),12.1)**2 )/2));
           if _name_="medianIQR" then stdiff="&&hl&n";
		 run;
	%end;

		    
%mend desc_ctn_b2;




%macro testB2(data=, var=, vtype=, grp=, test=, n=);
  %if %upcase(&test) in CHISQ  CMH  TREND FISHER  %then %do;
   %freq(data=&data, var=&var, vtype=&vtype, grp=&grp, test=&test, n=&n)
  %end;

  %else %if %upcase(&test) EQ TTEST   %then %do;
   %ttest(data=&data, var=&var, grp=&grp,n=&n)
  %end;

  %else %if %upcase(&test) EQ ANOVA   %then %do;
   %anova(data=&data, var=&var, grp=&grp,n=&n)
  %end;

  %else %if %upcase(&test) in  WILCX KRSWLS  %then %do;
   %npar1way(data=&data, var=&var, grp=&grp, test=&test,n=&n)
  %end;
%mend testB2;



%macro freq(data=, var=, vtype=, grp=, test=, n=);
	proc freq data=&data noprint;
	    %if &totcol eq Y  %then %do; 
		 where not missing(&grp) and &grp NE 0;
		%end;
		
		table &grp*&var/ %if %upcase(&exmisspct) EQ N %then %str(missing); noprint &test;
		
	    format &var  %if &vtype EQ char %then %str($&var.fmt.);%else %str(&var.fmt.); ;
		
		%if %upcase(&test) EQ CHISQ %then %do;
			output out = pvalue&n(keep=p_pchi rename=(p_pchi=pvalue)) pchi;
		%end;
		%if %upcase(&test) in CMH1  %then %do;
			output out = pvalue&n(keep=P_CMHCOR rename=(P_CMHCOR=pvalue)) cmh1;
		%end;
		%if %upcase(&test) in CMH2  %then %do;
			output out = pvalue&n(keep=P_CMHRMS rename=(P_CMHRMS=pvalue)) cmh2;
		%end;
		%if %upcase(&test) EQ TREND %then %do;
			output out = pvalue&n(keep=P2_TREND rename=(P2_TREND=pvalue)) trend;
		%end;
		%if %upcase(&test) EQ FISHER %then %do;
			output out = pvalue&n(keep=XP2_FISH rename=(XP2_FISH=pvalue)) fisher;
		%end;
		
	run;

%mend freq;




%macro ttest(data=, var=, grp=, n=);
    ods output equality=eq&n ttests=tt&n; 
	proc ttest data=&data plots=none;
		class &grp;
		var &var;
	    %if &totcol eq Y %then %do; 
		 where not missing(&grp) and &grp NE 0;
		%end;
	run;
	
	data _null_;
	  set eq&n;
	  call symputx('testeq',ProbF-0.05);
	run;

	data pvalue&n(keep=probt rename=(probt=pvalue));
	 set tt&n;
	 %if %quote(&testeq) GE 0 %then %do;
	 if _n_=1;
	 %end;

	 %if  %quote(&testeq) LT 0 %then %do;
      if _n_=2;
	 %end;
	run;
%mend ttest;



%macro anova(data=, var=, grp=, n=);
	ods output  HOVFTest=hov&n ModelANOVA=anova&n;
	proc anova data=&data plots=none;
		class &grp;
		model &var=&grp;
		means &grp/hovtest;
	    %if &totcol eq Y  %then %do; 
		 where not missing(&grp) and &grp NE 0;
		%end;
	run;

	data _null_;
	 	set hov&n;
	   if _n_=1 then call symputx('hovtest', ProbF-0.05);
	run;

   %if 	%quote(&hovtest) GE 0 %then %do;
	   data pvalue&n(keep=ProbF rename=(ProbF=Pvalue));
	   	set anova&n;
	   run;
   %end;

  %if  %quote(&hovtest) LT 0  %then %do;
	  %npar1way(data=&data, var=&var, grp=&grp, test=KRSWLS,n=&n)
  %end;

%mend anova;


%macro npar1way(data=, var=, grp=, test=, n=);
	proc npar1way data=&data wilcoxon noprint;
		class &grp;
		var &var;
	    output out=pvalue&n wilcoxon;
	 %if &totcol eq Y %then %do; 
		 where not missing(&grp) and &grp NE 0;
		%end;
	run;
		
	data pvalue&n;
	 set pvalue&n;
	 %if %upcase(&test) EQ WILCX %then %do;
		 keep p2_wil;
		 rename p2_wil=pvalue;
	%end;

	 %if %upcase(&test) EQ KRSWLS %then %do;
		 keep p_kw;
		 rename p_kw=pvalue;
	%end;
   run;
%mend;



%macro mergeB2(var=, test=, varlabel=, n=);
	%if %upcase(&test) in CHISQ  CMH  TREND FISHER %then %do;
	 %merge_cate_b2(var=&var, varlabel=&varlabel, n=&n)
	 %end;

	 %else %if %upcase(&test) in TTEST  ANOVA WILCX  KRSWLS  %then %do;
      %merge_cont_b2(var=&var, varlabel=&varlabel,n=&n)
	 %end;
%mend mergeB2;




%macro merge_cate_b2(var=, varlabel=, n=);
 	data dslabel&n;
	  set pvalue&n;
	  length label $ 85;
	  label = cats("^S={font_weight=bold}" , "&varlabel");
   run;


   data merge&n;
     keep order label col: pvalue  %if &ngrplabel EQ  2 and  %upcase(&stdiff) EQ Y %then stdiff;;
   	 length label $ 85;
	 set dslabel&n desc&n(where=(not missing(col1)));   
	 if _n_ > 1 then label= "^{nbspace 6}" ||put(&var,&var.fmt.);
	 order=&n;
   run;
%mend merge_cate_b2;



%macro merge_cont_b2(var=, varlabel=,n=);
  data dslabel&n;
	  set pvalue&n;
	  length label $ 85;
	  label = cats("^S={font_weight=bold}" , "&varlabel");
   run;


   data merge&n;
    keep order label col: pvalue %if &ngrplabel EQ  2 and  %upcase(&stdiff) EQ Y %then stdiff;;
    length label $ 85  ;
    set dslabel&n desc&n(where=(not missing(col1)));  
    
	if _n_ > 1 then
	select;
		when(_NAME_ = 'nnmiss')     label = "^{nbspace 6}Nmiss (%)"; 
		when(_NAME_ = 'minmax')     label = "^{nbspace 6}Min"||unicode("&#8211;","ncr")||"Max";
		when(_NAME_ = 'meanstd')    label = "^{nbspace 6}Mean%sysfunc(byte(177))SD";
		when(_NAME_ = 'medianIQR') label = "^{nbspace 6}Median (IQR)";
		otherwise;
	end;
	order=&n;
  run;

%mend merge_cont_b2;


%macro ggReportB2(data=, filetype=, file=, title=, footnote=, fnspace=, page=);

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

 %if %upcase(&totcol) eq Y %then %do; 
    columns (order label %do j=0 %to %sysevalf(&ngrp-1); col&j  %end;  
	 %if %upcase(&showP) EQ Y %then pvalue ;  
	%if &ngrplabel EQ  2 and %upcase(&stdiff) EQ Y %then stdiff ; );
	define order/ noprint;
	define label /display " Variables";
	%do c=0 %to %sysevalf(&ngrp-1);
	    define col&c /display right  "&&grplabel&c.|(N=&&n&c)" ;
	%end;
	
	%if %upcase(&showP) EQ Y %then %do; 
	define  pvalue /display center "P Value" f = pvalue6.4;
	%end;

    %if &ngrplabel EQ  2 and  %upcase(&stdiff) EQ Y %then  %do;
    define  stdiff /display right  "ASD/HL estimator"  f=6.1; 
	%end;
 %end;

  %if %upcase(&totcol) eq N %then %do; 
    columns (order label %do j=1 %to &ngrp; col&j  %end; 
	%if %upcase(&showP) EQ Y %then pvalue ; 
	%if &ngrplabel EQ  2 and %upcase(&stdiff) EQ Y %then stdiff ; );
	define order/ order  noprint;
	define label /display " Variables";
	%do c=1 %to &ngrp;
		define col&c /display right  "&&grplabel&c.|(N=&&n&c)" ;
	%end;
	
	%if %upcase(&showP) EQ Y %then %do; 
	define  pvalue /display center "P Value" f = pvalue6.4;
	%end;

    %if &ngrplabel EQ  2 and  %upcase(&stdiff) EQ Y %then  %do;
    define  stdiff /display right  "ASD/HL estimator"  f=6.1; 
	%end;
 %end;

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

%mend ggReportB2;









