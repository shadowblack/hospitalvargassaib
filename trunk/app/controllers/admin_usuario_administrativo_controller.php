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
            
            $sql = "SELECT * FROM modulos m JOIN transacciones t ON (m.id_mod = t.id_mod) WHERE id_tip_usu = 1 ORDER BY m.des_mod, t.des_tip_tra";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));            
            $result = $this->SqlData->array_to_objects($arr_query);
            
            $title =  __("Agregar Administrador",true);
            
            $data = Array(               
                "title"     => $title, 
                "result"    => $result              
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
            $pas_usu_adm = md5($_POST["pas_usu_adm"]);
            $log_usu_adm = $_POST["log_usu_adm"];
            $tel_usu_adm = $_POST["tel_usu_adm"];
            $ced_usu_adm = $_POST["ced_usu_adm"];
            $cor_usu_adm = $_POST["cor_usu_adm"]; 
            $val_str_tra = $_POST["val_str_tra"];
            
            $id_usu_log     = $this->Session->read("admin.id_usu"); 
            $tra_usu        = "AUA";  
            
            //$id_tip_usu_usu = $this->Session->read("admin.id_tip_usu_usu");          
                        
            $sql = "SELECT adm_registrar_usuario_admin(ARRAY[
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$pas_usu_adm',  
                '$log_usu_adm',
                '$tel_usu_adm', 
                '$ced_usu_adm',
                '$cor_usu_adm',
                '$val_str_tra',
                
                '$id_usu_log',
                '$tra_usu'
                
            ]) AS result";
            
            //die($sql);
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El usuario se ha insertado con éxito"));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu_adm\' ya se encuentra registrado en el sistema"));                    
                    break;
                case 2:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a con la cédula \'$ced_usu_adm\' ya se encuentra registrado en el sistema."));                    
                    break;
            }
            die;
        }
        
        /**
        * View lista de usuarios administrativos
        */
        function listar(){    
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            $title =  __("Listar Administradores",true);            
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
            
            $isUsuAdminPri = $this->Session->read("admin.adm_usu");
            $id_usu_log = $this->Session->read("admin.id_usu");
            
            $isPermitedModAdmin = $this->Login->isPermittedBoolean("MUA",$this->Session->read("admin.str_trans"));
            $isPermitedEliAdmin  = $this->Login->isPermittedBoolean("EUA",$this->Session->read("admin.str_trans"));
            $isPermitedResAdmin  = $this->Login->isPermittedBoolean("RCA",$this->Session->read("admin.str_trans"));
            
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
                "results"             => $this->SqlData->CakeArrayToObjects($this->paginate("UsuariosAdministrativo")),
                "isPermitedModAdmin"  => $isPermitedModAdmin,
                "isPermitedEliAdmin"  => $isPermitedEliAdmin,
                "isPermitedResAdmin"  => $isPermitedResAdmin,
                "isUsuAdminPri"       => $isUsuAdminPri,
                "id_usu_log"          => $id_usu_log
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
            
            $isUsuAdminPri = $this->Session->read("admin.adm_usu");
            $id_usu_log = $this->Session->read("admin.id_usu");
            
            $sql = "SELECT * FROM usuarios_administrativos WHERE id_usu_adm=$id";
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));
            
            $sql = "
                SELECT m.id_mod,m.cod_mod,m.des_mod,t.id_tip_tra,t.cod_tip_tra,t.des_tip_tra,tuu.id_tip_usu_usu
                    FROM modulos m 
                    JOIN transacciones t ON (m.id_mod = t.id_mod) 
                LEFT JOIN
                (
                    SELECT tuu.id_tip_usu_usu, tu.id_tip_tra 
                    FROM transacciones_usuarios tu 
                        JOIN tipos_usuarios__usuarios tuu ON (tuu.id_tip_usu_usu = tu.id_tip_usu_usu )
                    WHERE tuu.id_usu_adm = $id AND tuu.id_tip_usu = 1
                ) tuu
                ON (t.id_tip_tra = tuu.id_tip_tra) 
                WHERE  m.id_tip_usu = 1 
                ORDER BY m.des_mod              
            ";
            //die($sql);
            $arr_query = ($this->UsuariosAdministrativo->query($sql));            
            $result_tran = $this->SqlData->array_to_objects($arr_query);  
                    
                        
            $title =  __("Modificar administrador",true);
            
            $data = Array(
                "isUsuAdminPri"     => $isUsuAdminPri,
                "result"            => $result,
                "result_tran"       => $result_tran,
                "title"             => $title,
                "id"                => $id,
                "id_usu_log"        => $id_usu_log
                
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
            $ced_usu_adm    = $_POST["ced_usu_adm"];
            $log_usu_adm    = $_POST["log_usu_adm"];
            $tel_usu_adm    = $_POST["tel_usu_adm"];
            $cor_usu_adm    = $_POST["cor_usu_adm"];
            $val_str_tra    = $_POST["val_str_tra"];  
            
                     
            $id_usu_log     = $this->Session->read("admin.id_usu"); 
            $tra_usu        = "MUA";  
               
            $sql = "SELECT adm_modificar_usuario_admin(ARRAY[
                '$id_usu_adm',
                '$log_usu_adm',
                '$nom_usu_adm', 
                '$ape_usu_adm', 
                '$ced_usu_adm',                
                '$tel_usu_adm',
                '$cor_usu_adm',
                '$val_str_tra',
                
                '$id_usu_log',
                '$tra_usu'
            ]) AS result";
            
           // die($sql);
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El usuario se ha modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu_adm\' no se encuentra registrado en el sistema."));                    
                    break;  
                case 2:
                    die($this->FormatMessege->BoxStyle($result,"Existe un usuario con el login \'$log_usu_adm\' por favor intente con otro."));                  
                    break; 
                case 3:
                    die($this->FormatMessege->BoxStyle($result,"Existe un usuario con la cédula \'$ced_usu_adm\' por favor intente con otro."));                  
                    break;           
            }                               
            die;
        }
        
        /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
                
            $id_usu_log     = $this->Session->read("admin.id_usu"); 
            $tra_usu        = "EUA";  
               
             
            $sql = "SELECT adm_eliminar_usuario_admin(ARRAY[
                            '$id',
                            '$id_usu_log',
                            '$tra_usu'                                
                    ]) AS result";
                        
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
         
         
         
         /**
         * Restablecer contraseña del usuario administrativo
         */
         
         function event_restablecer($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
               
            $new_pas = md5("Admin123456");
            $tra_usu = "RCA";
            
             $sql = "SELECT adm_restablecer_contrasena_admin(ARRAY[
                        '$id',
                        '$new_pas',
                        '$tra_usu'                                 
                    ]) AS result";
                        
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"La contraseña del usuario administrador se restableció con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El usuario/a \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }        
    }
?>