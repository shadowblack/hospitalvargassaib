      
		<script type="text/javascript">
			jQuery(function(){
			 
                jQuery("body").addClass('medico_clase_formulario_fondo');
                 jQuery("#accordion").accordion({
        		      header: "h3",              
                      autoHeight:false,
                      alwaysOpen: false		                                   
                });                
                jQuery("#reg_usu_adm").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/medico/content_iframe')?>");
        		});
    				
			});
		</script>      
		<!--style type="text/css">
			/*demo page css*/
			body{
	font: 62.5% "Trebuchet MS", sans-serif;
	margin: 50px;
}
			.demoHeaders { margin-top: 2em; }
			#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
		</style-->	
<style type="text/css">
<!--
body {
	background-image: url(Img/Fondo1.png);
}
-->
</style>
    
    
    
 <!-- base -->
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
                                                <div style="height: 150px;text-align: left;">
                                                    <a id="reg_usu_adm" href="javascript:void(0)" ><?php __("Agregar Administrador")?></a>
                                                    <a id="edi_usu_adm" href="javascript:void(0)" ><?php __("Listar Administradores")?></a>                                                    
                                                </div>
                                            </div>
                            			</div>
                                        
                            			<div>
                            				<h3><a href="#">Second</a></h3>
                            				<div>Phasellus mattis tincidunt nibh.</div>
                            			</div>
                            			<div>
                            				<h3><a href="#">Third</a></h3>
                            				<div>Nam dui erat, auctor a, dignissim quis.</div>
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
                                <td class="top_menu_window_top_center" style="width:700px;">
                                    <!-- Dinamic -->
                                    
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
                                    <iframe id="frame_content" src="" style="width:720px;height: 400px;" frameborder="0" scrolling="auto"></iframe>
                                  
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
 <!-- fin base -->   
    
	

	
		