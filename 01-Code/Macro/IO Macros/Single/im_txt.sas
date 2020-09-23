
%macro  im_txt
(/*data set name*/ dsn
,/*fileref | "filepath" */file
,/*delimiter: TAB | SPACE | other specified*/dlm
);

	proc import  out=&dsn
                     datafile=&file
					 dbms=dlm  replace;
					 %if  %qupcase(&dlm)=TAB %then  %str(delimiter='09'x;);
					  %else %if %qupcase(&dlm)=SPACE  %then  %str(delimiter='20'x;);
					  %else  %str(delimiter="&dlm";);
					 getnames=yes;
	run;
%mend im_txt;


