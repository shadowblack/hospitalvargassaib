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
    <?php foreach($estudios as $row):?>
        <tr>
            <td>
                <input type="checkbox" class="standar_input_checkbox" name="chk_tip_est_mic_" value="<?php echo $row->id_tip_est_mic?>" <?php echo $row->id_tip_mic_pac <> "" ? "checked='checked'" : ""?> >        
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