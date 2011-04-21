<?php
    class AdminUsuarioAdministrativoController extends Controller{
        var $name = "AdminUsuarioAdministrativo";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","SqlData","FormatMessege");
       
       
        function index(){   
            
        }
  
        /**
        * Registro de usuarios administrativos
        */
        function registrar(){            
            
        }         
        
        /**
        * Registrando usuarios administrativos
        */
        function event_registrar(){
            
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
        * Lista de usuarios administrativos
        */
        function listar(){            
            
        }  
    }
?>