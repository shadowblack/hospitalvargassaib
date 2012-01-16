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
                    <td class="standar_font_sub lista_fondo" >
                        <?php __("Estudios para (".$row->nom_tip_exa.")")?>
                    </td>                   
                </tr>   
                <?php
            }           
        ?>     
        <tr>
            <td>
                <input type="checkbox" class="standar_input_checkbox" name="chk_tip_est_mic_" value="<?php echo $row->id_tip_est_mic?>" <?php echo $this->Otros->Attr($row->id_tip_est_mic,$row->nom_tip_est_mic,"txt_tip_est_mic__".$row->id_tip_est_mic);?>>        
            </td>
            <td align="left" class="standar_list">
                <?php echo $row->nom_tip_est_mic; ?>
            </td>            
        </tr>    
        <tr>
            <td colspan="2">
                <div style="width:170px">
                    <?php echo $this->Otros->Text(100);?>
                </div>                
            </td>
        </tr>
    <?php endforeach; ?>
</table>