<?php
    class MedicoInformacionPacienteController extends Controller{
        var $name = "MedicoInformacionPaciente";
        var $uses =         Array("HistorialesPaciente","CentroSalud","TiposConsulta","Animale","Tratamiento","TiempoEvolucione","CentroSaludPaciente");
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
            
            $centros_salud         = $this->SqlData->CakeArrayToObjects($this->CentroSalud->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                            "table"         => "centro_salud_pacientes",
                            "alias"         => "csp",
                            "conditions"    => "csp.id_cen_sal = CentroSalud.id_cen_sal",
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
                            "nom_cen_sal ASC",
                    "conditions" => "csp.id_his = $id_his"                      
                )
            ));
            $tipos_consultas       = $this->SqlData->CakeArrayToObjects($this->TiposConsulta->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                            "table"         => "tipos_consultas_pacientes",
                            "alias"         => "tcp",
                            "conditions"    => "tcp.id_tip_con = TiposConsulta.id_tip_con",
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
                        ),
                    "conditions" => "tcp.id_his = $id_his"
                )
            ));
            $animales              = $this->SqlData->CakeArrayToObjects($this->Animale->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                                "table"         => "contactos_animales",
                                "alias"         => "ca",
                                "conditions"    => "ca.id_ani = Animale.id_ani",
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
                            "nom_ani ASC",
                    "conditions" => "ca.id_his = $id_his"     
                )
            ));           
            $tratamientos           = $this->SqlData->CakeArrayToObjects($this->Tratamiento->find("all",
                Array(
                    "joins" =>
                        Array(
                            Array(
                                "table"         => "tratamientos_pacientes",
                                "alias"         => "tp",
                                "conditions"    => "tp.id_tra = Tratamiento.id_tra",
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
                            "nom_tra ASC",
                    "conditions" => "tp.id_his = $id_his"     
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
               
        function event_registrar(){   
                       
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");            
            $id_his     = $_POST["hdd_id_his"];
            $cen_sal    = $_POST["hdd_chk_cen_sal"];
            $tip_con    = $_POST["hdd_chk_tip_con"];
            $con_ani    = $_POST["hdd_chk_ani"];
            $tra_pre    = $_POST["hdd_chk_tra"]; 
            $tie_evo    = $_POST["txt_tie_evo"];
                                  
            $id_doc     = $this->Session->read("medico.id_usu");       
            $tra_usu    = 'IAP';
            $sql = $this->HistorialesPaciente->MedRegistrarInformacionAdicional($id_his,$cen_sal,$tip_con,$con_ani,$tra_pre,$tie_evo,$id_doc,$tra_usu);   
           
            $arr_query = ($this->HistorialesPaciente->query($sql));
             
            $result = $this->SqlData->ResultNum($arr_query);                        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"La información adicional se actualizó con éxito."));
                    break;               
                    
            }                   
            
            die;
        }                       
    }
?>