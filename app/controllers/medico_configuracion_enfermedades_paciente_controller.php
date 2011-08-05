<?php
    class MedicoConfiguracionEnfermedadesPacienteController extends Controller{
        var $name = "MedicoConfiguracionEnfermedadesPaciente";
        var $uses =         Array("Doctore","Paciente","AntecedentesPersonale","AntecedentesPaciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader","Event","History","Checkbox");                  
        
        var $group_session = "medico";                   
       
        function index(){   
            
        }
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar($id_his,$id_pac){                    
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
                 
            $title =  __("Enfermedades del paciente",true);            
            $data = Array(
                "id_his"    => $id_his,
                "id_pac"    => $id_pac,                
                "title"     => $title,
                "history"   =>  $this->History->GetHistory("a",true)              
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);
            $this->layout = "window";
                                           
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar(){           
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");  
                      
            
            $nombre     = $_POST["nom_pac"];
            $apellido   = $_POST["ape_pac"];
            $cedula     = $_POST["ced_pac"];                                                    
                         
            $this->History->SetHistory("a");
           //echo $this->History->GetHistoryData("a","ced_pac");             
            $this->paginate = array(
                'limit' => 12,
                /*'fields' => Array(
                                    "Paciente.id_pac",
                                    "Paciente.nom_pac",                                    
                                    "Paciente.prueba"
                ),*/
                "conditions" => Array(
                                    "Paciente.nom_pac ilike" => "%$nombre%",
                                    "Paciente.ape_pac ilike" =>  "%$apellido%",
                                    "Paciente.ced_pac ilike" => "%$cedula%"
                ),
                "order" => "Paciente.nom_pac ASC"
            ); 
                                                           
            
            
            $data = Array(                
                "results" =>$this->SqlData->CakeArrayToObjects($this->paginate("Paciente"))
            );  
            
            
            $this->set($data);  
            $this->layout = 'ajax';
          //    $this->cacheAction = true;   
        } 
   
        function registrar($id_his){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
                                                                                                               
            $sql = "SELECT id_tip_mic, nom_tip_mic FROM tipos_micosis";
            $arr_query = ($this->Doctore->query($sql));
            $tipos_micosis = ($this->SqlData->array_to_objects($arr_query));                          
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "id_his"            =>  $id_his,
                "tipos_micosis"     =>  $tipos_micosis,                                         
                "title"             =>  $title                                
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
                            WHERE id_pac = $id ";
                            
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
            
            $sql = "SELECT id_est,des_est,id_pai FROM estados WHERE id_pai = 1 ORDER BY des_est ASC";
            $arr_query = ($this->Doctore->query($sql));
            $estados = ($this->SqlData->array_to_objects($arr_query));  
            
            $sql = "SELECT * FROM pacientes WHERE id_pac=$id";
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));            
            
            
            $ante_pers   = $this->SqlData->CakeArrayToObjects($this->AntecedentesPersonale->find("all",Array(
                "fields"=>Array(
                                "AntecedentesPaciente.id_ant_per",
                                "AntecedentesPersonale.*"
                ),
                "joins"=>
                    Array(
                        Array(
                            "fields"        => Array("AntecedentesPaciente.id_ant_per"),                       
                            "table"=>"antecedentes_pacientes",
                            "alias"=>"AntecedentesPaciente",
                            "conditions"=>Array("AntecedentesPaciente.id_ant_per = AntecedentesPersonale.id_ant_per AND AntecedentesPaciente.id_pac=$id"),
                            "type"=>"left"
                        )
                    )
                
            ))
            );               
               
                  
            $title =  __("Modificación de pacientes",true);
            
            $data = Array(
                "result"    => $result,
                "estados"   => $estados,
                "ante_pers"  => $ante_pers,
                "title"     => $title                            
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
            $hdd_chk_ant_per= $_POST["hdd_chk_ant_per"];
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
                '$hdd_chk_ant_per',
                '$id_doc'
            ]) AS result";
            $arr_query = ($this->Doctore->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El paciente se a insertado con éxito"));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"Existe un paciente con la cédula \'$ced_pac\'"));                    
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
            $hdd_chk_ant_per= $_POST["hdd_chk_ant_per"];
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
                '$hdd_chk_ant_per',
                '$id_doc'
            ]) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));            
                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El paciente se a modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El paciente cédula \'$cel_pac\' no se encuentra registrado en el sistema."));                    
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
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");
            $sql = "SELECT med_eliminar_paciente(ARRAY[
                '$id',
                '$id_doc']
            ) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El paciente se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El paciente \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }  
         
         function event_enfermedades($id_tip_mic){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");    
                    
            $sql_enf = "SELECT id_enf_mic,nom_enf_mic 
                    FROM enfermedades_micologicas 
                    WHERE id_tip_mic = $id_tip_mic";
                    
            $sql_enf = "SELECT id_enf_mic,nom_enf_mic 
                    FROM enfermedades_micologicas 
                    WHERE id_tip_mic = $id_tip_mic";
                                            
            $enf_mic = ($this->SqlData->array_to_objects($this->Doctore->query($sql_enf)));                                         
            
            $title = __("Enfermedades Micologicas",true);
            
            $data = Array(                
                "enf_mic"     =>  $enf_mic,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';        
                                   
         }              
    }
?>