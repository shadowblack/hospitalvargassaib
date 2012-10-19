<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
                ({
                    header: "h3",                        
                    event: "mouseover"
                });                

            jQuery("#med_con_mic_sup").click(function()
                {            
                    document.location.href=("../medico_configuracion_micosis_superficial/registrar");
                    //('mic_sup_car2').load( "../medico_configuracion_micosis_superficial/registrar");
                });
            
            jQuery("#edi_med_enf").click(function()
                {            
                    window.parent.frames[1].location=("../medico_tipo_enfermedad/registrar");
                });

            
        });
</script>

<div id="accordion" >
<!--Primer Acordeon-->
    <div>
        <h3>
            <a id="med_con_mic_sup" href="javascript:void(0)" >
                <?php __("Micosis Superficial")?>
            </a>
            </h3>
            
        
        <iframe height= "400" width="650" name="contenido" src="<?php echo ("../medico_configuracion_micosis_superficial/registrar")?>"></iframe>                                                                               
            
        
    </div>
 
<!--Segundo Acordeon-->   
     <div>
        <h3>
            <a href="#">
                <?php __("Micosis SubCutaneas")?>
            </a>
            </h3>
            
        <iframe height= "400" width="650" name="contenido" src="<?php echo ("../medico_configuracion_micosis_subcutaneas/registrar")?>"></iframe>
    </div>
    
    
<!--Tercer Acordeon-->   
     <div>
        <h3>
            <a href="#">
                <?php __("Micosis Profundas")?>
            </a>
            </h3>
            
        <iframe height= "400" width="650" name="contenido" src="<?php echo ("../medico_configuracion_micosis_profunda/registrar")?>"></iframe>
    </div>    
    
<!--Cuarto Acordeon-->   
     <div>
        <h3>
            <a href="#">
                <?php __("Micosis Oportunista")?>
            </a>
            </h3>
            
        <div style="">                                               
            
            <a id="reg_med_pac" href="javascript:void(0)" >
                <?php __("Agregar Paciente")?>
            </a>
            <br/>
        
                                                              
        </div>
    </div>    
</div>
