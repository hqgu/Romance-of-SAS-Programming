/* Macro using PROC COPY and the XPORT engine for reading transport files*/
%macro xpt2sas(dir,ext,out);                                                                                                                                                                                                                             
 	 %let filrf=mydir;                     
  	/* Assigns the fileref of mydir to the directory and opens the directory */                                                                    
	  %let rc=%sysfunc(filename(filrf,&dir));                                                                                                
	  %let did=%sysfunc(dopen(&filrf));    
 
	  /* Returns the number of members in the directory */                                                                   
	  %let memcnt=%sysfunc(dnum(&did));                                                                                                      
	                                                                                                                                        
	   /* Loops through entire directory */                                                                                                  
	   %do i = 1 %to &memcnt;     
		     /* Returns the extension from each file */                                                                                                                                    
		     %let name=%qscan(%qsysfunc(dread(&did,&i)),-1,.);                                               
		     /* Checks to see if file contains an extension */                                                                                     
		     %if %qupcase(%qsysfunc(dread(&did,&i))) ne %qupcase(&ext) %then %do;            
				     /* Checks to see if the extension matches the parameter value */                                                                      
				     /* If condition is true, submit PROC COPY statement  */                                                                      
				     %if (%superq(ext) ne and %qupcase(&name) = %qupcase(&ext)) or  (%superq(ext) = and %superq(name) ne) %then %do;                                                                             
					     	libname old xport "&dir.\%qsysfunc(dread(&did,&i))"; 
							libname new "&out";
							proc copy in=old out=new;
							quit;
				     %end;                                                                                                                               
		   %end; 
  %end; 
 
  /* Close the directory */                                                                                                            
  %let rc=%sysfunc(dclose(&did));                                                                                 
%mend xpt2sas;   





