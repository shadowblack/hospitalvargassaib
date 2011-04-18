      
		<script type="text/javascript">
		<!--Funciones de JQUERY-->
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

				//hover states on the static widgets
				jQuery('#dialog_link, ul#icons li').hover(
					function() { jQuery(this).addClass('ui-state-hover'); }, 
					function() { jQuery(this).removeClass('ui-state-hover'); }
				);
				
			});
		</script>
		<?php echo $this->Html->css('medico_clase_formulario');?>
	
        
           <div id="tabs">
			<ul>
				<li><a href="#tabs-1">Tipo de Infección</a></li>
			    <li><a href="#tabs-2">Descripción de la Lesi&oacute;n I</a></li>
		      <li><a href="#tabs-3">Descripción de la Lesi&oacute;n II</a></li>
                <li><a href="#tabs-4">Estudio Micológico</a></li>
			</ul>
			
    <ul>
    <div id="tabs-1">
    
	<h2 class="texPrincipal">Evaluar Micosis Subcutaneas</h2>
    
  
  <fieldset>	
    
	    	<legend>
    		<strong>
    			Tipo de Infección:    		</strong>    	</legend>
        <!------------------------------BOTON DE PREGUNTA--------------------------------------->  
  <h2 class="demoHeaders">&nbsp;</h2>
		<p><a href="#" id="dialog_link" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-help"></span>Ayuda</a>
		  <!-- ui-dialog -->
</p>
		
		
		<div id="dialog" title="Ayuda sobre descripción de la lesión">
			<p>Aqui colocamos una pequeña descripcion de ayuda sobre esta pantalla para que el usuario tenga material de apoyo</p>
	</div>
    <form action="" method="get">
    
    
    <table width="500" border="0" align="center">
  <tr>
    <td width="250">
    <fieldset>
    <legend><strong>Tipo de Infecci&oacute;n</strong></legend>
    <table width="160" border="0" align="center">
  <tr>
    <td width="20"><label>
      <input type="checkbox" name="che_act2" id="che_act2">
    </label></td>
    <td width="130">Actinomicetoma</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_cro2" id="che_cro2"></td>
    <td>Cromoblastomicos</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_esp2" id="che_esp2"></td>
    <td>Esporotricosis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_eum2" id="che_eum2"></td>
    <td>Eumicetoma</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_act3" id="che_act3"></td>
    <td>Lobomicosis</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
    </fieldset>    </td>
    <td width="240">
    <fieldset>
    <legend><strong>Forma de Infecci&oacute;n</strong></legend>
   <table width="160" border="0" align="center">
  <tr>
    <td width="20"><label>
      <input type="checkbox" name="che_Tra" id="che_Tra">
    </label></td>
    <td width="130">Traum&aacute;tica</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Pic" id="che_Pic"></td>
    <td>Picada Insecto</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Pin" id="che_Pin"></td>
    <td>Pinchazo espinas</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Mor" id="che_Mor"></td>
    <td>Mordedura roedores</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Ins" id="che_Ins"></td>
    <td>Instrumento met&aacute;lico</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Cas" id="che_Cas"></td>
    <td>Caza animales</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="che_Acc" id="che_Acc"></td>
    <td>Accidente laboratorio</td>
  </tr>
</table>
    </fieldset>    </td>
  </tr>
