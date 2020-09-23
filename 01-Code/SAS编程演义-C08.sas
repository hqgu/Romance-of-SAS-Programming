*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: 第八章 菱花荇蔓随双浆：百变绘图
*==============================================================================================*;


*===自定义样式;
proc template;
  define style styles.ggStyle;
	parent = Styles.Htmlblue;

	*==修改图形大小;
	style Graph from Graph/
	OutputWidth=14cm
	OutputHeight=10cm 
	BorderWidth=0;
   
	*==修改图形填充边框;
	style  GraphBorderLines from GraphBorderLines /
	LineThickness=0px 
	LineStyle=1;

    *==修改图形边框;
	style GraphOutlines from GraphOutlines/
	LineStyle=1
	LineThickness=0px;
    
	*==修改整个图形边框;
    style  GraphWalls from GraphWalls/
	FrameBorder=off
	LineThickness=0px 
	LineStyle=1; 
   end;
run;




proc template;                                                                
   define style Styles.ggplot2;                                              
      parent = styles.listing; 

	  style color_list from color_list
	     "Abstract colors used in graph styles" /
		 'bgA'   = cxffffff; 

      class GraphColors
         "Abstract colors used in graph styles" /
         'gwalls' =cxebebeb
		 'glegend'=cxebebeb
		 'ggrid'  =cxFFFFFF
		  'gcdata7' = cxfb61d7
	      'gdata7' = cxfb61d7
	      'gcdata6' = cxa58aff
	      'gdata6' = cxa58aff
	      'gcdata5' = cx00b6eb
	      'gdata5' = cx00b6eb
	      'gcdata4' = cx00c094
	      'gdata4' = cx00c094
	      'gcdata3' = cx53b400
	      'gdata3' = cx53b400
	      'gcdata2' = cxc49a00
	      'gdata2' = cxc49a00
	      'gcdata1' = cxf8766d
	      'gdata1' = cxf8766d 
           'gcdata'=cxf8766d
           'gdata'=cxf8766d;

      class GraphWalls /                                                      
         linethickness = 1px                                                  
         linestyle = 1                                                        
         frameborder = on   
         contrastcolor = GraphColors('gwalls')                                 
         backgroundcolor = GraphColors('gwalls')                              
         color = GraphColors('gwalls');   

      class GraphGridLines /                                                  
         displayopts = "on"                                                 
         linethickness = 1px                                                  
         linestyle = 1                                                        
         contrastcolor = GraphColors('ggrid')                                 
         color = GraphColors('ggrid');

      class GraphAxisLines /                                                  
         tickdisplay = "outside"                                              
         linethickness = 1px                                                  
         linestyle = 1                                                        
         contrastcolor = GraphColors('gaxis');  
 
      class GraphBox /                                                        
         capstyle = "serif"                                                   
         connect = "mean"                                                     
        displayopts = "fill median mean outliers";

		*==修改图形大小;
		style Graph from Graph/
		OutputWidth=14cm
		OutputHeight=10cm 
		BorderWidth=0;
	   
		*==修改图形填充边框;
		style  GraphBorderLines from GraphBorderLines /
		LineThickness=0px 
		LineStyle=1;

	    *==修改图形边框;
		style GraphOutlines from GraphOutlines/
		LineStyle=1
		LineThickness=0px;
	    
	    *==修改Markersymbol;
	   class GraphData1 from GraphData1 /
       markersymbol = "CircleFilled" ;
	   class GraphData2 from GraphData2 /
       markersymbol = "CircleFilled" ;
	   class GraphData3 from GraphData3 /
       markersymbol = "CircleFilled" ;
	   class GraphData4 from GraphData4 /
       markersymbol = "CircleFilled" ;
	   class GraphData5 from GraphData5 /
       markersymbol = "CircleFilled" ;
	   class GraphData6 from GraphData6 /
       markersymbol = "CircleFilled" ;
	   class GraphData7 from GraphData7 /
       markersymbol = "CircleFilled" ;

	   *==修改坐标轴;
		class GraphAxisLines from GraphAxisLines/
		tickdisplay = "outside"
		linethickness = 0px
		linestyle = 1;
 end;
run;




*===使用样式;
ods html style=mystyle gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;



ods html style=ggplot2;

*程序 8-1 SAS/Graph 模块画图举例;

*===画散点图;
proc gplot data=sashelp.class;
   plot height*weight;
run;

symbol1 interpol=rcclm95  value=circle  cv=darkred   
        ci=black   co=blue   width=2;   
plot height*weight;
run;
quit;


*==画直条图;
proc gchart data=sashelp.class;
  block sex/sumvar=weight ;
run;



