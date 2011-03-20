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
    }
?>