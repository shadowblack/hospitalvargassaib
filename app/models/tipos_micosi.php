<?php
    class TiposMicosi extends AppModel{
        var $name   = "TiposMicosi";  
        var $virtualFields = array(
            "id_tipos_micosis"                     => "TiposMicosi.id_tip_mic"           
        );                             
    }
    
?>