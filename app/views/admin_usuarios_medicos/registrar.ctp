<?php

  
?>
<!-- Css validator-->
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-validate.password/jquery.validate.password.css"?>" />  
<?php echo $this->Html->script("jquery/jquery-validate.password/jquery.validate.password.js"); ?>  
<script type="text/javascript">
  
    jQuery(function(){ 
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs();
        /*Parametrizando los ids de las transacciones*/
        _arr_str = new Array();
        jQuery("[name^='mod_tra_chk_']:checked").each(function(i,obj){
            _arr_str.push(obj.value)
        });        
        _str = _arr_str.join(",");
        jQuery("#val_str_tra").val(_str);    
        
        parent.jQuery("#title_content").html("<?php echo $title;?>");        
       jQuery("#reg_usu_doc").validate({
    		rules: {    			
    			pas_doc: {    				
    				minlength: 5
    			},
    			rep_pas_usu_doc: {
    				required: true,
    				minlength: 5,
    				equalTo: "#pas_usu_doc"
    			}
    		},
            submitHandler: function(form) {                
   	            <?php echo $this->Event->Insert($this->Html->url("/AdminUsuariosMedicos/event_registrar"),"form",$this->Html->url("listar"))?>
            }
    	});   
        /*Validando la contraseña con la libreria Valid()*/      
        jQuery("#pas_usu_doc").valid();
               	
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
   // $T_V_TYPE = 1;
   // include_once("../libs/_dialog.php");  
   echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Datos del médico",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: auto;">   
            <form action="" id="reg_usu_doc" name="login" method="post" style="position: relative;">                          
                <input type="hidden" value="" name="val_str_tra" id="val_str_tra">
                <table border="0" align="center" style="margin-top: 20px;">
                    <tr>
                        <td align="center" style="height: 310px;" valign="top">            
                                <table style='width:483px' border="0" align="center">
                                    <tr>
                                        <td class="tam_cel" valign="top">
                                             <label for="nom_usu_doc"  class="standar_font"><?php echo __("Nombre");?>:</label>
                            			     <input type="text" id="nom_usu_doc" name="nom_usu_doc" class="text required" minlength="3" maxlength="100" />
                                        </td>
                                        <td class="tam_cel" valign="top">    
                                             <label for="ape_usu_doc" class="standar_font"><?php echo __("Apellido");?>:</label>
                            			     <input type="text" id="ape_usu_doc" name="ape_usu_doc" class="text required" minlength="3" maxlength="100" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <label for="ced_usu_doc"  class="standar_font"><?php echo __("Cédula");?>:</label>
                                            <input type="text" id="ced_usu_doc" name="ced_usu_doc" class="number required" minlength="3" maxlength="8" />
                                        </td>
                                        <td valign="top">
                                             <label for="log_usu_doc"  class="standar_font"><?php echo __("Usuario");?>:</label>
                            			     <input type="text" id="log_usu_doc" name="log_usu_doc" class="text required" minlength="3" maxlength="100" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                             <label for="pas_usu_doc"  class="standar_font"><?php echo __("Clave");?>:</label>
                            			     <input type="password" id="pas_usu_doc" name="pas_usu_doc" class="password" minlength="3" maxlength="100" />
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
                                             <label for="rep_pas_usu_doc" class="standar_font"><?php echo __("Repetir Clave");?>:</label>
                            			     <input type="password" id="rep_pas_usu_doc" name="rep_pas_usu_doc" class="required" minlength="3" maxlength="100" />
                                        </td>                                
                                        <td valign="top">    
                                             <label for="tel_usu_doc" class="standar_font"><?php echo __("Teléfono");?>:</label>
                            			     <input type="text" id="tel_usu_doc" name="tel_usu_doc" class="number required" minlength="7" maxlength="11" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                             <label for="cor_usu_doc"  class="standar_font"><?php echo __("Correo");?>:</label>
                            			     <input type="text" id="cor_usu_doc" name="cor_usu_doc" class="text required" minlength="10" maxlength="100" />
                                        </td>
                                        <td class="font-standar" valign="top">
                                            <?php echo __("Centro de Salud")?>:
                                            <select id="sel_cen_sal" name="sel_cen_sal" class="required" style="width: 109px;;">
                                                <option value="">--<?php echo __("Seleccione",true)?>--</option>
                                                <?php foreach($centros_salud as $row){?>   
                                                        <option value="<?php echo $row->id_cen_sal;?>" title="<?php echo $row->des_cen_sal;?>"><?php echo $row->des_cen_sal;?></option>
                                                <?php }?>
                                            </select>                             
                                        </td>
                                    </tr>   
                                    </tr>                               
                                                            
                                    <tr>
                                        <td height="20px;"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: ;">
                                            <div class="lista_standar" style="width: 100%;height: 170px;overflow-y: auto;">
                                                 <table style="width: 100%;" border="0">
                                                 <?php 
                                                    $id_mod = "";
                                                    foreach($result as $row){?>
                                                    <?php 
                                                        if ($id_mod <> $row->id_mod){
                                                            ?>
                                                            <tr>
                                                                <td align="right" style="width:10px">
                                                                    <input style="width:10px" type="checkbox" id="mod_chk_<?php echo $row->id_mod;?>" name="mod_chk_<?php echo $row->cod_mod;?>" value="<?php echo $row->id_mod;?>">
                                                                </td>
                                                                <td class="standar_font">
                                                                    <span>
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
                                                                                <input style="width:10px" type="checkbox" id="tra_chk_<?php echo $row->id_tip_tra;?>" name="mod_tra_chk_<?php echo $row->id_mod;?>" value="<?php echo $row->id_tip_tra;?>" id_mod="<?php echo $row->id_mod?>">
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
                </form>
            </fieldset>
        </div>
</div>    