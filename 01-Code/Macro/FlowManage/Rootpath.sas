%let  CodeRoot= %qsubstr(%sysget(SAS_ExecfilePath), 1, %length(%sysget(SAS_ExecfilePath))-%length(%sysget(SAS_ExecfileName)));
%let  ProjRoot=%qsubstr(&CodeRoot,1,%length(&CodeRoot)-18);
%put  &ProjRoot;