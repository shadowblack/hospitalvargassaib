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
                        Evaluar Micosis Superficial
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
    <div id="dialog" title="Ayuda sobre descripción de la lesión">
        Aqui colocamos una pequeña descripcion de ayuda sobre 
        esta pantalla para que el usuario tenga material de apoyo
    </div>

<form action="" method="get">
    
    <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
<!--Inicio de la 1era fila-->
        <tr>
            <td>
                <input type="checkbox" name="checkbox" id="formulario_check" />
            </td>

            <td width="120">
                <label>
                    <div align="left">
                        Cromomicosis Dermatofitica
                    </div>
                </label>
            </td>

            <td width="1">
            </td>


            <td width="1">
                <div>
                <input type="checkbox" name="checkbox10" id="formulario_check"/>        
                </div>
            </td>

            <td width="120">
                Tinea Barbae
            </td>
        </tr>
<!--Fin de la 1era fila-->  

<!--Inicio de la 2da fila-->
        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox2" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Dermatofitosis
                </div>
            </td>
            
            <td>
            </td>
            
            <td width="1">
                <input type="checkbox" name="checkbox18" id="formulario_check"/>
            </td>

            <td>
                Tinea Capitis
            </td>
        </tr>
<!--Fin de la 2da fila--> 

<!--Inicio de la 3ra fila-->   
        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox3" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Oculomicosis
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox17" id="formulario_check"/>
            </td>

            <td>
                Tinea Corporis
            </td>
        </tr>
<!--Fin de la 3ra fila-->  

<!--Inicio de la 4ta fila-->  
        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox4" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Onicomicosis Dermatofitica
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox16" id="formulario_check"/>        
            </td>

            <td>
                Tinea Cruris
            </td>
        </tr>
<!--Fin de la 4ta fila--> 

<!--Inicio de la 5ta fila-->   

        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox5" id="formulario_check"/>
            </td>
            
            <td>
                <div align="left">
                    Onicomicosis no Dermatofitica
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox15" id="formulario_check"/>
            </td>

            <td>
                Tinea Imbricata
            </td>
        </tr>
<!--Fin de la 5ta fila-->       

<!--Inicio de la 6va fila-->    
        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox6" id="formulario_check"/>
            </td>
            <td>
                <div align="left">
                    Otomicosis
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox39" id="formulario_check"/>
            </td>

            <td>
                Tinea Manuum
            </td>
        </tr>
<!--Fin de la 6va fila-->        

<!--Inicio de la 7ma fila--> 
        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox7" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Piedra Blanca
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox13" id="formulario_check"/>
            </td>

            <td>
                Tinea Pedis
            </td>
        </tr>
<!--Fin de la 7ma fila-->        


        <tr>
            <td width="1">
                <input type="checkbox" name="checkbox8" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Piedra Negra
                </div>
            </td>

            <td>
            </td>

            <td width="1">
                <input type="checkbox" name="checkbox12" id="formulario_check"/>
            </td>

            <td>
                Tinea Unguium
            </td>
        </tr>


        <tr>
            <td>
                <input type="checkbox" name="checkbox9" id="formulario_check"/>
            </td>

            <td>
                <div align="left">
                    Pitiriasis Versicolor
                </div>
            </td>

            <td>
            </td>

            <td>      

                <input type="checkbox" name="checkbox11" id="formulario_check"/>    

            </td>

            <td>
                Ti&ntilde;a Negra
            </td>
        </tr>
    </table>
</form>
                        </fieldset>         
        </div>
<!--FIN DE LA PRIMERA PESTAÑA DEL MODULO MICOSIS SUPERFICIAL--> 
<!--                                                        -->


    <div id="tabs-2">
                    <h2 class="texPrincipal">
                        Descripcion de la Lesion Mano(s), Uña(s) y Pie(s)
                    </h2>
                        <fieldset>	
                            <legend>
                                <strong>
                                    Agente de Infección:
                                </strong>
                            </legend>


