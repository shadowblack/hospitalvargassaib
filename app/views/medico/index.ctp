<link rel="stylesheet" type="text/css" href="<?php echo $this->Html->webroot."js/jquery/jquery-window-5.03/css/jquery.window.css";  ?>"/>
 <?php
    echo $this->Html->script("script/util.js"); 
    echo $this->Html->script("men_mac/js/interface.js");
    echo $this->Html->script("jquery/jquery-window-5.03/jquery.window.js");          
 ?> 

 <link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/js/men_mac/style.css"?>"/>  
		<script type="text/javascript">
			jQuery(function(){			     
                
                 jQuery("body:eq(0)").addClass('standar_fondo');
                 jQuery("#accordion").accordion({
        		      header: "h3",              
                      autoHeight:false,
                      alwaysOpen: false		                                   
                });
                
                   jQuery("#reg_med_pac").click(function(){            
                   jQuery("#men_izq_reg").attr("src","<?php echo $this->Html->url('../medico_menu/registrar')?>");
                   
        		});
                   
                   jQuery("#confi_med_pac").click(function(){            
                   jQuery("#men_izq_reg").attr("src","<?php echo $this->Html->url('../medico_menu/configurar')?>");
                   
        		});
                   
                   jQuery("#repo_med_pac").click(function(){            
                   jQuery("#men_izq_reg").attr("src","<?php echo $this->Html->url('../medico_menu/reporte')?>");
                   
        		});
                   jQuery("#esta_med_pac").click(function(){            
                   jQuery("#men_izq_reg").attr("src","<?php echo $this->Html->url('../medico_menu/estadistica')?>");
                   
        		});
                
    			jQuery('#dock').Fisheye(
    				{
    				    
                        fishEyeItemName: ".FishEye",
    					maxWidth: 50,
    					items: 'a',
    					itemsText: 'span',
    					container: '.dock-container',
    					itemWidth: 50,//tama�o del  menu
    					proximity: 90,
    					halign : 'center'
                                                        
    				}
    			)
                });
		</script>      	
 <!-- base -->     
 <div class="standar_content">  
   <table style="width:100%" border="0" class="menu_top_window" align="center">
    <tr>
        <td align="center">            
            <img src="<?php echo $this->webroot?>/img/menu_top/header/Banner.png" style="width: 747px; height: 240px; margin-top: 0px;"/>
        </td>
    </tr>    
    <tr>
         <td style="height: 35px;">
            <!--Botones Superiores--> 
                   
            <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: -30px;">
                <tr>        
                    <td align="right">                                        
                        <div class="dock" id="dock">
                            <div class="dock-container">
                                <a class="dock-item" href="<?php echo $this->Html->url("/MedicoMenu/registrar");?>" target="men_izq_reg">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/registrar.png" alt="Registrar" />
                                </a>                                
                                
                                <a class="dock-item" href="<?php echo $this->Html->url("/MedicoMenu/reporte");?>" target="men_izq_reg">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/reporte.png" alt="Reporte" />
                                </a>
                                 
                                <a class="dock-item" href="<?php echo $this->Html->url("/MedicoMenu/estadistica");?>" target="men_izq_reg">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/estadistica.png" alt="Estadistica" />
                                </a>
                                 
                                <a class="dock-item" target="_BLANK" href="<?php echo $this->webroot?>/manual.pdf">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/ayuda.png" alt="Ayuda" />
                                </a>
                                 
                                <a class="dock-item" href="<?php echo $this->Html->url("/Medico/salir");?>">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/salir.png" alt="Salir" />
                                </a>   
                            </div>
                        </div>
                                                                      
                    </td>
                    
                </tr>
            </table>
            <table  width="40%" border="0" align="right">
                 <tr>        
                    <td align="center"> 
                        <div class="standar_font">
                            <span style="font-weight: bold;"><?php echo __("Operador", true)?>: </span><?php echo $nomb_usu;?>
                        </div>
                    </td>
                 </tr> 
            </table>
            <!--Fin de los Botones Superiores-->                                    
        </td>
    </tr>
    <tr>
        <td style="height: 400px;" valign="top" align="center">  
            <div id="win_console" style="width: 100%;overflow-y:auto ;">                
            <table border="0" style="margin-top: 2px;">
                <tr>
                    <td  valign="top">
                        <!-- windows -->
                        <table class="" border="0" cellpadding="0" cellspacing="0" >
                           <!--Top-->
                            <tr>
                                <td class="top_menu_window_top_left">
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_circle">
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_center" style="width:200px;">
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_right">                    
                                    &nbsp;
                                </td>
                            </tr>
                            <!--Cuerpo-->
                            <tr>
                                <td class="top_menu_window_body_left">
                                    &nbsp;
                                </td>                
                                <td align="center" valign="top" class="top_menu_window_body_center" colspan="2"  style="width:*;height: 150px;">
                                    <!-- Iframe izquierdo-->
                                    <iframe id="men_izq_reg" name="men_izq_reg" src="medico_menu/registrar" width="220"  frameborder="0" scrolling="auto" align="center"></iframe>                                                       
                                </td>
                                <td class="top_menu_window_body_right">                    
                                    
                                </td>
                            </tr>
                            <!--Footer-->
                            <tr>
                                <td class="top_menu_window_footer_left">
                                    
                                </td>
                               
                                <td class="top_menu_window_footer_center" colspan="2">
                                    <!-- Dinamic -->   
                                    
                                </td>
                                <td class="top_menu_window_footer_right">                    
                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div id="win_console_dock" style="margin-top: 2px; border: 0px solid black;width: 234px;height: 278px;">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <table class="" border="0" cellpadding="0" cellspacing="0" >
                           <!--Top-->
                            <tr>
                                <td class="top_menu_window_top_left">
                                   
                                </td>
                                <td class="top_menu_window_top_circle">
                                   
                                </td>
                                <td class="top_menu_window_top_center" style="width:700px;text-align: left;" valign="top">
                                   <!-- Dinamic -->
                                    
                                    <!-- Title -->
                                    <div id="title_content" class="standar_font" style="margin: 6px;">&nbsp;</div>
                                    
                                </td>
                                <td class="top_menu_window_top_right">                    
                                   
                                </td>
                            </tr>
                            <!--Cuerpo-->
                            <tr>
                                <td class="top_menu_window_body_left">
                                    
                                </td>                
                                <td align="center" class="top_menu_window_body_center" colspan="2"  style="width:700px;height: 420px;" valign="top">
                                    <!-- Dinamic -->
                                     
                                    <iframe id="frame_content" name="frame_content" src="medico/content_iframe" style="width:720px;height: 430px;" frameborder="0" scrolling="no"></iframe>
                                  
                                </td>
                                <td class="top_menu_window_body_right">                    
                                    
                                </td>
                            </tr>
                            <!--Footer-->
                            <tr>
                                <td class="top_menu_window_footer_left">
                                    
                                </td>
                               
                                <td class="top_menu_window_footer_center" colspan="2">
                                    <!-- Dinamic -->
                                    
                                </td>
                                <td class="top_menu_window_footer_right">                    
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </div>                                    
        </td>                
    </tr>    
   </table>
   </div>  
 <!-- fin base -->