*程序 8-2 生存分析自动产生K-M曲线;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;




*程序 8-3 ODS Graphics语句设置;

*===ODS GRAPHICS语句设置长宽、图片名字以及格式，并要求绘制累积事件图;
ods graphics on/width=20cm height=18cm  noborder 
                imagename="failureplot" outputfmt=jpg;
proc lifetest data=sashelp.bmt plots=(s(f));
	time t*status(0);
	strata group;
run;


proc lifetest data=sashelp.bmt plots=(s);
	time t*status(0);
	strata group;
run;





*程序 8-4 SAS ODS Graphics编辑器;
ods html sge=on;
ods graphics on/width=20cm height=18cm  noborder 
                imagename="failureplot"  outputfmt=jpg;
proc lifetest data=sashelp.bmt plots=(s(f));
	time t*status(0);
	strata group;
run;
ods html sge=off;



*程序 8-5 Proc sgplot绘图;

*===散点+回归;
proc sgplot data=sashelp.class;
   scatter x=height y=weight;
   reg   x=height y=weight/cli clm;   
run;

*==画直条图;
proc sgplot data=sashelp.class;
  vbar sex/respose=weight;
run;



*=程序 8-6 用GTL绘制散点和回归线图;

*==定义;
proc template;
 define statgraph scattereg;
 	begingraph;
	layout overlay;
	scatterplot x=height y=weight;
	regressionplot x=height y=weight/name= "fitline" legendlabel="Regression line" clm="clm" cli="cli" ;
	modelband  "clm"/name="bandclm" legendlabel="95% CLI" datatransparency=0.3;
	modelband  "cli"/name="bandcli" legendlabel="95% CLM" display=(outline); 
    discretelegend "fitline" "bandclm"  "bandcli";
    endlayout;
   endgraph;
  end;
run;

*==渲染;
proc sgrender data=sashelp.class template=scattereg;
run;




*=======
 STYLE
========;

proc template;
   list styles;
run;

proc template;
	source styles.htmlblue;
    source styles.statistical;
	source styles.default;
run;







*=====================
 统计图形精选
======================;

dm odsresults 'clear' continue;

ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;


ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;

ods html style=ggStyle gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;



*程序 8-7 Proc Sgplot的hbar与vbar语句绘制条图;

*===简单直条图;

*==纵向;
proc sgplot data=sashelp.cars  ;
	vbar DriveTrain/categoryorder=respdesc  ;
run;

*==横向;
proc sgplot data=sashelp.cars ;
	hbar DriveTrain/categoryorder=respdesc ;
run;



*程序 8-8 Proc freq过程调用ODS Graphics系统绘制频数图;  
*===频数图;
proc freq data=sashelp.cars;
	table DriveTrain/plots=freqplots;
run;



*程序 8 9 Proc sgplot的vbar语句绘制带误差限单式条图;

*==误差限;
proc sgplot data=sashelp.cars;
	vbar type/response=msrp stat=mean limitstat=stddev limits=upper ;
run;


/**/
/**=连续变量;*/
/*proc sgplot data=sashelp.cars;*/
/*	vbar type/response=msrp stat=mean;*/
/*run;*/
/**/




*程序 8-10 Prog Sgplot的hbar语句绘制百分比条图;

*===构建辅助变量;
data cars;
	set sashelp.cars;
	Drive_Train="Drive Type";
run;

*===Stat指定统计百分比，groupdisplay指定堆叠方式;
proc sgplot data=cars noborder;
	hbar Drive_Train/group=DriveTrain groupdisplay=stack 
                     stat=percent categoryorder=respdesc ;
run;



*程序 8-11 Proc sgplot的vbar语句绘制复式条图;
proc sgplot data=sashelp.cars  ;
	vbar origin/group=DriveTrain groupdisplay=cluster;
run;


*程序 8-12 Proc sgplot的vbar语句绘制簇拥式复式误差限条图;
proc sgplot data=sashelp.cars;
	vbar origin/response=msrp stat=mean  group=type groupdisplay=cluster limitstat=stddev limits=upper ;
run;


*程序 8-13 Proc sgplot 的vbar语句绘制复式百分比条图;

*===复式百分比条图-簇拥式;
proc sgplot data=sashelp.cars  pctlevel=group;
	  vbar origin/group=DriveTrain groupdisplay=cluster stat=percent;
run;

*===复式百分比条图-堆叠式;
proc sgplot data=sashelp.cars  pctlevel=group;
	vbar origin/group=DriveTrain groupdisplay=stack stat=percent categoryorder=respdesc;
run;



