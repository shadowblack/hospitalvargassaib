<?php
    class CentroSalud extends AppModel{
        var $name   = "CentroSalud";  
        var $virtualFields = array(
            "id__centro_saluds"                     => "CentroSalud.id_cen_sal"           
        );                             
    }
    
?>