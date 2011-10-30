<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
                ({
                    header: "h3",                        
                    event: "mouseover"
                });                

            jQuery("#est_eda_pac").click(function()
            {      
                
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoEstadisticaGrupoEtario/busqueda")?>");
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
                <div style="height: 80px;text-align: left;">
                    <a id="est_eda_pac" href="javascript:void(0)" >
                        <?php __("Grupo Etario del paciente")?>
                    </a></br>
                    <a id="est_sex_pac" href="javascript:void(0)" >
                        <?php __("Sexo del paciente")?>
                    </a></br>
                    <a id="est_eda_pac" href="javascript:void(0)" >
                        <?php __("Tipo de Lesión del paciente")?>
                    </a></br>
                    <a id="est_eda_pac" href="javascript:void(0)" >
                        <?php __("Tipo de micosis del paciente")?>
                    </a></br>                               
                </div>
          </div>
        </div>
    </div>                       