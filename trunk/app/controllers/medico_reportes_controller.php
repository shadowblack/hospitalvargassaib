<?php
    class MedicoReportesController extends Controller{
        var $name = "MedicoReportes";
        var $uses = Array("Transaccione");
        var $components = Array("Login","Session","SqlData");
        protected $group_session = "medico";
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
        }
        
        
        function busqueda(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            // Se realiza el query para obtener los usuarios medicos
            $sql = "SELECT d.id_doc, tuu.id_tip_usu_usu, d.nom_doc||' '||d.ape_doc AS nom_usu_doc 
                    FROM doctores d
                    	LEFT JOIN tipos_usuarios__usuarios tuu USING(id_doc)
                    ORDER BY nom_usu_doc";					
		   	$arr_query = $this->Transaccione->query($sql);
            $usuarios_medico = $this->SqlData->array_to_objects($arr_query); 
            
            // Se realiza el query para obtener las transacciones
            $sql = "SELECT id_tip_tra,des_tip_tra FROM transacciones ORDER BY des_tip_tra";					
		   	$arr_query = $this->Transaccione->query($sql);
            $transacciones = $this->SqlData->array_to_objects($arr_query);     
            
            $title = __("Búsqueda de transacciones",true);
           
            $data = Array(
                "usuarios_medico" => $usuarios_medico,
                "transacciones"   => $transacciones,
                "title"           => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        function event_listar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
                       
            $ids_usu     = $_REQUEST["id_usuarios"]; 
            $ids_tra     = $_REQUEST["id_transacc"];
            
            if(isset($_REQUEST['txt_fec_ini']) && isset($_REQUEST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_REQUEST["txt_fec_ini"]);
                $fec_fin = $this->SqlData->date_to_postgres($_REQUEST["txt_fec_fin"]);
                $fechas  = " AND fec_aud_tra >= '$fec_ini' AND fec_aud_tra <= '$fec_fin'";
            }
            
            // Se realiza el query para obtener la auditoría de transacciones de usuarios
            $sql = "SELECT  to_char(fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM' ) AS fecha_tran,
                        	d.nom_doc||' '||d.ape_doc AS nom_ape_usu,
                        	d.log_doc AS log_usu,
                        	t.des_tip_tra AS des_tip_tra,
                        	CASE 
                        		WHEN data_xml IS NOT NULL THEN 'Si' ELSE 'No' 
                        	END AS detalle
                    
                    FROM auditoria_transacciones at
                            LEFT JOIN tipos_usuarios__usuarios tuu USING(id_tip_usu_usu)
                            LEFT JOIN doctores d ON (tuu.id_doc = d.id_doc)
                            LEFT JOIN transacciones t ON(at.id_tip_tra = t.id_tip_tra)
                    
                    WHERE id_tip_usu_usu IN($ids_usu) 
                    AND t.id_tip_tra IN($ids_tra) 
                    $fechas
                    ORDER BY fecha_tran DESC";
            
            $arr_query = $this->Transaccione->query($sql);
            $auditoria = $this->SqlData->array_to_objects($arr_query);             
            
            $title = __("Reporte de transacciones",true);
            $data = Array(
                "auditoria" => $auditoria,
                "title"     => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
                                     
        }
    }
?>