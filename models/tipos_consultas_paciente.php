<?php
    class TiposConsultasPaciente extends AppModel{
        var $name   = "TiposConsultasPaciente";  
        var $virtualFields = array(
            "id"                     => "TiposConsultasPaciente.id_tip_con_pac"           
        );                             
    }    
?>