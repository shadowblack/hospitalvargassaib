<?php

?>
<!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
    jQuery(function(){ 
       jQuery("#tabs-1").css("display","block");
       jQuery( "#tabs" ).tabs();
       
       /*Checkeando el padre de los checkbox cuando se detecta que esta lleno por defecto*/
        jQuery("[id^=mod_chk_]").each(function(i,obj){
            var nom_id = jQuery(this).attr("id"),
            arr_str = new Array();
            arr_str = nom_id.split("mod_chk_");            
            var _checked = ((jQuery("[name='mod_tra_chk_"+arr_str[1]+"']:checked").length) == (jQuery("[name='mod_tra_chk_"+arr_str[1]+"']").length));            
            jQuery(this).attr("checked",_checked); 
        });
        
        /*Parametrizando los ids de las transacciones*/
        _arr_str = new Array();
        jQuery("[name^='mod_tra_chk_']:checked").each(function(i,obj){
            _arr_str.push(obj.value)
        });        
        _str = _arr_str.join(",");
        jQuery("#val_str_tra").val(_str);  
       
       parent.jQuery("#title_content").html("<?php echo $title;?>");
       
       jQuery("#reg_usu_adm").validate({
    		
            submitHandler: function(form) { 
                
                <?php echo $this->Event->Update($this->Html->url("/AdminUsuarioAdministrativo/event_modificar"),"form",$this->Html->url("listar"))?>                   	                           
            }
    	});
                
       /*Seleccionando todas las transacciones hijos al seleccionar el módulo padre*/          
        jQuery("[id^='mod_chk_']").click(function(){
            var _mod = jQuery(this).attr("value"); 
            _select = "[name^='mod_tra_chk_"+_mod+"']";         
            jQuery(_select).attr("checked",this.checked); 
            
            /*Parametrizando los ids de las transacciones*/
            _arr_str = new Array();
            jQuery("[name^='mod_tra_chk_']:checked").each(function(i,obj){
                _arr_str.push(obj.value)
            });        
            _str = _arr_str.join(",");
            jQuery("#val_str_tra").val(_str);                          
        });
            
        /*Selecionando check del modulo cuando se seleccionan todos las transacciones hijos*/
        jQuery("[name^=mod_tra_chk_]").click(function(){
            var _mod = jQuery(this).attr("id_mod"); 
            _select = "[name^='mod_tra_chk_"+_mod+"']";
            var _checked =(jQuery(_select).length == jQuery(_select+":checked").length);           
            jQuery("[id^='mod_chk_"+_mod+"']").attr("checked",_checked);      
            
            /*Parametrizando los ids de las transacciones*/
            _arr_str = new Array();
            jQuery("[name^='mod_tra_chk_']:checked").each(function(i,obj){
                _arr_str.push(obj.value)
            });        
            _str = _arr_str.join(",");
            jQuery("#val_str_tra").val(_str);
                
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

<?php 
    //$T_V_TYPE = 1;
    //include_once("../libs/_dialog.php");  
    
    echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Datos del administrador",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: auto;">       
            <form action="" id="reg_usu_adm" name="login" method="post">  
                <input type="hidden" id="id_usu_adm"  name="id_usu_adm"  value="<?php echo $id?>">
                <input type="hidden" id="val_str_tra" name="val_str_tra" value="" >
                <table style="width:540px;margin-top: 20px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" style="height: 280px;" valign="top">            
                            <table style='width:483px' border="0" align="center">
                                <tr>
                                    <td class="tam_cel" valign="top">
                                         <label for="nom_usu_adm"  class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Nombre");?>:</label>
                        			     <input type="text" id="nom_usu_adm" name="nom_usu_adm" class="text required" minlength="3" maxlength="100"  value="<?php echo $result->nom_usu_adm?>"/>
                                    </td>
                                    <td class="tam_cel" valign="top">    
                                         <label for="ape_usu_adm" class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Apellido");?>:</label>
                        			     <input type="text" id="ape_usu_adm" name="ape_usu_adm" class="text required" minlength="3" maxlength="100" value="<?php echo $result->ape_usu_adm?>"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <label for="ced_usu_adm"  class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Cédula");?>:</label>
                                        <input type="text" id="ced_usu_adm" name="ced_usu_adm" class="number required" minlength="6" maxlength="8" value="<?php echo $result->ced_usu_adm?>"/>
                                    </td>
                                    <td valign="top">
                                         <label for="log_usu_adm"  class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Usuario");?>:</label>
                        			     <input type="text" id="log_usu_adm" name="log_usu_adm" readonly="readonly" class="text required" minlength="3" maxlength="100" value="<?php echo $result->log_usu_adm?>"/>
                                    </td>
                                </tr>
                                <tr>                               
                                    <td valign="top">    
                                         <label for="tel_usu_adm" class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Teléfono");?>:</label>
                        			     <input type="text" id="tel_usu_adm" name="tel_usu_adm" class="number required" minlength="7" maxlength="20" value="<?php echo $result->tel_usu_adm?>"/>
                                    </td>
                                    <td valign="top">
                                         <label for="cor_usu_adm" class="standar_font"><span class="standar_asterisco">* </span><?php echo __("Correo");?>:</label>
                        			     <input type="text" id="cor_usu_adm" name="cor_usu_adm" class="email required" minlength="10" maxlength="100" value="<?php echo $result->cor_usu_adm?>"/>
                                    </td>
                                </tr>
                                <tr>
									<td colspan="4" align="left" class="font-standar" style="font-size:10px">
										<span class="standar_asterisco">* </span><?php print __('Nota', true).':'.__('Los campos con asteriscos son obligatorios', true); ?>
									</td>
								</tr>
                                <tr>
                                    <td height="10px;"></td>
                                </tr> 
                                <tr>
                                    <td colspan="4" style="height: ;">
                                        <div class="lista_standar" style="width: 100%;height: 170px;overflow-y: auto;">
                                             <table style="width: 100%;" border="0">
                                             <?php 
                                                $id_mod = "";
                                                foreach($result_tran as $row){?>
                                                <?php 
                                                    if ($id_mod <> $row->id_mod){
                                                        ?>
                                                        <tr>
                                                            <td align="right" style="width:10px">
                                                                <input style="width:10px" type="checkbox" id="mod_chk_<?php echo $row->id_mod;?>" name="mod_chk_<?php echo $row->cod_mod;?>" value="<?php echo $row->id_mod;?>">
                                                            </td>
                                                            <td class="standar_font">
                                                                <span style="font-weight: bold;">
                                                                    <?php echo $row->des_mod?>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <?php 
                                                        $id_mod = $row->id_mod;
                                                    }  
                                                    ?>
                                                        <tr>
                                                            <td class="standar_font" colspan="2">
                                                                <table style="width: 100%;" class="" border="0">
                                                                    <tr>
                                                                        <td align="right" style="width:40px">
                                                                            <input style="width:10px" type="checkbox" id="tra_chk_<?php echo $row->id_tip_tra;?>" name="mod_tra_chk_<?php echo $row->id_mod;?>" value="<?php echo $row->id_tip_tra;?>" id_mod="<?php echo $row->id_mod?>" <?php echo ($row->id_tip_usu_usu <> ""  ? "checked='checked'" : "")?> >
                                                                        </td>
                                                                        <td>
                                                                            <span>
                                                                                <?php echo $row->des_tip_tra?>
                                                                            </span>    
                                                                        </td>                                                                    
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    <?php
                                                } ?>
                                            </table>
                                        </div>                                                                    
                                    </td>
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