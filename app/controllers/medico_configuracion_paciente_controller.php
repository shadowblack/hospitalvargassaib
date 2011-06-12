<?php
    class MedicoConfiguracionPacienteController extends Controller{
        var $name = "MedicoConfiguracionPaciente";
        var $uses =         Array("Doctore");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","DateFormat");   
        protected $group_session = "medico";                   
       
        function index(){   
            
        }
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                
            $title =  __("Configuración de Pacientes",true);            
            $data = Array(                
                "title"     => $title                
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);                                     
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar($str){
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            $param_array = explode(",",$str);
            
            $nombre     = $param_array[0];
            $apellido   = $param_array[1];
            $cedula     = $param_array[2];            
                                    
            $sql = "SELECT * FROM pacientes
                    WHERE nom_pac ilike('%$nombre%') 
                    AND ape_pac ilike('%$apellido%')
                    AND ced_pac ilike('%$cedula%') ORDER BY nom_pac ASC";
            $arr_query = ($this->Doctore->query($sql));
            $results = ($this->SqlData->array_to_objects($arr_query));        
            
            $data = Array(
                "results" => $results
            );  
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
   
        function registrar(){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
                                                                                                               
            $sql = "SELECT id_est,des_est,id_pai FROM estados WHERE id_pai = 1 ORDER BY des_est ASC";
            $arr_query = ($this->Doctore->query($sql));
            $estados = ($this->SqlData->array_to_objects($arr_query));        
                                                          
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "estados"           => $estados,                                         
                "title"             => $title                
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
            
            $sql = "SELECT id_est,des_est,id_pai FROM estados WHERE id_pai = 1 ORDER BY des_est ASC";
            $arr_query = ($this->Doctore->query($sql));
            $estados = ($this->SqlData->array_to_objects($arr_query));  
            
            $sql = "SELECT * FROM pacientes WHERE id_pac=$id";
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));        
                        
            $title =  __("Modificación de pacientes",true);
            
            $data = Array(
                "result"    => $result,
                "estados"   => $estados,
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
                                            
            $sql = "SELECT med_registrar_paciente(ARRAY[
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
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El paciente se a insertado con éxito"));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"Existe un paciente con la cédula \'$ced_pac\'"));                    
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