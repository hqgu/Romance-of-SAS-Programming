*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
*==============================================================================================*;

proc template;                                                                
   define style Styles.ggplot2;                                               
      parent = styles.listing;                                                
      style color_list from color_list                                        
         "Abstract colors used in graph styles" /                             
         'bgA' = cxffffff;                                                    
      class GraphColors                                                       
         "Abstract colors used in graph styles" /                             
         'gdata' = cxf8766d                                                   
         'gcdata' = cxf8766d                                                  
         'gdata1' = cxf8766d                                                  
         'gcdata1' = cxf8766d                                                 
         'gdata2' = cxc49a00                                                  
         'gcdata2' = cxc49a00                                                 
         'gdata3' = cx53b400                                                  
         'gcdata3' = cx53b400                                                 
         'gdata4' = cx00c094                                                  
         'gcdata4' = cx00c094                                                 
         'gdata5' = cx00b6eb                                                  
         'gcdata5' = cx00b6eb                                                 
         'gdata6' = cxa58aff                                                  
         'gcdata6' = cxa58aff                                                 
         'gdata7' = cxfb61d7                                                  
         'gcdata7' = cxfb61d7                                                 
         'ggrid' = cxFFFFFF                                                   
         'glegend' = cxebebeb                                                 
         'gwalls' = cxebebeb;                                                 
      class GraphWalls /                                                      
         color = GraphColors('gwalls')                                        
         backgroundcolor = GraphColors('gwalls')                              
         contrastcolor = GraphColors('gwalls')                                
         frameborder = on                                                     
         linestyle = 1                                                        
         linethickness = 1px;                                                 
      class GraphGridLines /                                                  
         color = GraphColors('ggrid')                                         
         contrastcolor = GraphColors('ggrid')                                 
         linestyle = 1                                                        
         linethickness = 1px                                                  
         displayopts = "on";                                                  
      class GraphBox /                                                        
         displayopts = "fill median mean outliers"                            
         connect = "mean"                                                     
         capstyle = "serif";                                                  
      style Graph from Graph /                                                
         borderwidth = 0                                                      
         height = 10cm                                                        
         width = 14cm;                                                        
      style GraphBorderLines from GraphBorderLines /                          
         linestyle = 1                                                        
         linethickness = 0px;                                                 
      style GraphOutlines from GraphOutlines /                                
         linethickness = 0px                                                  
         linestyle = 1;                                                       
      class GraphDataDefault /                                                
         markersymbol = "CircleFilled";                                       
      class GraphData1 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData2 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData3 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData4 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData5 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData6 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphData7 /                                                      
         markersymbol = "CircleFilled";                                       
      class GraphAxisLines /                                                  
         linestyle = 1                                                        
         linethickness = 0px                                                  
         tickdisplay = "outside";                                             
   end;                                                                       
run;                       
