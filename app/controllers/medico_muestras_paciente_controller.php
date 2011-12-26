<?php
    class MedicoMuestrasPacienteController extends Controller{
        var $name = "MedicoMuestrasPaciente";
        var $uses =         Array("HistorialesPaciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader","Cache","Event","Checkbox","Otros");                  
        
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
            
            $muestras_clinicas         = $this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                "SELECT mc.nom_mue_cli,mc.id_mue_cli as mc_id_mue_cli,mp.id_mue_cli as mp_id_mue_cli,mp.otr_mue_cli
                FROM muestras_clinicas mc 
                LEFT JOIN muestras_pacientes mp ON (mc.id_mue_cli = mp.id_mue_cli AND mp.id_his=$id_his)"
            ));
                          
                                                                                  
            $title = __("Registro del Historial de paciente",true);                        
            
            $data = Array(                        
                "muestras_clinicas"       => $muestras_clinicas,                              
                "title"                 => $title,
                "id_his"                => $id_his                         
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
            
            $muestras_clinicas         = $this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                "SELECT mc.nom_mue_cli,mp.otr_mue_cli
                FROM muestras_clinicas mc 
                JOIN muestras_pacientes mp ON (mc.id_mue_cli = mp.id_mue_cli)
                WHERE mp.id_his = $id_his"
            ));
                                                                                                            
            $title = __("Registro del Muestras clinicas",true);                        
            
            $data = Array(                        
                "muestras_clinicas"       => $muestras_clinicas,                              
                "title"                 => $title,
                "id_his"                => $id_his                         
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';            
           
        }
               
        function event_registrar(){   
                       
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");            
            $id_his     = $_POST["hdd_id_his"];
            $mue_cli    = $_POST["hdd_chk_mue_cli"];    
            
            if (isset($_POST["txt_otr_mue_cli"])){
                $txt_otr_mue_cli        = $_POST["txt_otr_mue_cli"];
                $id_hdd_otr_mue_cli     = $_POST["hdd_txt_otr_mue_cli"];
            } else {
                $txt_otr_mue_cli        = "";
                $id_hdd_otr_mue_cli     = -1;
            }
                    
                                  
            $id_doc         = $this->Session->read("medico.id_usu");       
            $tra_usu        = "MCP";  
            $sql = $this->HistorialesPaciente->MedMuestraClinicaPaciente(
                        $id_his,
                        $mue_cli,
                        $id_hdd_otr_mue_cli,
                        $txt_otr_mue_cli,
                        $id_doc,
                        $tra_usu
            );   
                                                                          
            $arr_query = ($this->HistorialesPaciente->query($sql));
             
            $result = $this->SqlData->ResultNum($arr_query);                        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"Las muestras clinicas se actualizaron correctamente."));
                    break;               
                    
            }                   
            
            die;
        }                       
    }
?>