*程序 8-14 Proc freq过程plots选项绘制马赛克图;
proc freq data=sashelp.cars;
	table origin*DriveTrain/plots=mosaicplot;
run;


*程序 8-15 Proc sgplot绘制镜面复式条图;

*===创建测试数据集;
data Pop;
  length AgeGroup $12; 
  do AgeGroup='Pre Teen', 'Teen', 'Young Adult', 'Adult', 'Senior';
    Male=round(500*(1+ranuni(2))); 
    Female=round(400*(1+ranuni(2))); 
    output;
  end;
run;

*===变换镜面数据;
data butterfly;
  set pop;
  Male=-male; 
  zero=0; 
run;

*===格式设定;
proc format;
  picture positive low-<0='0000'
                   0<-high='0000';
run;

*===横向镜面;
proc sgplot data=ButterFly;
  format male female positive.;   
  hbarparm category=agegroup response=male ;
  hbarparm category=agegroup response=female;
  xaxis display=(noline nolabel) values=(-1000 to 1000 by 200) ;
  yaxis display=(noline nolabel);
  keylegend /  position=right across=1 noopaque ;
run;


*===纵向镜面;
proc sgplot data=ButterFly;
  format male female positive.;   
  vbarparm category=agegroup response=male ;
  vbarparm category=agegroup response=female;
   xaxis display=(noline nolabel);
  yaxis display=(noline nolabel) values=(-1000 to 1000 by 200) ; 
  keylegend /  position=right across=1 noopaque ;
run;






*程序 8-16 Proc sgpanel绘制面板条图;

*===簇拥式;
proc sgpanel data=sashelp.cars pctlevel=group;
    panelby type;
	vbar origin/group=DriveTrain groupdisplay=cluster stat=percent;
run;

*===堆叠式;
proc sgpanel data=sashelp.cars pctlevel=group;
    panelby type;
	vbar origin/group=DriveTrain groupdisplay=stack stat=percent categoryorder=respdesc;
run;





/*================================

           直方图
================================*/


*程序 8-17 简单直方图的Sgplot和Univariate过程;
*===简单直方图（sgplot）;
proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20;
run;

*===简单直方图（univariate）;
proc univariate data=sashelp.cars;
  histogram msrp;
run;



*程序 8-18 Prog sgpot绘制重叠直方图;
*===叠加直方图;

proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20 group=type ;
run;

/*proc sgplot data=sashelp.cars;*/
/*	histogram msrp/nbins=20 group=origin transparency=0.4;*/
/*run;*/


*程序 8-19 多个histogram语句绘制重叠直方图;
proc sgplot data=sashelp.cars;
  histogram mpg_city / binstart=0 binwidth=2 transparency=0.5  ;
  histogram mpg_highway / binstart=0 binwidth=2  transparency=0.5 ;
run;




*程序 8-20 GTL绘制镜面直方图;

*===横向镜面直方;
proc template;
  define statgraph MirrorHistogramHorz;
    dynamic _binwidth;
      begingraph;

      entrytitle 'Mileage Distribution';
      layout lattice / order=columnmajor columnweights=(0.49 0.51) rowdatarange=union;

        cell;
		  cellheader;
		     entry 'City Mileage';
		  endcellheader;
          layout overlay / xaxisopts=(reverse=true griddisplay=on display=(tickvalues) 
                           linearopts=(tickvaluepriority=true tickvaluesequence=(start=0 end=25 increment=5))) 
                           yaxisopts=(display=none reverse=true griddisplay=on 
                           linearopts=(tickvaluesequence=(start=0 end=70 increment=10)));
           histogram mpg_city / binstart=0 binwidth=_binwidth orient=horizontal binaxis=false 
                                fillattrs=graphdata1 datatransparency=0.3 ;
	      endlayout;
		endcell;

        cell;
		  cellheader;
		     entry 'Highway Mileage';
		  endcellheader; 
          layout overlay / xaxisopts=(griddisplay=on display=(tickvalues) 
		                   linearopts=(tickvaluepriority=true tickvaluesequence=(start=0 end=25 increment=5))) 
                           yaxisopts=(display=(tickvalues) reverse=true griddisplay=on 
                           linearopts=(tickvaluesequence=(start=0 end=70 increment=10)));
	        histogram mpg_highway / binstart=0 binwidth=_binwidth  orient=horizontal binaxis=false 
                                    fillattrs=graphdata2 datatransparency=0.3;
	      endlayout;
		endcell;

	  endlayout;
	endgraph;
  end;
run;

proc sgrender data=sashelp.cars template=MirrorHistogramHorz;
  dynamic _binwidth=2;
run;




*===纵向镜面直方图;

