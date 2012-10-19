<style type="text/css">
    label.error { width: 200px; text-align: left; margin-left: 10px;}    
</style>
<script type="text/javascript">                      
        function change_enfermedad(id_tip_mic){
            // #tabs-1
            jQuery("#content")
                .html('<img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 94px;">')
                .addClass("standar_cargador");
            jQuery("#content").load("<?php echo $this->Html->url("event_enfermedades_registrar")?>/"+id_tip_mic,function(){
                <?php echo $this->Checkbox->Multiple("chk_enf_pac_","#pacientes")?>
                <?php echo $this->Otros->Script()?>
            });
            
            jQuery("#tabs-2").load("<?php echo $this->Html->url("event_cat_mic_registrar")?>/"+id_tip_mic,function(){
                
            });
            
            jQuery("#tabs-3").load("<?php echo $this->Html->url("event_estudios_micologicos_registrar")?>/"+id_tip_mic, function(){
                <?php echo $this->Checkbox->Multiple("chk_tip_est_mic_","#pacientes",true)?>
                <?php echo $this->Otros->Script()?>
                
                /*Permite marcar el campo de las observa*/  
                jQuery("input[name^='positivo__']").click(function(){                        
                    var _arr        = jQuery(this).attr("name").split("__");                                               
                    var _observacion= jQuery(this).val() == 1;
                    jQuery("#observaciones__"+_arr[1]).css("display",(_observacion ? "block":"none"));                      
                }); 
            }); 
            jQuery("#tabs-4").load("<?php echo $this->Html->url("event_forma_infeccion_registrar")?>/"+id_tip_mic, function(){
                <?php echo $this->Checkbox->Multiple("chk_for_inf_","#pacientes",true)?>
                <?php echo $this->Otros->Script()?>
            });           
        } 
        
        function check_parte_cuerpo(obj){            
           var id_par_cue_cat_cue = jQuery(obj).attr("id_par_cue_cat_cue");           
           if(obj.checked){                
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).load("<?php echo $this->Html->url("event_lesiones_registrar")?>/"+jQuery("[name='cmb_tipos_micosis']").val()+"/"+id_par_cue_cat_cue+"/",function(){                    
                    <?php echo $this->Checkbox->Multiple("les_","#pacientes",true)?>
                    <?php echo $this->Otros->Script()?>
                });
           } else {
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).empty();
                les();
           }           
        }                 
         
        function required_s(value, element, param){                
                return value != "-1";
        } 
             
        jQuery(function(){                        
                        
            jQuery("#tabs").css("display","block");
            jQuery( "#tabs" ).tabs();                                    
            
            jQuery.validator.addMethod("required_select",required_s,"<?php echo __("Seleccione una enfermedad",true)?>");
            
            jQuery("#pacientes").validate({
                rules:{
                    cmb_tipos_micosis:{
                        required_select:true
                    }
                },
                submitHandler: function(form) {
                    var _arr_ele    = [];
                    var _str        = "";
                    var _i = 0;
                    jQuery("input[name^='txt_otr_les__']").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ "~@@~" +jQuery(this).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    jQuery("#hdd_str_otr_les").val(_arr_ele.join("~@~"));
                    
                    // multiples otros para los tipos de estudios micologicos
                    _arr_ele    = [];
                    _str        = "";
                    _i = 0;
                     jQuery("input[name^='txt_tip_est_mic__']").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ "~@@~" +jQuery(this).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    /*Valor final de la cadena es id;descripcion,id;descripcion,id;descripcion*/                    
                    jQuery("#hdd_str_otr_est_mic").val(_arr_ele.join("~@~"));
                    
                      /* multiples positivos para los estudios micologicos*/
                    _arr_ele    = [];
                    _str        = "";
                    _i = 0;
                     jQuery("input[name^='positivo__']:checked").each(function(i,obj){
                        if (jQuery(this).val() != ""){
                            _str = jQuery(this).attr("name");                            
                            var _arr = _str.split("__");
                            _str = _arr[1]+ "~@@~" +jQuery(this).val() + "~@@~" + jQuery("#observaciones__"+_arr[1]).val();
                            _arr_ele[_i] = _str;                                                        
                            _i++;
                        }
                    });
                    jQuery("#hdd_str_pos").val(_arr_ele.join("~@~"));
                    
                    //return false;
                    <?php echo $this->Event->Insert($this->Html->url("event_registrar"),"form","back")?>                 
                }
            }); 
            
            var _name = "[name='cmb_tipos_micosis']";
            change_enfermedad(jQuery(_name).val());
            jQuery(_name).change(function(){
                var id_tip_mic = this.value;
                change_enfermedad(id_tip_mic);
            });                              
        });
</script>
<?php 
    //$T_V_TYPE = 1;
    //include_once("../libs/_dialog.php");  
    echo $this->element("dialog",Array("T_V_TYPE" => 1));
?> 		
    <div id="tabs" style="display: none;">
        <ul>
            <li>
                <a href="#tabs-1" >
                    <?php echo __("Micosis",true)?>
                </a>
            </li>
            <li>
                <a href="#tabs-2" >
                    <?php echo __("Descripción de la lesión",true)?>
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
            <input type="hidden" name="hdd_id_his" value="<?php echo $id_his?>">
            <input type="hidden" id="hdd_str_otr_les" name="hdd_str_otr_les" value="" >
            <input type="hidden" id="hdd_str_otr_est_mic" name="hdd_str_otr_est_mic" value="" >
            <input type="hidden" id="hdd_str_pos" name="hdd_str_pos" value="" > 
            <div id="tabs-1" style="height: 325px;" class="standar_fieldset_child">                                          
                <table style="width:540px;margin-top: 5px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="standar_font" valign="top">
                            <?php echo __( "Tipos de enfermedades",true)?>
                        </td>                        
                    </tr>
                    <tr>
                        <td valign="top">                            
                            <select name="cmb_tipos_micosis" style="width: 120px;" class=".required_select">                                
                            <?php foreach($tipos_micosis as $row):?>                                
                                <option value="<?php echo $row->id_tip_mic?>"><?php echo $row->nom_tip_mic?></option>
                            <?php endforeach; ?>
                                <option value="-1">--<?php echo __( "Seleccione",true);?>--</option>
                            </select>
                            <div style="line-height: 10px;">
                                &nbsp;
                            </div>
                        </td>                       
                    </tr>
                    <tr>
                        <td class="font-standar"valign="top">                                
                            <div id="content" style="height: 270px;width:100%; overflow-y:auto ;" class="">
                            &nbsp;
                                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 88px;display: none;" class="standar_cargador">
                            </div>       
                        </td>                       
                    </tr>                                                                           
                </table>
             </div> 
             <div id="tabs-2" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <!-- Contenido de las enfermedades -->
             </div>
             <div id="tabs-3" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <!-- Contenido de las enfermedades -->
             </div>
             <div id="tabs-4" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <!-- Contenido de las forma de infeccion -->
             </div>              
             <table style="width: 100%;" class="">
                <tr>
                    <td  align="right" style="height: 0" valign="bottom">
                        <input type="submit" name="btn_aceptar" value="<?php echo __("Aceptar",true)?>">
                    </td>
                    <td  align="left" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="<?php echo __("Volver",true)?>" onclick="javascript:window.location.href='<?php echo $_SERVER["HTTP_REFERER"]?>'">                       
                    </td>
                </tr>
            </table>                                                         
        </form>    
        </fieldset>
    </div>       