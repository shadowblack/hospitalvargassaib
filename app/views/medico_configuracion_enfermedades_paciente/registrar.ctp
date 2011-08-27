<script type="text/javascript">              
        function change_enfermedad(id_tip_mic){
            // #tabs-1
            jQuery("#content")
                .html('<img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 94px;">')
                .addClass("standar_cargador");
            jQuery("#content").load("<?php echo $this->Html->url("event_enfermedades")?>/"+id_tip_mic,function(){
                <?php echo $this->Checkbox->Multiple("chk_enf_pac_","#pacientes")?>
            });
            
            jQuery("#tabs-2").load("<?php echo $this->Html->url("event_cat_mic")?>/"+id_tip_mic);
            
        } 
        
        function check_parte_cuerpo(obj){
           var id_par_cue_cat_cue = jQuery(obj).attr("id_par_cue_cat_cue");
           if(obj.checked){
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).load("<?php echo $this->Html->url("event_lesiones")?>/"+jQuery("[name='cmb_tipos_micosis']").val()+"/"+id_par_cue_cat_cue+"/",function(){
                    <?php echo $this->Checkbox->Multiple("les_","#pacientes",true)?>
                });
           } else {
                jQuery("#div_les_par_cue_"+id_par_cue_cat_cue).empty();
                les();
           }           
        } 
        
       
             
        jQuery(function() {
                        
           // jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();            
           
            jQuery("#pacientes").validate({                
                submitHandler: function(form) {
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
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>
<?php 
    //$T_V_TYPE = 1;
    //include_once("../libs/_dialog.php");  
    echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>

    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" >
                    <?php echo __("Micosis",true)?>
                </a>
            </li>
            <li>
                <a href="#tabs-2" >
                    <?php echo __("Descripción de la lesion",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
        <form name="pacientes" id="pacientes" > 
            <input type="hidden" name="hdd_id_his" value="<?php echo $id_his?>">
            <div id="tabs-1" style="height: 325px;" class="standar_fieldset_child">                                          
                <table style="width:540px;margin-top: 10px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="font-standar" valign="top">
                            <?php echo __( "Tipos de enfermedades",true)?>
                        </td>                        
                    </tr>
                    <tr>
                        <td valign="top">                            
                            <select name="cmb_tipos_micosis" style="width: 120px;">
                            <?php foreach($tipos_micosis as $row):?>
                                <option value="<?php echo $row->id_tip_mic?>"><?php echo $row->nom_tip_mic?></option>
                            <?php endforeach; ?>
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
             <div id="tabs-2" style="height: 325px;border: 1px solid black; overflow-y: auto;" class="standar_fieldset_child">                                          
                <!-- Contenido de las enfermedades -->
             </div>               
             <table style="width: 100%;" class="">
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
        </fieldset>
    </div>       