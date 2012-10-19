<?php
    class AdminAuditoriaController extends Controller{
        var $name = "AdminAuditoria";
        var $uses = Array("AuditoriaTransaccione","Transaccione");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History");
        var $helpers =      Array("Paginator",);
        protected $group_session = "admin";
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
        }
        
        
        function busqueda(){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            
            // Se realiza el query para obtener los usuarios medicos
            $sql = "    SELECT
                        	tuu.id_tip_usu_usu,
                        	CASE 
                        		WHEN tu.id_tip_usu = 1  THEN (ua.nom_usu_adm::text || ' '::text) || ua.ape_usu_adm::text 
                        		WHEN tu.id_tip_usu = 2  THEN (d.nom_doc::text || ' '::text) || d.ape_doc::text 
                        	END AS nom_ape_usu,
                        	tu.des_tip_usu
                        FROM tipos_usuarios__usuarios tuu
                        	LEFT JOIN usuarios_administrativos ua USING(id_usu_adm)
                        	LEFT JOIN doctores d USING(id_doc)
                        	LEFT JOIN tipos_usuarios tu USING(id_tip_usu)
                        ORDER BY nom_usu_adm
                        ";					
		   	$arr_query = $this->Transaccione->query($sql);
            $usuarios = $this->SqlData->array_to_objects($arr_query); 
            
            
            $sql= " SELECT * FROM tipos_usuarios ";
            $arr_query = $this->Transaccione->query($sql);
            $tipo_usuario = $this->SqlData->array_to_objects($arr_query);
            
            // Se realiza el query para obtener las transacciones
            $sql = "SELECT id_tip_tra,des_tip_tra FROM transacciones ORDER BY des_tip_tra";					
		   	$arr_query = $this->Transaccione->query($sql);
            $transacciones = $this->SqlData->array_to_objects($arr_query);     
            
            $title = __("Buscar transacciones",true);
           
            $data = Array(
                "usuarios"        => $usuarios,
                "transacciones"   => $transacciones,
                "tipo_usuario"    => $tipo_usuario,
                "title"           => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        function event_listar(){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            
            if (count($_POST) > 0){
                $this->Session->write("admin.paginacion",$_POST);
            } else {
                $_POST = $this->Session->read("admin.paginacion");         
            }           
            
            $ids_usu =  $_POST["id_usuarios"];
            $ids_tra =  $_POST["id_transacc"];
            
            $tip_usu = "";
            if(isset($_POST["sel_tip_usu"]) && $_POST["sel_tip_usu"] != ""){
                $tip_usu = $_POST["sel_tip_usu"];  
            }
            
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
            }
            
            $this->paginate = array(
                'limit' => 17,
                'fields' => Array(
                                    "vat.fecha_tran",
                                    "vat.nom_ape_usu",
                                    "vat.log_usu",
                                    "vat.detalle",
                                    "Transaccione.des_tip_tra",
                                    "vat.data_xml",
                                    "vat.id_tip_tra",
                                    "vat.cod_tip_tra",
                                    "vat.id_mod",
                                    "vat.id_tip_usu",
                                    "vat.des_tip_usu"
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
                    "CAST(vat.fecha_tran AS DATE) <=" => "$fec_fin",
                    "vat.id_tip_usu" => $tip_usu
                ),
                "order" => "CAST(vat.fecha_tran AS DATE) DESC"
            ); 
   
            $arr_query = $this->paginate("Transaccione");
            $auditoria = $this->SqlData->CakeArrayToObjects($arr_query);             
            
            $title = __("Listar transacciones del usuario",true);
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