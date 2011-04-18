  
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
		

        <link href="Librerias/Tab.css" rel="stylesheet" type="text/css">
    </head>
	<body>	
           <div id="tabs">
			<ul>
				<li><a href="#tabs-1">Tipo de Infección</a></li>
			    <li><a href="#tabs-2">Descripción de la Lesi&oacute;n I</a></li>
		      <li><a href="#tabs-3">Descripción de la Lesi&oacute;n II</a></li>
                <li><a href="#tabs-4">Estudio Micológico</a></li>
			</ul>
			
    <ul>
    <div id="tabs-1">
    
	<h2 class="texPrincipal">Evaluar Micosis Superficial</h2>
    
  
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
			<p>
                Aqui colocamos una pequeña descripcion de ayuda sobre esta pantalla para que el usuario tenga material de apoyo
            </p>
	</div>
    <form>
    <center>
      <select id="sel_pac_ref" name="sel_pac_ref" class="textos">
        <option>Cromomicosis Dermatofitica</option>
        <option>Dermatofitosis</option>
        <option>Oculomicosis</option>
        <option>Onicomicosis Dermatofitica</option>
        <option>Onicomicosis no Dermatofitica</option>
        <option>Otomicosis</option>
        <option>Piedra Blanca</option>        
        <option>Piedra Negra</option>
        <option>Pitiriasis Versicolor</option>
        <option>Tinea Barbae</option>
        <option>Tinea Capitis</option>
        <option>Tinea Corporis</option>
        <option>Tinea Cruris</option>
        <option>Tinea Imbricata</option>
        <option>Tinea Manuum</option>
        <option>Tinea Pedis</option>
        <option>Tinea Unguium</option>
        <option>Tiña Negra </option>
      </select>
    </center>
    </form>
    <form action="" method="get">
    <table width="474" border="0" align="center">
  <tr>
    <td width="26"><input type="checkbox" name="checkbox" id="checkbox"></td>
    <td width="180"><label>Cromomicosis Dermatofitica</label></td>
    <td width="40">&nbsp;</td>
    <td width="20"><input type="checkbox" name="checkbox10" id="checkbox10"></td>
    <td width="186">Tinea Barbae</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox2" id="checkbox2"></td>
    <td>Dermatofitosis</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox18" id="checkbox18"></td>
    <td>Tinea Capitis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox3" id="checkbox3"></td>
    <td>Oculomicosis</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox17" id="checkbox17"></td>
    <td>Tinea Corporis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox4" id="checkbox4"></td>
    <td>Onicomicosis Dermatofitica</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox16" id="checkbox16"></td>
    <td>Tinea Cruris</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox5" id="checkbox5"></td>
    <td>Onicomicosis no Dermatofitica</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox15" id="checkbox15"></td>
    <td>Tinea Imbricata</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox6" id="checkbox6"></td>
    <td>Otomicosis</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox14" id="checkbox14"></td>
    <td>Tinea Manuum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox7" id="checkbox7"></td>
    <td>Piedra Blanca</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox13" id="checkbox13"></td>
    <td>Tinea Pedis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox8" id="checkbox8"></td>
    <td>Piedra Negra</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox12" id="checkbox12"></td>
    <td>Tinea Unguium</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox9" id="checkbox9"></td>
    <td>Pitiriasis Versicolor</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox11" id="checkbox11"></td>
    <td>Ti&ntilde;a Negra </td>
  </tr>
</table>
</form>
  </fieldset>         
            </div>
          
    <div id="tabs-2">
	<h2 class="texPrincipal">Descripcion de la Lesion Mano(s), Uña(s) y Pie(s)</h2>
    
  
  <fieldset>	
    
		<legend>
    		<strong>
    			Agente de Infección:    		</strong>    	</legend>
  
  

  
  

  
  
  <form id="for_Eva" name="for_Eva" method="post" action="">
    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="24"><div align="center"></div></td>
        <td width="149"><div align="center"></div></td>
        <td width="110"><div align="center">Mano</div></td>
        <td width="110"><div align="center">U&ntilde;as</div></td>
        <td width="110"><div align="center">Pies</div></td>
      </tr>
    </table>
    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="20">&nbsp;</td>
        <td width="153">&nbsp;</td>
        <td width="55"><div align="center">Derecha</div></td>
        <td width="55"><div align="center">Derecha</div></td>
        <td width="55"><div align="center">Izquierda</div></td>
        <td width="55"><div align="center">Derecha</div></td>
        <td width="55"><div align="center">Izquierdo</div></td>
        <td width="55"><div align="center">Derecho</div></td>
      </tr>
    </table>
    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="20"><p>
          <input type="checkbox" name="checkbox19" id="checkbox19">
        </p></td>
        <td width="140">Onicolisis subungueal distal</td>
        <td width="13">&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox20" id="checkbox20">
        </p></td>
        <td>Onicodistrofia total</td>
        <td>&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox21" id="checkbox21">
        </p></td>
        <td>Coloraci&oacute;n blanco-amarillenta</td>
        <td>&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox22" id="checkbox22">
        </p></td>
        <td>Coloraci&oacute;n negruzca</td>
        <td>&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox23" id="checkbox23">
        </p></td>
        <td>Onicolisis subungueal proximal</td>
        <td>&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox24" id="checkbox24">
        </p></td>
        <td>Leuconiquia</td>
        <td>&nbsp;</td>
        <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox25" id="checkbox25">
        </p></td>
        <td>Coloraci&oacute;n pardo-naranja</td>
        <td>&nbsp;</td>
         <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
      <tr>
        <td><p>
          <input type="checkbox" name="checkbox26" id="checkbox26">
        </p></td>
        <td>Dermatofitoma</td>
        <td>&nbsp;</td>
         <td width="55"><div align="center"><img src="Img/Man_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Man_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Una_Der.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Izq.png" width="39" height="52"></div></td>
        <td width="55"><div align="center"><img src="Img/Pie_Der.png" width="39" height="52"></div></td>
      </tr>
    </table>    
  </form> 
