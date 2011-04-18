<?php
    class MedicoController extends Controller{
        var $name = "Medico";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","Session");
        
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            
        }
    
    }
?>