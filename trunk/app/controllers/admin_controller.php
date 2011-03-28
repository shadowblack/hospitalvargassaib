<?php
    class AdminController extends Controller{
        var $name = "Admin";
        var $uses = Array("UsuariosAdministrativo");
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){ 
            print_r($this->UsuariosAdministrativo->query("SELECT * FROM validar_usuarios('hitokiri83','123','adm')"));die;
            //$this->redirect("/admin/login");
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