<?php
    class MedicoController extends Controller{
        var $name = "Medico";
        var $uses = Array("Doctore");
        var $components = Array("Login","Session","SqlData","FormatMessege");
        protected $group_session = "medico";
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            $this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
        }
        /**
         * Entrando a la aplicacion administrativa
         */
        function content_iframe(){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
        }
        /**
         * Login de la aplicacion
         */
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
                                                
                $arr_query = ($this->Doctore->query("SELECT * FROM validar_usuarios('".$log_usu."','".$pas_usu."','med') AS result"));                
                $usuario = $this->SqlData->array_to_object($arr_query);
                if (!empty($usuario->id_usu) && $this->Doctore->getNumRows() > 0){
                    //print_r($usuario);
                    
                    $this->Session->write("medico.id_usu",$usuario->id_usu);
                    $this->Session->write("medico.nom_usu",$usuario->nom_usu);
                    $this->Session->write("medico.ape_usu",$usuario->ape_usu);
                    $this->Session->write("medico.log_usu",$usuario->log_usu);
                    $this->Session->write("medico.tel_usu",$usuario->tel_usu);
                    $this->Session->write("medico.id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("medico.id_tip_usu",$usuario->id_tip_usu);
                    $this->Session->write("medico.id_tip_usu_usu",$usuario->id_tip_usu_usu);
                    $this->Session->write("medico.cod_tip_usu",$usuario->cod_tip_usu);
                    $this->Session->write("medico.str_mods",$usuario->str_mods);
                    $this->Session->write("medico.str_trans",$usuario->str_trans);
                    $this->Session->write("medico.des_tip_usu",$usuario->des_tip_usu);

                    die($this->FormatMessege->box_style(1,"Usuario verificado."));
                } else {
                    die($this->FormatMessege->box_style(2,"Por favor verifique sus datos."));    
                }                               
                die;                                             
        }
        function salir(){           
            //$this->Session->destroy();
            $this->Session->delete("medico");
            $this->redirect("/medico/login");
        }
    }
?>