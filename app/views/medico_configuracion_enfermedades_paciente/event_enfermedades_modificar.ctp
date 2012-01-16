<?php if (count($enf_mic)==0){  ?>
     <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("No hay registros para modificar",true)?></span>
    </div>           
<?php die; } ?>   
<table border="0" style="margin-left: 10px;" cellspacing="0">    
    <?php foreach($enf_mic as $row):?>
        <tr>
            <td>                
                <input type="checkbox" class="standar_input_checkbox" name="chk_enf_pac_" value="<?php echo $row->id_enf_mic?>" <?php echo ($row->check_id != "" ? "checked='checked'" : "");echo $this->Otros->Attr($row->id_enf_mic,$row->nom_enf_mic,"txt_otr_enf_pac")?>>                        
            </td>
            <td align="left" class="standar_list">
                <?php echo $row->nom_enf_mic; ?>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <?php echo $this->Otros->Text(20, $row->otr_enf_mic);?>
            </td>
        </tr>
    <?php endforeach; ?>
</table>