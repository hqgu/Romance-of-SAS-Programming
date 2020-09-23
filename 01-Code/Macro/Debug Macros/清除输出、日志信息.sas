ods listing close;
ods output close;
ods results=off;/*不显示在“结果”窗口*/
dm output 'clear' continue;	/*清除“输出窗口”*/
dm log 'clear' continue;/*清除“日志窗口”*/
dm result 'clear' continue;	/*清除“编辑窗口”*/
dm odsresult 'clear' continue;/*清除“结果”窗口*/
proc print data=sashelp.class;
run;