*本段代码受Sanjay Matange的博客启发，授权依据其血压镜面图代码修改。在此致谢;
*===定义模板;
proc template;
  define statgraph MirrorHistogramVert;
    dynamic _binwidth;
      begingraph;
      entrytitle 'Mileage Distribution';
     *==定义布局;
     layout lattice /columndatarange=union rowgutter=0;
	      *==定义横轴;
	      columnaxes;
		    columnaxis /display=(tickvalues) griddisplay=on 
                        linearopts=(tickvaluesequence=(start=0 end=60 increment=10) tickvaluepriority=true);
		  endcolumnaxes;

		  *==上部分直方图;
          layout overlay /walldisplay=none xaxisopts=(griddisplay=on)
		                  yaxisopts=(griddisplay=on display=(tickvalues label) 
                          linearopts=(tickvaluesequence=(start=5 end=25 increment=5) tickvaluepriority=true));
            histogram mpg_city /binstart=0 binwidth=_binwidth  binaxis=false 
                                fillattrs=graphdata1 datatransparency=0.3 ;
		    entry halign=right 'City Mileage' /valign=top;
	      endlayout;
          
		  *==下部分直方图;
          layout overlay /walldisplay=none  xaxisopts=(griddisplay=on)
                          yaxisopts=(reverse=true griddisplay=on display=(tickvalues label)  
                          linearopts=(tickvaluesequence=(start=5 end=25 increment=5) tickvaluepriority=true));                           ;
		    histogram mpg_highway /binstart=0 binwidth=_binwidth binaxis=false 
		                           fillattrs=graphdata2 datatransparency=0.3;
		    entry halign=right 'Highway Mileage' /valign=bottom;
	    endlayout;

	endlayout;
  endgraph;
  end;
run;

*===渲染模板;
ods graphics /NOBORDER reset width=5in height=3in imagename='MirrorHistogramVert';
proc sgrender data=sashelp.cars template=MirrorHistogramVert;
  dynamic _binwidth=2;
run;



ods graphics/ reset=all  outputfmt=jpg;
/*ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;*/
/*ods html style=ggStyle gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;*/
ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;



*程序 8-21 Proc sgpanel绘制面板直方图;
proc sgpanel data=sashelp.cars;
  panelby origin/layout=columnlattice;
  histogram mpg_city / binstart=0 binwidth=2 transparency=0.5  ;
  histogram mpg_highway / binstart=0 binwidth=2  transparency=0.5 ;
run;




*====================
   箱线图
=====================;


*程序 8-22 Proc sgplot绘制箱线图;
*==纵向;
proc sgplot data=sashelp.cars;
	vbox msrp;
run;

*==横向;
proc sgplot data=sashelp.cars;
	hbox msrp;
run;


*程序 8-23 Proc sgplot绘制分组箱线图;
*===分组;
proc sgplot data=sashelp.cars;
	vbox msrp/group=type ;
run;



*程序 8-24 Proc sgpanle绘制面板箱线图;
*===面板;
proc sgpanel data=sashelp.cars;
     panelby origin/layout=columnlattice;
	vbox msrp/group=type ;
run;




*=====================
   散点；
=====================;


*程序 8-25 Proc sgplot绘制散点图;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
run;


*程序 8-26 Proc sgpot绘制散点回归图;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
  reg x=horsepower  y=mpg_highway;
run;



*程序 8-27 Proc sgplot绘制分组散点图;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway/group=type;
run;


*程序 8-28 Proc sgpanel绘制面板散点图;
proc sgpanel  data=sashelp.cars;
  panelby origin/layout=columnlattice;
  scatter x=horsepower  y=mpg_highway/group=type;
run;



*程序 8-29 Proc sgplot绘制泡泡图;
proc sgplot data=sashelp.cars  ;
	bubble x=horsepower y=mpg_highway size=enginesize;
run;


*程序 8-30 Proc sgscatter绘制矩阵散点图;
proc sgscatter data=sashelp.cars;
 	matrix mpg_highway   horsepower enginesize/diagonal=(histogram normal);
run;


proc sgscatter data=sashelp.cars;
 	matrix mpg_highway   horsepower enginesize/diagonal=(histogram normal) group=type;
run;

	


*=================
  折线图
=================;

*程序 8-31 Proc sgplot的series语句绘制简单折线图;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
  series x=date y=close ;
run;

*程序 8-32 Proc sgplot的vline语句绘制简单折线图;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean markers;
run;

*程序 8-33 Proc sgplot绘制误差限折线图;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean limits=both  limitstat=stddev markers;
run;
	
	

*程序 8-34 Proc sgplot绘制分组折线图;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean group=type
                    limits=both  limitstat=stddev markers;
