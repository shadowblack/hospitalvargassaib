<?php

     class MedicoCambiarContrasenaController extends Controller{
        var $name = "MedicoCambiarContrasena";
        var $uses = Array("doctores");
        var $components = Array("Login","SqlData","FormatMessege","Session");
        var $helpers    = Array("Paginator","Loader","Event");
       protected $group_session = "medico";
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
        }
        
               
        /**
        * View modificar contraseña de usuarios operadores
        */
        function modificar(){
           $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
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
        * cambiando la contraseña del usuario operador
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");;
            $pas_old_usu    = md5($_POST["pas_old_usu"]);
            $pas_new_usu    = md5($_POST["pas_new_usu"]);
            
                        
            $sql = "SELECT med_cambiar_contrasena_ope(ARRAY[
                        '$id_doc',
                        '$pas_old_usu',
                        '$pas_new_usu'
                    ]) AS result";
            
           // die ($sql);
            $arr_query = ($this->doctores->query($sql));
                             
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