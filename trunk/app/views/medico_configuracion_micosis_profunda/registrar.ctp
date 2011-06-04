<script type="text/javascript">
    jQuery(function() 
    {
        jQuery( "#tabs" ).tabs
        ({
            event: "mouseover"
        });
    });
    
    jQuery(function()
    {
        jQuery("#accordion").accordion({ header: "h3" });
            // Tabs
        jQuery('#tabs').tabs();
            // Dialog			
        jQuery('#dialog').dialog
          ({
            autoOpen: false,
            width: 600,
                buttons: 
                 {
                    "Ok": function() 
                        { 
                            jQuery(this).dialog("close"); 
                        }, 
                    "Cancel": function() 
                        {                     
                            jQuery(this).dialog("close"); 
                        } 
                 }
          });

            // Dialog Link
                jQuery('#dialog_link').click(function()
                {               
                    jQuery('#dialog').dialog('open');
                    return false;
                });

            // Datepicker
                jQuery('#datepicker').datepicker
                ({
                    inline: true
                });

            // Slider
                jQuery('#slider').slider
                ({                
                    range: true,
                    values: [17, 67]
                });

            // Progressbar
                jQuery("#progressbar").progressbar
                ({                
                    value: 20 
                });


            //hover states on the static widgets
                jQuery('#dialog_link, ul#icons li').hover
                (
                    function() { jQuery(this).addClass('ui-state-hover'); }, 
                    function() { jQuery(this).removeClass('ui-state-hover'); }
                ); 



            /*Agregando Clase CSS para el fondo del login*/       

                jQuery(function()
                {               
                    jQuery("#link_aceptar").click(function()
                        {                    
                            jQuery("#login").submit();
                        })
                    jQuery("#login").validate
                        ({                      
                            submitHandler: function(form) 
                            {                                            
                                    var array_form = jQuery("input[type=text],input[type=password]").serializeArray();
                                    var array_form = jQuery("form").serializeArray();                                                  
                                        jQuery.ajax
                                        ({
                                                        url:"<?php echo $this->Html->url("/medico/validar_usuario")?>",
                                                        type: "POST",
                                                        data: array_form,
                                                        dataType: "json",                                      
                                                        error:function(){alert("Error json")},
                                                        success: function(data)
                                                        {                                                                                                             
                                                        eval("data="+data);   

                                                    jQuery("#dialog #dialog_messege").css("display","block");
                                                    jQuery("#dialog img").css("display","none"); 

                                                var _select = "#dialog #dialog_text";     

                                                    jQuery(_select).empty();
                                                    jQuery(_select).text(data.coment);

                                                        _select = "#dialog td > div > div";
                                                    jQuery(_select).attr("class","");
                                                    jQuery(_select).addClass(data.class_background);

                                                        _select = "#dialog span";
                                                    jQuery(_select).attr("class","");
                                                    jQuery(_select).addClass(data.class_icon);

                                                    jQuery("#dialog").dialog("destroy");
                                                    jQuery("#dialog").dialog
                                                    ({
                                                        modal:true,
                                                        minHeight: 150,                            
                                                        buttons: 
                                                            [
                                                                {
                                                                    text: '<?php echo __("Aceptar",true)?>',
                                                                    click: function() 
                                                                    {                                                         
                                                                    jQuery(this).dialog("close"); 
                                                                    }
                                                                }
                                                            ],

                                                                resizable: false
                                                    }).css("display","block");                                                                                                            
                                                if (data.event == 1)
                                                {                                    
                                                    window.location.href = "<?php echo $this->Html->url("/medico") ?>";
                                                }                                                                        
                                            }                   
                                        });

                                        jQuery("#dialog").dialog("destroy");
                                        jQuery("#dialog #dialog_messege").css("display","none");
                                        jQuery("#dialog img").css("display","block");                
                                        jQuery("#dialog").dialog
                                        ({
                                            resizable: false
                                        }).css("display","block");    

                            }   
                        }); 
                });
});
</script>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">Descripción</a></li>
		<li><a href="#tabs-2">Estudio Micol&oacute;gico</a></li>
                <li><a href="#tabs-3">Inmunodiagnostico</a></li>
                <li><a href="#tabs-4">Serologia por (IDD)</a></li>
                <li><a href="#tabs-5">Elisa</a></li>
                <li><a href="#tabs-6">Estudio Molecular</a></li>
	</ul>