run;
	


*程序 8-35 Proc sgplot绘制面板折线图;
proc sgpanel data=sashelp.cars;
    panelby origin/layout=columnlattice;
	vline cylinders/response=msrp stat=mean group=type
                    limits=both  limitstat=stddev markers;
run;



*===Area plot;

*程序 8 36 Proc sgplot绘制面积图;
*==非重叠面积图;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=0 upper=high/legendlabel="High";
run;

*==重叠面积图;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=0 upper=high/legendlabel="High";
    band x=date lower=0 upper=low/legendlabel="Low";
run;


*程序 8 37 Proc sgplot绘制带状图;
*==带状图;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=low upper=high;
run;




*==============================

   拟合图形
==============================;


*程序 8-38 拟合密度曲线;
ods html dpi=300;
ods graphics /width=10cm height=8cm;

*===统计过程;
proc univariate data=sashelp.cars;
	histogram msrp/normal;
run;

*===绘图过程;
proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20;
	density msrp;
run;




*程序 8-39 拟合回归线;
*==统计过程;
proc reg data=sashelp.cars plots(only)=fitplot;
  model mpg_highway=horsepower;
quit;

*==绘图过程;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
  reg x=horsepower  y=mpg_highway/cli clm;
run;


*程序 8-40 Proc sgplot绘制椭圆曲线;
proc sgplot data=sashelp.cars;
    scatter x=horsepower y=mpg_highway;
	ellipse x=horsepower y=mpg_highway;
run;



*程序 8-41 Proc Logistic绘制ROC曲线;
proc logistic data=sashelp.heart plots=roc;
	class sex Chol_Status  BP_Status  Weight_Status  Smoking_Status;
    model Status(event="Dead")=AgeAtStart sex Chol_Status  BP_Status  Weight_Status  Smoking_Status;
run;



*程序 8-42 Prco lifetest绘制生存曲线与累积事件曲线;
*==生存曲线;
proc lifetest data=sashelp.bmt plots=s;
	time t*status(0);
	strata group;
run;

*==累积事件;
proc lifetest data=sashelp.bmt plots=s(failure);
	time t*status(0);
	strata group;
run;



*程序 8-43 Proc sgplot和Proc loess绘制LOESS曲线;

*==Proc sgplot;
proc sgplot data=sashelp.cars;
	loess x=horsepower y=mpg_highway;
run;

*===Proc loess;
proc loess data=sashelp.cars  plots(only)=(FitPlot);
      model mpg_highway=horsepower/select= AICC  alpha=.05 all;
run;


*程序 8-44 Proc sgplot绘制样条函数曲线;

proc sgplot data=sashelp.cars;
	pbspline  x=horsepower y=mpg_highway ;
run;




/*=========================

       森林图
=========================*/


proc import out=fr 
			 datafile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Clean\forest_t.csv"
			 dbms="csv" replace;
run;



*程序 8 45 Proc sgplot绘制简单森林图;
ods graphics /height=10cm;
proc sgplot data=fr noautolegend nocycleattrs nowall noborder;
     
	*==文字;
	yaxistable Study	CABG	PCI_DES	RR  / position=left labelattrs=(size=7);
	*==图;
	scatter y=study x=rr_m / markerattrs=graphdata2(symbol=squarefilled);
	scatter y=study x=rr_2 / markerattrs=graphdata2(symbol=diamondfilled size=10);
	highlow y=study low=rr_l high=rr_u / type=line;

	*==底部文本;
	text y=study x=xlbl text=lbl /position=center contributeoffsets=none;
	
	*==坐标轴;
	xaxis  max=3  minor display=(nolabel) valueattrs=(size=7);
	yaxis display=none fitpolicy=none reverse  colorbands=even valueattrs=(size=7) colorbandsattrs=Graphdatadefault(transparency=0.8);

	*==参考线;
	refline 1 / axis=x noclip;
run;



*程序 8 46 SAS 9.40M3 sgplot实现亚组分析森林图核心程序;

