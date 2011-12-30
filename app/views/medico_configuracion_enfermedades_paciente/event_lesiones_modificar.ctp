<?php if (count($les_cat)==0){  ?>
     <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("Esta enfermedad no posee categorías",true)?></span>
    </div>           
<?php die; } ?>  
<table style="margin-left: 20px;margin-top: 5px;">
    <tr>
        <td class="standar_font_sub" colspan="2">
            <?php __("Lesiones")?>
        </td>
    </tr>
    <?php
        foreach($les_cat as $row){
            ?>
                <tr>
                    <td>
                        <input class="standar_input_checkbox" type="checkbox" name="les_" value="(<?php echo $row->id_cat_cue_les.";".$id_par_cue_cat_cue?>)" <?php echo ($row->id_checked == "") ? "" : "checked='checked'";echo $this->Otros->Attr($row->id_cat_cue_les.";".$id_par_cue_cat_cue,$row->nom_les,"txt_otr_les__".$row->id_cat_cue_les.";".$id_par_cue_cat_cue)?>>
                    </td>
                    <td class="standar_list">
                        <?php echo $row->nom_les?>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <?php echo $this->Otros->Text(100, $row->otr_les_par_cue);?>
                    </td>
                </tr>
            <?php
        }
    ?>
</table>