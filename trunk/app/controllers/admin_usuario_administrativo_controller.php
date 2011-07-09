<?php
    class AdminUsuarioAdministrativoController extends Controller{
        var $name = "AdminUsuarioAdministrativo";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","SqlData","FormatMessege","Session");
        var $helpers    = Array("Paginator","Loader","Event");
       protected $group_session = "admin";
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
        }
  
        /**
        * View registro de usuarios administrativos
        */
        function registrar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            $title =  __("Agregar usuarios administrativos",true);
            
            $data = Array(               
                "title"     => $title,               
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);    
        }         
        
        /**
        * Registrando usuarios administrativos
        */
        function event_registrar(){           
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $nom_usu_adm = $_POST["nom_usu_adm"];
            $ape_usu_adm = $_POST["ape_usu_adm"];
            $pas_usu_adm = $_POST["pas_usu_adm"];
            $log_usu_adm = $_POST["log_usu_adm"];
            $tel_usu_adm = $_POST["tel_usu_adm"]; 
            $id_tip_usu_usu = $this->Session->read("admin.id_tip_usu_usu");          
                        
            $sql = "SELECT adm_registrar_usuario_admin(ARRAY[
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$pas_usu_adm',  
                '$log_usu_adm',
                '$tel_usu_adm',                
                '$id_tip_usu_usu'
            ]) AS result";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El usuario se a insertado con éxito"));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu_adm\' ya se encuentra registrado en el sistema"));                    
                    break;
                    
            }                   
            
            die;
        }
        
        /**
        * View lista de usuarios administrativos
        */
        function listar(){    
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
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
        function event_listar($str){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            $param_array = explode(",",$str);
            
            $nombre     = $param_array[0];
            $apellido   = $param_array[1];
            $login      = $param_array[2];            
                                    
            $sql = "SELECT * FROM usuarios_administrativos
                    WHERE nom_usu_adm ilike('%$nombre%') 
                    AND ape_usu_adm ilike('%$apellido%')
                    AND log_usu_adm ilike('%$login%') ORDER BY nom_usu_adm ASC";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));                   
            
            $this->paginate = Array(
                "conditions" => Array(
                    "UsuariosAdministrativo.ape_usu_adm ilike" => "%$apellido%",
                    "UsuariosAdministrativo.log_usu_adm ilike" => "%$login%",
                    "UsuariosAdministrativo.nom_usu_adm ilike" => "%$nombre%"
                ),
                "order" => "UsuariosAdministrativo.nom_usu_adm",
                "limit" => 12
                
            );
            
            $data = Array(
                "results" => $this->SqlData->CakeArrayToObjects($this->paginate("UsuariosAdministrativo"))
            );  
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
        
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
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
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_usu_adm     = $_POST["id_usu_adm"];
            $nom_usu_adm    = $_POST["nom_usu_adm"];
            $ape_usu_adm    = $_POST["ape_usu_adm"];
            $pas_usu_adm    = $_POST["pas_usu_adm"];
            $log_usu_adm    = $_POST["log_usu_adm"];
            $tel_usu_adm    = $_POST["tel_usu_adm"];  
            $id_tip_usu_usu = $this->Session->read("id_tip_usu_usu");
                        
            $sql = "SELECT adm_modificar_usuario_admin(ARRAY[
                '$id_usu_adm',
                '$log_usu_adm',
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$pas_usu_adm',                  
                '$tel_usu_adm',
                '$id_tip_usu_usu'
            ]) AS result";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El usuario se a modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu_adm\' no se encuentra registrado en el sistema."));                    
                    break;  
                case 2:
                    die($this->FormatMessege->BoxStyle($result,"Existe un usuario con el login \'$log_usu_adm\' por favor intente con otro."));                  
                    break;            
            }                               
            die;
        }
        
        /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
                                   
            $sql = "SELECT adm_eliminar_usuario_admin(
                '$id'              
            ) AS result";
                        
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El usuario se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }        
    }
?>