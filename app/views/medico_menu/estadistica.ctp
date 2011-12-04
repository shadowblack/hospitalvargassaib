<script type="text/javascript">               
    jQuery(function()
        {
            jQuery("#accordion").accordion
            ({
                header: "h3",                        
                event: "mouseover"
            });
            
            jQuery("#est_gen_pac").click(function()
            { 
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoEstadisticaGenero/busqueda")?>");
            });
            
            jQuery("#est_eda_pac").click(function()
            { 
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoEstadisticaGrupoEtario/busqueda")?>");
            });
            
            jQuery("#est_les_pac").click(function()
            { 
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoEstadisticaTipoLesion/busqueda")?>");
            });
            
            jQuery("#est_mic_pac").click(function()
            { 
                window.parent.frame_content.location=("<?php echo $this->Html->url("/MedicoEstadisticaTipoMicosis/busqueda")?>");
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
                    <?php __("Estadística")?>
                </a>
            </h3>
            <div style="">                                               
                <div style="height: 80px;text-align: left;">
                    <a id="est_gen_pac" href="javascript:void(0)" >
                        <?php __("Género")?>
                    </a></br>
                    <a id="est_eda_pac" href="javascript:void(0)" >
                        <?php __("Grupo Etario")?>
                    </a></br>
                    <a id="est_les_pac" href="javascript:void(0)" >
                        <?php __("Tipo de Lesión")?>
                    </a></br>
                    <a id="est_mic_pac" href="javascript:void(0)" >
                        <?php __("Tipo de Micosis")?>
                    </a></br>                               
                </div>
          </div>
        </div>
    </div>                       