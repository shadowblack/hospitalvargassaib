<table style="margin-left: 20px;">    
    <?php
        foreach($les_cat as $row){
            ?>
                <tr>
                    <td class="standar_list">
                        <input class="standar_input_checkbox" type="checkbox" name="les_" value="(<?php echo $row->id_cat_cue_les.";".$id_par_cue_cat_cue?>)" <?php echo $this->Otros->Attr($row->id_cat_cue_les.";".$id_par_cue_cat_cue,$row->nom_les,"txt_otr_les__".$row->id_cat_cue_les.";".$id_par_cue_cat_cue);?>>
                    </td>
                    <td class="standar_list">
                        <?php echo $row->nom_les?>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="standar_list">
                        <?php echo $this->Otros->Text(100,'');?> 
                    </td>
                </tr>
            <?php
        }
    ?>
</table>