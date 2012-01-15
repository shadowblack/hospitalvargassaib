<link  rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/css/esti_esta.css"?>"/>
<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
                ({
                    header: "h3",                        
                    event: "mouseover"
                });                

            jQuery("#reg_med_pac").click(function()
                {            
                    window.parent.frames[1].location=("../medico_configuracion_paciente/registrar");
                });


            jQuery("#reg_med_pac_mic_sup").click(function()
                {            
                    window.parent.frames[1].location=("../medico_configuracion_micosis_superficial/registrar");
                });

            jQuery("#reg_med_pac_mic_sub").click(function()
                {            
                    window.parent.frames[1].location=("../medico_configuracion_micosis_subcutaneas/registrar");
                });	

            jQuery("#reg_med_pac_mic_pro").click(function()
                {            
                    window.parent.frames[1].location=("../medico_configuracion_micosis_profunda/registrar");
                });

            jQuery("#reg_med_pac_mic_opo").click(function()
                {            
                    window.parent.frames[1].location=("../medico_configuracion_micosis_oportunista/registrar");
                });
        });
</script>      

<!-- Acordion con sus opciones -->
    <div id="accordion" >

      <div>
            <h3>
                <a href="#">
                    <?php __("Configuración 1")?>
                </a>
            </h3>

        <div style="">                                               
            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac" href="javascript:void(0)" >
                    <?php __("Agregar Paciente")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Modificar Paciente")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Eliminar Paciente")?>
                </a>                                                   
        </div>
      </div>
    </div>
<!--------------------Segundo Acordion-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Configuración 2")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sup" href="javascript:void(0)" >
                    <?php __("Agregar Micosis")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Modificar Micosis")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Eliminar Micosis")?>
                </a>                                                   
            </div>
        </div>   
<!--------------------Fin de Tab Segundo Acordion-------------------->                                        


<!--------------------Inicio de Tab Micosis Subcutaneas-------------------->                                                       
                <h3>
                    <a href="#">
                        <?php __("Configuración 3")?>
                    </a>
                </h3>
            
            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sub" href="javascript:void(0)" >
                    <?php __("Agregar Micosis")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Modificar Micosis")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Eliminar Micosis")?>
                </a>                                                   
            </div>
        </div>
<!--------------------Fin de Tab Micosis Subcutaneas-------------------->                                        

<!--------------------Inicio de Tab Micosis Profundas-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Configuración 4")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_pro" href="javascript:void(0)" >
                    <?php __("Agregar Micosis")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Modificar Micosis")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Eliminar Micosis")?>
                </a>                                                   
            </div>
        </div>
<!--------------------Fin de Tab Micosis Subcutaneas--------------------> 


<!--------------------Inicio de Tab Micosis Oportunista-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Configuración 5")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_opo" href="javascript:void(0)" >
                    <?php __("Agregar Micosis")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Modificar Micosis")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Eliminar Micosis")?>
                </a>                                                   
            </div>
        </div>
<!--------------------Fin de Tab Micosis Oportunista-------------------->                       