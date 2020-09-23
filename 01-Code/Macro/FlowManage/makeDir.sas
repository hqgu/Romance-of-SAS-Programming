options
   mprint symbolgen 
   noxwait noxsync
;

%let ProjRoot= %qsubstr(%sysget(SAS_ExecfilePath), 1, %length(%sysget(SAS_ExecfilePath))-%length(%sysget(SAS_ExecfileName)));

%put &ProjRoot;

%macro MakeDir(ProjRoot); 
   x " %str(md %"&ProjRoot\01-Data\01-Raw%"  %"&ProjRoot\01-Data\02-Tidy%"  %"&ProjRoot\01-Data\03-codeBook%" 
	           %"&ProjRoot\02-SAP%"    %"&ProjRoot\03-Ref%"   %"&ProjRoot\04-Code%" 
               %"&ProjRoot\05-Out\01-Table%" %"&ProjRoot\05-Out\02-Figure%"	 %"&ProjRoot\05-Out\03-Draft%"		   
			)" ;
 %mend;

 %MakeDir(&ProjRoot);
