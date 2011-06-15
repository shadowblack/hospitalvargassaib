<fieldset style="height: 370px;">
    <legend>
        <strong class="font-standar">
            <?php __("Datos del personaje del paciente"); ?>
        </strong>
    </legend>                
        <table style="width:540px" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
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
                <td class="standar_font_sub"valign="top">                                
                    <?php echo __("Fecha de Nacimiento",true)?>                                
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
                <td class="standar_font_sub" valign="top">
                    <?php echo __("Ocupación")?>                                
                </td>
            </tr>                       
            <tr>
                <td valign="top">                                                    
                    <span class="standar_font"><?php echo $this->DateFormat->postgres_to_date($result->fec_nac_pac)?></span>
                </td>
                <td>
                    &nbsp;
                </td>
                <td valign="top" >
                    <span class="standar_font"><?php echo ($result->ced_pac == "1" ? __("Venezolano") : __("Extranjero"))?></span>
                    
                </td>
                <td >
                    &nbsp;
                </td>
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
            </tr>
             <tr>
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
                <td class="standar_font_sub" valign="top">
                    <?php echo __("Ciudad de Residencia")?>                                
                </td>
            </tr>
             <tr>
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
                <td class="font-standar" valign="top">                                
                    <span class="font-standar"><?php echo $result->ciu_pac?></span>                 
                </td>
            </tr>
            <tr>
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
                <td  class="standar_font_sub" valign="top">
                    &nbsp;
                    <!--<?php echo __("Parroquia")?>-->
                    
                </td>
            </tr>
            <tr>
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
                <td>
                    &nbsp;                               
                </td>
            </tr>                                        
        </table>                      
        <table style="width: 100%;left: 0;bottom: 20px;top: auto;" border="0" class="standar_position">
            <tr>               
                <td  align="center" style="height: 0" valign="bottom">
                    <input type="button" name="btn_volver" value="Volver" onclick="history.back()">
                </td>
            </tr>
        </table>              
</fieldset>           