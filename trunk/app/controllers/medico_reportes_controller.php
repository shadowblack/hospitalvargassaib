<?php
    class MedicoReportesController extends Controller{
        var $name = "MedicoReportes";
        var $uses = Array("AuditoriaTransaccione","Transaccione");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History");
        var $helpers =      Array("Paginator",);
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
            
            $ids_usu =  $_POST["id_usuarios"];
            $ids_tra = $_POST["id_transacc"];
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
            }
            
            $this->paginate = array(
                'limit' => 18,
                'fields' => Array(
                                    "vat.fecha_tran",
                                    "vat.nom_ape_usu",
                                    "vat.log_usu",
                                    "vat.detalle",
                                    "Transaccione.des_tip_tra",
                                    "vat.data_xml",
                                    "vat.id_tip_tra",
                                    "vat.cod_tip_tra",
                                    "vat.id_mod"
                ),
                "joins" => array(
                    Array(
                        "table"      => "view_auditoria_transacciones",
                        "alias"      => "vat",
                        "conditions" => "vat.id_tip_tra = Transaccione.id_tip_tra"
                    )
                ),
                "conditions" => Array(
                    "vat.id_tip_usu_usu" => explode(",",$ids_usu),                                
                    "vat.id_tip_tra" => explode(",",$ids_tra),
                    "CAST(vat.fecha_tran AS DATE) >=" => "$fec_ini",
                    "CAST(vat.fecha_tran AS DATE) <=" => "$fec_fin"
                ),
                "order" => "CAST(vat.fecha_tran AS DATE) DESC" 
            ); 
   
            $arr_query = $this->paginate("Transaccione");
            $auditoria = $this->SqlData->CakeArrayToObjects($arr_query);             
            
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