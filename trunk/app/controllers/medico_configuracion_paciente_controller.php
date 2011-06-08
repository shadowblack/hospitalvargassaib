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
            
            $sql = "SELECT id_cen_sal, nom_cen_sal FROM centro_salud ORDER BY nom_cen_sal ASC";
            $arr_query = ($this->Doctore->query($sql));
            $cen_sal = ($this->SqlData->array_to_objects($arr_query));
            
            $sql = "SELECT id_ani, nom_ani FROM animales ORDER BY nom_ani ASC";
            $arr_query = ($this->Doctore->query($sql));
            $animales = ($this->SqlData->array_to_objects($arr_query));                        
            
            
            $sql = "SELECT id_ant_per, nom_ant FROM antecedentes_personales ORDER BY nom_ant ASC";
            $arr_query = ($this->Doctore->query($sql));
            $antecedentes = ($this->SqlData->array_to_objects($arr_query));        
            
            $sql = "SELECT id_tra, nom_tra FROM tratamientos ORDER BY nom_tra ASC";
            $arr_query = ($this->Doctore->query($sql));
            $tratamientos = ($this->SqlData->array_to_objects($arr_query));
            
            $sql = "SELECT id_mue_cli, nom_mue_cli FROM muestras_clinicas ORDER BY nom_mue_cli ASC";
            $arr_query = ($this->Doctore->query($sql));
            $muestras = ($this->SqlData->array_to_objects($arr_query));
            
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "estados"           => $estados,
                "centro"            => $cen_sal,  
                "animal"            => $animales,
                "tratamiento"       => $tratamientos,
                "muestra"           => $muestras,                
                "antecedente"       =>$antecedentes,                
                "title"             => $title                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
    }
?>