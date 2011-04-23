<?php
    class AdminUsuarioAdministrativoController extends Controller{
        var $name = "AdminUsuarioAdministrativo";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","SqlData","FormatMessege","Session");
       
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/admin/login");
        }
  
        /**
        * View registro de usuarios administrativos
        */
        function registrar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login");
        }         
        
        /**
        * Registrando usuarios administrativos
        */
        function event_registrar(){           
            $this->Login->autenticacion_usuario($this,"/admin/login");
            $nom_usu_adm = $_POST["nom_usu_adm"];
            $ape_usu_adm = $_POST["ape_usu_adm"];
            $pas_usu_adm = $_POST["pas_usu_adm"];
            $log_usu_adm = $_POST["log_usu_adm"];
            $tel_usu_adm = $_POST["tel_usu_adm"];           
                        
            $sql = "SELECT adm_registrar_usuario_admin(ARRAY[
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$pas_usu_adm',  
                '$log_usu_adm',
                '$tel_usu_adm' 
            ]) AS result";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se a insertado con éxito"));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu_adm\' ya se encuentra registrado en el sistema"));                    
                    break;
                    
            }                   
            
            die;
        }
        
        /**
        * View lista de usuarios administrativos
        */
        function listar(){    
            $this->Login->autenticacion_usuario($this,"/admin/login");
            $title =  __("Lista de usuarios administrativos",true);            
            $data = Array(                
                "title"     => $title                
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);            
        }  
        
        /**
        * Listando de usuarios administrativos
        */
        function event_listar($nombre = "", $apellido="", $login=""){     
            $this->Login->autenticacion_usuario($this,"/admin/login");
            $sql = "SELECT * FROM usuarios_administrativos";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
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
            $this->Login->autenticacion_usuario($this,"/admin/login");
            $sql = "SELECT * FROM usuarios_administrativos WHERE id_usu_adm=$id";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));        
                        
            $title =  __("Modificación de usuarios administrativos",true);
            
            $data = Array(
                "result"    => $result,
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
            $this->Login->autenticacion_usuario($this,"/admin/login");
            $id_usu_adm  = $_POST["id_usu_adm"];
            $nom_usu_adm = $_POST["nom_usu_adm"];
            $ape_usu_adm = $_POST["ape_usu_adm"];
            $pas_usu_adm = $_POST["pas_usu_adm"];
            $log_usu_adm = $_POST["log_usu_adm"];
            $tel_usu_adm = $_POST["tel_usu_adm"];           
                        
            $sql = "SELECT adm_modificar_usuario_admin(ARRAY[
                '$id_usu_adm',
                '$log_usu_adm',
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$pas_usu_adm',                  
                '$tel_usu_adm' 
            ]) AS result";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se a modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu_adm\' no se encuentra registrado en el sistema."));                    
                    break;  
                case 2:
                    die($this->FormatMessege->box_style($result,"Existe un usuario con el login \'$log_usu_adm\' por favor intente con otro."));                  
                    break;            
            }                               
            die;
        }
        
        /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id){
            $this->Login->autenticacion_usuario($this,"/admin/login");
                                   
            $sql = "SELECT adm_eliminar_usuario_admin(
                '$id'              
            ) AS result";
                        
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu_adm\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }        
    }
?>