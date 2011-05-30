<?php
    class MedicoConfiguracionPacienteController extends Controller{
        var $name = "MedicoConfiguracionPaciente";
        var $uses = Array("Doctore");
        var $components = Array("Login","SqlData","FormatMessege","Session");    
        protected $group_session = "medico";                   
       
        function index(){   
            
        }
   
        function registrar(){   
             $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                                                                                                    
            $sql = "SELECT id_est,des_est,id_pai FROM estados WHERE id_pai = 1";
            $arr_query = ($this->Doctore->query($sql));
            $estados = ($this->SqlData->array_to_objects($arr_query));        
            
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "estados"    => $estados,
                "title"     => $title                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
    }
?>