*==此段代码原创自Sanjay Matange，笔者仅增加注释文字;
proc sgplot data=forest_subgroup_2 nowall noborder nocycleattrs dattrmap=attrmap noautolegend;
  styleattrs axisextent=data;
  *==左边文字;
  yaxistable subgroup  / location=inside position=left textgroup=id labelattrs=(size=7) 
             textgroupid=text indentweight=indentWt ;
  yaxistable countpct / location=inside position=left labelattrs=(size=7) valueattrs=(size=7);
  yaxistable PCIGroup group pvalue / location=inside position=left  pad=(right=15px) 
             labelattrs=(size=7) valueattrs=(size=7);
  *==绘制95%CIBAR;
  highlow y=obsid low=low high=high; 
  *==绘制Bar的中点;
  scatter y=obsid x=mean / markerattrs=(symbol=squarefilled);
  *==二次绘制Bar中点,关联x2axis;
  scatter y=obsid x=mean / markerattrs=(size=0) x2axis;
  *==底部文字;
  text x=xl y=obsid text=text / position=bottom contributeoffsets=none strip;
  format text $txt.;
  *==坐标轴;
  yaxis reverse display=none colorbands=odd colorbandsattrs=(transparency=1) offsetmin=0.0;
  xaxis display=(nolabel) values=(0.0 0.5 1.0 1.5 2.0 2.5);
  x2axis label='Hazard Ratio' display=(noline noticks novalues) labelattrs=(size=8);
  *==参考线;
  refline 1 / axis=x;
  refline ref / lineattrs=(thickness=13 color=cxf0f0f7);
run;



*====GTL实现;

%macro  PltRatio(Dataset=, ObsID=obsid, Indent=indent, FactorVar=factor, FactorLbl=Factor,n1=n1,p1=p1,ctnpct1Lbl=Treat, n2=n2, p2=p2, ctnpct2Lbl=Control, ratio=ratio, lcl=lcl, ucl=ucl, ratiocllbl=%str(Ratio(95% CI)), P=p,Plbl=P value, width=10, height=7);

 ods graphics / reset width=&width.cm height=&height.cm ; 
  data ForestRatioDS;
	  set &dataset;
    FactorLbl="&FactorLbl";
    ctnpct1Lbl="&ctnpct1Lbl";
    ctnpct2Lbl="&ctnpct2Lbl";
		RatioclLbl="&ratiocllbl";
    Plbl="&Plbl";

		%if &n1 NE %str() and &p1 NE %str() %then %str(
		ctnpct1=cats(&n1,'(',put(&p1,6.2),')');
		ctnpct2=cats(&n2,'(',put(&p2,6.2),')');
    );
		
		ratiocl=cats(put(&ratio,6.2),'(',put(&lcl,6.2),'-',put(&ucl,6.2),')');
	  pv=put(&p,6.4);

		%if &n1 NE %then %do;
      if missing(&n1) then call missing(ctnpct1,ctnpct2,ratiocl,ratiocl,pv);
		%end;
run;


proc template;
	define statgraph Forest_DataLabel_Indent_93;
		dynamic  _bandcolor;
		begingraph;
			layout lattice / columns=2 columnweights=(0.8 0.2);

				/*--First column for Subgroup and patient counts--*/
				layout overlay / walldisplay=none 
					x2axisopts=(display=(tickvalues) offsetmin=0.05 offsetmax=0.1 tickvalueattrs=(size=8)) 
					yaxisopts=(reverse=true display=none tickvalueattrs=(weight=bold) offsetmin=0);

					referenceline y=ref / lineattrs=(thickness=14 color=_bandcolor);

					scatterplot y=eval(ifn(&Indent=0, &ObsID, .)) x=FactorLbl / datalabel=&FactorVar markerattrs=(size=0) datalabelposition=right 
						xaxis=x2 discreteoffset=-0.25 datalabelattrs=(weight=bold size=7  color=black); /*subgroup title*/

			        scatterplot y=eval(ifn(&Indent=1, &ObsID, .)) x=FactorLbl / datalabel=&FactorVar markerattrs=(size=0) datalabelposition=right 
						xaxis=x2 discreteoffset=-0.15 datalabelattrs=(weight=normal size=7  color=black); /*subgoup value*/


					scatterplot y=&ObsID  x=ctnpct1Lbl / datalabel=ctnpct1 markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=ctnpct2Lbl / datalabel=ctnpct2 markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=ratioclLbl / datalabel=ratiocl markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=plbl / datalabel=Pv markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

				endlayout;

				/*--Second column showing odds ratio graph--*/
				layout overlay / yaxisopts=(reverse=true display=none offsetmin=0) walldisplay=none
					xaxisopts=(type=log label="Ratio" tickvalueattrs=(size=8) labelattrs=(size=9)  );
					referenceline y=ref / lineattrs=(thickness=14 color=_bandcolor);
					highlowplot y=&ObsID low=&lcl  high=&ucl;
					scatterplot y=&ObsID x=&ratio  / markerattrs=(symbol=squarefilled);
					referenceline x=1;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=ForestRatioDS template=Forest_DataLabel_Indent_93;
	dynamic _bandcolor='cxf0f0f0';
run;
%mend;


proc import out=plotds datafile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Clean\plot data1.csv"
			 dbms=csv replace;
