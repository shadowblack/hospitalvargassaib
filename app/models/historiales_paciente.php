<?php
    class HistorialesPaciente extends AppModel{
        var $name   = "HistorialesPaciente";        
        var $virtualFields = array(
            "id__historiales_pacientes"                     => "HistorialesPaciente.id_his",
            "num_his"                                       => "HistorialesPaciente.id_his::TEXT",
            "fec_his"                                       => "to_char(fec_his, 'DD/MM/YYYY HH12:MI:SS am')"
        );    
        
        function MedRegistrarHistorialPaciente($id_pac,$des_his,$des_pac_his,$id_doc){
            $sql = "SELECT med_registrar_hitorial_paciente(ARRAY[
                '$id_pac', 
                '$des_his', 
                '$des_pac_his', 
                '$id_doc'               
            ]) AS result";
            return $sql;
        }
        
        function MedModificarHistorialPaciente($id_his,$des_his,$des_pac_his,$id_doc){
            $sql = "SELECT med_modificar_hitorial_paciente(ARRAY[
                '$id_his', 
                '$des_his', 
                '$des_pac_his', 
                '$id_doc'               
            ]) AS result";
            return $sql;
        }
        
        function MedEliminarHistorialPaciente($id_his,$id_doc){
            $sql = "SELECT med_eliminar_historial(ARRAY[
                '$id_his',
                '$id_doc']
            ) AS result";
            return $sql;
        }
    }
    
?>