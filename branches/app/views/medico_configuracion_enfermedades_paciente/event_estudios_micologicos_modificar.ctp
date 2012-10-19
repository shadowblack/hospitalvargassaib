<?php if (count($estudios)==0){  ?>
    <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("Esta enfermedad no posee estudios micológicos",true)?></span>
    </div>            
<?php die; } ?>   
<table border="0" style="margin-left: 5px;margin-top: 5px;width:100%"  cellspacing="0">     
    <?php
        $id_tip_exa = "";  
        foreach($estudios as $row):
        if ($id_tip_exa <> $row->id_tip_exa){
                $id_tip_exa = $row->id_tip_exa;                
                ?>
                <tr>
                    <td style="width: 5px;" class="lista_fondo">
                        &nbsp;
                    </td>
                    <td class="standar_font_sub lista_fondo" style="200px">                                                                                           
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td><?php __("Estudios para (".$row->nom_tip_exa.")")?></td>
                                <td>&nbsp;-&nbsp;</td><td><?php __("Positivo")?>:&nbsp;</td>
                                <td style="width: 100px;">                                    
                                    <input type="radio" <?php echo ($row->exa_pac_est == 0 ? "checked = 'checked'" : "") ?> name="positivo__<?php echo $row->id_tip_exa?>" value="0" style="width: 10px;"><?php __("Si") ?>
                                    <input type="radio" <?php echo ($row->exa_pac_est == 1 ? "checked = 'checked'" : "") ?> name="positivo__<?php echo $row->id_tip_exa?>" value="1" style="width: 10px;"><?php __("No") ?>
                                    <input type="radio" <?php echo ($row->exa_pac_est == 3 ? "checked = 'checked'" : "") ?> name="positivo__<?php echo $row->id_tip_exa?>" value="3" style="width: 10px;"><?php __("N/A") ?>
                                </td>
                            </tr>
                        </table>
                    </td>                   
                </tr> 
                <tr>
                    <td colspan="2">
                        <input maxlength="200" type="text" style="width: 99%; <?php echo ($row->exa_pac_est == 1 ? "display:block'" : "display:none") ?>;" id="observaciones__<?php echo $row->id_tip_exa?>" value="<?php echo $row->obs_exa_pac?>"/>
                    </td>
                </tr> 
                <?php
            } 
        ?>
        <tr>
            <td>
                <input type="checkbox" class="standar_input_checkbox" name="chk_tip_est_mic_" value="<?php echo $row->id_tip_est_mic?>" <?php echo $row->id_tip_mic_pac <> "" ? "checked='checked'" : ""?> <?php echo $this->Otros->Attr($row->id_tip_est_mic,$row->nom_tip_est_mic,"txt_tip_est_mic__".$row->id_tip_est_mic);?> >        
            </td>
            <td align="left" class="standar_list">
                <?php echo $row->nom_tip_est_mic; ?>
            </td>            
        </tr>    
        <tr>
            <td colspan="2">
                <div style="width:170px">
                    <?php echo $this->Otros->Text(100,$row->otr_tip_est_mic);?>
                </div>                
            </td>
        </tr>
    <?php endforeach; ?>
</table>