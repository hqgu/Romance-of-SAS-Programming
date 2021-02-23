*=======================================================
 %ggBaseline: generate Demographic Tables with one group or multiple groups 
 Maintainer: Hong-Qiu Gu <guhongqiu@yeah.net> 
 Date: V20180105

 For details, please see and ref Ann Transl Med, 2018, 6(16): 326.
 
 Copyright: CC BY-NC-SA 4.0 
 In short: you are free to share and make derivative 
 works of the work under the conditions that you appropriately 
 attribute it, you use the material only for non-commercial 
 purposes, and that you distribute it only under a license 
 compatible with this one.
  
=======================================================
%ggBaseline(
data=, 
var=var1|test|label1\
    var2|test|label2, or 
    var1|CTN|label1\
    var2|CTG|label2, 
grp=grpvar,
grplabel=grplabel1|grplabel2,  
stdiff=N,
totcol=N, 
pctype=COL|ROW, 
exmisspct=Y|N,
filetype=RTF|PDF, 
file=&ProjPath\05-Out\01-Table\, 
title=,
footnote=, 
fnspace=20,
page=PORTRAIT|LANDSCAPE,
deids=Y|N
)

====================================================;

%macro ggBaseline(
data=, 
var=, 
grp=,
grplabel=,  
stdiff=N,
totcol=N, 
pctype=col, 
exmisspct=Y,
showP=Y,
filetype=rtf, 
file=, 
title=,
footnote=, 
fnspace=,
page=portrait,
deids=Y
);




%if &grp EQ %str() %then  

%ggBaseline1(
data=&data, 
var=&var, 
exmisspct=&exmisspct,
filetype=&filetype, 
file=&file, 
title=&title, 
footnote=&footnote,
fnspace=&fnspace,
page=&page,
deids=&deids
);


%else 

%ggBaseline2(
data=&data, 
var=&var, 
grp=&grp,
grplabel=&grplabel,  
stdiff=&stdiff,
totcol=&totcol, 
pctype=&pctype,
exmisspct=&exmisspct, 
showP=&showP,
filetype=&filetype, 
file=&file, 
title=&title,
footnote=&footnote, 
fnspace=&fnspace,
page=&page,
deids=&deids
);

%mend ggBaseline;





