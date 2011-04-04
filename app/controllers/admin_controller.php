<?php
    class AdminController extends Controller{
        var $name = "Admin";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","Session");
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){                        
           if (!$this->Session->read("id_usu"))
                $this->redirect("/admin/login");
        }
        /*
        function __construct(){            
           parent::__construct();
        }*/
       
        /**
         * Login de usuario
         */
        function login(){
            
        }
        /**
         * Validando usuario 
         */
        function val_usu(){
          
                if (!isset($_POST["log_usu"]) || !isset($_POST["pas_log"])){
                    die("{event:0,coment:'".__("Error de validación")."'}");
                }                
                $log_usu = $_POST["log_usu"];    
                $pas_usu = $_POST["pas_log"];
                                                
                $arr_query = ($this->UsuariosAdministrativo->query("SELECT * FROM validar_usuarios('hitokiri83','123','adm') AS result"));
                $row = $arr_query[0][0];
                $usuario = $this->Login->array_to_object($row);
                if (!empty($usuario->id_usu)){
                    print_r($usuario);
                    
                    $this->Session->write("id_usu",$usuario->id_usu);
                    $this->Session->write("nom_usu",$usuario->nom_usu);
                    $this->Session->write("ape_usu",$usuario->ape_usu);
                    $this->Session->write("log_usu",$usuario->log_usu);
                    $this->Session->write("tel_usu",$usuario->tel_usu);
                    $this->Session->write("id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("cod_tip_usu",$usuario->cod_tip_usu);
                    $this->Session->write("str_mods",$usuario->str_mods);
                    $this->Session->write("str_trans",$usuario->str_trans);
                    $this->Session->write("des_tip_usu",$usuario->des_tip_usu);
                    
                    die("{event:1}");
                } else {
                    die("{event:0,coment:'".__("El usuario no existe por favor intente nuevamente")."'}");
                }                               
                die;                                             
        }
        function salir(){
            $this->Session->destroy();
            $this->redirect("/admin/login");
        }
    }
?>