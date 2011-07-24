<?php
    class MedicoWindowsController extends Controller{
        var $name =         "MedicoWindows";
        var $uses =         Array("HistorialesPaciente","Paciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","FormatString");                  
        
        protected $group_session = "medico";                   
       
        function index(){   
            
        }
        
        function medico_informacion_paciente($id_his,$id_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            
            $result = $this->HistorialesPaciente->find("first",
                Array(
                    "fields" => Array(
                        "Paciente.nom_pac",
                        "Paciente.ape_pac",
                        "HistorialesPaciente.id_his"
                    ),
                    "conditions" => Array(
                        "id_his" => $id_his
                     ),
                     "joins"=>Array(
                        Array(                            
                            "table"         =>  "pacientes",
                            "alias"         =>  "Paciente",
                            "conditions"    =>  Array(
                                "Paciente.id_pac = HistorialesPaciente.id_pac"
                            )  
                        )                                         
                     )                    
                )
            );   
           // echo debug($result);         
            $title = __("Información del paciente",true);
             $data = Array(
                "title"         => $title,
                "id_his"        => $id_his,
                "id_pac"        => $id_pac,
                "result"      => $this->SqlData->CakeArrayToObject($result)            
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);  
        }     
        
    }
             
?>