<link  rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/css/esti_esta.css"?>"/>
<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
                ({
                    header: "h3",                        
                    event: "mouseover"
                });                

            jQuery("#med_tra_usu").click(function()
            {            
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoReportes/busqueda")?>");
            });
            
            jQuery("#enf_mic_pac").click(function()
            {            
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoReportesEnfermedadesMicologicasPacientes/busqueda")?>");
            });   
            
            jQuery("#tip_les_pac").click(function()
            {            
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoReportesEnfermedadesMicologicasPacientes/busqueda")?>");
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
                    <?php __("Reportes")?>
                </a>
            </h3>
            <div style="">                                               
                 <div class="contenedor">
                           
                    <table border="0" width="100%">
                        <tr>
                            <td>
                                <ul>
                                    <li>                        
                                        <a id="med_tra_usu" href="javascript:void(0)" >
                                            <?php __("Transacciones de Usuarios")?>
                                        </a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr><td style="height: 5px;;"></td></tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>                                    
                                        <a id="enf_mic_pac" href="javascript:void(0)" >
                                            <?php __("Enfermedades Micológicas del Paciente")?>
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