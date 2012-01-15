<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/css/esti_esta.css"?>"/>
<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
                ({
                    header: "h3",                        
                    event: "mouseover"
                });                

            jQuery("#med_con_pac").click(function()
            {            
                window.parent.frame_content.location=("../medico_configuracion_paciente/listar");
            });                          
            
            jQuery("#edi_med_enf").click(function()
            {            
                window.parent.frames[1].location=("../medico_tipo_enfermedad/registrar");
            });
        });
</script>      
 <style type="text/css">
    .ui-widget{        
        font-weight: bold;       
    }
 </style>
<!-- Acordion con sus 5 opciones -->
    <div id="accordion" style="width: *;text-align: left;">
          <div>
            <h3>
                <a href="#">
                    <?php __("Pacientes")?>
                </a>
            </h3>
            <div style="">                              
                <!--div style="height: 80px;text-align: left;"-->
                <div class="contenedor">
                    <table border="0" width="100%">
                        <tr>
                            <td> 
                                <ul>
                                    <li>
                                        <a id="med_con_pac"  href="javascript:void(0)" >
                                            <?php __("Configurar Paciente")?>
                                        </a>
                                    </li>
                                </ul> 
                            </td>
                        </tr>
                    </table>                                                    
                </div>
          </div>
        </div>
    </div>                       