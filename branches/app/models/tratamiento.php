<?php
    class Tratamiento extends AppModel{
        var $name   = "Tratamiento";  
        var $virtualFields = array(
            "id__tratamientos"                     => "Tratamiento.id_tra"           
        );                             
    }    
?>