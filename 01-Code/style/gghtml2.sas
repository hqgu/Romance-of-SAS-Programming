*==============================================================================================*
Book: SAS编程演义/Romance of SAS Programming
Author:谷鸿秋/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
*==============================================================================================*;
proc template;                                                                
   define style Styles.Gghtml2;                                               
      parent = Styles.Htmlblue;                                               
      style Graph from Graph /                                                
         width = 14cm                                                         
         height = 10cm                                                        
         borderwidth = 0;                                                     
      style GraphBorderLines from GraphBorderLines /                          
         linethickness = 0px                                                  
         linestyle = 1;                                                       
      style GraphOutlines from GraphOutlines /                                
         linestyle = 1                                                        
         linethickness = 0px;                                                 
      style GraphWalls from GraphWalls /                                      
         frameborder = off                                                    
         linethickness = 0px                                                  
         linestyle = 1;                                                       
      class GraphColors                                                       
         "Abstract colors used in graph styles" /                             
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
         'gcdata' = cxf8766d                                                  
         'gdata' = cxf8766d;                                                  
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
   end;                                                                       
run;                                
