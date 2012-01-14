<?php if (count($estudios)==0){  ?>
    <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("Esta enfermedad no posee estudios micológicos",true)?></span>
    </div>            
<?php die; } ?>   
<table border="0" style="margin-left: 10px;margin-top: 5px;">
    <tr>
        <td>
            &nbsp;
        </td>
        <td class="standar_font_sub">
            <?php __("Estudios")?>
        </td>
        <td class="standar_font_sub">
            <?php __("Tipo de examen") ?>
        </td>
    </tr>      
    <?php
        $tip_est_ant = ""; 
        foreach($estudios as $row):
            if ($tip_est_ant <> $row->id_tip_est_mic){
                $tip_est_ant = $row->id_tip_est_mic;
                $show_new_tr = true;
            } else {
                $show_new_tr = false;
            }
            
        ?>     
        <tr>
            <td>
                <input type="checkbox" class="standar_input_checkbox" name="chk_tip_est_mic_" value="<?php echo $row->id_tip_est_mic?>" >        
            </td>
            <td align="left" class="standar_list">
                <?php echo $row->nom_tip_est_mic; ?>
            </td>
            <td  class="standar_list">
                <?php echo $row->nom_tip_exa; ?>
            </td>
        </tr>    
    <?php endforeach; ?>
</table>