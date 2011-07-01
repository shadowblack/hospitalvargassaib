<?php
    class HistorialesPaciente extends AppModel{
        var $name   = "HistorialesPaciente";        
        var $virtualFields = array(
            'id__historiales_pacientes' => 'HistorialesPaciente.id_his',
            'num_his' => 'HistorialesPaciente.num_his::TEXT',
        );    
    }
    
?>