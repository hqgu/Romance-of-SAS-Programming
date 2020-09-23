


%macro DeDup(dsname=, byvar= , duplevel=, nouni=);

/*=========================================
 针对去重级别（变量，观测）及保留级别（要UNI,不要UNI）
 duplevel= REC|KEY
 nouni=1|0   ;  1: 重复的里面，一个也不要
                0：重复的里面，取第一个
产出数据集：dupout, nodupout,uniout
===========================================*/ 



%if  %upcase(&duplevel)=KEY  and  &nouni=0   %then %do;
   proc sort data=&dsname  nodupkey  dupout=dupout  out=nodupout;
   		by &byvar;
	run;
%end;

%if  %upcase(&duplevel)=KEY  and  &nouni=1   %then %do;
   proc sort data=&dsname nouniquekey    uniout=uniout ;
   		by &byvar;
	run;

	 data dupout;
	    set &dsname;
	run;
%end;

%if  %upcase(&duplevel)=REC and  &nouni=0  %then %do;
   proc sort data=&dsname noduprec     dupout=dupout  out=nodupout;
   		by &byvar;
	run;
%end;

%if  %upcase(&duplevel)=REC  and  &nouni=1   %then %do;
   proc sort data=&dsname nouniquerec   uniout=uniout ;
   		by &byvar;
	run;

	data dupout;
	    set &dsname;
	run;
%end;
%mend DeDup;

