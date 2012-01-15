<script type="text/javascript">
    jQuery(function(){
         jQuery("#tabs-1").css("display","block");
         jQuery( "#tabs" ).tabs();     
    })
</script>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Agregar Paciente",true)?>
                </a>
            </li>            
        </ul>
        <fieldset class="standar_fieldset_content">  
            <div class="standar_fieldset_child">                       
                <table style="margin-top: 20px;" border="0" align="center" bgcolor="" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="120" class="standar_font_sub" valign="top" align="left">
                            <?php echo __("Número de historia",true)?>
                        </td>
                        <td width="20" class="standar_font_sub ">
                            &nbsp;
                        </td>
                        <td width="159" class="standar_font_sub" valign="top" align="left">
                            <?php echo __( "Descripción de la historia",true)?>
                        </td>
                        <td width="20" class="standar_font" valign="top">
                            &nbsp;
                        </td>
                        <td width="204" class="standar_font_sub" valign="top" align="left">
                            <?php __("Descripción adicional del paciente");?>                                
                        </td>
                    </tr>               
                    <tr>
                        <td valign="top" align="left">                              
                            <span class="standar_font"><?php echo $this->FormatString->NumbersZero($result->HistorialesPaciente->id_his,6)?></span>
                        </td>
                        <td>
                            &nbsp;
                        </td >
                        <td valign="top" align="left">
                            <span class="standar_font"><?php echo $result->HistorialesPaciente->des_his?></span>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td valign="top" align="left">                                
                            <span class="standar_font"><?php echo $result->HistorialesPaciente->des_adi_pac_his?></span>
                        </td>
                    </tr>                                                      
                </table>
            </div>             
            <table style="width: 100%;" border="0">
                <tr>               
                    <td  align="center" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="window.location.href='<?php echo$this->History->Url($_SERVER['HTTP_REFERER'])?>'">
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</div>                             