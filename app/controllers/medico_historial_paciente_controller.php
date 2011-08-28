<?php
    class MedicoHistorialPacienteController extends Controller{
        var $name = "MedicoHistorialPaciente";
        var $uses =         Array("HistorialesPaciente","Paciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader","Event","History");                  
        
        var $group_session = "medico";                   
       
        function index(){   
            
        }
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar($id_pac){              
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                
            $title =  __("Historial del paciente",true);            
            $data = Array(                
                "title"         => $title,
                "id_pac"        => $id_pac,
                "history"   =>  $this->History->GetHistory("a")               
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);                                     
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar($id_pac){             
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");      
                        
            $num_his        = $_POST["num_his"];
            $des_his        = $_POST["des_his"];
            $nom_doc        = $_POST["nom_doc"];
            //$ape_doc        = $param_array[3]; 
            
            $this->History->SetHistory("a");                                                      
                                               
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
                                    "HistorialesPaciente.id_pac"        => "$id_pac",                                    
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
                                                           
          
           
            $data = Array(                
                "results" =>$this->SqlData->CakeArrayToObjects($this->paginate("HistorialesPaciente"))
            );  
            
            
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
   
        function registrar($id_pac){
            //$this->Login->no_cache();            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                                                                                                                                 
                                                          
            $title = __("Registro del Historial de paciente",true);
            
            $data = Array(                                                      
                "title"                 => $title,
                "id_pac"                => $id_pac              
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
        
        /**
        * View editar usuarios administrativos
        */ 
        function consultar($id_his){            
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            
            $result = $this->HistorialesPaciente->find("first", Array(
                "conditions" => Array(
                    "id_his"    => $id_his
                )        
            ));                                                                                                 
            
            $title =  __("Consuta de pacientes",true);
            
            $data = Array(
                "result"    => $this->SqlData->CakeArrayToObject($result),                
                "title"     => $title                          
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
         
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id_his){
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
                                                          
            $result = ($this->SqlData->CakeArrayToObject(
                $this->HistorialesPaciente->find("first",
                    array("conditions" => Array("HistorialesPaciente.id_his = " => $id_his)))
                )
            );        
                                   
            $title =  __("Modificación de historial",true);
            
            $data = Array(
                "result"    => $result,                
                "title"     => $title,
                "id_his"    => $id_his                            
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
            $id_pac         = $_POST["id_pac"];
            $des_his        = $_POST["txt_des_his"];
            $des_pac_his    = $_POST["txt_des_pac_his"];                       
            $id_doc         = $this->Session->read("medico.id_usu");       
            $tra_usu        = "RHP";  
            $sql = $this->HistorialesPaciente->MedRegistrarHistorialPaciente($id_pac,$des_his,$des_pac_his,$id_doc,$tra_usu);   
                                                              
            $arr_query = ($this->HistorialesPaciente->query($sql));
             
            $result = $this->SqlData->ResultNum($arr_query);                        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El Historico del paciente se inserto con éxito"));
                    break;               
                    
            }                   
            
            die;
        }
        
         /**
        * Editando paciente
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
                       
            $id_his             = $_POST["hdd_id_his"];
            $des_his            = $_POST["txt_des_his"];
            $des_pac_his        = $_POST["txt_des_pac_his"];            
            $id_doc             = $this->Session->read("medico.id_usu");          
            $tra_usu            = "MHP"; 
                                           
            $sql = $this->HistorialesPaciente->MedModificarHistorialPaciente($id_his,$des_his,$des_pac_his,$id_doc,$tra_usu);
                    
            $arr_query = ($this->HistorialesPaciente->query($sql));            
                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El historial se ha modificado con éxito."));
                    break;   
            }             
                        
            die;
        }
        
         /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id_his,$num_his=""){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");
            $tra_usu        = "EHP"; 
            
            $sql = $this->HistorialesPaciente->MedEliminarHistorialPaciente($id_his,$id_doc,$tra_usu);
                         
            $arr_query = ($this->HistorialesPaciente->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El Historial se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El Historial \'$num_his\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }     
        
    }            
?>