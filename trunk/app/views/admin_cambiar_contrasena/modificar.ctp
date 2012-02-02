<?php

?>
<!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  


<script type="text/javascript">
    jQuery(function(){ 
        
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs();
                    
        parent.jQuery("#title_content").html("<?php echo $title;?>");        
        jQuery("#mod_pas_usu").validate({
            rules: { 
                pas_old_usu: {    				
    				minlength: 5
    			},
    			pas_new_usu: {    				
    				minlength: 5
    			},
    			rep_pas_new: {
    				required: true,
    				minlength: 5,
    				equalTo: "#pas_new_usu"
    			}
            },
            submitHandler: function(form) { 
                <?php echo $this->Event->Update($this->Html->url("/AdminCambiarContrasena/event_modificar"),"form",$this->Html->url("listar"))?>                   	                           
            }
        });         
        jQuery("#pas_new_usu").valid();
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
    //$T_V_TYPE = 1;
   // include_once("../libs/_dialog.php");
   echo $this->element("dialog",Array("T_V_TYPE" => 1));  
?>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Cambio de Contraseña",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: auto;">    
            <form action="" id="mod_pas_usu" name="mod_pas_usu" method="post">  
                <table border="0" align="center" style="position: relative;height: 350px;">
                    <tr>
                        <td align="center">            
                            <table style='width:483px' border="0" align="center">
                                <tr>
                                    <td valign="top">
                                         <label for="pas_old_usu"  class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Clave anterior");?>:</label>
                                         <input type="password" id="pas_old_usu" name="pas_old_usu" class="required" minlength="3" maxlength="100" />
                                    </td>
                                </tr>  
                                <tr>
                                    <td valign="top">
                                         <label for="pas_new_usu"  class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Clave");?>:</label>
                        			     <input type="password" id="pas_new_usu" name="pas_new_usu" class="required password" minlength="3" maxlength="100"/>
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
                                         <label for="rep_pas_new" class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Repetir Clave");?>:</label>
                        			     <input type="password" id="rep_pas_new" name="rep_pas_new" class="required" minlength="3" maxlength="100" />
                                    </td> 
                                </tr>           
                                <tr>
                                    <td height="10px;"></td>
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
        </fieldset>
    </div>
</div>