</table>
    </form>
  </fieldset>         
            </div>
          
    <div id="tabs-2">
	<h2 class="texPrincipal">Ubicai&oacute;n de la Lesion</h2>
    
  
  <fieldset>	
    
		<legend>
    		<strong>
    			Ubicaci&oacute;n:    		</strong>    	</legend>
  
  

  
  

  
  
  <form id="for_Eva" name="for_Eva" method="post" action="">
  
  
  
  
  <table width="300" border="0" align="center">
            <tr>
              <td width="18"><label>
                <input type="checkbox" name="che_Cab" id="che_Cab">
              </label></td>
              <td>Cabeza</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Tor" id="che_Tor"></td>
              <td>T&oacute;rax Anterior</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Esp" id="che_Esp"></td>
              <td>Espalda</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Fla_Der" id="che_Fla_Der"></td>
              <td>Flanco derecho</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Fla_Izq" id="che_Fla_Izq"></td>
              <td>Flanco izquierdo</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Bra_Der" id="che_Bra_Der"></td>
              <td>Brazo derecho</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Bra_Izq" id="che_Bra_Izq"></td>
              <td>Brazo izquierdo</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Pier_Der" id="che_Pier_Der"></td>
              <td>Pierna derecha</td>
            </tr>

            <tr>
              <td><input type="checkbox" name="che_Pier_Izq" id="che_Pier_Izq"></td>
              <td>Pierna izquierda</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Pie_Der" id="che_Pie_Der"></td>
              <td>Pie derecho</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Pie_Izq" id="che_Pie_Izq"></td>
              <td>Pie izquierdo</td>
            </tr>
          </table>
  </form> 
