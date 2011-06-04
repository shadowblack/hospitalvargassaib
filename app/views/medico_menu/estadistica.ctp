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

<!-- Acordion con sus 5 opciones -->
    <div id="accordion" >

      <div>
            <h3>
                <a href="#">
                    <?php __("Estadística por Paciente ")?>
                </a>
            </h3>

        <div style="">                                               
            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac" href="javascript:void(0)" >
                    <?php __("Edad")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Sexo")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Ubicación Geográfica")?>
                </a> 
            <br/>
        </div>
      </div>
    </div>
<!--------------------Inicio de Tab Micosis Superficial-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Estadística Micosis Sup.")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sup" href="javascript:void(0)" >
                    <?php __("Tipo de Infección ")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Agente de Infección")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Ubicación Geográfica ")?>
                </a>                                                   
            </div>
        </div>   
<!--------------------Fin de Tab Micosis Superficial-------------------->                                        


<!--------------------Inicio de Tab Micosis Subcutaneas-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Estadística Micosis Sub.")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sup" href="javascript:void(0)" >
                    <?php __("Tipo de Infección ")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Agente de Infección")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Ubicación Geográfica ")?>
                </a>                                                   
            </div>
        </div>
<!--------------------Fin de Tab Micosis Subcutaneas-------------------->                                        

<!--------------------Inicio de Tab Micosis Profundas-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Estadística Micosis Prof.")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sup" href="javascript:void(0)" >
                    <?php __("Tipo de Infección ")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Agente de Infección")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Ubicación Geográfica ")?>
                </a>                                                   
            </div>

        </div>
<!--------------------Fin de Tab Micosis Subcutaneas--------------------> 


<!--------------------Inicio de Tab Micosis Oportunista-------------------->                                        
        <div>
            <h3>
                <a href="#">
                    <?php __("Estadística Micosis Opo.")?>
                </a>
            </h3>

            <div style="height: 150px;text-align: left;">
                <a id="reg_med_pac_mic_sup" href="javascript:void(0)" >
                    <?php __("Tipo de Infección ")?>
                </a>
            <br/>

                <a id="edi_med_pac" href="javascript:void(0)" >
                    <?php __("Agente de Infección")?>
                </a> 
            <br/>

                <a id="eli_med_pac" href="javascript:void(0)" >
                    <?php __("Ubicación Geográfica ")?>
                </a>                                                   
            </div>

        </div>
<!--------------------Fin de Tab Micosis Oportunista-------------------->                       