<!--Inicio de la pestaña "tabs-1" -->    	 
    <div id="tabs-1">
        <h2 class="texPrincipal">Evaluar Micosis Profunda</h2>
        <fieldset>	   
            <legend><strong>Descripción de la lesión:</strong></legend>   
        <!--<form>
                <center>
                    <table width="364" border="0">
                        <tr>
                            <td width="182">
                                <h3 class="texSecundario">
                                    <fieldset>
                                        <legend>Tipo de Infección</legend>
                                        <p align="center">
                                            <select id="sel_pac_ref" name="sel_pac_ref" class="textos">
                                                <option> Actinomicetoma </option>
                                                <option> Cromoblastomicos </option>
                                                <option> Esporotricosis </option>
                                                <option> Eumicetoma </option>
                                                <option> Lobomicosis </option>
                                            </select>
                                        </p>
                                    </fieldset>
                                </h3>          
                            </td>
                            <td width="166">
                                <h3 class="texSecundario">
                                    <fieldset>
                                        <legend>Forma de Infección</legend>
                                        <p align="center">
                                            <select id="sel_pac_ref" name="sel_pac_ref" class="textos">
                                                <option> Actinomicetoma </option>
                                                <option> Cromoblastomicos </option>
                                                <option> Esporotricosis </option>
                                                <option> Eumicetoma </option>
                                                <option> Lobomicosis </option>
                                            </select>
                                        </p>
                                    </fieldset>
                                </h3>          
                            </td>
                        </tr>
                    </table>
                </center>
            </form>-->
            <form action="" method="get">
                <table width="474" border="0" align="center">
                    <tr>
                        <td width="237">
                            <fieldset>
                                <legend><strong>Descripci&oacute;n:</strong></legend>
                                <table width="235" border="0">
                                    <tr>
                                        <td width="20">
                                            <input type="checkbox" name="che_cut" id="formulario_check"/>
                                        </td>
                                        <td width="200">Cut&aacute;nea</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul" id="formulario_check"/></td>
                                        <td>Pulmonar</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul_lev" id="formulario_check"/></td>
                                        <td>Pulmonar leve</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul_mod" id="formulario_check"/></td>
                                        <td>Pulmonar moderada</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul_agu" id="formulario_check"/></td>
                                        <td>Pulmonar aguda</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul_cro" id="formulario_check"/></td>
                                        <td>Pulmonar cr&oacute;nica benigna</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_pul_pro" id="formulario_check"/></td>
                                        <td>Pulmonar progresiva</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_dis" id="formulario_check"/></td>
                                        <td>Diseminada</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_teg" id="formulario_check"/></td>
                                        <td>Tegumentaria (mucocut&aacute;nea)</td>
                                    </tr>
                                </table>
                            </fieldset>    
                        </td>
                        <td width="237">
                            <fieldset>
                                <legend><strong>Descripción:</strong></legend>
                                <table width="235" border="0">
                                    <tr>
                                        <td width="25"><input type="checkbox" name="che_gan" id="formulario_check"/></td>
                                        <td width="200">Ganclionar</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_vic" id="formulario_check"/></td>
                                        <td>Visceral</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_mix" id="formulario_check"/></td>
                                        <td>Mixta</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_men" id="formulario_check"/></td>
                                        <td>Men&iacute;ngea</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_hep" id="formulario_check"/></td>
                                        <td>Hepatoesplenomegalia</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_gen" id="formulario_check"/></td>
                                        <td>Generalizada</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_hit" id="formulario_check"/></td>
                                        <td>Hitoplasmoma</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="che_otr" id="formulario_check"/></td>
                                        <td>Otra</td>
                                    </tr>
                                    <tr>
                                        <td height="20">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </fieldset>    
                        </td>
                    </tr>
                </table>
            </form>
        </fieldset>         
        <fieldset>	   
              <legend><strong>Modo de Infección:</strong></legend>
              <form action="" method="get" style="text-align:center">
                <select name="">
                    <option>-- --</option>
                    <option>Inhalación</option>
                    <option>Traumática</option>
                    <option>Accidente de Laboratorio</option>
                </select>
              </form>  
        </fieldset>   
    </div>
