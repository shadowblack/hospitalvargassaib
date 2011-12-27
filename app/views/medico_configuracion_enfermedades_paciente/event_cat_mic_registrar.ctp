 <?php if (count($cat_cue)==0){  ?>
    <div class="standar_not_register">
            <span class="standar_not_register"><?php echo __("Esta enfermedad no posee descripción de lessiones.",true)?></span>
    </div> 
<?php die; } ?> 
 <table style="width:540px;margin-top: 5px;" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="184" class="standar_font" valign="top">            
            <?php echo __( "Categorias",true)?>
        </td>                        
    </tr>
    <?php        
        $id_cat_cue = false;
        foreach($cat_cue as $row):                            
            if ($id_cat_cue != $row->id_cat_cue){
    ?>
                <tr>    
                    <td class="standar_font_sub">
                        <div style="margin-left: 10px;">                            
                            <?php echo $row->nom_cat_cue ?>:
                        </div>
                    </td>
                </tr>
            <?php
            }
            $id_cat_cue = $row->id_cat_cue; 
            ?> 
            <tr>    
                <td class="">
                    <div style="margin-left: 25px;">
                        <input type="checkbox" name="chk_par_cue" id_par_cue_cat_cue="<?php echo $row->id_par_cue_cat_cue?>" class="standar_input_checkbox" onclick="check_parte_cuerpo(this);" value="<?php echo $row->id_par_cue?>" >
                        <?php echo $row->nom_par_cue ?>
                        <div id="div_les_par_cue_<?php echo $row->id_par_cue_cat_cue?>">
                            <!-- Check box lesiones con, ajax -->
                        </div>            
                    </div>
                </td>
            </tr>
            <?php
            
            
        endforeach;                         
    ?>                                                                                           
</table>