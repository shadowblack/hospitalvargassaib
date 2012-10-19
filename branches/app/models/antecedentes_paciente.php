<?php
    class AntecedentesPaciente extends AppModel{
        var $name   = "AntecedentesPaciente";  
        var $virtualFields = array(
            "id__antecedentes_pacientes"                     => "AntecedentesPaciente.id_ant_pac"           
        );                                             
    }    
?>