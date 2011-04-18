	    
        <!--------------Esto es para agregar el Iframe dentro del acordeon-------------->
        <link rel="stylesheet" href="Librerias/Tab.css" type="text/css" media="screen">
        <!----------------------------------------------------------------------------->
       
		<script type="text/javascript">
			jQuery(function(){

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
		<!--style type="text/css">
			/*demo page css*/
			body{
	font: 62.5% "Trebuchet MS", sans-serif;
	margin: 50px;
}
			.demoHeaders { margin-top: 2em; }
			#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
		</style-->	
<style type="text/css">
<!--
body {
	background-image: url(Img/Fondo1.png);
}
-->
</style>
    
    
	

	
		<!-- Tabs -->
		<table border="0" width="837" align="center">
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
    				<iframe class="ContenidoPestana" src="pag3.html" height="500" width="100%"></iframe>							
                </div>
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			
				<h3><a href="#">Micosis Profunda</a></h3>
				<div>               
    					<iframe class="ContenidoPestana" src="pag4.html" height="500" width="100%"></iframe>	 									
                </div>
<!------------------------TODOOOOO LO DEMAS---------------------------->            
			
				<h3><a href="#">Micosis Oportunista</a></h3>
				<div>               
    					<iframe class="ContenidoPestana" src="pag5.html" height="500" width="100%"></iframe>								
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
	