<form id="for_Eva" name="for_Eva" method="post" action="">
    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >

        <tr>
            
            <td width="19">
                <div align="center">
                </div>
            </td>
            
            <td width="150">
                <div align="center">
                </div>
            </td>
            
            <td width="80">
                <div align="center">
                    Mano
                </div>
            </td>
            
            <td width="80">
                <div align="center">
                    U&ntilde;as
                </div>
            </td>
            
            <td width="80">
                <div align="center">
                    Pies
                </div>
            </td>
        </tr>
    </table>

    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
            <td width="20">&nbsp;            
            </td>
            
            <td width="152">&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    Izq
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    Der
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    Izq
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    Der
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    Izq
                </div>
            </td>
            
            <td width="40">    
                <div align="center">
                    Der
                </div>
            </td>
        </tr>
    </table>

    <table width="503" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
            <td width="20">
                <p>
                    <input type="checkbox" name="checkbox19" id="formulario_check"/>
                </p>            
            </td>
            
            <td width="141">
                Onicolisis subungueal distal            
            </td>
            
            <td width="13">&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox20" id="formulario_check"/>
                </p>            
            </td>
            
            <td>
                Onicodistrofia total            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox21" id="formulario_check"/>
                </p>
            </td>
            
            <td>
                Coloraci&oacute;n blanco-amarillenta            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox22" id="formulario_check"/>
                </p>
            </td>
            
            <td>
                Coloraci&oacute;n negruzca            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox23" id="formulario_check"/>
                </p>
            </td>

            <td>
                Onicolisis subungueal proximal            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox24" id="formulario_check"/>
                </p>
            </td>
            
            <td>
                Leuconiquia            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>

        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox25" id="formulario_check"/>
                </p>
            </td>
            
            <td>
                Coloraci&oacute;n pardo-naranja            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
        
        <tr>
            <td>
                <p>
                    <input type="checkbox" name="checkbox26" id="formulario_check"/>
                </p>            
            </td>
            
            <td>
                Dermatofitoma            
            </td>
            
            <td>&nbsp;            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Man_Der.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Izq.png" height="47" width="41"/>
                </div>
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Una_Der.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Izq.png" height="47" width="41"/>
                </div>            
            </td>
            
            <td width="40">
                <div align="center">
                    <img src="../img/Img_formulario/Pie_Der.png" height="47" width="41"/>
                </div>            
            </td>
        </tr>
    </table>    
</form> 
                        </fieldset>
    </div>

    <div id="tabs-3">

                    <h2 class="texPrincipal">
                        Descripción de la Lesión Piel ó Pelo
                    </h2>


                        <fieldset>	

                            <legend>
                                <strong>
                                    Tipo de Infección:
                                </strong>    	
                            </legend>

<form action="" method="get">

    <table width="513" border="0" align="center" cellpadding="0"  cellspacing="0">

<!--Inicio de la 1ra fila-->  
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Placas eritematoscamosa
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox10" id="formulario_check"/>
                </div>
            </td>

            <td width="220"> 
                <div align="left">
                    Multiples
                </div>
            </td>
        </tr>
<!--Fin de la 1ra fila-->        

<!--Inicio de la 2da fila-->        
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox2" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Descamativa
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox18" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Pustulas
                </div>
            </td>
        </tr>
<!--Fin de la 2da fila-->  

<!--Inicio de la 3ra fila-->  
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox3" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Pruriginosa
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox17" id="formulario_check"/>    
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Alopecia
                </div>
            </td>
        </tr>
<!--Fin de la 3ra fila-->  

<!--Inicio de la 4ta fila-->  
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox4" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Bordees Activos
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox16" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Granuloma tricofitico
                </div>
            </td>

        </tr>
<!--Fin de la 4ta fila-->  

<!--Inicio de la 5ta fila-->  
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox5" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Inflamatoria
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox15" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Foliculitis
                </div>
            </td>
        </tr>
<!--Fin de la 5ta fila-->  

<!--Inicio de la 6ta fila-->     
        <tr>
            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox6" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Extensa
                </div>
            </td>

            <td width="0">
            </td>

            <td width="20">
                <div align="left">
                    <input type="checkbox" name="checkbox14" id="formulario_check"/>
                </div>
            </td>

            <td width="220">
                <div align="left">
                    Querion de celso
                </div>
            </td>
        </tr>
<!--Fin de la 6ta fila-->
    </table>
</form>
                        </fieldset>         
    </div>


    <div id="tabs-4">
                    <h2 class="texPrincipal">
                        Estudio Micológico de Laboratorio
                    </h2>

    <table width="618" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="245">

                        <fieldset>
                            <legend>
                                <strong>
                                    Directo
                                </strong>
                            </legend>

    <table width="283" border="0" align="center" cellpadding="0" cellspacing="0">

<!--Inicio de la 1ra fila-->    
        <tr>
            <td width="20">            
                <div align="left">
                    <input type="checkbox" name="checkbox27" id="formulario_check"/>
                </div>
            </td>

            <td>                
                <div align="left">
                    Hifas delgadas tabicadas
                </div>                
            </td>
        </tr>
<!--Fin de la 1ra fila-->       

<!--Inicio de la 2da fila--> 
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox28" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Hifas gruesas tabicadas
                </div>
            </td>
        </tr>
