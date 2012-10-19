<?php
    class AntecedentesPersonale extends AppModel{
        var $name   = "AntecedentesPersonale";  
        var $virtualFields = array(
            "id__antecedentes_personales"                     => "AntecedentesPersonale.id_ant_per"           
        );                             
    }    
?>