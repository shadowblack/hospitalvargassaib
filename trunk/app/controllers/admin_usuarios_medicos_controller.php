<?php
    class AdminUsuariosMedicosController extends Controller{
        var $name = "AdminUsuariosMedicos";
        var $uses = Array("Doctore");
        var $components = Array("Login","SqlData","FormatMessege","Session");
        var $helpers    = Array("Paginator","FormatString","Loader");
        protected $group_session = "admin";
       
        function index(){   
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
        }
  
        /**
        * View registro de usuarios administrativos
        */
        function registrar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
                        
            $sql = "SELECT * FROM modulos m JOIN transacciones t ON (m.id_mod = t.id_mod)";
            $arr_query = ($this->Doctore->query($sql));            
            $result = $this->SqlData->array_to_objects($arr_query);
            
            $sql = "SELECT id_cen_sal,nom_cen_sal,des_cen_sal FROM centro_salud ORDER BY nom_cen_sal,des_cen_sal ASC";
            $arr_query = ($this->Doctore->query($sql));
            $centros_salud = ($this->SqlData->array_to_objects($arr_query));       
            
            $title =  __("Agregar usuarios médicos",true);
            
            $data = Array(               
                "title"         => $title,
                "result"        => $result,
                "centros_salud" => $centros_salud              
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title); 
            //$this->layout = 'default';   
        }         
        
        /**
        * Registrando usuarios administrativos
        */
        function event_registrar(){           
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $nom_usu_doc = $_POST["nom_usu_doc"];
            $ape_usu_doc = $_POST["ape_usu_doc"];
            $ced_usu_doc = $_POST["ced_usu_doc"];
            $log_usu_doc = $_POST["log_usu_doc"];
            $pas_usu_doc = $_POST["pas_usu_doc"];
            $tel_usu_doc = $_POST["tel_usu_doc"];
            $cor_usu_doc = $_POST["cor_usu_doc"];
            $sel_cen_sal = $_POST["sel_cen_sal"];
            $trans_usu   = $_POST["val_str_tra"];           
                        
            $sql = "SELECT adm_registrar_medico(ARRAY[
                '$nom_usu_doc', 
                '$ape_usu_doc',
                '$ced_usu_doc', 
                '$pas_usu_doc',  
                '$log_usu_doc',
                '$tel_usu_doc',
                '$cor_usu_doc',
                '$sel_cen_sal',
                '$trans_usu'
            ]) AS result";
            //die($sql);
            $arr_query = ($this->Doctore->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);
            /*App::import("Lib",Array("FirePhp","fb"));
            $firephp = FirePHP::getInstance(true);
            $firephp->log('Hello World');*/
            
            
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se ha insertado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu_doc\' ya se encuentra registrado en el sistema."));                    
                    break;
                case 2:
                     die($this->FormatMessege->box_style($result,"El usuario/a con la cédula \'$ced_usu_doc\' ya se encuentra registrado en el sistema."));                    
                    break;
            } 
            die;
        }
        
        /**
        * View lista de usuarios administrativos
        */
        function listar(){    
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");            
            $title =  __("Lista de usuarios médicos",true);            
            $data = Array(                
                "title"     => $title                
            ); 
            $this->set($data);            
            $this->set('title_for_layout', $title);            
        }  
        
        /**
        * Listando de usuarios administrativos
        */
        function event_listar($str){  
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            
            $param_array = explode(",",$str);
            
            $nombre     = $param_array[0];
            $apellido   = $param_array[1];
            $login      = $param_array[2];                                                                     
                        
          
            $this->paginate =
                Array(
                    "limit"=>12,
                    "conditions"=>
                        Array(
                            "Doctore.nom_doc ilike" => "%$nombre%",                                        
                            "Doctore.ape_doc ilike" => "%$apellido%",
                            "Doctore.log_doc ilike" => "%$login%"
                        ),
                    "order" => "Doctore.nom_doc"                
                )                        
            ;                    
            $data = Array(
                "results" => $this->SqlData->CakeArrayToObjects($this->paginate("Doctore"))
            );  
            $this->set($data);  
            $this->layout = 'ajax';
            
        } 
        
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"iframe");
            $this->Login->no_cache();
            $sql = "SELECT * FROM doctores WHERE id_doc=$id";
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));
            
            $sql = "
                SELECT m.id_mod,m.cod_mod,m.des_mod,t.id_tip_tra,t.cod_tip_tra,t.des_tip_tra,tuu.id_tip_usu_usu
                    FROM modulos m JOIN
                    transacciones t ON (m.id_mod = t.id_mod) 
                LEFT JOIN
                (
                    SELECT tuu.id_tip_usu_usu, tu.id_tip_tra 
                    FROM transacciones_usuarios tu 
                        JOIN tipos_usuarios__usuarios tuu ON (tuu.id_tip_usu_usu = tu.id_tip_usu_usu )
                    WHERE tuu.id_doc = $id
                ) tuu
                ON (t.id_tip_tra = tuu.id_tip_tra)                
            ";
            //die($sql);
            $arr_query = ($this->Doctore->query($sql));            
            $result_tran = $this->SqlData->array_to_objects($arr_query);  
            
            
            $sql = "
                SELECT cs.id_cen_sal,cs.des_cen_sal, csd.id_doc
                FROM centro_salud cs
                	LEFT JOIN
                	(
                		SELECT cs.id_doc,cs.id_cen_sal 
                        FROM centro_salud_doctores cs
                            LEFT JOIN doctores d ON (cs.id_doc = d.id_doc)
                		WHERE cs.id_doc = $id
                	) csd
                	 ON (cs.id_cen_sal = csd.id_cen_sal) 
                
                ORDER BY cs.des_cen_sal ASC
            ";

            $arr_query = ($this->Doctore->query($sql));
            $result_cen_sal = ($this->SqlData->array_to_objects($arr_query));             
                        
            $title =  __("Modificación de usuarios médicos",true);
            
            $data = Array(
                "result"        => $result,
                "result_tran"   => $result_tran,
                "result_cen_sal"=> $result_cen_sal,
                "title"         => $title,
                "id"            => $id
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        /**
        * Editando usuarios administrativos
        */ 
        function event_modificar(){            
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
            $id_doc  = $_POST["id_doc"];
            $nom_doc = $_POST["nom_doc"];
            $ced_doc = $_POST["ced_usu_doc"];
            $ape_doc = $_POST["ape_doc"];           
            $pas_doc = $_POST["pas_doc"];
            $log_doc = $_POST["log_doc"];
            $tel_doc = $_POST["tel_doc"]; 
            $cor_doc = $_POST["cor_usu_doc"];
            $cen_sal = $_POST["sel_cen_sal"];          
            $val_str_tra = $_POST["val_str_tra"];
            $sql = "SELECT adm_modificar_medico(ARRAY[
                '$id_doc',
                '$log_doc',
                '$ced_doc',
                '$nom_doc', 
                '$ape_doc', 
                '$pas_doc',                  
                '$tel_doc',
                '$cor_doc',
                '$cen_sal',
                '$val_str_tra'
            ]) AS result";
           // die($sql);
            $arr_query = ($this->Doctore->query($sql));
                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se ha modificado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_doc\' no se encuentra registrado en el sistema."));                    
                    break;  
                case 2:
                    die($this->FormatMessege->box_style($result,"Existe un usuario con el login \'$log_doc\' por favor intente con otro."));                  
                    break;
                case 3:
                    die($this->FormatMessege->box_style($result,"Existe un usuario con la cédula \'$ced_doc\' por favor intente con otro."));                  
                    break;              
            }                               
            die;
        }
        
        /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id,$log_usu=""){
            $this->Login->autenticacion_usuario($this,"/admin/login",$this->group_session,"json");
                                   
            $sql = "SELECT adm_eliminar_medico(
                '{\"$id\"}'              
            ) AS result";
                        
            $arr_query = ($this->Doctore->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->result_num($arr_query);            
                        
            switch($result){
                case 2:
                    die($this->FormatMessege->box_style($result,"No se puede eliminar este doctor porque tiene pacientes asociados."));
                    break;
                case 1:
                    die($this->FormatMessege->box_style($result,"El usuario se ha eliminado con éxito."));
                    break;
                case 0:
                     die($this->FormatMessege->box_style($result,"El usuario/a \'$log_usu\' no se encuentra registrado en el sistema."));                    
                    break;                            
            }         
         }        
    }
?>