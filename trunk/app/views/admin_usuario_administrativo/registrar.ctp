<?php

  
?>
        <!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
    jQuery(function(){        
       jQuery("#reg_usu_adm").validate({ }); 
       //jQuery("#pas_usu_adm").valid();
       
       jQuery(function() {
		  //jQuery("#dialog").dialog();
	   });
              
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


<div id="dialog" title="Basic dialog" ></div>
<div style="padding: 0;position: absolute; width: 700px">
    
    <form action="" id="reg_usu_adm" name="login" method="post">  
        <table border="0" align="center" style="position: relative;">
            <tr>
                <td align="center">
                    <fieldset id="fieldMaq" style='width:583px'><legend class="standar_font">Registrar Usuario Administrativo</legend>
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
                                    <div class="password-meter">
                                		<div class="password-meter-message">&nbsp;</div>
                                		<div class="password-meter-bg">
                                			<div class="password-meter-bar"></div>
                                		</div>
                                	</div>
                                </td>
                                
                            </tr>
                            <tr>
                                <td >    
                                     <label for="rep_pas_usu_adm" class="standar_font"><?php echo __("Repetir Clave");?>:</label>
                    			     <input type="text" id="rep_pas_usu_adm" name="rep_pas_usu_adm" class="password required" minlength="3" maxlength="50" />
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
                                     <label for="tip_usu" class="standar_font"><?php echo __("Tipo Usuario");?>:</label>
                                     <select name="tip_usu" id="tip_usu">
                                        <option value="0"><?php echo __("Sin selección");?></option>
                                        <option value="1"><?php echo __("Administrador");?></option>
                                        <option value="2"><?php echo __("Doctor");?></option>
                                     </select>
                                    
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
                    </fieldset>
                </td>
            </tr>
        </table>
          
                
    </form>
</div>