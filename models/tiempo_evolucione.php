<?php
    class TiempoEvolucione extends AppModel{
        var $name   = "TiempoEvolucione";  
        var $virtualFields = array(
            "id__tiempo_evoluciones"                     => "TiempoEvolucione.id_tie_evo"           
        );                             
    }
    
?>