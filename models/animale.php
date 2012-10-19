<?php
    class Animale extends AppModel{
        var $name   = "Animale";  
        var $virtualFields = array(
            "id__animales"                     => "Animale.id_ani"           
        );                             
    }
    
?>