%macro  im_m1mexcel(dir=) ;
	filename indata  pipe "dir &dir  /b";

	data FileName;
			length fname $20.;
			infile indata truncover;
			input fname $20.;
			dname=scan(fname,1,".");
			call symputx(cats('File',_n_),fname);
			call symputx(cats('ds',_n_),dname);
			call symputx('NumFile',_n_);
	run;
    
	/*****************************************
	 Two other ways to get filelist:
	 
	%sysexec  cd   &dir\; 
	%sysexec  dir  *.xls  /b/o:n > flist.txt; 

	x 'cd  "&dir" ';
	x 'dir   *.xls  /b/o:n > flist.txt ';
	
	data _null_;
		length fname $20.;
		infile "&dir\flist.txt";
		input fname $20.;
		dname=scan(fname,1,".");
		call symputx(cats('File',_n_),fname);
		call symputx(cats('ds',_n_),dname);
		call symputx('NumFile',_n_);	
	run;
	*****************************************/
	
 	%do i=1 %to &NumFile;
        proc  import out=&&ds&i
	                     datafile="&Dir\&&file&i"
						 dbms=excel replace;
	   run;
	%end;
%mend;



%im_m1mexcel(dir=F:\PharmaSUGChina\SUB)