<!--Fin de la 2da fila--> 

<!--Inicio de la 3era fila-->   
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox29" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Blastoconidias
                </div>
            </td>
        </tr>
<!--Fin de la 3era fila-->


<!--Inicio de la 4ta fila-->
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox30" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Pseudohifas
                </div>
            </td>
        </tr>
<!--Fin de la 4ta fila-->

<!--Inicio de la 5ta fila-->
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox31" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Artroconidias
                </div>
            </td>
        </tr>
<!--Fin de la 5ta fila-->

<!--Inicio de la 6ta fila-->
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox32" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Hifas cortas y agrupamiento de esporas
                </div>
            </td>
        </tr>
<!--Fin de la 6ta fila-->

<!--Inicio de la 7ma fila-->
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox33" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Esporas Endotrix
                </div>
            </td>
        </tr>
<!--Fin de la 7ma fila-->

<!--Inicio de la 8va fila-->    
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox34" id="formulario_check"/>
                </div>
            </td>

            <td>
                <div align="left">
                    Esporas Ectoendotrix
                </div>
            </td>
        </tr>
<!--Fin de la 8va fila-->

<!--Inicio de la 9na fila-->    
        <tr>

            <td height="20">
            </td>

            <td>
            </td>
        </tr>
<!--Fin de la 9na fila-->  

<!--Inicio de la 10ma fila-->    
        <tr>

            <td height="20">
            </td>

            <td>
            </td>
        </tr>
<!--Fin de la 10ma fila-->  

<!--Inicio de la 11ava fila-->    
        <tr>

            <td height="20">
            </td>

            <td>
            </td>
        </tr>
<!--Fin de la 11ava fila-->

<!--Inicio de la 12ava fila-->    
        <tr>

            <td height="20">
            </td>

            <td>
            </td>
        </tr>
<!--Fin de la 12ava fila-->  

    </table>
                        </fieldset>
            </td>

            <td width="261">
                        <fieldset>
                            <legend>
                                <strong>
Cultivo
                                </strong>
                            </legend>

    <table width="267" border="0" align="center" cellpadding="0" cellspacing="0">
<!--Inicio de la 1era fila-->        
        <tr>
            <td height="20">

                <div align="left">
                    <input type="checkbox" name="checkbox27" id="formulario_check"/>
                </div>

            </td>

            <td>
                <div align="left">
                    Microsporum canis
                </div>
            </td>
        </tr>
<!--Fin de la 1era fila-->  

<!--Inicio de la 2da fila-->

        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox28" id="formulario_check"/>    
                </div>
            </td>

            <td>
                <div align="left">
                    Microsporum gypseum
                </div>
            </td>
        </tr>
<!--Fin de la 2ra fila-->  

<!--Inicio de la 3era fila-->    
        <tr>
            <td>
                <div align="left">
                    <input type="checkbox" name="checkbox29" id="formulario_check"/>    
                </div>
            </td>

            <td height="20">
                <div align="left">
                    Microsporum nanum
                </div>
            </td>
        </tr>
<!--Fin de la 3era fila-->  

<!--Inicio de la 4ta fila-->

        <tr>
            <td height="20">      
                <div align="left">
                    <input type="checkbox" name="checkbox30" id="formulario_check"/>    
                </div>
            </td>
            <td>
                <div align="left">
                    Trichophyton rubrum
                </div>
            </td>
        </tr>
        <tr>
            <td height="20">
    <div align="left">
                    <input type="checkbox" name="checkbox31" id="formulario_check"/>
    </div>
            </td>
            <td>
                <div align="left">
                    Trichophyton mentagrophytes
                </div>
            </td>
        </tr>
        
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox32" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Trichophyton Tonsurans
                </div>
            </td>
        </tr>
        
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox33" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Trichophyton Verrucosum
                </div>
            </td>
        </tr>
        
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox34" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Trichophyton Violaceum
                </div>
            </td>
        </tr>
        
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox35" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Epidermophyton Floccosum
                </div>
            </td>
        </tr>
        
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox36" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Malassezia Furfur
                </div>
            </td>
        </tr>
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox37" id="formulario_check"/>
                </div>
            </td>
            <td>
    <div align="left">
Malassezia Pachydermatis
    </div>
            </td>
        </tr>
        <tr>
            <td height="20">
                <div align="left">
                    <input type="checkbox" name="checkbox38" id="formulario_check"/>
                </div>
            </td>
            
            <td>
                <div align="left">
                    Malassezia Spp
                </div>
            </td>
        </tr>
    </table>
                        </fieldset>                </td>
        </tr>
    </table>
    </div>       
</ul>
    </div>