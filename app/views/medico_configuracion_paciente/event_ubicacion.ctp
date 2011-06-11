<?php 
    switch($num_cat){
        case 3:
            ?><option value="">--<?php echo __("Seleccione")?>--</option><?php
            foreach($results as $municipios){
                ?><option value="<?php echo $municipios->id_mun?>"><?php echo $municipios->des_mun?></option><?php
            }
        break;
    }
?>