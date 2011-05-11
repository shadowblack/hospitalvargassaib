<?php
    class MedicoController extends Controller{
        var $name = "Medico";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","Session");
        
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login");
        }
        /**
         * Login de la aplicacion
         */
        function login(){
            
        }
        function content_iframe(){
            
        }
    
    }
?>