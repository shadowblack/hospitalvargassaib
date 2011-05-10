<?php   
    //echo $url_img =  $this->webroot."img/menu_top/"; 
    //echo "http://127.0.0.1$url_img"."img/menu_top/8_01.jpg";die;
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
       
    
    });
</script>
<style type="text/css">
   
</style>
  <div class="standar_content">
  
   <table style="width:100%" border="0" class="menu_top_window" align="center">
    <tr>
        <td style="height: 125px;">
            <!-- Banner -->banner
        </td>
    </tr>    
    <tr>
         <td style="height: 35px;">
            
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
                                <td class="top_menu_window_top_center" style="width:200px">
                                    <!-- Dinamic -->
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
                                <td align="center" valign="top" class="top_menu_window_body_center" colspan="2"  style="width:*;height: 300px;">
                                    <!-- Dinamic -->
                                    <div id="accordion" style="width: 220px;text-align: center;">                                       
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
                            				<h3><a href="#"><?php __("Usuarios Médicos")?></a></h3>
                            				<div>
                                                <div style="height: 45px;text-align: left;width: 150px;">                                               
                                                    <table>
                                                        <tr>
                                                            <td class="standar_font_menu">
                                                                <a id="reg_usu_med" href="javascript:void(0)" ><?php __("Agregar Médicos")?></a>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="standar_font_menu">
                                                                <a id="lis_usu_med" href="javascript:void(0)" ><?php __("Listar Médicos")?></a>
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
                                <td class="top_menu_window_top_center" style="width:700px;" valign="top">
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
                                    <iframe id="frame_content" src="" style="width:720px;height: 400px;" frameborder="0" scrolling="auto" marginwidth="0" marginheight="0"></iframe>
                                  
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
       