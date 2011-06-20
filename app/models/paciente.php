<?php
    class Paciente extends AppModel{
        var $name   = "Paciente";        
        var $virtualFields = array(
            'prueba' => 'Paciente.nom_pac'
        );

        
        
        /*
        var $hasMany = Array(
            "Municipio" => Array(
                                "foreighKey"    => "id_par"                                
            )
        );*/
    }
    
?>