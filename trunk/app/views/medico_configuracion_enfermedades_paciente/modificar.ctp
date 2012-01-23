<script type="text/javascript">              
        function change_enfermedad(id_tip_mic_pac){
            // #tabs-1
            jQuery("#content")
                .html('<img id="cargador" src="<?php echo $this->webroot ?>img/icon/load_list.gif" style="margin-top: 94px;">')
                .addClass("standar_cargador");
            jQuery("#content").load("<?php echo $this->Html->url("event_enfermedades_modificar") ?>/"+id_tip_mic_pac,function(){
                <?php echo $this->Checkbox->Multiple("chk_enf_pac_",
"#pacientes") ?>
                <?php echo $this->Otros->Script()?>
            });
            
            jQuery("#tabs-2").load("<?php echo $this->Html->url("event_cat_mic_modificar") ?>/"+id_tip_mic_pac,function(){                
                // checkeando las partes del cuerpo para que automaticamente salga la lista a modificar
                jQuery("#tabs-2 input[type='checkbox']").each(function(i,obj){
                    this.checked = true;
                    check_parte_cuerpo(obj);
                });                
            });
            
            jQuery("#tabs-3").load("<?php echo $this->Html->url("event_estudios_micologicos_modificar") ?>/"+id_tip_mic_pac,function(){                 
                    <?php echo $this->Checkbox->Multiple("chk_tip_est_mic_", "#pacientes") ?>;
                    <?php echo $this->Otros->Script()?>                             
            });    
            
            jQuery("#tabs-4").load("<?php echo $this->Html->url("event_forma_infeccion_modificar") ?>/"+id_tip_mic_pac,function(){                 
                    <?php echo $this->Checkbox->Multiple("chk_for_inf_", "#pacientes") ?>;  
                     <?php echo $this->Otros->Script()?>                           
            });        
            
        } 
        
        function check_parte_cuerpo(obj){
           var id_par_cue_cat_cue = jQuery(obj).attr("id_par_cue_cat_cue");
           if(obj.checked){
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).load("<?php echo
$this->Html->url("event_lesiones_modificar") ?>/"+jQuery("[name='hdd_tipos_micosis_pacientes']").val()+"/"+id_par_cue_cat_cue+"/",function(){
                    <?php echo $this->Checkbox->Multiple("les_", "#pacientes", true) ?>
                    <?php echo $this->Otros->Script()?> 
                });
           } else {
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).empty();
                
                // funcion que genera automaticamente al implementar la libreria $this->Checkbox->Multiple
                les();
           }           
        } 
             
        jQuery(function() {
                        
            jQuery("#tabs").css("display","block");
            jQuery( "#tabs" ).tabs();            
           
            jQuery("#pacientes").validate({                
                submitHandler: function(form) {
                    var _arr_ele    = [];
                    var _str        = "";
                    var _i = 0;
                    jQuery("input[name^='txt_otr_les__']").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ ";" +jQuery(this).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    jQuery("#hdd_str_otr_les").val(_arr_ele.join(","));
                    
                    /* multiples otros para los tipos de estudios micologicos*/
                    _arr_ele    = [];
                    _str        = "";
                    _i = 0;
                     jQuery("input[name^='txt_tip_est_mic__']").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ ";" +jQuery(this).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    jQuery("#hdd_str_otr_est_mic").val(_arr_ele.join(","));
                    
                     /* multiples positivos para los estudios micologicos*/
                    _arr_ele    = [];
                    _str        = "";
                    _i = 0;
                     jQuery("input[name^='positivo__']:checked").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ ";" +jQuery(this).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    jQuery("#hdd_str_pos").val(_arr_ele.join(","));
                    
                    <?php echo $this->Event->Update($this->Html->url("event_modificar"),
"form", "back") ?>                   
                }
            }); 
            
            var _name = "[name='hdd_tipos_micosis_pacientes']";
            change_enfermedad(jQuery(_name).val());                                
        });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>
<?php
echo $this->element("dialog", array("T_V_TYPE" => 1));
?>

    		
    <div id="tabs" style="display: none;">
        <ul>
            <li>
                <a href="#tabs-1" >
                    <?php echo __("Micosis", true) ?>
                </a>
            </li>
            <li>
                <a href="#tabs-2" >
                    <?php echo __("Descripción de la lesión", true) ?>
                </a>
            </li>
            <li>
                <a href="#tabs-3" >
                    <?php echo __("Estudios Micológicos",true)?>
                </a>
            </li>
             <li>
                <a href="#tabs-4" >
                    <?php echo __("Forma de Infección",true)?>
                </a>
            </li>                
        </ul>
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
        <form name="pacientes" id="pacientes" > 
            <input type="hidden" id="hdd_str_otr_les" name="hdd_str_otr_les" value="" >
            <input type="hidden" id="hdd_str_otr_est_mic" name="hdd_str_otr_est_mic" value="" >
            <input type="hidden" id="hdd_str_pos" name="hdd_str_pos" value="" >            
            <div id="tabs-1" style="height: 325px;" class="standar_fieldset_child">                                          
                <table style="width:540px;margin-top: 5px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="standar_font" valign="top">
                            <?php echo __("Tipos de enfermedades", true) ?>
                        </td>                        
                    </tr>
                    <tr>
                        <td valign="top">        
                            <span class="standar_font_sub"><?php echo $tipos_micosis->
nom_tip_mic ?></span>
                            <input type="hidden" name="hdd_tipos_micosis_pacientes" value="<?php echo
$tipos_micosis->id_tip_mic_pac ?>">                           
                            <div style="line-height: 10px;">
                                &nbsp;
                            </div>
                        </td>                       
                    </tr>
                    <tr>
                        <td class="font-standar"valign="top">                                
                            <div id="content" style="height: 270px;width:100%; overflow-y:auto ;" class="">
                            &nbsp;
                                <img id="cargador" src="<?php echo $this->
webroot ?>img/icon/load_list.gif" style="margin-top: 88px;display: none;" class="standar_cargador">
                            </div>       
                        </td>                       
                    </tr>                                                                           
                </table>
             </div> 
             <div id="tabs-2" style="height: 325px;overflow-y: auto;" class="standar_fieldset_child">            
                <!-- Contenido de las enfermedades -->
             </div>               
             <div id="tabs-3" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <!-- Contenido de las enfermedades -->
             </div> 
             <div id="tabs-4" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <!-- Forma de infeccion-->
             </div>              
             <table style="width: 100%;" class="">
                <tr>
                    <td  align="right" style="height: 0" valign="bottom">
                        <input type="submit" name="btn_aceptar" value="Aceptar">
                    </td>
                    <td  align="left" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="javascript:window.location.href='<?php echo
$_SERVER["HTTP_REFERER"] ?>'" >                       
                    </td>
                </tr>
            </table>                                                         
        </form>    
        </fieldset>
    </div>       