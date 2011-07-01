<script type="text/javascript">   
        /*Agregando Clase CSS para el fondo del login*/

        jQuery(function() {
            jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();     
            parent.jQuery("#title_content").html("<?php echo $title;?>");
            
           
    		jQuery( "#txt_fec_nac_pac" ).datepicker({
                dateFormat: "dd/mm/yy",
    			showOn: "button",
    			buttonImage: "<?php echo $this->webroot?>/img/icon/calendar.png",
    			buttonImageOnly: true,
                inline:true
    		});

            jQuery("#pacientes").validate({
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
                        url: "<?php echo $this->Html->url("/MedicoConfiguracionPaciente/event_modificar")?>",
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
            
            // cascade estados y municipios 
            municipios();
            jQuery("#sel_est_pac").change(function(){     
               municipios();
            });    
    });
    function municipios(){
            jQuery("#indicator").css("display","block");
            jQuery("#sel_mun_pac").load("<?php echo $this->Html->url("/MedicoConfiguracionPaciente/event_ubicacion")?>/3/"+jQuery("#sel_est_pac").val()+"/<?php echo $result->id_mun?>",function(){jQuery("#indicator").css("display","none");});  
    }
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>
<?php 
    $T_V_TYPE = 1;
    include_once("../libs/_dialog.php");  
?>

<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 653px;">
                    <?php echo __("Agregar Paciente",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: 365px;"> 	
        <form name="pacientes" id="pacientes">
            <input type="hidden" name="hdd_id_pac" id="hdd_id_pac" value="<?php echo $result->id_pac?>">                         
            <table style="width:540px;margin-top: 20px;" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="184" class="font-standar" valign="top">
                        <?php echo __( "Nombre",true)?>
                    </td>
                    <td width="9" class="font-standar">
                        &nbsp;
                    </td>
                    <td width="189" class="font-standar" valign="top">
                        <?php echo __( "Apellido",true)?>
                    </td>
                    <td width="8" class="font-standar" valign="top">
                        &nbsp;
                    </td>
                    <td width="144" class="font-standar" valign="top">
                        <?php __("Cédula de identidad");?>                                
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <input type="text" name="txt_nom_pac" value="<?php echo $result->nom_pac?>" class="required" maxlength="100" >
                    </td>
                    <td>
                        &nbsp;
                    </td >
                    <td valign="top">
                        <input type="text" name="txt_ape_pac" value="<?php echo $result->ape_pac?>" class="required" maxlength="20">
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top">
                        <input type="text" name="txt_ced_pac" value="<?php echo $result->ced_pac?>" class="required" maxlength="20">
                    </td>
                </tr>
                <tr>
                    <td class="font-standar"valign="top">                                
                        <?php echo __("Fecha de Nacimiento",true)?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                     <td class="font-standar" valign="top">                                
                        <?php echo __("Nacionalidad")?>
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                    <td class="font-standar" valign="top">
                        <?php echo __("Ocupación")?>                                
                    </td>
                </tr>                       
                <tr>
                    <td valign="top">                                
                        <input name="txt_fec_nac_pac" id="txt_fec_nac_pac" value="<?php echo $this->DateFormat->postgres_to_date($result->fec_nac_pac)?>" class="date required" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top" >
                        <select class="required" name="sel_nac_pac">
                            <option value="">--<?php __("Seleccione")?>--</option>                                    
                            <option value="1" <?php echo ($result->nac_pac == 1 ? "selected='selected'":"")?>><?php __("Venezolano")?></option>
                            <option value="2" <?php echo ($result->nac_pac == 2 ? "selected='selected'":"")?>><?php __("Extrangero")?></option>
                        </select>
                    </td>
                    <td >
                        &nbsp;
                    </td>
                    <td valign="top">
                        <select id="sel_ocu_pac" name="sel_ocu_pac" value="" class="required"
                        >    
                        <option value="">--<?php __("Seleccione")?>--</option>                            
                        <option value="1" <?php echo ($result->ocu_pac == 1 ? "selected='selected'":"")?>>
                            <?php  __("Profesional")?>
                            
                        </option>
                        <option value="2" <?php echo ($result->ocu_pac == 2 ? "selected='selected'":"")?>>
                            <?php  __("Técnico")?>
                            
                        </option>
                        <option value="3" <?php echo ($result->ocu_pac == 3 ? "selected='selected'":"")?>>
                            <?php  __("Obrero")?>
                            
                        </option>
                        <option value="4" <?php echo ($result->ocu_pac == 4 ? "selected='selected'":"")?>>
                            <?php  __("Agricultor")?>
                            
                        </option>
                        <option value="5" <?php echo ($result->ocu_pac == 5 ? "selected='selected'":"")?>>
                            <?php  __("Jardinero")?>
                            
                        </option>
                        <option value="6" <?php echo ($result->ocu_pac == 6 ? "selected='selected'":"")?>>
                            <?php  __("Otro")?>                                    
                        </option>
                        </select>
                    </td>
                </tr>
                 <tr>
                    <td class="font-standar" valign="top" >                                
                        <?php echo __("Teléfono",true)?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                     <td class="font-standar" valign="top">                                
                        <?php echo __("Celular")?>
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                    <td class="font-standar" valign="top">
                        <?php echo __("Ciudad de Residencia")?>                                
                    </td>
                </tr>
                 <tr>
                    <td class="font-standar" valign="top">                                
                        <input type="text" name="txt_tel_pac" id="txt_tel_pac" value="<?php echo $result->tel_hab_pac?>" class="number required" maxlength="12">                               
                    </td>
                    <td>
                        &nbsp;
                    </td>
                     <td class="font-standar" valign="top">                                
                        <input type="text" name="txt_cel_pac" id="txt_cel_pac" value="<?php echo $result->tel_cel_pac?>" class="number required" maxlength="12">                          
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                    <td class="font-standar" valign="top">
                        <input type="text" name="txt_ciu_res_pac" id="txt_res_pac" value="<?php echo $result->ciu_pac?>" class="text required" maxlength="100">                                                         
                    </td>
                </tr>
                <tr>
                    <td  class="font-standar" valign="top">
                        <?php echo __("Estado")?>
                        
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td  class="font-standar" valign="top">
                        <?php echo __("Municipio")?>
                        
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td  class="font-standar" valign="top">
                        &nbsp;
                        <!--<?php echo __("Parroquia")?>-->
                        
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <select id="sel_est_pac" name="sel_est_pac" class="required">
                            <option value="">--<?php echo __("Seleccione",true)?>--</option>
                            <?php foreach($estados as $row){?>   
                                    <option value="<?php echo $row->id_est?>" <?php echo ($result->id_est == $row->id_est ? "selected='selected'":"")?>><?php echo $row->des_est?></option>
                            <?php    }?>
                        </select>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top">    
                        <table>
                            <tr>
                                <td>
                                    <select name="sel_mun_pac" id="sel_mun_pac" style="width: 120px;" class="required">
                                        <option value="">--<?php __("Seleccione")?>--</option>
                                    </select>
                                </td>
                                <td style="width: 50px;" valign="top">
                                    <img id="indicator" style="display: none;" src="<?php echo $this->webroot?>/img/icon/indicator.gif">
                                </td>
                            </tr>
                        </table>
                        
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                        <!--<input type="text" name="tex_pac_par" id="tex_pac_par" value="" class="required"
                        />-->
                    </td>
                </tr>                                        
            </table>                      
            <table style="width: 100%;left: 0;bottom: 20px;top: auto;" border="0" class="standar_position">
                <tr>
                    <td  align="right" style="height: 0" valign="bottom">
                        <input type="submit" name="btn_aceptar" value="Aceptar">
                    </td>
                    <td  align="left" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="history.back()">
                    </td>
                </tr>
            </table>                                                  
        </form>
    </div>
</div>