<?php
    class AdminController extends Controller{
        var $name = "Admin";
        var $uses = Array();
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){            
            $this->redirect("/admin/login");
        }
        /**
         * Login de usuario
         */
        function login(){
            
        }
        /**
         * Validando usuario 
         */
        function val_usu(){
           $pas_usu = $_POST["pas_log"];
           $log_usu = $_POST["txt_log"];
           
        }
    }
?>