run;

ods html dpi=300;

%PltRatio(Dataset=plotds, ObsID=id,FactorVar=endpoint,width=18, height=14)






*================================
 统计地图
================================;

*===心怀祖国;
*==GMAP过程;
proc gmap map=maps.china data=maps.china ;
      id id; 
     choro id /nolegend;
run;
quit;

*==GMAP过程;
proc gmap map=mapsgfk.china data=mapsgfk.china ;
      id id; 
     choro id /nolegend;
run;
quit;

*===SGPLOT过程;
proc sgplot data = maps.china ;
 scatter x = x y = y /markerattrs=(size=2);
 xaxis  display=none ; 
 yaxis  display=none ;
run;


*==放眼世界;
proc gmap map=mapsgfk.world data=mapsgfk.world ;
	id id;
	choro id/nolegend;
run;
quit;


proc gmap map=mapsgfk.us data=mapsgfk.us ;
	id id;
	choro id/nolegend;
run;
quit;





*===加地名;

*==中国;
*==调用自带宏;
%annomac
%maplabel(mapsgfk.china, mapsgfk.China_attr(keep=id1 id1nameU), anno_label,id1nameU,id1)




/* Determine the center of the map areas */
%centroid(mapsgfk.china,centers,id);
%maplabel(centers, mapsgfk.China_attr(keep=id1 id1nameU), anno_label,id1nameU,id1)

data anno_label;
	set anno_label;
	text=input(Id1nameU, $uesc50.);
run;
proc gmap map=mapsgfk.china  data=mapsgfk.china;
	id id1;
	choro id1/nolegend anno=anno_label;
run;
quit;


data names; 
   merge centers(in=a) mapsgfk.china_attr;
   by id;
   if a;
   retain xsys '2' ysys '2' when 'a' function 'label';
   length text $20 color $8;
   text=input(Id1nameU, $uesc50.);
   position='5'; color='black'; size=1;
   output;
   text=trim(id1name);
   position='8'; color='gray11'; size=0.5;
   output;
run;


proc sort data=names(where=(position='5' and isoname="CHINA")) nodupkey;
  by text;
run;

ods graphics /width =25cm  height=18cm;
proc gmap data=mapsgfk.china map=mapsgfk.china ;
   id  id1 id  ; 
   choro id/ anno=names coutline=graybb  nolegend;
run; 
quit; 



*===统计地图;
proc import out=gdp2013 
             datafile="D:\03-Publishing\B01-Book\01 SAS编程演义\02 Data\Clean\gdp.csv"
			 dbms=csv replace;
run;



proc sql;
 create table chinagdp as
 select a.*, b.*
 from maps.china as a left join  gdp2013 as b
 on a.id=b.id;
quit;


*===热力地图;
ods listing style=styles.colorramp;
proc gmap map=maps.china data=chinagdp ;
      id id; 
      choro avggdp2013;
run;
quit;

ods listing style=styles.colorramp;
proc gmap map=maps.china data=chinagdp ;
      id id; 
      choro pm25;
run;
quit;




/*================
  美国
================*/

*程序 8-47  PROC GMAP绘制美国地图;
proc gmap map=maps.us  data=maps.us;
	id state;
	choro state/nolegend ;
run;
quit;

proc gmap map=mapsgfk.us data=mapsgfk.us ;
	id id;
	choro id/nolegend;
run;
quit;

proc sgplot data=mapsgfk.us;
 scatter x = x y = y /markerattrs=(size=4);
 xaxis  display=none ; 
 yaxis  display=none ;
run;



*===标注各州;
%annomac
%maplabel(mapsgfk.us, mapsgfk.us_states_attr(keep=id idname), anno_label,idname,id)

*===画图;
proc gmap map=maps.us  data=maps.us;
	id state;
	choro state/nolegend anno=anno_label;
run;

quit;



*程序 8-48 Proc gmap绘制统计地图;
data sample;
   input st $  pop2010 @@;
   state=stfips(st);
   datalines;
AL 4779736 AK 710231 AZ 6392017 AR 2915918
CA 37253956 CO 5029196 CT 3574097 DE 897934
DC 601723 FL 18801310 GA 9687653 HI 1360301
ID 1567582 IL 12830632 IN 6483802 IA 3046355
KS 2853118 KY 4339367 LA 4533372 ME 1328361
MD 5773552 MA 6547629 MI 9883640 MN 5303925
MS 2967297 MO 5988927 MT 989415 NE 1826341
NV 2700551 NH 1316470 NJ 8791894 NM 2059179
NY 19378102 NC 9535483 ND 672591 OH 11536504
OK 3751351 OR 3831074 PA 12702379 RI 1052567
SC 4625364 SD 814180 TN 6346105 TX 25145561
UT 2763885 VT 625741 VA 8001024 WA 6724540
WV 1852994 WI 5686986 WY 563626 PR 3725789 
;
run;


