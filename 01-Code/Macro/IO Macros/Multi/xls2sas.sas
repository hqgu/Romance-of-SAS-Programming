%macro xls2sas(folder= , subfd= , exclfd= , startrow=  ) ;
	/************************************
        folder:  root folder name to be searched for 
		subfd: include subfolder (Y/N, default=Y) 
		exclfd: subfolder list to be excluded 
		startrow:  starting row of Excel worksheet  
     *************************************/

  	%local _j _cnt  _dsid  _i  _num  _s_ext  _s_name  _filename  _rc; 
	%let _rc=%qsysfunc(filename(filrf,&folder)); 

	 %if &_rc=0 %then 
	 %do; 
  			%let _dsid=%sysfunc(dopen(&filrf)); 
			 %if &_dsid>0 %then 
			 %do; 
				 	%let _num=%sysfunc(dnum(&_dsid)); 
                    %if &_num >0 %then
					 %do _i=1 %to &_num; 
					     %let _filename=%sysfunc(dread(&_dsid,&_i));
					     %let _s_name=%scan(&_filename, 1, .);
					      %let _s_ext=%scan(&_filename, 2, .); 
						
							 %if  %upcase(&_s_ext)= XLS   or  %upcase(&_s_ext)=XLSX  %then 
									%do; 
										Libname excellib excel "&folder\&_filename"; 
										data _null_; 
											 set sashelp.vstabvw end=last; 
											 where libname="EXCELLIB"; 
											 memname=upcase(scan(memname, 1, '$')); 
											 call symputx(cats('sheet', _n_), memname, 'L'); 
											 if last then call symputx('_cnt', _n_, 'L'); 
										run; 

										libname excellib clear; 
										
									%do _j=1 %to &_cnt; 
											 proc import  datafile="&folder\&_filename" 
																 out=%cmpres(&_s_name._&&sheet&_j)
																 dbms=excel replace; 
																 range="&&sheet&_j..$&startrow.:65000"; 
																 mixed=yes; 
																 getnames=yes; 
											 run;
										%end;
									%end; 
						
							 %else %if   %upcase(&_s_ext)=    and  &subfd=Y and %qsysfunc(indexw(&exclfd,&_filename))=0 %then 
								 %do; 
								        %let _rc=%sysfunc(dclose(&_dsid));
										%xls2sas(folder=&folder\&_filename, subfd=&subfd,  exclfd=&exclfd, startrow=&startrow) 
								 %end;
				%end;
			%end;
	%end;
	%let _rc=%sysfunc(dclose(&_dsid));
	%mend xls2sas;