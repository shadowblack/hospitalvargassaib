<?php
    class MedicoHistorialPacienteController extends Controller{
        var $name = "MedicoHistorialPaciente";
        var $uses =         Array("HistorialesPaciente","Paciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader");                  
        
        protected $group_session = "medico";                   
       
        function index(){   
            
        }
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar($id){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                
            $title =  __("Historial del paciente",true);            
            $data = Array(                
                "title"     => $title,
                "id"        => $id               
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);                                     
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar(){
             
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");      
                        
            $num_his        = $_POST["num_his"];
            $des_his        = $_POST["des_his"];
            $nom_doc        = $_POST["nom_doc"];
            //$ape_doc        = $param_array[3];                                                       
                                               
            $this->paginate = array(
                'limit' => 12,
                'fields' => Array(
                                    "Doctore.nom_doc",
                                    "Doctore.ape_doc",
                                    "HistorialesPaciente.*"
                ),
                "conditions" => Array(                                    
                                    "HistorialesPaciente.num_his ilike" => "%$num_his%",
                                    "HistorialesPaciente.des_his ilike" => "%$des_his%",                                   
                                    "OR" => Array(
                                        "Doctore.nom_doc ilike"         => "%$nom_doc%",
                                        "Doctore.ape_doc ilike"         => "%$nom_doc%"
                                    )  
                ),
                "order" => "HistorialesPaciente.num_his ASC",
                "joins" => array(
                    Array(
                        "table"         => "doctores",
                        "alias"         => "Doctore",
                        "conditions"    => "Doctore.id_doc = HistorialesPaciente.id_doc",
                        "fields"        => Array("Doctore.nom_doc","Doctore.ape_doc")
                    )
                )
            ); 
                                                           
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log($this->paginate("HistorialesPaciente"));
            $firephp->log($this->SqlData->CakeArrayToObject($this->paginate("HistorialesPaciente"))); 
            */   
            // die;  
           
            $data = Array(                
                "results" =>$this->SqlData->CakeArrayToObjects($this->paginate("HistorialesPaciente"))
            );  
            
            
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
   
        function registrar($id){
            //$this->Login->no_cache();            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                                                                                                                                 
                                                          
            $title = __("Registro del Historial de paciente",true);
            
            $data = Array(                                                      
                "title"             => $title,
                "id"                => $id              
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
        
        /**
        * View editar usuarios administrativos
        */ 
        function consultar($id){            
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            
            $sql = "SELECT  p.nom_pac, 
                            p.ape_pac, 
                            p.ced_pac, 
                            p.fec_nac_pac, 
                            p.nac_pac, 
                            p.tel_hab_pac, 
                            p.tel_cel_pac, 
                            p.ocu_pac,
                            p.ciu_pac, 
                            e.des_est,                             
                            m.des_mun 
                            FROM 
                            pacientes p 
                            JOIN estados e  USING(id_est) 
                            JOIN municipios m USING(id_mun) 
                            WHERE id_pac = 7 ";
                            
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                                                
            
            $title =  __("Consuta de pacientes",true);
            
            $data = Array(
                "result"    => $result,                
                "title"     => $title                          
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
         
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id){
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
                                                          
            $result = ($this->SqlData->CakeArrayToObject(
                $this->HistorialesPaciente->find("first",
                    array("conditions" => Array("HistorialesPaciente.id_his = " => $id)))
                )
            );        
                                   
            $title =  __("Modificación de historial",true);
            
            $data = Array(
                "result"    => $result,                
                "title"     => $title,
                "id"        => $id                            
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        /**
        * Registrando usuarios pacientes
        */
        function event_registrar(){   
                       
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            $id_pac         = $_POST["id"];
            $des_his        = $_POST["txt_des_his"];
            $des_pac_his    = $_POST["txt_des_pac_his"];                       
            $id_doc         = $this->Session->read("medico.id_usu");          
                                            
            $sql = "SELECT med_registrar_hitorial_paciente(ARRAY[
                '$id_pac', 
                '$des_his', 
                '$des_pac_his', 
                '$id_doc'               
            ]) AS result";
            //die($sql)           ;  
            $arr_query = ($this->HistorialesPaciente->query($sql));
             
            $result = $this->SqlData->result_num($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El Historico del paciente se inserto con éxito"));
                    break;               
                    
            }                   
            
            die;
        }
        
         /**
        * Editando paciente
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
                       
            $id_pac         = $_POST["hdd_id_pac"];
            $nom_pac        = $_POST["txt_nom_pac"];
            $ape_pac        = $_POST["txt_ape_pac"];
            $ced_pac        = $_POST["txt_ced_pac"];
            $fec_nac_pac    = $this->SqlData->date_to_postgres($_POST["txt_fec_nac_pac"]);
            $nac_pac        = $_POST["sel_nac_pac"];
            $ocu_pac        = $_POST["sel_ocu_pac"];
            $tel_pac        = $_POST["txt_tel_pac"];
            $cel_pac        = $_POST["txt_cel_pac"];
            $ciu_res_pac    = $_POST["txt_ciu_res_pac"];
            $est_pac        = $_POST["sel_est_pac"];
            $num_pac        = $_POST["sel_mun_pac"];
            $id_doc         = $this->Session->read("medico.id_usu");          
                                            
            $sql = "SELECT med_modificar_paciente(ARRAY[
                '$id_pac',
                '$nom_pac', 
                '$ape_pac', 
                '$ced_pac', 
                '$fec_nac_pac',
                '$nac_pac',
                '$tel_pac',
                '$cel_pac',
                '$ocu_pac',
                '$ciu_res_pac',
                '1',
                '$est_pac',
                '$num_pac',
                '$id_doc'
            ]) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));            
                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El paciente se a modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El paciente cédula \'$cel_pac\' no se encuentra registrado en el sistema."));                    
                    break;                          
            } 
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/                              
            die;
        }
        
         /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");
            $sql = "SELECT med_eliminar_paciente(ARRAY[
                '$id',
                '$id_doc']
            ) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El paciente se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El paciente \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }     
        
        /**
         * Retorna la ubicacion del pais, municipios, parroquias
         * $id_est: solo si se desea listar municipios identificados, se usa cuando se desea obtener la informacion registrada para 
         * poder modificarlo
         * */
        function event_ubicacion($num_cat,$id,$id_mun=""){
            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
                 
                                             
            switch($num_cat){
                // municipios
                case 3:                                     
                    $sql = "SELECT id_mun, des_mun FROM municipios WHERE id_est = $id ORDER BY des_mun ASC";
                    $arr_query = ($this->Doctore->query($sql));
                    $results = ($this->SqlData->array_to_objects($arr_query));   
                      
                break;
                
            }       
                
            $data = Array(
                "num_cat" => $num_cat,
                "results" => $results,
                "id_mun"  => $id_mun
            );  
            
            $this->set($data);  
            $this->layout = 'ajax';
        }
        
      
        
    }
?>