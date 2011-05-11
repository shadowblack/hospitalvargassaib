<?php
    class AdminController extends Controller{
        var $name = "Admin";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","Session","SqlData","FormatMessege");
        
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){ 
           $this->Login->no_cache();
           $this->Login->autenticacion_usuario($this,"/admin/login");
                
           //$mod = $this->Session->read("str_mods");
           /*
           $data = Array(
            "cua"=>$this->Login->validar_permisos($mod,"cua")
           );
           $this->set($data);  */         
        }
        /*
        function __construct(){            
           parent::__construct();
        }*/
        
        /*
        * Mostrando pagina de inicio de login
        */
        function login(){
            
        }
       
        
        /**
         * Validando usuario 
         */
        function validar_usuario(){
          
                if (!isset($_POST["log_usu"]) || !isset($_POST["pas_log"])){
                    die($this->FormatMessege->box_style(2,"Error de validación."));
                }                
                $log_usu = $_POST["log_usu"];    
                $pas_usu = ($_POST["pas_log"]);
                                                
                $arr_query = ($this->UsuariosAdministrativo->query("SELECT * FROM validar_usuarios('".$log_usu."','".$pas_usu."','adm') AS result"));                
                $usuario = $this->SqlData->array_to_object($arr_query);
                if (!empty($usuario->id_usu)){
                    //print_r($usuario);
                    
                    $this->Session->write("id_usu",$usuario->id_usu);
                    $this->Session->write("nom_usu",$usuario->nom_usu);
                    $this->Session->write("ape_usu",$usuario->ape_usu);
                    $this->Session->write("log_usu",$usuario->log_usu);
                    $this->Session->write("tel_usu",$usuario->tel_usu);
                    $this->Session->write("id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("id_tip_usu_usu",$usuario->id_tip_usu_usu);
                    $this->Session->write("cod_tip_usu",$usuario->cod_tip_usu);
                    $this->Session->write("str_mods",$usuario->str_mods);
                    $this->Session->write("str_trans",$usuario->str_trans);
                    $this->Session->write("des_tip_usu",$usuario->des_tip_usu);

                    die($this->FormatMessege->box_style(1,"Usuario verificado."));
                } else {
                    die($this->FormatMessege->box_style(2,"Por favor verifique sus datos."));    
                }                               
                die;                                             
        }
        function salir(){           
            $this->Session->destroy();
            $this->redirect("/admin/login");
        }
    }
?>