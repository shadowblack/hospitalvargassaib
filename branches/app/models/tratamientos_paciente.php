<?php
    class TratamientosPaciente extends AppModel{
        var $name   = "TratamientosPaciente";  
        var $virtualFields = array(
            "id"                     => "TratamientosPaciente.id_tra_pac"           
        );                             
    }    
?>