</fieldset>
     </div>
     
    <div id="tabs-3">
    
	<h2 class="texPrincipal">Descripción de la Lesión Piel ó Pelo</h2>
    
  
  <fieldset>	
    
		<legend>
    		<strong>
    			Tipo de Infección:    		</strong>    	</legend>
    <form action="" method="get">
    <table width="474" border="0" align="center">
  <tr>
    <td width="26"><input type="checkbox" name="checkbox" id="checkbox"></td>
    <td width="180"><label>Placas eritematoscamosa</label></td>
    <td width="40">&nbsp;</td>
    <td width="20"><input type="checkbox" name="checkbox10" id="checkbox10"></td>
    <td width="186"> Multiples</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox2" id="checkbox2"></td>
    <td> Descamativa</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox18" id="checkbox18"></td>
    <td>Pustulas</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox3" id="checkbox3"></td>
    <td> Pruriginosa</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox17" id="checkbox17"></td>
    <td>Alopecia</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox4" id="checkbox4"></td>
    <td>Bordees Activos</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox16" id="checkbox16"></td>
    <td>Granuloma tricofitico</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox5" id="checkbox5"></td>
    <td> Inflamatoria</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox15" id="checkbox15"></td>
    <td>Foliculitis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox6" id="checkbox6"></td>
    <td>Extensa</td>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="checkbox14" id="checkbox14"></td>
    <td>Querion de celso</td>
  </tr>
</table>
    </form>
  </fieldset>         
            </div>
            
    <div id="tabs-4">
    
	<h2 class="texPrincipal">Estudio Micológico de Laboratorio</h2>
    
  
  
	
    <table width="500" border="0" align="center">
  <tr>
    <td width="245">
    <fieldset>
    <legend><strong>Directo</strong></legend>
    <table width="240" border="0" align="center">
  <tr>
    <td width="20"><label>
      <input type="checkbox" name="checkbox27" id="checkbox27">
    </label></td>
    <td width="210">Hifas delgadas tabicadas</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox28" id="checkbox28"></td>
    <td>Hifas gruesas tabicadas</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox29" id="checkbox29"></td>
    <td>Blastoconidias</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox30" id="checkbox30"></td>
    <td>Pseudohifas     </td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox31" id="checkbox31"></td>
    <td>Artroconidias</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox32" id="checkbox32"></td>
    <td>Hifas cortas y agrupamiento de esporas</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox33" id="checkbox33"></td>
    <td>Esporas Endotrix</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox34" id="checkbox34"></td>
    <td>Esporas Ectoendotrix</td>
  </tr>
  <tr>
    <td height="22">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="22">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="22">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="22">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
    </fieldset>    </td>
    <td width="245">
    <fieldset>
    <legend><strong>Cultivo</strong></legend>
   <table width="239" border="0" align="center">
  <tr>
    <td width="20"><label>
      <input type="checkbox" name="checkbox27" id="checkbox27">
    </label></td>
    <td width="180">Microsporum canis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox28" id="checkbox28"></td>
    <td>Microsporum gypseum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox29" id="checkbox29"></td>
    <td>Microsporum nanum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox30" id="checkbox30"></td>
    <td>Trichophyton rubrum      </td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox31" id="checkbox31"></td>
    <td>Trichophyton mentagrophytes</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox32" id="checkbox32"></td>
    <td>Trichophyton Tonsurans</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox33" id="checkbox33"></td>
    <td>Trichophyton Verrucosum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox34" id="checkbox34"></td>
    <td>Trichophyton Violaceum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox35" id="checkbox35"></td>
    <td>Epidermophyton Floccosum</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox36" id="checkbox36"></td>
    <td>Malassezia Furfur</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox37" id="checkbox37"></td>
    <td>Malassezia Pachydermatis</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="checkbox38" id="checkbox38"></td>
    <td>Malassezia Spp</td>
  </tr>
</table>
    </fieldset>    </td>
  </tr>
</table>
    </div>       
    </ul>
    </div>
    




