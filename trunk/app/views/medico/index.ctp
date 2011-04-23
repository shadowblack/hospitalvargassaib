      
		<script type="text/javascript">
			jQuery(function(){
			 
                jQuery("body").addClass('medico_clase_formulario_fondo');
                 jQuery("#accordion").accordion({
        		      header: "h3",              
                      autoHeight:false,
                      alwaysOpen: false		                                   
                });                
                jQuery("#reg_med_pac").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('../medico_configuracion_paciente/registrar')?>");
                   
        		});
                
                 jQuery("#reg_med_pac_mic_sup").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('../medico_configuracion_micosis_superficial/registrar')?>");
        		});
    			
                jQuery("#reg_med_pac_mic_sub").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('../medico_configuracion_micosis_subcutaneas/registrar')?>");
        		});	
                
                jQuery("#reg_med_pac_mic_pro").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('../medico_configuracion_micosis_profunda/registrar')?>");
        		});
                
                jQuery("#reg_med_pac_mic_opo").click(function(){            
                   jQuery("#frame_content").attr("src","<?php echo $this->Html->url('../medico_configuracion_micosis_oportunista/registrar')?>");
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
        <?php echo $this->Html->css('medico_clase_formulario');?>	
    
    
    
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
    <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a href="#">
                    <br/>
                        Configuración
                </a>
            </div>
        </td>
        
        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a href="#">
                    <br/>
                        Reportes
                    </a>
                </div>
            </td>
        
        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a href="#">
                    <br/>
                        Estadisticas
                    </a>
                </div>
            </td>
    </tr>
    </table>
            
            
            
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
                            				<h3><a href="#"><?php __("Pacientes")?></a></h3>
                            				<div style="">                                               
                                                <div style="height: 150px;text-align: left;">
                                                    <a id="reg_med_pac" href="javascript:void(0)" ><?php __("Agregar Paciente")?></a>
                                                    <br/>
                                                    <a id="edi_med_pac" href="javascript:void(0)" ><?php __("Modificar Paciente")?></a> 
                                                    <br/>
                                                    <a id="eli_med_pac" href="javascript:void(0)" ><?php __("Eliminar Paciente")?></a>                                                   
                                                </div>
                                            </div>
                            			</div>
<!--------------------Inicio de Tab Micosis Superficial-------------------->                                        
                            			<div>
                            				<h3><a href="#"><?php __("Micosis Superficial")?></a></h3>
                            				<div style="height: 150px;text-align: left;">
                                                    <a id="reg_med_pac_mic_sup" href="javascript:void(0)" ><?php __("Agregar Micosis")?></a>
                                                    <br/>
                                                    <a id="edi_med_pac" href="javascript:void(0)" ><?php __("Modificar Micosis")?></a> 
                                                    <br/>
                                                    <a id="eli_med_pac" href="javascript:void(0)" ><?php __("Eliminar Micosis")?></a>                                                   
                                                </div>
                            			</div>   
<!--------------------Fin de Tab Micosis Superficial-------------------->                                        
                            			
                                        
<!--------------------Inicio de Tab Micosis Subcutaneas-------------------->                                        
                                        <div>
                            				<h3><a href="#"><?php __("Micosis Subcutaneas")?></a></h3>
                            				<div style="height: 150px;text-align: left;">
                                                    <a id="reg_med_pac_mic_sub" href="javascript:void(0)" ><?php __("Agregar Micosis")?></a>
                                                    <br/>
                                                    <a id="edi_med_pac" href="javascript:void(0)" ><?php __("Modificar Micosis")?></a> 
                                                    <br/>
                                                    <a id="eli_med_pac" href="javascript:void(0)" ><?php __("Eliminar Micosis")?></a>                                                   
                                                </div>
                            			</div>   
<!--------------------Fin de Tab Micosis Subcutaneas-------------------->                                        
                                        
<!--------------------Inicio de Tab Micosis Profundas-------------------->                                        
                                        <div>
                            				<h3><a href="#"><?php __("Micosis Profunda")?></a></h3>
                            				<div style="height: 150px;text-align: left;">
                                                    <a id="reg_med_pac_mic_pro" href="javascript:void(0)" ><?php __("Agregar Micosis")?></a>
                                                    <br/>
                                                    <a id="edi_med_pac" href="javascript:void(0)" ><?php __("Modificar Micosis")?></a> 
                                                    <br/>
                                                    <a id="eli_med_pac" href="javascript:void(0)" ><?php __("Eliminar Micosis")?></a>                                                   
                                                </div>
                            			</div>   
<!--------------------Fin de Tab Micosis Subcutaneas--------------------> 


<!--------------------Inicio de Tab Micosis Oportunista-------------------->                                        
                                        <div>
                            				<h3><a href="#"><?php __("Micosis Oportunista")?></a></h3>
                            				<div style="height: 150px;text-align: left;">
                                                    <a id="reg_med_pac_mic_opo" href="javascript:void(0)" ><?php __("Agregar Micosis")?></a>
                                                    <br/>
                                                    <a id="edi_med_pac" href="javascript:void(0)" ><?php __("Modificar Micosis")?></a> 
                                                    <br/>
                                                    <a id="eli_med_pac" href="javascript:void(0)" ><?php __("Eliminar Micosis")?></a>                                                   
                                                </div>
                            			</div>   
<!--------------------Fin de Tab Micosis Oportunista-------------------->                                       
                                        
                                        
                                        
                                        
                                        
                                        
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