<script type="text/javascript">   
          
        jQuery(function() {
            jQuery("body").addClass("standar_background_color");
            <?php echo $this->Checkbox->Multiple("chk_mue_cli_","#muestras") ?>           
                                   
            jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();                                                   		

            jQuery("#muestras").validate({                
                submitHandler: function(form) {
                    <?php echo $this->Event->Update($this->Html->url("event_registrar"),"form",false)?>                   
                }
            });
            
            <?php echo $this->Otros->Script()?> 
                        
        });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>

<?php   
    echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>
        
<form name="muestras" id="muestras" >
   <input type="hidden" name="hdd_id_his" value="<?php echo $id_his?>">
    <div class="standar_window_fieldset_child lista_standar" style="overflow-y: auto;margin-top: 5px;">                   
        <table style="width:98%; border" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>                
                <td width="144" class="standar_font lista_fondo" valign="top">
                    <?php __("Muestra Clínica a procesar ");?>                                
                </td>                                                                                        
            </tr>
            <tr>
                <td valign="top" >
                    <div class="standar_margin ">
                        <ol class="standar_list">
                            <?php foreach($muestras_clinicas as $row): ?>
                                <li>
                                    <input name="chk_mue_cli_<?php echo $row->mc_id_mue_cli?>" class="standar_input_checkbox" type="checkbox" value="<?php echo $row->mc_id_mue_cli?>" <?php echo (!empty($row->mp_id_mue_cli) ? "checked='checked'" : ""); echo $this->Otros->Attr($row->mc_id_mue_cli,$row->nom_mue_cli,"txt_otr_mue_cli");?>><?php echo $row->nom_mue_cli?>
                                    <div style="width: 160px;"><?php echo $this->Otros->Text(20, $row->otr_mue_cli);?></div>
                                </li>
                            <?php endforeach ?>
                        </ol>
                    </div>
                </td>                
            </tr>                                                                           
        </table>
     </div> 
     <table style="width: 100%;" border="0" class="">
        <tr>
            <td  align="right" style="height: 0" valign="bottom">
                <input type="submit" name="btn_aceptar" value="<?php echo __("Aceptar",true)?>">
            </td>
            <td  align="left" style="height: 0" valign="bottom">
                <input type="button" value="<?php echo __("Volver",true)?>" onclick="parent.window.location.href=parent.page">
            </td>           
        </tr>
    </table>                                                                           
</form>    
