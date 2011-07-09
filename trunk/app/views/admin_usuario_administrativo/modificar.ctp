<?php

?>
<!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
    jQuery(function(){ 
       jQuery("#tabs-1").css("display","block");
       jQuery( "#tabs" ).tabs()
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
   	            <?php echo $this->Event->Update($this->Html->url("event_modificar"),"form",$this->Html->url("listar"))?>
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

<?php 
    $T_V_TYPE = 1;
    include_once("../libs/_dialog.php");  
?>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 653px;">
                    <?php echo __("Datos del usuario administrativo",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: 340px;">    
            <form action="" id="reg_usu_adm" name="login" method="post">  
                <input type="hidden" id="id_usu_adm" name="id_usu_adm" value="<?php echo $id?>">
                <table style="width:540px;margin-top: 20px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" style="height: 280px;" valign="top">            
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
                                </table>                    
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table>
                                <tr>
                                    <td>
                                        <input type="submit" value="<?php echo __("Aceptar");?>" name="btn_ace" id="btn_ace">
                                    </td>
                                    <td>
                                        <input type="reset" value="<?php echo __("Cancelar");?>" name="btn_can" id="btn_can">
                                    </td>
                                    <td>
                                        <input type="button" value="<?php echo __("Regresar");?>" name="btn_vol" id="btn_vol" onclick="javascript:history.back(-1)">
                                    </td>
                                </tr>
                            </table>                                                                    
                        </td>                                
                    </tr>
                </table>            
            </form>
        </fieldset>
    </div>
</div>