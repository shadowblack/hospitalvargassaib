<?php
    foreach($tipo_enf_mic as $row){
?>   
        <option value="<?php echo $row->id_enf_mic?>" title="<?php echo $row->nom_enf_mic;?>"><?php echo $row->nom_enf_mic?></option>
<?php 
    }
?>