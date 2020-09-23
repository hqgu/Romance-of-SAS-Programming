%macro im_mmmexcel(dir=);
	%let rs=%sysfunc(filename(filref,&dir));
	 %if  &rs=0 %then 
     %do;
			%let did=%sysfunc(dopen(&filref));
			 %if &did>0 %then 
             %do;
					%let nobs=%sysfunc(dnum(&did));
					%if &nobs>0 %then  
				    %do i=1 %to &nobs.;
						    %let name=%qscan(%qsysfunc(dread(&did,&i)),1,.);
						    %let ext=%qscan(%qsysfunc(dread(&did,&i)),-1,.);
							%if %upcase(&ext)=XLS  or %upcase(&ext)=XLSX %then 
							%do;        
				 
							        libname MyExcel Excel "&dir.\&name..&ext.";
								    run;

							        proc sql noprint;
							                select count(distinct memname) into :number
							                from sashelp.vmember
							                where libname="MYEXCEL";
							                select compress(memname,"$") into :sheet1 - :sheet%left(&number)
							                from sashelp.vmember
							                where libname="MYEXCEL";
							        quit;

									%do j=1 %to &sqlobs; 
										proc import out=%cmpres(&name._&&sheet&j)
														 datafile="&dir.\&name..&ext."
														 dbms=excel replace;
												         getnames=yes;
											             sheet="&&sheet&j";
										                mixed=yes;
									    run;
									%end;				
								%end;
					%end;
		%end;
	%end;

%let rc=%sysfunc(dclose(&did));
%mend im_mmmexcel;