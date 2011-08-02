<?php
    class MedicoInformacionPacienteController extends Controller{
        var $name = "MedicoInformacionPaciente";
        var $uses =         Array("HistorialesPaciente","CentroSalud","TiposConsulta","Animale","Tratamiento","TiempoEvolucione");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader","Cache","Event","Checkbox");                  
        
        var $group_session = "medico";                   
       
        function index($id_his,$id_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                
            $title =  __("Información del paciente",true);            
            $data = Array(                
                "title"         => $title,
                "id_his"        => $id_his ,
                "id_pac"        => $id_pac             
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);            
        }     
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar($id_pac){
            $this->cacheAction = true;
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                
            $title =  __("Historial del paciente",true);            
            $data = Array(                
                "title"         => $title,
                "id_pac"        => $id_pac               
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);                                     
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar($id_pac){    //$this->cacheAction = false;         
            //$this->Login->no_cache();
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
   
        function registrar($id_his,$id_pac){
            //$this->Login->no_cache();            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                     
            
            $centros_salud         = $this->SqlData->CakeArrayToObjects($this->CentroSalud->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                            "table"         => "centro_salud_pacientes",
                            "alias"         => "csp",
                            "conditions"    => "csp.id_his = $id_his AND csp.id_cen_sal = CentroSalud.id_cen_sal",
                            "type"          => "left",
                            "fields"        => "id_cen_sal"
                            )
                        ),
                    "fields" =>
                        Array(
                            "*",
                            "csp.id_cen_sal"                           
                        ),
                    "order"=>                        
                            "nom_cen_sal ASC"                        
                )
            ));
            $tipos_consultas       = $this->SqlData->CakeArrayToObjects($this->TiposConsulta->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                            "table"         => "tipos_consultas_pacientes",
                            "alias"         => "tcp",
                            "conditions"    => "tcp.id_his = $id_his AND tcp.id_tip_con = TiposConsulta.id_tip_con",
                            "type"          => "left",
                            "fields"        => "id_tip_con"                            
                            )
                        ),
                    "fields" =>
                        Array(
                            "*",
                            "tcp.id_tip_con"                           
                        ),
                    "order"=>
                        Array(
                            "nom_tip_con ASC"
                        )
                )
            ));
            $animales              = $this->SqlData->CakeArrayToObjects($this->Animale->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                                "table"         => "contactos_animales",
                                "alias"         => "ca",
                                "conditions"    => "ca.id_his = $id_his AND ca.id_ani = Animale.id_ani",
                                "type"          => "left",
                                "fields"        => "ca.id_ani"
                            )
                        ),
                    "fields" =>
                         Array(
                            "*",
                            "ca.id_ani"                           
                        ),
                    "order"=>                        
                            "nom_ani ASC"     
                )
            ));           
            $tratamientos           = $this->SqlData->CakeArrayToObjects($this->Tratamiento->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                                "table"         => "tratamientos_pacientes",
                                "alias"         => "tp",
                                "conditions"    => "tp.id_his = $id_his AND tp.id_tra = Tratamiento.id_tra",
                                "type"          => "left",
                                "fields"        => "tp.id_tra"
                            )
                        ),
                    "fields" =>
                         Array(
                            "*",
                            "tp.id_tra"                           
                        ),
                    "order"=>                        
                            "nom_tra ASC"     
                )
            )); 
            $tie_evo              = $this->SqlData->CakeArrayToObject($this->TiempoEvolucione->find("first",
                Array(
                    "conditions" => 
                        Array(
                            "TiempoEvolucione.id_his" => $id_his
                        )
                )
            ));  
                                                                      
            $title = __("Registro del Historial de paciente",true);                        
            
            $data = Array(                                                      
                "title"                 => $title,
                "id_his"                => $id_his,
                "centros_salud"         => $centros_salud,
                "tipos_consultas"       => $tipos_consultas,
                "animales"              => $animales,  
                "tie_evo"               => $tie_evo,              
                "tratamientos"          => $tratamientos                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
        
        /**
        * View editar usuarios administrativos
        */ 
        function consultar($id_his){                       
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            
            /*$result = $this->HistorialesPaciente->find("first", Array(
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
            $this->layout = 'default';*/
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
        * Registrando informacion adicional
        */
        function event_registrar(){   
                       
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");            
            $id_his     = $_POST["hdd_id_his"];
            $cen_sal    = $_POST["hdd_chk_cen_sal"];
            $tip_con    = $_POST["hdd_chk_tip_con"];
            $con_ani    = $_POST["hdd_chk_ani"];
            $tra_pre    = $_POST["hdd_chk_tra"]; 
            $tie_evo    = $_POST["txt_tie_evo"];
                                  
            $id_doc         = $this->Session->read("medico.id_usu");       
            
            $sql = $this->HistorialesPaciente->MedRegistrarInformacionAdicional($id_his,$cen_sal,$tip_con,$con_ani,$tra_pre,$tie_evo,$id_doc);   
                                                                         ;  
            $arr_query = ($this->HistorialesPaciente->query($sql));
             
            $result = $this->SqlData->ResultNum($arr_query);                        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"La información adicional se actualizó con éxito."));
                    break;               
                    
            }                   
            
            die;
        }
        
         /**
        * Editando paciente
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
                       
            $id_his                 = $_POST["hdd_id_his"];
            $des_his                = $_POST["txt_des_his"];
            $des_pac_his        = $_POST["txt_des_pac_his"];            
            $id_doc                 = $this->Session->read("medico.id_usu");          
                                            
            $sql = $this->HistorialesPaciente->MedModificarHistorialPaciente($id_his,$des_his,$des_pac_his,$id_doc);
                        
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
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");
            
            $sql = $this->HistorialesPaciente->MedEliminarHistorialPaciente($id_his,$id_doc);
                        
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