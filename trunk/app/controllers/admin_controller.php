<?php
    class AdminController extends Controller{
        var $name = "Admin";
        var $uses = Array("UsuariosAdministrativo");
        var $components = Array("Login","Session","SqlData","FormatMessege");
        var $helpers    = Array("Html","Event");
        protected $group_session = "admin";        
        
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){ 
           //$this->Login->no_cache();
           //$this->cakeError('errors404');          
           $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session);
                
           //$mod = $this->Session->read("str_mods");
           /*
           $data = Array(
            "cua"=>$this->Login->validar_permisos($mod,"cua")
           );
           $this->set($data);  */  
           
           $nomb_usu = $this->Session->read("admin.nom_usu").' '.$this->Session->read("admin.ape_usu");
           
           $data = Array(
                "nomb_usu"=> $nomb_usu
           );
           $this->set($data); 
              
        }
        
        
         /**
         * Entrando a la aplicacion administrativa
         */
        function content_iframe(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
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
                    die($this->FormatMessege->BoxStyle(2,"Error de validación."));
                }                
                $log_usu = $_POST["log_usu"];    
                $pas_usu = ($_POST["pas_log"]);
                                                
                $arr_query = ($this->UsuariosAdministrativo->query("SELECT * FROM validar_usuarios('".$log_usu."','".$pas_usu."','adm') AS result"));     
                               
                $usuario = $this->SqlData->array_to_object($arr_query);
                
                if (!empty($usuario->id_usu) && $this->UsuariosAdministrativo->getNumRows() > 0){
                    //print_r($usuario);
                    
                    $this->Session->write("admin.id_usu",$usuario->id_usu);
                    $this->Session->write("admin.nom_usu",$usuario->nom_usu);
                    $this->Session->write("admin.ape_usu",$usuario->ape_usu);
                    $this->Session->write("admin.log_usu",$usuario->log_usu);
                    $this->Session->write("admin.tel_usu",$usuario->tel_usu);
                    $this->Session->write("admin.id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("admin.id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("admin.id_tip_usu_usu",$usuario->id_tip_usu_usu);
                    $this->Session->write("admin.cod_tip_usu",$usuario->cod_tip_usu);
                    $this->Session->write("admin.str_trans",$usuario->str_trans);
                    $this->Session->write("admin.des_tip_usu",$usuario->des_tip_usu);

                    die($this->FormatMessege->BoxStyle(1,"Usuario verificado."));
                } else {
                    die($this->FormatMessege->BoxStyle(2,"Por favor verifique sus datos."));    
                }                               
                die;                                             
        }
        function salir(){           
            //$this->Session->destroy();
            $this->Session->delete("admin");
            $this->redirect("/admin/login");
        }
    }
?>