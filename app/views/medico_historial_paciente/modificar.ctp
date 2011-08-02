<script type="text/javascript">   
    /*Agregando Clase CSS para el fondo del login*/

    jQuery(function() {
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs(); 
        parent.jQuery("#title_content").html("<?php echo $title; ?>");
                       		
        jQuery("#historiales_pacientes").validate({                
            submitHandler: function(form) {
               <?php echo $this->Event->Update($this->Html->url("event_modificar"),"form","back"); ?>
            }
        }); 
        
        // cascade estados y municipios 
        
        jQuery("#sel_est_pac").change(function(){     
            jQuery("#indicator").css("display","block");
            jQuery("#sel_mun_pac").load("event_ubicacion/3/"+jQuery(this).val(),function(){jQuery("#indicator").css("display","none");});  
        });    
});
</script>
<style type="text/css">
label.error { width: 150px; text-align: left; }    
</style>
<?php
//$T_V_TYPE = 1;
//include_once ("../libs/_dialog.php");
echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>
<div id="tabs-1" style="display: none;">    		
<div id="tabs">
    <ul>
        <li>
            <a href="#tabs-1" style="width: 653px;">
                <?php echo __("Modificar", true) ?>
            </a>
        </li>            
    </ul>
    <fieldset class="standar_fieldset_content"> 
        <form name="historiales_pacientes" id="historiales_pacientes">
            <input type="hidden" name="hdd_id_his" value="<?php echo $id_his ?>">                                                                <div class="standar_fieldset_child">
            <table style="width:540px; margin-top: 20px;" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="184" class="font-standar" valign="top">
                        <?php echo __("Descripción de la historia", true) ?>
                    </td>                                                                             
                </tr>
                <tr>                               
                    <td valign="top">                                
                        <textarea name="txt_des_his" maxlength="255"  style="width: 571px;height: 50px;text-align: left;"><?php print
$result->HistorialesPaciente->des_his ?></textarea>
                    </td>                           
                </tr> 
                 <tr>
                    <td width="200" class="font-standar" valign="top">
                        <?php echo __("Descripción adicional del paciente", true) ?>
                    </td>                                                                                  
                </tr>  
                <tr>                                                      
                    <td valign="top">                                
                        <textarea name="txt_des_pac_his" maxlength="255" style="width: 571px;height: 200px;"><?php echo $result->HistorialesPaciente->
des_adi_pac_his ?></textarea>
                    </td>                           
                </tr>                                                                              
            </table>                      
            </div>
             <table style="width: 100%;left: 0;bottom: 20px;top: auto;" border="0" class="standar_position">
                <tr>
                    <td  align="right" style="height: 0" valign="bottom">
                        <input type="submit" name="btn_aceptar" value="Aceptar">
                    </td>
                    <td  align="left" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="window.location.href='<?php echo$this->History->Url($_SERVER['HTTP_REFERER'])?>'">
                    </td>
                </tr>
            </table>                      
        </form>
    </div>
</div>