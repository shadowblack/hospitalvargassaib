<?php

  
?>
<script type="text/javascript">
    jQuery(function(){
       jQuery("#reg_usu_adm").validate({ }); 
       
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
    .font_estandar{
        font-weight: bold;
    }
    
    
</style>
<div style="margin-top: 10%; width: 75%; margin-left: auto;margin-right: auto; text-align: center;">
    <div id="dialog" title="Basic dialog"></div>
    <form action="" id="reg_usu_adm" name="login" method="post">    
        <fieldset id="fieldMaq" ><legend class="font_estandar">Registrar Usuario Administrativo</legend>
        <!--<table width="240px" border="0" align="center">-->
            <tr>
                <td>
                     <label for="nom_usu_adm"  class="font_estandar"><?php echo __("Nombre");?>:</label>
    			     <input type="text" id="nom_usu_adm" name="nom_usu_adm" class="text required" minlength="3" maxlength="25" />
                </td>
                <td>    
                     <label for="ape_usu_adm" class="font_estandar"><?php echo __("Apellido");?>:</label>
    			     <input type="password" id="ape_usu_adm" name="ape_usu_adm" class="text required" minlength="3" maxlength="25" />
                </td>
            </tr>
            <tr>
                <td>
                     <label for="pas_usu_adm"  class="font_estandar"><?php echo __("Clave");?>:</label>
    			     <input type="password" id="pas_usu_adm" name="pas_usu_adm" class="password required" minlength="3" maxlength="50" />
                </td>
                <td>    
                     <label for="rep_pas_usu_adm" class="font_estandar"><?php echo __("Repetir Clave");?>:</label>
    			     <input type="text" id="rep_pas_usu_adm" name="rep_pas_usu_adm" class="password required" minlength="3" maxlength="50" />
                </td>
            </tr>
            <tr>
                <td>
                     <label for="log_usu_adm"  class="font_estandar"><?php echo __("Usuario");?>:</label>
    			     <input type="text" id="log_usu_adm" name="log_usu_adm" class="text required" minlength="3" maxlength="50" />
                </td>
                <td>    
                     <label for="tel_usu_adm" class="font_estandar"><?php echo __("Teléfono");?>:</label>
    			     <input type="text" id="tel_usu_adm" name="tel_usu_adm" class="numbers required" minlength="3" maxlength="11" />
                </td>
            </tr>
            <tr>
                <td>
                     <label for="cor_ele_adm"  class="font_estandar"><?php echo __("Correo");?>:</label>
    			     <input type="text" id="cor_ele_adm" name="cor_ele_adm" class="text required" minlength="3" maxlength="50"/>
                </td>
                <td>    
                     <label for="tip_usu" class="font_estandar"><?php echo __("Tipo Usuario");?>:</label>
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
                <td>
                    <input type="submit" value="<?php echo __("Aceptar");?>" name="btn_ace" id="btn_ace">
                </td>
                <td>
                    <input type="reset" value="<?php echo __("Cancelar");?>" name="btn_can" id="btn_can">
                </td>
            </tr>
        <!--</table>-->
        </fieldset>
    </form>
</div>