</fieldset>
     </div>
     
    <div id="tabs-3">
    
	<h2 class="texPrincipal">Descripción de la Lesión</h2>
    
  
  <fieldset>	
    
		<legend>
    		<strong>
    			Tipo de Infección:    		</strong>    	</legend>
    <form action="" method="get">
    
    <table width="500" border="0" align="center">
      <tr>
        <td width="245"><fieldset>
          <legend><strong>Descripci&oacute;n</strong></legend>
          <table width="193" border="0" align="center">
            <tr>
              <td width="23"><label>
                <input type="checkbox" name="che_Les_Uni2" id="che_Les_Uni3">
              </label></td>
              <td width="160">Lesi&oacute;n &Uacute;nica</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Les_Mul2" id="che_Les_Mul3"></td>
              <td>Lesi&oacute;n M&uacute;ltiple</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Con_Fis2" id="che_Con_Fis3"></td>
              <td>Con f&iacute;stula</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Sin_Fis2" id="che_Sin_Fis3"></td>
              <td>Sin f&iacute;stula</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Sec2" id="che_Sec3"></td>
              <td>Secreci&oacute;n granos de la f&iacute;stula</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Aum_Vol2" id="che_Aum_Vol3"></td>
              <td>Aumento volumen</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Afe_Hue2" id="che_Afe_Hue3"></td>
              <td>Afectaci&oacute;n hueso</td>
            </tr>
            <tr>
              <td><label>
                <input type="checkbox" name="che_Cut_Ver2" id="che_Cut_Ver3">
              </label></td>
              <td>Cut&aacute;nea verrugosa</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Tum2" id="che_Cut_Tum3"></td>
              <td>Cut&aacute;nea tumoral</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Pla2" id="che_Cut_Pla3"></td>
              <td>Cut&aacute;nea en placa</td>
            </tr>
          </table>
        </fieldset></td>
    <td width="245"><fieldset>
          <legend><strong>Descripci&oacute;n</strong></legend>
          <table width="190" border="0" align="center">
            <tr>
              <td width="20"><input type="checkbox" name="che_Nod_Eri2" id="che_Nod_Eri4"></td>
              <td width="160">N&oacute;dulos eritematosos</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Atr_Cen2" id="che_Atr_Cen4"></td>
              <td>Atrofia central</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Bor_Act2" id="che_Bor_Act4"></td>
              <td>Bordes activos</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Fij2" id="che_Cut_Fij4"></td>
              <td>Cut&aacute;nea fija</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Lin2" id="che_Cut_Lin4"></td>
              <td>Cut&aacute;nea linfangitica</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Mul2" id="che_Cut_Mul4"></td>
              <td>Cut&aacute;nea m&uacute;ltiple</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Que2" id="che_Cut_Que4"></td>
              <td>Cut&aacute;nea queloidal</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Inf2" id="che_Cut_Inf4"></td>
              <td>Cut&aacute;nea infiltrante</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Gom2" id="che_Cut_Gom4"></td>
              <td>Cut&aacute;nea gomosa</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Cut_Ulc2" id="che_Cut_Ulc4"></td>
              <td>Cut&aacute;nea ulcerada</td>
            </tr>
          </table>
       </fieldset></td>
      </tr>
    </table>
    </form>
  </fieldset>         
            </div>
            
    <div id="tabs-4">
    
	<h2 class="texPrincipal">Examen Directo y de Cultivo</h2>
    
  
  <fieldset>	
    
		<legend>
    		<strong>
    			Examen:    		</strong>    	</legend>
    <form action="" method="get">
    
    
    <table width="470" border="0" align="center">
      <tr>
        <td width="223"><fieldset>
          <legend><strong>Directo</strong></legend>
          <table width="221" height="506" border="0">
            <tr>
              <td width="20"><label>
                <input type="checkbox" name="che_Exa_Lev" id="che_Exa_Lev">
              </label></td>
              <td width="191">Levaduras Simples</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Bla" id="che_Exa_Bla"></td>
              <td>Blastoconidias</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Lev_Cad" id="che_Exa_Lev_Cad"></td>
              <td>Levaduras en cadena</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Fum" id="che_Exa_Fum"></td>
              <td>C&eacute;lulas fumogoides</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="checkbox" id="checkbox5"></td>
              <td>Hifas dematiaceas</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="checkbox" id="checkbox6"></td>
              <td>Cuerpos asteroides</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </fieldset></td>
        <td width="237"><fieldset>
          <legend><strong>Cultivo</strong></legend>
          <table width="244" height="506" border="0">
            <tr>
              <td width="20"><label>
                <input type="checkbox" name="che_Exa_Sch" id="che_Exa_Sch">
              </label></td>
              <td width="214">Sporothix Schenckii</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Cla" id="che_Exa_Cla"></td>
              <td>Cladiophialophora carrionii</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Fon" id="che_Exa_Fon"></td>
              <td>Fonseca pedrosoi</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Phi" id="che_Exa_Phi"></td>
              <td>Phialophora cerrucosa</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Rhi" id="che_Exa_Rhi"></td>
              <td>Rhinocladiella aquaspersa</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Acr" id="che_Exa_Acr"></td>
              <td>Acremionium spp</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Acr_Fal" id="che_Exa_Acr_Fal"></td>
              <td>Acremionium falciforme</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Mad" id="che_Exa_Mad"></td>
              <td>Madurella grisea</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Pse" id="che_Exa_Pse"></td>
              <td>Pseudallescheria boydii</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Fus_Oxi" id="che_Exa_Fus_Oxi"></td>
              <td>Fusarium oxisporum</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Fus_Sol" id="che_Exa_Fus_Sol"></td>
              <td>Fusarium solami</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Mal" id="che_Exa_Mal"></td>
              <td>Malassezia SPP</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Asp" id="che_Exa_Asp"></td>
              <td>Aspergillus flavus</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Asp_Nid" id="che_Exa_Asp_Nid"></td>
              <td>Aspergillus nidulans</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Asp_Fum" id="che_Exa_Asp_Fum"></td>
              <td>Aspergillus fumigatus</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Asp_Spp" id="che_Exa_Asp_Spp"></td>
              <td>Aspergillus SPP</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Noc" id="che_Exa_Noc"></td>
              <td>Nocardia Brasiliensis</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Str" id="che_Exa_Str"></td>
              <td>Streptomyces somaliensis</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Act" id="che_Exa_Act"></td>
              <td>Actinomadura madurae</td>
            </tr>
            <tr>
              <td><input type="checkbox" name="che_Exa_Fus_Spp" id="che_Exa_Fus_Spp"></td>
              <td>Fusarium SPP</td>
            </tr>
            <tr>
              <td height="22"><input type="checkbox" name="che_Exa_Par_Lob" id="che_Exa_Par_Lob"></td>
              <td>Paracoccidioides loboi (Histopoatologia)</td>
            </tr>
          </table>
        </fieldset></td>
      </tr>
    </table>
    
    
    </form>
  </fieldset>         
            </div>        
    </ul>
    </div>