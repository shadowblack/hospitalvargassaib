<?php 
    
    switch($num_cat){
        case 3:
            $condicion = "";
            if ($id_mun <> ""){
                $condicion = "echo (\$id_mun==\$municipios->id_mun ? \"selected='selected'\" : \"\");";                               
            } 
            ?><option value="">--<?php echo __("Seleccione")?>--</option><?php
            foreach($results as $municipios){
                ?><option value="<?php echo $municipios->id_mun?>" <?php eval($condicion)?>><?php echo $municipios->des_mun?></option><?php
            }
        break;
    }
?>