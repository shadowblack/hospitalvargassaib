<script type="text/javascript">   
          
        jQuery(function() {
            jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();                                               
    		jQuery( "#txt_fec_nac_pac" ).datepicker({
                dateFormat: "dd/mm/yy",
    			showOn: "button",
    			buttonImage: "<?php echo $this->webroot?>/img/icon/calendar.png",
    			buttonImageOnly: true,
                inline:true
    		});

            jQuery("#pacientes").validate({                
                submitHandler: function(form) {
                    <?php echo $this->Event->Insert("event_registrar","form","back")?>                   
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
    include_once("../libs/_dialog.php");  
?>
asdf
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 653px;">
                    <?php echo __("Agregar Paciente",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
        <form name="pacientes" id="pacientes" > 
            <div style="" class="standar_fieldset_child">                                          
                <table style="width:540px;margin-top: 20px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="font-standar" valign="top">
                            <?php echo __( "Nombre",true)?>
                        </td>
                        <td width="9" class="font-standar">
                            &nbsp;
                        </td>
                        <td width="189" class="font-standar" valign="top">
                            <?php echo __( "Apellido",true)?>
                        </td>
                        <td width="8" class="font-standar" valign="top">
                            &nbsp;
                        </td>
                        <td width="144" class="font-standar" valign="top">
                            <?php __("Cédula de identidad");?>                                
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <input type="text" name="txt_nom_pac" value="" class="required" maxlength="100">
                        </td>
                        <td>
                            &nbsp;
                        </td >
                        <td valign="top">
                            <input type="text" name="txt_ape_pac" value="" class="required" maxlength="20">
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td valign="top">
                            <input type="text" name="txt_ced_pac" value="" class="required" maxlength="20">
                        </td>
                    </tr>
                    <tr>
                        <td class="font-standar"valign="top">                                
                            <?php echo __("Fecha de Nacimiento",true)?>                                
                        </td>
                        <td>
                            &nbsp;
                        </td>
                         <td class="font-standar" valign="top">                                
                            <?php echo __("Nacionalidad")?>
                        </td>                            
                        <td>
                            &nbsp;
                        </td>
                        <td class="font-standar" valign="top">
                            <?php echo __("Ocupación")?>                                
                        </td>
                    </tr>                       
                    <tr>
                        <td valign="top">                                
                            <input name="txt_fec_nac_pac" id="txt_fec_nac_pac" value="" class="date required" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td valign="top" >
                            <select class="required" name="sel_nac_pac">
                                <option value="">--<?php __("Seleccione")?>--</option>                                    
                                <option value="1"><?php __("Venezolano")?></option>
                                <option value="2"><?php __("Extrangero")?></option>
                            </select>
                        </td>
                        <td >
                            &nbsp;
                        </td>
                        <td valign="top">
                            <select id="sel_ocu_pac" name="sel_ocu_pac" value="" class="required"
                            >    
                            <option value="">--<?php __("Seleccione")?>--</option>                            
                            <option value="1">
                                <?php  __("Profesional")?>
                                
                            </option>
                            <option value="2">
                                <?php  __("Técnico")?>
                                
                            </option>
                            <option value="3">
                                <?php  __("Obrero")?>
                                
                            </option>
                            <option value="4">
                                <?php  __("Agricultor")?>
                                
                            </option>
                            <option value="5">
                                <?php  __("Jardinero")?>
                                
                            </option>
                            <option value="6">
                                <?php  __("Otro")?>                                    
                            </option>
                            </select>
                        </td>
                    </tr>
                     <tr>
                        <td class="font-standar" valign="top" >                                
                            <?php echo __("Teléfono",true)?>                                
                        </td>
                        <td>
                            &nbsp;
                        </td>
                         <td class="font-standar" valign="top">                                
                            <?php echo __("Celular")?>
                        </td>                            
                        <td>
                            &nbsp;
                        </td>
                        <td class="font-standar" valign="top">
                            <?php echo __("Ciudad de Residencia")?>                                
                        </td>
                    </tr>
                     <tr>
                        <td class="font-standar" valign="top">                                
                            <input type="text" name="txt_tel_pac" id="txt_tel_pac" value="" class="number required" maxlength="12">                               
                        </td>
                        <td>
                            &nbsp;
                        </td>
                         <td class="font-standar" valign="top">                                
                            <input type="text" name="txt_cel_pac" id="txt_cel_pac" value="" class="number required" maxlength="12">                          
                        </td>                            
                        <td>
                            &nbsp;
                        </td>
                        <td class="font-standar" valign="top">
                            <input type="text" name="txt_ciu_res_pac" id="txt_res_pac" value="" class="text required" maxlength="100">                                                         
                        </td>
                    </tr>
                    <tr>
                        <td  class="font-standar" valign="top">
                            <?php echo __("Estado")?>
                            
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td  class="font-standar" valign="top">
                            <?php echo __("Municipio")?>
                            
                        </td>                           
                        <td  class="font-standar" valign="top">
                            &nbsp;
                            <!--<?php echo __("Parroquia")?>-->
                            
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <select id="sel_est_pac" name="sel_est_pac" class="required">
                                <option value="">--<?php echo __("Seleccione",true)?>--</option>
                                <?php foreach($estados as $row){?>   
                                        <option value="<?php echo $row->id_est?>"><?php echo $row->des_est?></option>
                                <?php    }?>
                            </select>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td valign="top">    
                            <table>
                                <tr>
                                    <td>
                                        <select name="sel_mun_pac" id="sel_mun_pac" style="width: 120px;" class="required">
                                            <option value="">--<?php __("Seleccione")?>--</option>
                                        </select>
                                    </td>
                                    <td style="width: 50px;" valign="top">
                                        <img id="indicator" style="display: none;" src="<?php echo $this->webroot?>/img/icon/indicator.gif">
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;                          
                        </td>
                    </tr>                                        
                </table>
             </div>                
             <table style="width: 100%; border="0" class="">
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
        </fieldset>
    </div>       
</div>