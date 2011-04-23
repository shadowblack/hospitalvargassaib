<?php

?>
<!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
    jQuery(function(){ 
       parent.jQuery("#title_content").html("<?php echo $title;?>");        
       jQuery("#reg_usu_adm").validate({
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
                    url:"<?php echo $this->Html->url("/AdminUsuarioAdministrativo/event_modificar")?>",                    
                    type: "POST",
                    data: array_form,
                    dataType: "json",                                      
                    error:function(){alert("Error json")},
                    success: function(data){                                                                     
                        eval("data="+data);   
                        
                        jQuery("#dialog #dialog_messege").css("display","block");jQuery("#dialog img").css("display","none"); 
                                                                     
                        var _select = "#dialog #dialog_text";                      
                        jQuery(_select).empty();
                        jQuery(_select).text(data.coment);
                        
                        _select = "#dialog td > div > div";
                        jQuery(_select).attr("class","");
                        jQuery(_select).addClass(data.class_background);
                        
                        _select = "#dialog span";
                        jQuery(_select).attr("class","");
                        jQuery(_select).addClass(data.class_icon);
                        
                        jQuery("#dialog").dialog({
                            modal:true,
                            minHeight: 150,                            
                            buttons: [
                                {
                                    text: '<?php echo __("Aceptar",true)?>',
                                    click: function() { jQuery(this).dialog("close"); }
                                }
                            ],
                            resizable: false
                        }).css("display","block");                                                                                            
                    }                   
                });
                
                jQuery("#dialog #dialog_messege").css("display","none");jQuery("#dialog img").css("display","block");                
                jQuery("#dialog").dialog({                            
                    resizable: false
                }).css("display","block");    
            }
    	});         
        jQuery("#pas_usu_adm").valid();
              
       	   
              
    });
</script>
<style type="text/css">
    #fieldMaq {
       	background-color:#D5DFE5;
        padding: 30px;
        width: 310px;
        text-align: center;
    }
    td.tam_cel{
        width:50%;
    }            
</style>

<div id="dialog" title="<?php echo __("Mensaje",true)?>" style="text-align:center;display:none;overflow: hidden;">
    <table style="height: 70px;" align="center">
        <tr>
            <td valign="center" class="">    
                <img src="<?php echo $this->webroot."img/icon/loadinfo.net.gif"?>" style="margin-top: 15px;">                          
                <div id="dialog_messege" class="ui-widget">
        			<div class="" style="margin-top: 15px; padding: 0 .7em;">         				
                            <span class="" style="float: left; margin-right: .3em;"></span>
        				    <div id="dialog_text" class="" style="text-align: left;">&nbsp;</div>                        
        			</div>
        		</div>
            </td>
        </tr>
    </table>              
</div>
<div style="padding: 0;position: absolute; width: 700px;margin-top: 60px;">    
    <form action="" id="reg_usu_adm" name="login" method="post">  
        <input type="hidden" id="id_usu_adm" name="id_usu_adm" value="<?php echo $id?>">
        <table border="0" align="center" style="position: relative;">
            <tr>
                <td align="center">            
                        <table style='width:483px' border="0" align="center">
                            <tr>
                                <td class="tam_cel" valign="top">
                                     <label for="nom_usu_adm"  class="standar_font"><?php echo __("Nombre");?>:</label>
                    			     <input type="text" id="nom_usu_adm" name="nom_usu_adm" class="text required" minlength="3" maxlength="100"  value="<?php echo $result->nom_usu_adm?>"/>
                                </td>
                                <td class="tam_cel" valign="top">    
                                     <label for="ape_usu_adm" class="standar_font"><?php echo __("Apellido");?>:</label>
                    			     <input type="text" id="ape_usu_adm" name="ape_usu_adm" class="text required" minlength="3" maxlength="100" value="<?php echo $result->ape_usu_adm?>"/>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                     <label for="pas_usu_adm"  class="standar_font"><?php echo __("Clave");?>:</label>
                    			     <input type="password" id="pas_usu_adm" name="pas_usu_adm" class="password" minlength="3" maxlength="100" />
                                </td>
                                <td valign="top">
                                    <div class="password-meter " style="width: 210px;height: 3px;text-align: right;">
                                		<div class="password-meter-message" style="font-size: 9pt;" style="height: 3px;">&nbsp;</div>
                                		<div class="password-meter-bg" style="height: 3px;">
                                			<div class="password-meter-bar" style="height: 2px;"></div>
                                		</div>
                                	</div>
                                </td>                                
                            </tr>
                            <tr>
                                <td valign="top">    
                                     <label for="rep_pas_usu_adm" class="standar_font"><?php echo __("Repetir Clave");?>:</label>
                    			     <input type="password" id="rep_pas_usu_adm" name="rep_pas_usu_adm" class="required" minlength="3" maxlength="100" />
                                </td>                                
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                     <label for="log_usu_adm"  class="standar_font"><?php echo __("Usuario");?>:</label>
                    			     <input type="text" id="log_usu_adm" name="log_usu_adm" class="text required" minlength="3" maxlength="100" value="<?php echo $result->log_usu_adm?>"/>
                                </td>
                                <td valign="top">    
                                     <label for="tel_usu_adm" class="standar_font"><?php echo __("Teléfono");?>:</label>
                    			     <input type="text" id="tel_usu_adm" name="tel_usu_adm" class="number required" minlength="7" maxlength="20" value="<?php echo $result->tel_usu_adm?>"/>
                                </td>
                            </tr>                            
                            <tr>
                                <td height="20px;"></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <table>
                                        <tr>
                                            <td>
                                                <input type="submit" value="<?php echo __("Aceptar");?>" name="btn_ace" id="btn_ace">
                                            </td>
                                            <td>
                                                <input type="reset" value="<?php echo __("Cancelar");?>" name="btn_can" id="btn_can">
                                            </td>
                                        </tr>
                                    </table>                                                                    
                                </td>                                
                            </tr>
                        </table>                    
                </td>
            </tr>
        </table>
          
                
    </form>
</div>