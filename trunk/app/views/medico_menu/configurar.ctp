
		<script type="text/javascript">
			jQuery(function(){
			 
                
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
     

                                     <!-- Dinamic -->
                                    <div id="accordion" >
                                        
                            			<div>
                            				<h3><a href="#"><?php __("Configurar")?></a></h3>
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
                            				<h3><a href="#"><?php __("Siguiente Configuracion")?></a></h3>
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
                            				<h3><a href="#"><?php __("Continua la Configuracion")?></a></h3>
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
                            				<h3><a href="#"><?php __("Seguimos Configurando")?></a></h3>
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
                            				<h3><a href="#"><?php __("Fin de la Configuracion")?></a></h3>
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