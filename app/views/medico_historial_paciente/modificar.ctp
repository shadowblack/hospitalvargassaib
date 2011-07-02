<script type="text/javascript">   
    /*Agregando Clase CSS para el fondo del login*/

    jQuery(function() {
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs(); 
        parent.jQuery("#title_content").html("<?php echo $title; ?>");
                       		
        jQuery("#historiales_pacientes").validate({                
            submitHandler: function(form) {
                //jQuery(form).ajaxSubmit();
                var array_form = jQuery("form").serializeArray();
                jQuery.ajax({
                    url: "<?php echo $this->Html->url("event_modificar") ?>",
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
                                text: '<?php echo __("Aceptar", true) ?>',
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
$T_V_TYPE = 1;
include_once ("../libs/_dialog.php");
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
    <fieldset style="height: 365px;"> 
        <form name="historiales_pacientes" id="historiales_pacientes">
            <input type="hidden" name="hdd_id_his" value="<?php echo $id_his ?>">                                                                    
            <table style="width:540px" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
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