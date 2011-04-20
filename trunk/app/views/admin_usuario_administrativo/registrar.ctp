<?php

  
?>
        <!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
    jQuery(function(){        
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
    		}
    	}); 
        
        jQuery("#pas_usu_adm").valid();
              
        jQuery("#dialog").dialog({
            modal:true,
            minHeight: 150
        }).css("display","block");	   
              
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
    body{
        font-size: 9pt;
    }
</style>

<div id="dialog" title="Basic dialog" style="text-align:center;display:none;">
    <table style="height: 80px;" align="center">
        <tr>
            <td valign="center" class="standar_font">
               <?php echo __("El Usuario se a insertado con exito",true)?> 
            </td>
        </tr>
    </table>              
</div>
<div style="padding: 0;position: absolute; width: 700px;margin-top: 60px;">    
    <form action="" id="reg_usu_adm" name="login" method="post">  
        <table border="0" align="center" style="position: relative;">
            <tr>
                <td align="center">            
                        <table style='width:483px' border="0" align="center">
                            <tr>
                                <td class="tam_cel">
                                     <label for="nom_usu_adm"  class="standar_font"><?php echo __("Nombre");?>:</label>
                    			     <input type="text" id="nom_usu_adm" name="nom_usu_adm" class="text required" minlength="3" maxlength="25" />
                                </td>
                                <td class="tam_cel">    
                                     <label for="ape_usu_adm" class="standar_font"><?php echo __("Apellido");?>:</label>
                    			     <input type="text" id="ape_usu_adm" name="ape_usu_adm" class="text required" minlength="3" maxlength="25" />
                                </td>
                            </tr>
                            <tr>
                                <td >
                                     <label for="pas_usu_adm"  class="standar_font"><?php echo __("Clave");?>:</label>
                    			     <input type="password" id="pas_usu_adm" name="pas_usu_adm" class="password" minlength="3" maxlength="50" />
                                </td>
                                <td>
                                    <div class="password-meter " style="width: 210px;height: 3px;text-align: right;">
                                		<div class="password-meter-message" style="font-size: 9pt;" style="height: 3px;">&nbsp;</div>
                                		<div class="password-meter-bg" style="height: 3px;">
                                			<div class="password-meter-bar" style="height: 2px;"></div>
                                		</div>
                                	</div>
                                </td>                                
                            </tr>
                            <tr>
                                <td >    
                                     <label for="rep_pas_usu_adm" class="standar_font"><?php echo __("Repetir Clave");?>:</label>
                    			     <input type="password" id="rep_pas_usu_adm" name="rep_pas_usu_adm" class="required" minlength="3" maxlength="50" />
                                </td>                                
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                     <label for="log_usu_adm"  class="standar_font"><?php echo __("Usuario");?>:</label>
                    			     <input type="text" id="log_usu_adm" name="log_usu_adm" class="text required" minlength="3" maxlength="50" />
                                </td>
                                <td>    
                                     <label for="tel_usu_adm" class="standar_font"><?php echo __("Teléfono");?>:</label>
                    			     <input type="text" id="tel_usu_adm" name="tel_usu_adm" class="numbers required" minlength="3" maxlength="11" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                     <label for="cor_ele_adm"  class="standar_font"><?php echo __("Correo");?>:</label>
                    			     <input type="text" id="cor_ele_adm" name="cor_ele_adm" class="text required" minlength="3" maxlength="50"/>
                                </td>
                                <td>    
                                    &nbsp;                                    
                                </td>
                            </tr>
                            <tr>
                                <td height="20px;"></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
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