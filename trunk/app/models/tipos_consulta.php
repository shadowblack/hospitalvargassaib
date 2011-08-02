<?php
    class TiposConsulta extends AppModel{
        var $name   = "TiposConsulta";  
        var $virtualFields = array(
            "id__tipos_consultas"                     => "TiposConsulta.id_tip_con"           
        );                             
    }
    
?>