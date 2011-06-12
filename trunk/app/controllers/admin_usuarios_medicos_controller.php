<?php
    class AdminUsuariosMedicosController extends Controller{
        var $name = "AdminUsuariosMedicos";
        var $uses = Array("Doctore");
        var $components = Array("Login","SqlData","FormatMessege","Session");
        protected $group_session = "admin";
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
        }
  
        /**
        * View registro de usuarios administrativos
        */
        function registrar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
                        
            $sql = "SELECT * FROM modulos m JOIN transacciones t ON (m.id_mod = t.id_mod)";
            $arr_query = ($this->Doctore->query($sql));            
            $result = $this->SqlData->array_to_objects($arr_query);
            $title =  __("Agregar usuarios médicos",true);
            
            $data = Array(               
                "title"     => $title,
                "result"    => $result,               
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);    
        }         
        
        /**
        * Registrando usuarios administrativos
        */
        function event_registrar(){           
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $nom_usu_doc = $_POST["nom_usu_doc"];
            $ape_usu_doc = $_POST["ape_usu_doc"];
            $ced_usu_doc     = $_POST["ced_usu_doc"];
            $pas_usu_doc = $_POST["pas_usu_doc"];
            $log_usu_doc = $_POST["log_usu_doc"];
            $tel_usu_doc = $_POST["tel_usu_doc"];
            $trans_usu   = $_POST["val_str_tra"];           
                        
            $sql = "SELECT adm_registrar_medico(ARRAY[
                '$nom_usu_doc', 
                '$ape_usu_doc',
                '$ced_usu_doc', 
                '$pas_usu_doc',  
                '$log_usu_doc',
                '$tel_usu_doc',
                '$trans_usu'
            ]) AS result";
            //die($sql);
            $arr_query = ($this->Doctore->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se a insertado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu_doc\' ya se encuentra registrado en el sistema."));                    
                    break;
                case 2:
                     die($this->FormatMessege->box_style($result,"El usuario/a con la cédula \'$ced_usu_doc\' ya se encuentra registrado en el sistema."));                    
                    break;
            }                   
            
            die;
        }
        
        /**
        * View lista de usuarios administrativos
        */
        function listar(){    
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");            
            $title =  __("Lista de usuarios médicos",true);            
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
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            
            $param_array = explode(",",$str);
            
            $nombre     = $param_array[0];
            $apellido   = $param_array[1];
            $login      = $param_array[2];                                                
            
            $sql = "SELECT * FROM doctores
                    WHERE nom_doc ilike('%$nombre%') 
                    AND ape_doc ilike('%$apellido%')
                    AND log_doc ilike('%$login%') ORDER BY nom_doc ASC";
            $arr_query = ($this->Doctore->query($sql));
            $results = ($this->SqlData->array_to_objects($arr_query));        
            
            $data = Array(
                "results" => $results
            );  
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
        
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            $this->Login->no_cache();
            $sql = "SELECT * FROM doctores WHERE id_doc=$id";
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));
            
            $sql = "
                SELECT m.id_mod,m.cod_mod,m.des_mod,t.id_tip_tra,t.cod_tip_tra,t.des_tip_tra,tuu.id_tip_usu_usu
                    FROM modulos m JOIN
                    transacciones t ON (m.id_mod = t.id_mod) 
                LEFT JOIN
                (
                    SELECT tuu.id_tip_usu_usu, tu.id_tip_tra FROM transacciones_usuarios tu 
                    JOIN tipos_usuarios__usuarios tuu ON (tuu.id_tip_usu_usu = tu.id_tip_usu_usu )
                    WHERE tuu.id_doc = $id
                ) tuu
                ON (t.id_tip_tra = tuu.id_tip_tra)                
            ";
            //die($sql);
            $arr_query = ($this->Doctore->query($sql));            
            $result_tran = $this->SqlData->array_to_objects($arr_query);          
                        
            $title =  __("Modificación de usuarios médicos",true);
            
            $data = Array(
                "result"    => $result,
                "result_tran"    => $result_tran,
                "title"     => $title,
                "id"        => $id
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        /**
        * Editando usuarios administrativos
        */ 
        function event_modificar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_doc  = $_POST["id_doc"];
            $nom_doc = $_POST["nom_doc"];
            $ced_doc = $_POST["ced_usu_doc"];
            $ape_doc = $_POST["ape_doc"];           
            $pas_doc = $_POST["pas_doc"];
            $log_doc = $_POST["log_doc"];
            $tel_doc = $_POST["tel_doc"];           
            $val_str_tra = $_POST["val_str_tra"];
            $sql = "SELECT adm_modificar_medico(ARRAY[
                '$id_doc',
                '$log_doc',
                '$ced_doc',
                '$nom_doc', 
                '$ape_doc', 
                '$pas_doc',                  
                '$tel_doc',
                '$val_str_tra'
            ]) AS result";
           // die($sql);
            $arr_query = ($this->Doctore->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se a modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_doc\' no se encuentra registrado en el sistema."));                    
                    break;  
                case 2:
                    die($this->FormatMessege->box_style($result,"Existe un usuario con el login \'$log_doc\' por favor intente con otro."));                  
                    break;
                case 3:
                    die($this->FormatMessege->box_style($result,"Existe un usuario con la cédula \'$ced_doc\' por favor intente con otro."));                  
                    break;              
            }                               
            die;
        }
        
        /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
                                   
            $sql = "SELECT adm_eliminar_medico(
                '{\"$id\"}'              
            ) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 2:
                    die($this->FormatMessege->box_style($result,"No se puede eliminar este doctor porque tiene pacientes asociados."));
                    break;
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }        
    }
?>