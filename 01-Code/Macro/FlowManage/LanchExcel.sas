OPTIONS NOXSYNC NOXWAIT;
filename cmdexcel DDE 'EXCEL|SYSTEM'; /* Fileref for Excel System */
/*********************************************************************/
/* Data step to start Excel if it is not already open */
/*********************************************************************/
data _null_;
 fid = fopen('cmdexcel','S'); /* Check if Excel is open */
 if fid le 0 then
 do; /* Excel is not open, open Excel via Windows registry */
 rc=system("Start Excel"); /* DOS command to open Excel*/
 start = datetime(); /* Note start time */
 stop = start + 5; /* Max time to try opening */
 do while (fid le 0); /* Loop while Excel opens */
 fid = fopen('cmdexcel','S'); /* Check if Excel is open */
 time = datetime(); /* Reset current time */
 if time ge stop then
 fid = time; /* Set FID to terminate loop*/
 end; /* do while (fid le 0); */
 end; /* Excel is not open, open Excel via Windows registry */
 rc = fclose(fid); /* Close fileopen on EXCEL */
run;


/*====other ways to launch excel===*/

 options noxwait noxsync;
 x  start excel;