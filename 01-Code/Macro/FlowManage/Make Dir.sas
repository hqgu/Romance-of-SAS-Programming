options
   mprint symbolgen 
   noxwait noxsync
;

%let ProjRoot= %qsubstr(%sysget(SAS_ExecfilePath), 1, %length(%sysget(SAS_ExecfilePath))-%length(%sysget(SAS_ExecfileName)));

%put &ProjRoot;

%macro MakeDir(ProjRoot); 
     x   " %str(md   %"&ProjRoot\01 Doc\SPSAP%"    %"&ProjRoot\01 Doc\Ref%"   %"&ProjRoot\01 Doc\Notes%"   %"&ProjRoot\02 Data\Raw%"     %"&ProjRoot\02 Data\Clean%"     %"&ProjRoot\03 Code\Macro%"     %"&ProjRoot\03 Code\Core%"  %"&ProjRoot\04 Out%"  %"&ProjRoot\05 Report%"  )"    ;
 %mend;

 %MakeDir(&ProjRoot);
