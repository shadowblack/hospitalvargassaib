<script type="text/javascript">
    jQuery(function() {
        jQuery("#tabs").tabs({
            event: "mouseover"
        });
    });

    jQuery(function() {
        jQuery("#accordion").accordion({
            header: "h3"
        });
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
        jQuery('#dialog_link').click(function() {
            jQuery('#dialog').dialog('open');
            return false;
        });

        // Datepicker
        jQuery('#datepicker').datepicker({
            inline: true
        });

        // Fecha de nacimiento del paciente
        jQuery('#txt_fec_nac_pac').datepicker({
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
        function() {
            jQuery(this).addClass('ui-state-hover');
        },
        function() {
            jQuery(this).removeClass('ui-state-hover');
        });

        /*Agregando Clase CSS para el fondo del login*/

        jQuery(function() {
            jQuery("#link_aceptar").click(function() {
                jQuery("#login").submit();
            })
            jQuery("#login").validate({
                rules: {
                    pas_usu_adm: {
                        minlength: 5
                    },
                    rep_pas_usu_adm: {
                        required: true,
                        minlength: 5,
                        equalTo: "#pas_usu_adm"
                    }
                },
                submitHandler: function(form) {
                    //jQuery(form).ajaxSubmit();
                    var array_form = jQuery("form").serializeArray();
                    jQuery.ajax({
                        url: "<?php echo $this->Html->url(" / AdminUsuarioAdministrativo / event_registrar ")?>",
                        type: "POST",
                        data: array_form,
                        dataType: "json",
                        error: function() {
                            alert("Error json")
                        },
                        success: function(data) {
                            eval("data=" + data);

                            jQuery("#dialog #dialog_messege").css("display", "block");
                            jQuery("#dialog img").css("display", "none");

                            var _select = "#dialog #dialog_text";
                            jQuery(_select).empty();
                            jQuery(_select).text(data.coment);

                            _select = "#dialog td > div > div";
                            jQuery(_select).attr("class", "");
                            jQuery(_select).addClass(data.class_background);

                            _select = "#dialog span";
                            jQuery(_select).attr("class", "");
                            jQuery(_select).addClass(data.class_icon);

                            jQuery("#dialog").dialog("destroy");
                            jQuery("#dialog").dialog({
                                modal: true,
                                minHeight: 150,
                                buttons: [{
                                    text: '<?php echo __("Aceptar",true)?>',
                                    click: function() {
                                        jQuery(this).dialog("close");
                                    }
                                }],
                                resizable: false
                            }).css("display", "block");
                        }
                    });

                    jQuery("#dialog").dialog("destroy");
                    jQuery("#dialog #dialog_messege").css("display", "none");
                    jQuery("#dialog img").css("display", "block");
                    jQuery("#dialog").dialog({
                        resizable: false
                    }).css("display", "block");
                }
            });
        });
    });
</script>
<style type="text/css">
    label.error { width: 240px; text-align: left; }
</style>
<form name="login" id="login">
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1">
                    Nuevo Paciente
                </a>
            </li>
            <li>
                <a href="#tabs-2">
                    Evaluación Consulta
                </a>
            </li>
            <li>
                <a href="#tabs-3">
                    Evolución Tratamiento
                </a>
            </li>
            <li>
                <a href="#tabs-4">
                    Muestra Clinica
                </a>
            </li>
        </ul>
        <!--Inicio de la pestaña "tabs-1" -->
        <div id="tabs-1">
            <h2 class="texPrincipal">
                Agregar Datos Personales del Paciente
            </h2>
            <fieldset>
                <legend>
                    <strong>
                        Identificacion:
                    </strong>
                </legend>                
                    <table width="540" border="0" align="center" bgcolor="" cellpadding="0"
                    cellspacing="0">
                        <tr>
                            <td width="184">
                                <?php echo __( "Nombre",true)?>
                            </td>
                            <td width="9">
                                &nbsp;
                            </td>
                            <td width="189">
                                <?php echo __( "Apellido",true)?>
                            </td>
                            <td width="8">
                                &nbsp;
                            </td>
                            <td width="144">
                                Cedula de Identidad
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="tex_pac_nom" value="" class="required"/>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_ape" value="" class="required" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_ced" value="" class="required" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                
                                <?php echo __("Fecha de Nacimiento",true)?>
                                
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Edad
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Ocupacion
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="txt_fec_nac_pac" id="txt_fec_nac_pac" value="" class="date required" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_eda" value="" class="required" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <select id="sel_pac_ocu" name="sel_pac_ocu" value="" class="required"
                                />                                
                                <option>
                                    Profesional
                                </option>
                                <option>
                                    Tecnico
                                </option>
                                <option>
                                    Obrero
                                </option>
                                <option>
                                    Agricultor
                                </option>
                                <option>
                                    Jardinero
                                </option>
                                <option>
                                    Otro
                                </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Estado
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Municipio
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Parroquia
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select id="sel_pac_ciu" name="sel_pac_ciu" class="required">
                                    <option value="">--<?php echo __("Seleccione",true)?>--</option>
                                    <?php foreach($estados as $row){?>   
                                            <option value="<?php echo $row->id_est?>"><?php echo $row->des_est?></option>
                                    <?php    }?>
                                </select>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_mun" id="tex_pac_mun" value="" class="required"
                                />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_par" id="tex_pac_par" value="" class="required"
                                />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Referido Por:
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Nombre del Medico
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                Tipo de Consulta
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select id="sel_pac_ref" name="sel_pac_ref" class="required"/>
                                <option value="">--<?php echo __("Seleccione",true)?>--</option>
                                 <?php foreach($centro as $row){?>   
                                            <option value="<?php echo $row->id_cen_sal?>"><?php echo $row->nom_cen_sal?></option>
                                 <?php    }?>
                                </select>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <input type="text" name="tex_pac_nom6" value="" class="required"
                                />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <select id="sel_pac_con" name="sel_pac_con" class="required" />
                                <option>
                                    Consulta
                                </option>
                                <option>
                                    Dermatologia
                                </option>
                                <option>
                                    Pediatria
                                </option>
                                <option>
                                    Neumologia
                                </option>
                                <option>
                                    Consulta Interna
                                </option>
                                <option>
                                    Geriatria
                                </option>
                                <option>
                                    Urologia
                                </option>
                                <option>
                                    Infectologia
                                </option>
                                </select>
                            </td>
                        </tr>
                    </table>                
            </fieldset>
        </div>
        <!--Final de la pestaña "tabs-1" -->
        <!--Inicio de la pestaña "tabs-2" -->
        <div id="tabs-2">
            <h2 class="texPrincipal">
                Evaluación del Tipo de Consulta
            </h2>
            <fieldset>
                <legend>
                    <strong>
                        Contacto con:
                    </strong>
                </legend>
                
                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td style="width: 120px;text-align: center;"><?php echo __("Animal",true)?></td>
                            <td>&nbsp;</td>
                        </tr>
                        <?php foreach($animal as $row){?>   
                                <tr>
                                    <td>
                                        <?php echo __($row->nom_ani, true)?>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="animal" value="<?php echo $row->id_ani?>"/>
                                    </td>
                                </tr>
                        <?php    }?>   
                    </table>
                    <br/>
                    <table border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 120px;text-align: center;">
                                <div align="right">
                                    Especifique:
                                </div>
                            </td>
                            <td>
                                <textarea name="tex_eva_esp" id="tex_eva_esp" cols="35" rows="2" class="required"
                                />
                                </textarea>
                            </td>
                        </tr>
                    </table>
                
            </fieldset>
        </div>
        <!--Final de la pestaña "tabs-2" -->
        <!--Inicio de la pestaña "tabs-3" -->
        <div id="tabs-3">
            <h2 class="texPrincipal">
                Tiempo de Evoluci&oacute;n
            </h2>
            <fieldset>
                <legend>
                    <strong>
                        Tiempo:
                    </strong>
                </legend>
                <!--Formulario de fecha JQUERY-->
                <center>                    
                        <div class="demo">
                            <p>
                                Fecha:
                                <input type="text" id="datepicker" name="datepicker" class="date required"/>
                            </p>
                        </div>                    
                </center>
            </fieldset>
            <!--Fin del Formulario de fecha JQUERY-->
            <p>
                <fieldset>
                    <legend>
                        <strong>
                            Antecedentes personales o Factores predisponentes:
                        </strong>
                    </legend>
                    
                        <table width="443" border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td style="width: 120px;text-align: center;"><?php echo __("Antecedentes",true)?></td>
                            <td>&nbsp;</td>
                        </tr>
                        <?php foreach($antecedente as $row){?>   
                                <tr>
                                    <td>
                                        <?php echo __($row->nom_ant, true)?>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="ant" value="<?php echo $row->id_ant_per?>"/>
                                    </td>
                                </tr>
                        <?php    }?>
                        </table>
                        <br>
                        <table width="443" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr>
                                <td width="216" style="font-size: 12px;">
                                    <div align="right">
                                        Especifique:
                                    </div>
                                </td>
                                <td width="227">
                                    <label>
                                        <textarea name="tex_ant_esp" id="tex_ant_esp" cols="35" rows="2">
                                        </textarea>
                                    </label>
                                </td>
                            </tr>
                        </table>                    
                </fieldset>
                <p>
                    <fieldset>
                        <legend>
                            <strong>
                                Tratamiento previo:
                            </strong>
                        </legend>
                        
                            <table width="443" border="0" cellpadding="0" cellspacing="0" align="center">
                                <tr>
                            <td style="width: 120px;text-align: center;"><?php echo __("Tratamiento previo",true)?></td>
                            <td>&nbsp;</td>
                        </tr>
                        <?php foreach($tratamiento as $row){?>   
                                <tr>
                                    <td>
                                        <?php echo __($row->nom_tra, true)?>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="tra" value="<?php echo $row->id_tra?>"/>
                                    </td>
                                </tr>
                        <?php    }?>
                            </table>
                            <table width="443" border="0" cellpadding="0" cellspacing="0" align="center">
                                <tr>
                                    <td width="216" style="font-size: 12px;">
                                        <div align="right">
                                            Especifique:
                                        </div>
                                    </td>
                                    <td width="227">
                                        <label>
                                            <textarea name="tex_tra_esp" id="tex_tra_esp" cols="35" rows="2">
                                            </textarea>
                                        </label>
                                    </td>
                                </tr>
                            </table>                        
                    </fieldset>
        </div>
        <!--Final de la pestaña "tabs-3" -->
        <!--Inicio de la pestaña "tabs-4" -->
        <div id="tabs-4">
            <h2 class="texPrincipal">
                Muestra Clinica
            </h2>
            <fieldset>
                <legend>
                    <strong>
                        Muestra a Procesar:
                    </strong>
                </legend>
                
                    <table width="443" border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td style="width: 120px;text-align: center;"><?php echo __("Muestras",true)?></td>
                            <td>&nbsp;</td>
                        </tr>
                        <?php foreach($muestra as $row){?>   
                                <tr>
                                    <td>
                                        <?php echo __($row->nom_mue_cli, true)?>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="mues" value="<?php echo $row->id_mue_cli?>"/>
                                    </td>
                                </tr>
                        <?php    }?>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <div align="right">
                                        Especifique:
                                    </div>
                                </ul>
                            </td>
                            <td>
                                <ul>
                                    <textarea name="tex_tra_esp" id="tex_tra_esp" cols="35" rows="2">
                                    </textarea>
                                </ul>
                            </td>
                        </tr>
                    </table>                
            </fieldset>
        </div>
        <!--Final de la pestaña "tabs-4" -->
    </div>
    <table align="center">
        <tr>
            <td>
                <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
                    <a href="javascript:void(0)" id="link_aceptar" name="link_aceptar">
                        <br/>
                        <?php echo __( "Guardar",true)?>
                    </a>
                    </a>
                </div>
            </td>
        </tr>
    </table>
</form>