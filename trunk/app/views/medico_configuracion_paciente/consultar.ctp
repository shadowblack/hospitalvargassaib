<script type="text/javascript">
    jQuery(function(){
         parent.jQuery("#title_content").html("<?php echo $title;?>");
         jQuery("#tabs-1").css("display","block");
         jQuery( "#tabs" ).tabs();     
    })
</script>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Consultar Paciente",true)?>
                </a>
            </li>            
        </ul>
        <fieldset class="standar_fieldset_content"> 
            <div class="standar_fieldset_child">               
            <table style="width:540px;margin-top: 20px;" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="184" class="standar_font_sub" valign="top">
                        <?php echo __( "Nombre",true)?>
                    </td>
                    <td width="9" class="standar_font_sub">
                        &nbsp;
                    </td>
                    <td width="189" class="standar_font_sub" valign="top">
                        <?php echo __( "Apellido",true)?>
                    </td>
                    <td width="8" class="standar_font" valign="top">
                        &nbsp;
                    </td>
                    <td width="144" class="standar_font_sub" valign="top">
                        <?php __("Cédula de identidad");?>                                
                    </td>
                </tr>               
                <tr>
                    <td valign="top">                              
                        <span class="standar_font"><?php echo $result->nom_pac?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td >
                    <td valign="top">
                        <span class="standar_font"><?php echo $result->ape_pac?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top">                                
                        <span class="standar_font"><?php echo $result->ced_pac?></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="standar_font_sub"valign="top">                                
                        <?php echo __("Fecha de Nacimiento",true)?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="standar_font_sub" valign="top">                                
                        <?php echo __("Sexo")?>
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                    <td class="standar_font_sub" valign="top">                                
                        <?php echo __("Nacionalidad")?>
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                </tr>                       
                <tr>
                    <td valign="top">                                                    
                        <span class="standar_font"><?php echo $this->DateFormat->PostgresToDate($result->fec_nac_pac)?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top" >
                        <span class="standar_font"><?php echo ($result->sex_pac == "F" ? __("Femenino") : __("Masculino"))?></span>
                    </td>
                    <td >
                        &nbsp;
                    </td>
                    <td valign="top" >
                        <span class="standar_font"><?php echo ($result->ced_pac == "1" ? __("Venezolano") : __("Extranjero"))?></span>
                        
                    </td>
                    <td >
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                     <td class="standar_font_sub" valign="top">
                        <?php echo __("Ocupación")?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="standar_font_sub" valign="top" >                                
                        <?php echo __("Teléfono",true)?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                     <td class="standar_font_sub" valign="top">                                
                        <?php echo __("Celular")?>
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                    
                </tr>
                 <tr>
                     <td valign="top">
                        <?php
                            switch($result->ocu_pac){
                                case 1:
                                    $ocupacion = __("Profesional",true);
                                break;
                                case 2:
                                    $ocupacion = __("Técnico",true);
                                break;
                                case 3:
                                    $ocupacion = __("Obrero",true);
                                break;
                                case 4:
                                    $ocupacion = __("Agricultor",true);
                                break;
                                case 5:
                                    $ocupacion = __("Jardinero",true);
                                break;
                                case 6:
                                    $ocupacion = __("Otro",true);
                                break;
                            }
                        ?>
                        <span class="font-standar"><?php echo $ocupacion ?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="font-standar" valign="top">  
                        <span class="font-standar"><?php echo $result->tel_hab_pac?></span>                                                                                             
                    </td>
                    <td>
                        &nbsp;
                    </td>
                     <td class="font-standar" valign="top">                                                                
                         <span class="font-standar"><?php echo $result->tel_cel_pac?></span>                            
                    </td>                            
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="standar_font_sub" valign="top">
                        <?php echo __("Ciudad de Residencia")?>                                
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td  class="standar_font_sub" valign="top">
                        <?php echo __("Estado")?>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td  class="standar_font_sub" valign="top">
                        <?php echo __("Municipio")?>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="font-standar" valign="top">                                
                        <span class="font-standar"><?php echo $result->ciu_pac?></span>                 
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top">
                        <span class="font-standar"><?php echo $result->des_est?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td valign="top">    
                        <span class="font-standar"><?php echo $result->des_mun?></span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>                                        
            </table>
            </div>                      
            <table style="width: 100%;" border="0">
                <tr>               
                    <td  align="center" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="history.back()">
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</div>                             