<!--Final de la pestaña "tabs-1" -->
          
    
<!--Inicio de la pestaña "tabs-2" -->    
    <div id="tabs-2">
        <h2 class="texPrincipal">Examen Directo y de Cultivo</h2>
        <fieldset>	
            <legend><strong>Examen:</strong></legend>
            <form action="" method="get">
                <table width="470" border="0" align="center">
                    <tr>
                        <td width="223">
                            <fieldset>
                                <legend><strong>Directo</strong></legend>
                                <table width="221" height="122" border="0">
                                    <tr>
                                        <td width="20" height="22"><input type="checkbox" name="che_Exa_Lev_Sim" id="formulario_check"/></td>
                                        <td width="191">Levaduras Simples</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Levaduras Multi</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Esf&eacute;rulas pared doble</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Levaduras Intracelulares</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Otro</td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td width="237">
                            <fieldset>
                                <legend><strong>Cultivo</strong></legend>
                                <table width="244" height="122" border="0">
                                    <tr>
                                        <td width="20" height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td width="214">Coccidioides posadasii</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Histoplasma Capsulatum</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox" id="formulario_check"/></td>
                                        <td>Paracoccidioides Brasiliensis</td>
                                    </tr>
                                    <tr>
                                        <td height="22"><input type="checkbox" name="checkbox2" id="formulario_check"/></td>
                                        <td>Otro</td>
                                    </tr>
                                    <tr>
                                        <td height="22">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <fieldset>
                    <legend><strong> Agente Ailado</strong></legend>
                    <table width="549" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="20"><input type="checkbox" name="checkbox7" id="formulario_check"/></td>
                            <td width="150"><div align="left">Coccidioides posadasii</div></td>
                            <td width="20"><input type="checkbox" name="checkbox8" id="formulario_check"/></td>
                            <td width="150"><div align="left">Histoplasma Capsulatum</div></td>
                            <td width="20"><input type="checkbox" name="checkbox9" id="formulario_check"/></td>
                            <td width="150"><div align="left">Paracoccidioides Brasiliensis</div></td>
                        </tr>
                    </table>
                </fieldset>
            </form>
        </fieldset>         
    </div>
<!--Final de la pestaña "tabs-2" -->
            
<!--Inicio de la pestaña "tabs-3" -->            
    <div id="tabs-3">
        <h2 class="texPrincipal">Inmunodiagnostico de Las Micosis Subcutaneas</h2>
        <fieldset>	
            <legend><strong>Lectura 24 y 48 horas:</strong></legend>
            <table border="1" class="circular" align="center">
                <tr>
                    <th>
                        <table border="1" cellpadding="0" cellspacing="0">
                            <tr>
                                <th>&nbsp;</th>
                                <th>0-4,99 mm</th>
                                <th>5-7 MM</th>
                                <th>8-15 MM</th>
                                <th>&gt; 15MM</th> 
                            </tr>
                            <tr>
                                <th>Candidina</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /> </td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>ESPOROTRIQUINA</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>LEISHMANINA</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>HISTOPLASMINA</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>COCCIDIODINA</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>PARACOCCIDIOIDINA</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>PPD</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_3" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_4" value="radio" /></td>
                            </tr>
                        </table>
                    </th>
                </tr>
            </table>
        </fieldset>         
    </div>
<!--Final de la pestaña "tabs-3" -->            

