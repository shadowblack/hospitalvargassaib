<script>
    jQuery(function(){       
        jQuery("#grafico").load("<?php echo $this->Html->url("/MedicoEstadisticaGrupoEtario/grafico")?>",function(){            
        })  ;  
    })
</script>
<div id="grafico">
    
</div>