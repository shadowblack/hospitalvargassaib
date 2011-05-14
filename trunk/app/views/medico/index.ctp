    
		<script type="text/javascript">
			jQuery(function(){
			 
                jQuery("body").addClass('medico_clase_formulario_fondo');
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

                
                });
		</script>      
		
	
    
    
    
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

<!--Botones Superiores-->

    <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>

        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a id="reg_med_pac" href="javascript:void(0)" >
                    <br/>
                        <?php __("Registrar")?></a>
                </a>
            </div>
        </td>

        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a id="confi_med_pac" href="javascript:void(0)" >
                    <br/>
                        <?php __("Configurar")?></a>
                </a>
            </div>
        </td>
        
        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a id="repo_med_pac" href="javascript:void(0)" >
                    <br/>
                        <?php __("Reportes")?></a>
                </a>
                </div>
            </td>
        
        <td width="100" align="right" height="1">
            <div class="boton_medico_conf" id="boton_medico_conf">
                <a id="esta_med_pac" href="javascript:void(0)" >
                    <br/>
                        <?php __("Estadisticas")?></a>
                </a>
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
                                <td class="top_menu_window_top_center" style="width:210px;">
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
                                <td align="center" valign="top" class="top_menu_window_body_center" colspan="2"  style="width:237px;height: 330px;">
                                    <!--Aqui va el iframe izquierdo-->

                                <iframe id="men_izq_reg" src="" height="350" width="200" frameborder="0" scrolling="auto">
                                </iframe>



                                                       
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








                                     <!--Fin del Iframe izquierdo-->
                                    
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