<!--Inicio de la pestaña "tabs-4" -->
    <div id="tabs-4">
        <h2 class="texPrincipal">Inmunodiagnostico de Las Micosis Subcutaneas</h2>
        <fieldset>	
            <legend><strong>Lectura 24 y 48 horas:</strong></legend>
            <table width="150" border="1" class="circular" align="center">
                <tr>
                    <td>
                        <table width="150" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <th width="120">Antigenos</th>
                                <th>IDD</th>
                                <th>Titulo</th>
                                <th>Linea Iden</th>
                            </tr>
                        </table>
                        <table border="0" cellpadding="0" cellspacing="0" > 
                            <tr>
                                <th>&nbsp;</th>
                                <th>+</th>
                                <th>_</th>
                                <th>1:2</th>
                                <th>1:4</th>
                                <th>1:8</th>
                                <th>1:16</th>
                                <th>1:32</th>
                                <th>+1:32</th>
                                <th>Si</th>
                                <th>No</th>
                            </tr>
                            <tr>
                                <th>Candida</th>
                                    <form name="form1" method="post" action="">
                                        <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                        <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                    </form>

                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio" /></td>
                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio"/></td>
                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio"/></td>
                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio"/></td>
                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio"/></td>
                                <td class="fontd"><input name="radio" type="radio" value="" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>

                            <tr>
                                <th>S. Schenckii</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>P. Brasiliensis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>C. Posadasii</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>H. Capsulatum</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Aspergillus</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Criptococcus </th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" value="radio" id="formulario_radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>

                                
                            
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>         
    </div>
<!--Final de la pestaña "tabs-4" -->            

<!--Inicio de la pestaña "tabs-5" -->
    <div id="tabs-5">
        <h2 class="texPrincipal">Inmunodiagnostico de Las Micosis Subcutaneas</h2>
        <fieldset>	
            <legend><strong>Lectura 24 y 48 horas:</strong></legend>
            <table border="1" class="circular">
                <tr>
                    <td>
                        <table width="600" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <th width="121">Antigenos</th>
                                <th width="77">IDD</th>
                                <th width="332">Titulo</th>
                                <th width="73">Linea Iden</th>
                            </tr>
                        </table>
                        <table width="600"  border="0" cellpadding="0" cellspacing="0"> 
                            <tr>
                                <th width="200">&nbsp;</th>
                                <th width="39">+</th>
                                <th width="39">_</th>
                                <th width="60">1:2</th>
                                <th width="60">1:4</th>
                                <th width="60">1:8</th>
                                <th width="60">1:16</th>
                                <th width="60">1:32</th>
                                <th width="60">+1:32</th>
                                <th width="39">Si</th>
                                <th width="39">No</th>
                            </tr>
                            <tr>
                                <th>Candidiasis</th>
                                <form name="form1" method="post" action="">
                                    <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                                    <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                                </form>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input name="" type="radio" value="" /></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                            </tr>
                            <tr>
                                <th>Esporotricosis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="checkbox10"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Cromomicosis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Histoplasmosis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Paracoccidioidomicosis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Coccidioidomicosis</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                            <tr>
                                <th>Aspergil</th>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio3" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio4" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio5" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio6" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio7" value="radio"/></td>
                                <td class="fontd"><input type="radio" name="radio" id="radio8" value="radio"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                                <td class="fontd"><input type="checkbox" name="checkbox10" id="formulario_check"/></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>         
    </div>
<!--Final de la pestaña "tabs-5" -->            

<!--Inicio de la pestaña "tabs-6" -->
    <div id="tabs-6">
        <h2 class="texPrincipal">Inmunodiagnostico de Las Micosis Subcutaneas</h2>
        <fieldset>	
            <legend><strong>Lectura 24 y 48 horas:</strong></legend>
            <table border="1" class="circular" align="center">
                <tr>
                    <th>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <th width="138">antigenos</th>
                                <th width="85">Positivo</th>
                                <th width="85">Negativo</th>
                            </tr>
                            <tr>
                                <th>Candidina</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /> </td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>Cryptococcus</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>P. Brasiliensis</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>H. Capsulatum</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>S. Schenckii</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                            <tr>
                                <th>C. Posadasii</th>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_1" value="radio" /></td>
                                <td class="fontd"><input type="radio" name="rad_can" id="rad_2" value="radio" /></td>
                            </tr>
                        </table>
                    </th>
                </tr>
            </table>
        </fieldset>         
    </div>
<!--Final de la pestaña "tabs-6" -->            
</div>