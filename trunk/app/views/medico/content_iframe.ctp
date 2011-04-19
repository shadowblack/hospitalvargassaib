<script type="text/javascript">
    jQuery(function(){
       
			 
			     //jQuery("body:eq(0)").css('background-color','black');
                 
                 //jQuery("body").removeClass('');

				// Accordion
				jQuery("#accordion").accordion({ header: "h3" });
	
				// Tabs
				jQuery('#tabs').tabs();
	

				// Dialog			
				jQuery('#dialog').dialog({
					autoOpen: false,
					width: 600,
					buttons: {
						"Ok": function() { 
							jQuery(this).dialog("close"); 
						}, 
						"Cancel": function() { 
							jQuery(this).dialog("close"); 
						} 
					}
				});
				
				// Dialog Link
				jQuery('#dialog_link').click(function(){
					jQuery('#dialog').dialog('open');
					return false;
				});

				// Datepicker
				jQuery('#datepicker').datepicker({
					inline: true
				});
				
				// Slider
				jQuery('#slider').slider({
					range: true,
					values: [17, 67]
				});
				
				// Progressbar
				jQuery("#progressbar").progressbar({
					value: 20 
				});
				
				//hover states on the static widgets
				jQuery('#dialog_link, ul#icons li').hover(
					function() { jQuery(this).addClass('ui-state-hover'); }, 
					function() { jQuery(this).removeClass('ui-state-hover'); }
				); 
    });
</script>

<!-- Tabs -->
		<table border="1" width="837" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="831">Paginas</td>
          </tr>
          <tr>
            <td>
            
                        
            <h1>Sistema de Micología</h1>
    <!--El id="accordion" pertenece a JQUERY -->
<div id="accordion">
			
				<h3><a href="#">Agregar Nuevo Paciente</a></h3>
                <div>  	
                <!--La clase ContenidoPestana esta en la carpeta librerias Tab-->              
    					<iframe class="ContenidoPestana" src="<?php echo $this->Html->url("/MedicoConfiguracionPaciente/registrar")?>" height="500" width="100%"></iframe>  					
				</div>
		
<!------------------------TODOOOOO LO DEMAS---------------------------->
		
				<h3><a href="#">Micosis Superficial</a></h3>
				<div>                 
    					<iframe class="ContenidoPestana" src="<?php echo $this->Html->url("/MedicoConfiguracionMicosisSuperficial/registrar")?>" height="500" width="100%"></iframe>  									
                </div>
			
            
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			
				<h3><a href="#">Micosis SubCutaneas</a></h3>
				<div>               
    				<iframe class="ContenidoPestana" src="<?php echo $this->Html->url("/MedicoConfiguracionMicosisSubcutaneas/registrar")?>" height="500" width="100%"></iframe>							
                </div>
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			
				<h3><a href="#">Micosis Profunda</a></h3>
				<div>               
    					<iframe class="ContenidoPestana" src="<?php echo $this->Html->url("/MedicoConfiguracionMicosisProfunda/registrar")?>" height="500" width="100%"></iframe>	 									
                </div>
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			
				<h3><a href="#">Micosis Oportunista</a></h3>
				<div>               
    					<iframe class="ContenidoPestana" src="<?php echo $this->Html->url("/MedicoConfiguracionMicosisOportunista/registrar")?>" height="500" width="100%"></iframe>								
                </div>                                
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			<h3><a href="#">Estadisticas</a></h3>
				<div>               
    					<iframe class="ContenidoPestana" src="pag6.html" height="500" width="100%"></iframe>								
                </div>                 
                
<!--CIERRE FINAL DEL ACORDEON-->		
</div>            
			</td>
          </tr>
        </table>
	


