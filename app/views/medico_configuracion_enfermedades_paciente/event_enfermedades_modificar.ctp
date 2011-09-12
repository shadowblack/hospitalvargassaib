<?php if (count($enf_mic)==0){  ?>
     <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("No hay registros para modificar",true)?></span>
    </div>           
<?php die; } ?>   
<table border="0" style="margin-left: 10px;margin-top: 5px;">    
    <?php foreach($enf_mic as $row):?>
        <tr>
            <td>
                <input type="checkbox" class="standar_input_checkbox" name="chk_enf_pac_" value="<?php echo $row->id_enf_mic?>" <?php echo ($row->check_id != "" ? "checked='checked'" : "")?>>        
            </td>
            <td align="left" class="standar_list">
                <?php echo $row->nom_enf_mic; ?>
            </td>
        </tr>    
    <?php endforeach; ?>
</table>