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
        <li>
            <a href="#tabs-1">
                Tipo de Infección
            </a>
        </li>
        <li>
            <a href="#tabs-2">
                Descripción de la Lesi&oacute;n I
            </a>
        </li>
        <li>
            <a href="#tabs-3">
                Descripción de la Lesi&oacute;n II
            </a>
        </li>
        <li>
            <a href="#tabs-4">
                Estudio Micológico
            </a>
        </li>
    </ul>

    <ul>
<div id="tabs-1">
            <h2 class="texPrincipal">
                Evaluar Micosis Subcutaneas
            </h2>
            
        <fieldset>	
            <legend>
                <strong>
                    Tipo de Infección:    		
                </strong>    	
            </legend>
<!------------------------------BOTON DE PREGUNTA--------------------------------------->  

            <a href="#" id="dialog_link" class="ui-state-default ui-corner-all">
                <span class="ui-icon ui-icon-help">
                </span>
                    Ayuda
            </a>
<!-- ui-dialog -->


<div id="dialog" title="Ayuda sobre descripción de la lesión">
                    Aqui colocamos una pequeña descripcion de ayuda sobre esta pantalla                        para que el usuario tenga material de apoyo
</div>


    <form action="" method="get">
        <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="250">
                    <fieldset>
                        <legend>
                            <strong>
                                Tipo de Infecci&oacute;n
                            </strong>
                        </legend>
                        
                        
        <table width="230" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="0" height="20">
                    <input type="checkbox" name="che_act2" id="formulario_check"/>
                </td>
                
                <td width="200">
                    Actinomicetoma
                </td>
            </tr>
            
            <tr>
                <td width="0" height="20">
                    <input type="checkbox" name="che_cro2" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Cromoblastomicos
                    </td>
            </tr>
            
            <tr>
                <td width="0" height="20">  
                        <input type="checkbox" name="che_esp2" id="formulario_check"/>
                    </td>

                    <td width="200">
                        Esporotricosis
                    </td>
                </tr>
                
                <tr>
                    <td width="0" height="20">  
                        <input type="checkbox" name="che_eum2" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Eumicetoma
                    </td>
                </tr>

                <tr>
                    <td width="0" height="20">  
                        <input type="checkbox" name="che_act3" id="formulario_check"/>
                    </td>
                                    
                    <td width="200">
                        Lobomicosis
                    </td>
                </tr>

                <tr>
                    <td width="0" height="20">&nbsp;
                    </td>
                    
                    <td width="200">&nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td width="0" height="20">&nbsp;  
                    </td>
                    
                    <td width="200">&nbsp;
                    </td>
                </tr>
        </table>





            </fieldset>    
                    </td>
                        <td width="240">
            <fieldset>
            
                <legend>
                    <strong>
                        Forma de Infecci&oacute;n
                    </strong>
                </legend>
                
            
            <table width="230" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="0" height="20">  
                        <input type="checkbox" name="che_Tra" id="formulario_check"/>    
                    </td>
                    
                    <td width="200">
                        Traum&aacute;tica
                    </td>
                </tr>

                <tr>
                    <td width="0" height="20">  
                        <input type="checkbox" name="che_Pic" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Picada Insecto
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <input type="checkbox" name="che_Pin" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Pinchazo espinas
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <input type="checkbox" name="che_Mor" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Mordedura roedores
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <input type="checkbox" name="che_Ins" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Instrumento met&aacute;lico
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="checkbox" name="che_Cas" id="formulario_check"/>
                    </td>
                    
                    <td width="200">
                        Caza animales
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="checkbox" name="che_Acc" id="formulario_check"/>
                    </td>

                    <td width="200">
                        Accidente laboratorio
                    </td>
                </tr>
        </table>

                        </fieldset>    
                    </td>
                </tr>
            </table>
        </form>
    </fieldset>         
</div>