*===统计地图;
proc gmap map=maps.us data=sample ;
      id state; 
      block pop2010/levels=6;
	  format est2015 pop2010 comma12.;
run;
quit;


*程序 8-49 Proc gmap绘制热力地图;
ods listing style=styles.ggplot2;
proc gmap map=maps.us data=sample ;
      id state; 
      choro pop2010/levels=6 anno=anno_label;
	  format pop2010 comma12.;
run;
quit;




/*===============================
  修改样式
================================*/

*程序 8-50 ODS HTML默认输出样式；
ods html style=htmlblue;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;

*程序 8-51 更换输出样式;
ods html style=analysis;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;

ods html style=journal;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;




*=程序 8-52 SG过程语句选项修改图形外观;


ods html  gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/outputfmt=jpg;

*==默认效果;
ods html style=htmlblue;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;


*==SG过程选项修改效果;
ods graphics /noborder;
proc sgplot data=sashelp.cars noborder;
	histogram weight/binwidth=500  binstart=2000 nooutline fillattrs=(color=green);
	density weight/type=normal lineattrs=graphfit2;
    density weight/type=kernel lineattrs=graphfit3(color=blue);
	keylegend /noborder;
run;


*程序 8-53 GTL语句选项修改图形外观;
proc template;
	define statgraph hisdensity;
	  begingraph;
		layout overlay /walldisplay=none;
	    	histogram weight/binwidth=500  binstart=2000  fillattrs=(color=green) outlineattrs=(thickness=0);
			densityplot weight/normal() lineattrs=graphfit2;
	        densityplot weight/kernel() lineattrs=graphfit3(color=blue);
		endlayout;
	endgraph;
	end;
run;

		
proc sgrender data=sashelp.cars template=hisdensity;
run;



*==========================
  SAS 调用R;
*==========================;

*==检查是否有限制的系统选项;
proc options restrict;
run;
	

*==检查R选项;
proc options option=Rlang;
run;


*程序 8 54 用程序查看样式源文件;
proc template;
  source styles.default;
run;

*程序 8-55 PROC TEMPLATE自定义样式文件

*===自定义样式;
proc template;
  define style styles.ggStyle;
	parent = Styles.Htmlblue;

	*==修改图形大小;
	style Graph from Graph/
	OutputWidth=14cm
	OutputHeight=10cm 
	BorderWidth=0;
   
	*==修改图形填充边框;
	style  GraphBorderLines from GraphBorderLines /
	LineThickness=0px 
	LineStyle=1;

    *==修改图形边框;
	style GraphOutlines from GraphOutlines/
	LineStyle=1
	LineThickness=0px;
    
	*==修改整个图形边框;
    style  GraphWalls from GraphWalls/
	FrameBorder=off
	LineThickness=0px 
	LineStyle=1; 
   end;
run;



*程序 8-56 自定义样式文件模仿R包ggplot2风格;

*==SAS模仿ggplot2风格;
ods graphics/ outputfmt=jpg width=18cm height=20cm;
ods html style=ggplot2;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway/group=type;
  keylegend /position=right across=1 noopaque;
run;

*==SAS调用R对比;
proc iml;
	call ExportDatasetToR("SAShelp.cars","df");
	submit/R;
	library(ggplot2)
	ggplot(data = df, mapping = aes(x=Horsepower,y=MPG_Highway,color=Type))+
		geom_point() 
	endsubmit;
quit;



*==绘图比较;

*===使用样式;
ods html style=mystyle gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg ;
*===散点;



*程序 8-57  ODS语句设置图片属性;

ods html style=ggStyle gpath="d:\B01-Book\01 SAS编程演义\04 Out\StatsGraph" dpi=600;
ods graphics/  width=14cm height=10cm  outputfmt=jpg;



*程序 8-58  ODS语句设置图片属性;

ods listing gpath="D:\myGraph" dpi=300;
*===矢量图;
ods graphics on/imagename="myeps" outputfmt=EPS;

*===位图;
ods graphics on/imagename="mytif" outputfmt=TIF;


*程序 8-59 一个语句搞定学术期刊图片格式设置;

*===矢量图;
ods printer printer=Postscript FILE="D:\myeps.eps" dpi=300;
绘图语句
ods printer close;

*===位图;
ods printer printer=tiff FILE="D:\mytiff.tiff" dpi=300;
绘图语句
ods printer close;
