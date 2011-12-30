<?php
    class HistorialesPaciente extends AppModel{
        var $name   = "HistorialesPaciente";        
        var $virtualFields = array(
            "id__historiales_pacientes"                     => "HistorialesPaciente.id_his",
            "num_his"                                       => "HistorialesPaciente.id_his::TEXT",
            "fec_his"                                       => "to_char(fec_his, 'DD/MM/YYYY HH12:MI:SS am')"
        );    
        
        function MedRegistrarHistorialPaciente($id_pac,$des_his,$des_pac_his,$id_doc,$tra_usu){
            $sql = "SELECT med_registrar_hitorial_paciente(ARRAY[
                '$id_pac', 
                '$des_his', 
                '$des_pac_his', 
                '$id_doc',
                '$tra_usu'                               
            ]) AS result";
            return $sql;
        }
        
        function MedModificarHistorialPaciente($id_his,$des_his,$des_pac_his,$id_doc,$tra_usu){
            $sql = "SELECT med_modificar_hitorial_paciente(ARRAY[
                '$id_his', 
                '$des_his', 
                '$des_pac_his', 
                '$id_doc',
                '$tra_usu'               
            ]) AS result";
            return $sql;
        }
        
        function MedEliminarHistorialPaciente($id_his,$id_doc,$tra_usu){
            $sql = "SELECT med_eliminar_historial(ARRAY[
                '$id_his',
                '$id_doc',
                '$tra_usu'
            ]) AS result";
            return $sql;
        }
        
        function MedRegistrarInformacionAdicional(
            $id_his,
            $cen_sal,
            $tip_con,
            $con_ani,
            $tra_pre,
            $tie_evo,
            
            $id_hdd_otr_ani,
            $txt_otr_ani,
            
            $id_hdd_otr_tip_con,
            $txt_otr_tip_con,
            
            $id_hdd_otr_cen_sal,
            $txt_otr_cen_sal,
            
			$id_hdd_otr_tra,
            $txt_otr_tra, 
                             
            $id_doc,
            $tra_usu
        ){
            $sql = "SELECT med_registrar_informacion_adicional(ARRAY[
                '$id_his',
                '$cen_sal',
                '$tip_con',
                '$con_ani',
                '$tra_pre',
                '$tie_evo',
                
                '$id_hdd_otr_ani',
                '$txt_otr_ani',
                
                '$id_hdd_otr_tip_con',
                '$txt_otr_tip_con',
                
                '$id_hdd_otr_cen_sal',
                '$txt_otr_cen_sal',
                
				'$id_hdd_otr_tra',
                '$txt_otr_tra',
                            
                '$id_doc',
                '$tra_usu'                
                ]
            ) AS result";
            return $sql;
        }
        
        function MedMuestraClinicaPaciente(
                $id_his,
                $mue_cli,
                $id_hdd_otr_mue_cli,
                $txt_otr_mue_cli,
                $id_doc,
                $tra_usu
        ){
            $sql = "SELECT med_muestra_clinica_paciente(ARRAY[
                '$id_his',
                '$mue_cli',
                '$id_hdd_otr_mue_cli',
                '$txt_otr_mue_cli',               
                '$id_doc',
                '$tra_usu'                
                ]
            ) AS result";
            return $sql;
        }
        
        function MedInsertarMicosisPaciente(
                $id_his,
                $hdd_id_tip_mic,
                $hdd_chk_enf_pac,
                $hdd_les,
                $hdd_tip_est_mic,
                $hdd_chk_for_inf,
                
                $txt_otr_enf_mic,
                $id_hdd_otr_enf_mic,
                
                $id_hdd_otr_for_inf,
                $txt_otr_for_inf,
                
                $hdd_str_otr_les,
                
                $id_doc
        ){
        $sql = "SELECT med_insertar_micosis_pacientes(ARRAY[
                '$id_his',
                '$hdd_id_tip_mic',               
                '$hdd_chk_enf_pac',
                '$hdd_les',
                '$hdd_tip_est_mic',
                '$hdd_chk_for_inf',
                
                '$txt_otr_enf_mic',
                '$id_hdd_otr_enf_mic',
                
                '$id_hdd_otr_for_inf',
                '$txt_otr_for_inf',
                
                '$hdd_str_otr_les',
                
                '$id_doc'                              
                ]
            ) AS result";
            return $sql;
        }
        
        function MedModificarMicosisPaciente(
            $tipos_micosis_pacientes,
            $hdd_chk_enf_pac,
            $hdd_les,
            $hdd_est,
            $hdd_chk_for_inf,
            
            $txt_otr_enf_pac,
            $hdd_id_otr,
            
            $hdd_str_otr_les,
            
            $id_hdd_otr_for_inf,
            $txt_otr_for_inf,
                
            $id_doc
        ){
            $sql = "SELECT med_modificar_micosis_pacientes(ARRAY[                
                '$tipos_micosis_pacientes',               
                '$hdd_chk_enf_pac',
                '$hdd_les',
                '$hdd_est',
                '$hdd_chk_for_inf',
                
                '$txt_otr_enf_pac',
                '$hdd_id_otr',
                
                '$hdd_str_otr_les',
                
                '$id_hdd_otr_for_inf',
                '$txt_otr_for_inf',
                
                '$id_doc'              
                ]
            ) AS result";
            return $sql;
        }
        
        function MedEliminarMicosisPaciente($id_tip_mic_pac,$id_doc){
            $sql = "SELECT med_eliminar_micosis_paciente(ARRAY[
                '$id_tip_mic_pac',
                '$id_doc']
            ) AS result";
            return $sql;
        }
    }
    
?>