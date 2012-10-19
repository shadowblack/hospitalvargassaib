<?php

     class AdminCambiarContrasenaController extends Controller{
        var $name = "AdminCambiarContrasena";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","SqlData","FormatMessege","Session");
        var $helpers    = Array("Paginator","Loader","Event");
       protected $group_session = "admin";
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
        }
        
               
        /**
        * View modificar contraseña de usuarios administrativos
        */
        function modificar(){
           $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
           $this->Login->no_cache();
            
            $title =  __("Cambiar Contraseña",true);
            
            $data = Array(               
                "title"     => $title             
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';  
        }
        
        /**
        * cambiando la contraseña del usuario administrador
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_usu_adm     = $this->Session->read("admin.id_usu");;
            $pas_old_usu    = md5($_POST["pas_old_usu"]);
            $pas_new_usu    = md5($_POST["pas_new_usu"]);
            
                        
            $sql = "SELECT adm_cambiar_contrasena_admin(ARRAY[
                        '$id_usu_adm',
                        '$pas_old_usu',
                        '$pas_new_usu'
                    ]) AS result";
            
           // die ($sql);
            $arr_query = ($this->UsuariosAdministrativo->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);            
            //die ($result);         
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"El cambio de contraseña se ha realizado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"La contraseña anterior no coincide con la actual."));                    
                    break; 
            }                               
            die;
        }
    }
?>