<div id="tabs-2">
    <h2 class="texPrincipal">
        Ubicai&oacute;n de la Lesion
    </h2>
        
        <fieldset>	
            <legend>
                <strong>
                    Ubicaci&oacute;n:
                </strong>    	
            </legend>
            
            
                <form id="for_Eva" name="for_Eva" method="post" action="">
                    <table width="170" border="0" align="center"cellpadding="0" cellspacing="0" >
                        <tr>
                            <td width="0">
                                <input type="checkbox" name="che_Cab" id="formulario_check"/>              
                            </td>

                            <td>
                                Cabeza
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Tor" id="formulario_check"/>
                            </td>
                            
                            <td>
                                T&oacute;rax Anterior
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Esp" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Espalda
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Fla_Der" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Flanco derecho
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Fla_Izq" id="formulario_check"/>
                            </td>
                        
                            <td>
                                Flanco izquierdo
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Bra_Der" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Brazo derecho
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Bra_Izq" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Brazo izquierdo
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Pier_Der" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Pierna derecha
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Pier_Izq" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Pierna izquierda
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Pie_Der" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Pie derecho
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Pie_Izq" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Pie izquierdo
                            </td>
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
                    Tipo de Infección:    		
                </strong>    	
            </legend>

                <form action="" method="get">
                    <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <strong>
                                            Descripci&oacute;n
                                        </strong>
                                    </legend>

                    <table width="193" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="0" height="20">
                                <input type="checkbox" name="che_Les_Uni2" id="formulario_check"/>
                            </td>
                            
                            <td width="170">Lesi&oacute;n &Uacute;nica</td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Les_Mul2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Lesi&oacute;n M&uacute;ltiple
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Con_Fis2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Con f&iacute;stula
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Sin_Fis2" id="formulario_check"/>
                            </td>
    
                            <td>
                                Sin f&iacute;stula
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Sec2" id="formulario_check"/>
                            </td>

                            <td>
                                Secreci&oacute;n granos de la f&iacute;stula
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Aum_Vol2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Aumento volumen
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Afe_Hue2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Afectaci&oacute;n hueso
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Ver2" id="formulario_check"/>              
                            </td>
                            
                            <td>
                                Cut&aacute;nea verrugosa
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Tum2" id="formulario_check"/>
                            </td>

                            <td>
                                Cut&aacute;nea tumoral
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Pla2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea en placa
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        
                            <td width="245">
                                <fieldset>
                                    <legend>
                                        <strong>
                                            Descripci&oacute;n
                                        </strong>
                                    </legend>

                    <table width="193" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="0" height="20"> 
                                <input type="checkbox" name="formulario_check" id="formulario_check"/>
                            </td>
                            
                            <td width="170">
                                N&oacute;dulos eritematosos
                            </td>
                        </tr>
                        
                        <tr>
                            <td
                                ><input type="checkbox" name="che_Atr_Cen2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Atrofia central
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Bor_Act2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Bordes activos
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Fij2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea fija
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Lin2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea linfangitica
                            </td>
                        </tr>
                        
                        <tr>
                        
                            <td>
                                <input type="checkbox" name="che_Cut_Mul2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea m&uacute;ltiple
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Que2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea queloidal
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Inf2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea infiltrante
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Gom2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea gomosa
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" name="che_Cut_Ulc2" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cut&aacute;nea ulcerada
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
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
                        
                        
                    <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <strong>
                                            Directo
                                        </strong>
                                    </legend>
                        
                        
                    <table width="270" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Lev" id="formulario_check"/>              
                            </td>
                        
                            <td width="270">
                                Levaduras Simples
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Bla" id="formulario_check"/>
                            </td>
                        
                            <td>
                                Blastoconidias
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Lev_Cad" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Levaduras en cadena
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Fum" id="formulario_check"/>
                            </td>
                        
                            <td>
                                C&eacute;lulas fumogoides
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="checkbox" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Hifas dematiaceas
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="checkbox" id="formulario_check"/>
                            </td>
                        
                            <td>
                                Cuerpos asteroides
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                        
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                &nbsp;  
                            </td>
                            
                            <td>
                                &nbsp;
                            </td>
                        </tr>

                    </table>
                </fieldset>
            </td>
                        
                        
                        <td>
                                <fieldset>
                            <legend>
                                <strong>
                                    Cultivo
                                </strong>
                            </legend>
                    
                     <table width="270" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="0" height="20">   
                                <input type="checkbox" name="che_Exa_Sch" id="formulario_check"/>              
                            </td>
                            
                            <td width="270" height="20">
                                Sporothix Schenckii
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                <input type="checkbox" name="che_Exa_Cla" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Cladiophialophora carrionii
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Fon" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Fonseca pedrosoi    
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Phi" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Phialophora cerrucosa
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Rhi" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Rhinocladiella aquaspersa
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">      
                                <input type="checkbox" name="che_Exa_Acr" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Acremionium spp
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Acr_Fal" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Acremionium falciforme
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Mad" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Madurella grisea    
                            </td>
                        </tr>
                        <tr>
                            <td width="0" height="20">      
                                <input type="checkbox" name="che_Exa_Pse" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Pseudallescheria boydii
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Fus_Oxi" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Fusarium oxisporum
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Fus_Sol" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Fusarium solami
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Mal" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Malassezia SPP
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Asp" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Aspergillus flavus
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Asp_Nid" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Aspergillus nidulans
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Asp_Fum" id="formulario_check"/>
                            </td>
                                                        
                            <td>
                                Aspergillus fumigatus
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">      
                                <input type="checkbox" name="che_Exa_Asp_Spp" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Aspergillus SPP 
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">      
                                <input type="checkbox" name="che_Exa_Noc" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Nocardia Brasiliensis
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Str" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Streptomyces somaliensis
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">  
                                <input type="checkbox" name="che_Exa_Act" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Actinomadura madurae
                            </td>
                        </tr>

                        <tr>
                            <td width="0" height="20">
                                <input type="checkbox" name="che_Exa_Fus_Spp" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Fusarium SPP
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="0" height="20">
                                <input type="checkbox" name="che_Exa_Par_Lob" id="formulario_check"/>
                            </td>
                            
                            <td>
                                Paracoccidioides loboi (Histopoatologia)
                            </td>
                        </tr>
                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>         
        </div>        
    </ul>
</div>