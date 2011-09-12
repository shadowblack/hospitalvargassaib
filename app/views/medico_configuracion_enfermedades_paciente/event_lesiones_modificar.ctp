<?php if (count($les_cat)==0){  ?>
     <div class="standar_not_register">
        <span class="standar_not_register"><?php echo __("Esta enfermedad no posee categorias",true)?></span>
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
                        <input class="standar_input_checkbox" type="checkbox" name="les_" value="(<?php echo $row->id_cat_cue_les.";".$id_par_cue_cat_cue?>)" <?php echo ($row->id_checked == "") ? "" : "checked='checked'";?>>
                    </td>
                    <td class="standar_font">
                        <?php echo $row->nom_les?>
                    </td>
                </tr>
            <?php
        }
    ?>
</table>