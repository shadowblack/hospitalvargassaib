﻿<?php   
    //echo $url_img =  $this->webroot."img/menu_top/"; 
    //echo "http://127.0.0.1$url_img"."img/menu_top/8_01.jpg";die;
    //$this->error(404, 'Not found', 'This page was not found, sorry');die;
?>
<script type="text/javascript">
	jQuery(function(){
	   jQuery("body:eq(0)").addClass("standar_fondo");
		// Accordion
		jQuery("#accordion").accordion({
		      header: "h3",              
              autoHeight:false,
              alwaysOpen: false		

                   
        });
        
        jQuery("#reg_usu_adm").click(function(){            
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_usuario_administrativo/registrar')?>");
		});
        jQuery("#lis_usu_adm").click(function(){            
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_usuario_administrativo/listar')?>");
		}); 
        jQuery("#reg_usu_med").click(function(){            
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_usuarios_medicos/registrar')?>");
		});
        jQuery("#lis_usu_med").click(function(){            
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_usuarios_medicos/listar')?>");
		});
        jQuery("#cam_pas_usu").click(function(){            
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_cambiar_contrasena/modificar')?>");
		});
                  
       
    
    });
</script>
<style type="text/css">
   
</style>
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
                                <a class="dock-item" href="<?php echo $this->Html->url("/Admin/salir");?>">
                                    <img src="<?php echo $this->webroot?>/js/men_mac/images/salir.png" alt="Salir" />
                                        <!-- span style="padding-left: 100px;">
                                            Salir
                                        </span-->
                                </a>   
                            </div>
                        </div>                                                
                    </td>
                </tr>
            </table>
            <!--Fin de los Botones Superiores-->                                    
        </td>
    </tr>
    <tr>
        <td style="height: 400px;" valign="top" align="center">
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
                                <td class="top_menu_window_top_center" style="width:200px" valign="top">
                                    <!-- Dinamic -->
                                    <div class="standar_font" style="margin: 6px;"><?php echo __("Menú del Sistema Administrativo")?></div>
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
                                    <!-- Dinamic -->
                                    <div id="accordion" style="width: 220px;text-align: left;">                                       
                            			<div>
                            				<h3><a href="#"><?php __("Usuarios Administrativos")?></a></h3>
                            				<div style="">                                               
                                                <div style="height: 45px;text-align: left;width: 150px;">                                                
                                                <table>
                                                    <tr>
                                                        <td class="standar_font_menu">
                                                            <a id="reg_usu_adm" href="javascript:void(0)" ><?php __("Agregar Administrador")?></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="standar_font_menu">
                                                            <a id="lis_usu_adm" href="javascript:void(0)" ><?php __("Listar Administradores")?></a>
                                                        </td>
                                                    </tr>
                                                </table>                                                                                                                                                                                                          
                                                </div>
                                            </div>
                            			</div>                                        
                            			<div>
                            				<h3><a href="#"><?php __("Usuarios Operadores")?></a></h3>
                            				<div>
                                                <div style="height: 45px;text-align: left;width: 150px;">                                               
                                                    <table>
                                                        <tr>
                                                            <td class="standar_font_menu">
                                                                <a id="reg_usu_med" href="javascript:void(0)"><?php __("Agregar Operador")?></a>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="standar_font_menu">
                                                                <a id="lis_usu_med" href="javascript:void(0)" ><?php __("Listar Operadores")?></a>
                                                            </td>
                                                        </tr>
                                                    </table>                                                                                                                                                                                                          
                                                </div>
                                            </div>
                            			</div> 
                                        <div>
                            				<h3><a href="#"><?php __("Contraseña")?></a></h3>
                            				<div>
                                                <div style="height: 45px;text-align: left;width: 150px;">                                               
                                                    <table>
                                                        <tr>
                                                            <td class="standar_font_menu">
                                                                <a id="cam_pas_usu" href="javascript:void(0)"><?php __("Cambiar Contraseña")?></a>
                                                            </td>
                                                        </tr>
                                                    </table>                                                                                                                                                                                                          
                                                </div>
                                            </div>
                            			</div>                              		
                            		</div>                                  
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
                                <td class="top_menu_window_top_center" style="width:700px;" valign="top" align="left">
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
                                <td align="center" class="top_menu_window_body_center" colspan="2"  style="width:700px;height: 400px;">
                                    <!-- Dinamic -->
                                    <iframe id="frame_content" src="admin/content_iframe" style="width:720px;height: 400px;" frameborder="0" scrolling="auto"></iframe>
                                  
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
           
        </td>                
    </tr>    
   </table>
   </div>
       