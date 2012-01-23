<?php
    class MedicoConfiguracionEnfermedadesPacienteController extends Controller{
        var $name = "MedicoConfiguracionEnfermedadesPaciente";
        var $uses =         Array("HistorialesPaciente","TiposMicosisPaciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session"); 
        var $helpers =      Array("Html","DateFormat","Paginator","FormatString","Loader","Event","Checkbox","Otros");                  
        
        var $group_session = "medico";                   
       
        function index(){   
            
        }
        
        /**
        * Mostrando filtro para la lista de pacientes, acomplando de igual el boton agregar o registrar
        */
        function listar($id_his,$id_pac){                    
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
                 
            $title =  __("Enfermedades del paciente",true);            
            $data = Array(
                "id_his"    => $id_his,
                "id_pac"    => $id_pac,                
                "title"     => $title                             
            ); 
            $this->set($data);
            $this->set('title_for_layout', $title);
            $this->layout = "window";
                                           
        }
        
         /**
        * Listando de usuarios administrativos
        */
        function event_listar($id_his){           
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");                              
                                     
           //echo $this->History->GetHistoryData("a","ced_pac");             
            $this->paginate = array(
                'limit' => 12,
                'fields' => Array(
                                    "tm.nom_tip_mic",
                                    "TiposMicosisPaciente.id_tip_mic_pac"                                  
                ),
                "conditions" => Array(
                    "TiposMicosisPaciente.id_his" => "$id_his"                                  
                ),
                "joins"=>Array(
                    Array(
                        "table" => "tipos_micosis",
                        "alias" => "tm",
                        "conditions" => "TiposMicosisPaciente.id_tip_mic = tm.id_tip_mic"
                        
                    )
                ),
                "order" => "tm.nom_tip_mic ASC"
            ); 
                                                           
            
            
            $data = Array(                
                "results" =>$this->SqlData->CakeArrayToObjects($this->paginate("TiposMicosisPaciente"))
            );  
            
            
            $this->set($data);  
            $this->layout = 'ajax';
          //    $this->cacheAction = true;   
        } 
   
        function registrar($id_his){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
                                                                                                               
            $sql = "SELECT tm.id_tip_mic, tm.nom_tip_mic FROM tipos_micosis tm WHERE tm.id_tip_mic NOT IN(SELECT tm.id_tip_mic FROM tipos_micosis tm JOIN tipos_micosis_pacientes tmp ON (tm.id_tip_mic = tmp.id_tip_mic AND tmp.id_his = $id_his))";                                    
            $arr_query = ($this->HistorialesPaciente->query($sql));
            $tipos_micosis = ($this->SqlData->array_to_objects($arr_query)); 
                                                                        
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "id_his"            =>  $id_his,                
                "tipos_micosis"     =>  $tipos_micosis,                                         
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
             
        }
        
        function event_cat_mic_registrar($id_tip_mic){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            $query =  " SELECT cc.nom_cat_cue,cc.id_cat_cue,pc.nom_par_cue,pc.id_par_cue,pccc.id_par_cue_cat_cue 
                        FROM tipos_micosis tm 
                            JOIN categorias__cuerpos_micosis ccm ON (ccm.id_tip_mic = tm.id_tip_mic)
                            JOIN categorias_cuerpos cc ON (ccm.id_cat_cue = cc.id_cat_cue)
                            JOIN partes_cuerpos__categorias_cuerpos pccc ON (pccc.id_cat_cue = cc.id_cat_cue)
                            JOIN partes_cuerpos pc ON (pc.id_par_cue = pccc.id_par_cue)
                        WHERE tm.id_tip_mic = $id_tip_mic
            ;";
            $cat_cue = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
               $query
            ))); 
                                     
            $title = __("Registro de categoría micosis",true);
            
            $data = Array(
                "cat_cue"           =>  $cat_cue,
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';
        }
        
        function event_cat_mic_modificar($id_tip_mic_pac){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            $sql =  "
                SELECT cc.nom_cat_cue,cc.id_cat_cue,pc.nom_par_cue,pc.id_par_cue,pccc.id_par_cue_cat_cue 
                from tipos_micosis tm 
                JOIN categorias__cuerpos_micosis ccm ON (ccm.id_tip_mic = tm.id_tip_mic) 
                JOIN categorias_cuerpos cc ON (ccm.id_cat_cue = cc.id_cat_cue) 
                JOIN partes_cuerpos__categorias_cuerpos pccc ON (pccc.id_cat_cue = cc.id_cat_cue) 
                JOIN partes_cuerpos pc ON (pc.id_par_cue = pccc.id_par_cue) 
                JOIN tipos_micosis_pacientes tmp ON(tmp.id_tip_mic = tm.id_tip_mic)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac 
            ;";
            $cat_cue = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql))); 
                                     
            $title = __("Registro de categoría micosis",true);
            
            $data = Array(
                "cat_cue"           =>  $cat_cue,
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';
        }
        
         function event_lesiones_registrar($id_tip_mic,$id_par_cue_cat_cue){  
           
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            $query = " SELECT l.nom_les, ccl.id_cat_cue_les,tm.id_tip_mic               
                        FROM tipos_micosis tm
                            JOIN categorias__cuerpos_micosis ccm ON (tm.id_tip_mic = ccm.id_tip_mic)
                            JOIN categorias_cuerpos cc ON (cc.id_cat_cue = ccm.id_cat_cue)
                            JOIN partes_cuerpos__categorias_cuerpos pccc ON (pccc.id_cat_cue = cc.id_cat_cue)
                            JOIN categorias_cuerpos__lesiones ccl ON (ccl.id_cat_cue = cc.id_cat_cue)
                            JOIN lesiones l ON (l.id_les = ccl.id_les) 
                        WHERE tm.id_tip_mic = $id_tip_mic 
                            AND pccc.id_par_cue_cat_cue = $id_par_cue_cat_cue";
            $les_cat = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                $query
            ))); 
                                     
            $title = __("Registro de categoría micosis",true);
            
            $data = Array(
                "id_par_cue_cat_cue"        =>  $id_par_cue_cat_cue,
                "les_cat"           =>  $les_cat,
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';
        }
        
        function event_lesiones_modificar($id_tip_mic_pac,$id_par_cue_cat_cue){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            $sql = "SELECT l.nom_les, 
                                ccl.id_cat_cue_les,
                                tm.id_tip_mic,
                                lpcp.otr_les_par_cue, 
                                lpcp.id_cat_cue_les AS id_checked 
                    FROM tipos_micosis tm 
                        JOIN categorias__cuerpos_micosis ccm ON (tm.id_tip_mic = ccm.id_tip_mic) 
                        JOIN categorias_cuerpos cc ON (cc.id_cat_cue = ccm.id_cat_cue)
                        JOIN partes_cuerpos__categorias_cuerpos pccc ON (pccc.id_cat_cue = cc.id_cat_cue)  
                        JOIN categorias_cuerpos__lesiones ccl ON (ccl.id_cat_cue = cc.id_cat_cue) 
                        JOIN lesiones l ON (l.id_les = ccl.id_les)
                        JOIN tipos_micosis_pacientes tmp ON(tmp.id_tip_mic = tm.id_tip_mic)
                        LEFT JOIN lesiones_partes_cuerpos__pacientes lpcp ON (lpcp.id_cat_cue_les = ccl.id_cat_cue_les AND lpcp.id_tip_mic_pac = tmp.id_tip_mic_pac AND lpcp.id_par_cue_cat_cue = $id_par_cue_cat_cue) 
                    WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac 
                        AND pccc.id_par_cue_cat_cue = $id_par_cue_cat_cue;";
            $les_cat = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                $sql
            ))); 
                                     
            $title = __("Registro de categoría micosis",true);
            
            $data = Array(
                "id_par_cue_cat_cue"        =>  $id_par_cue_cat_cue,
                "les_cat"           =>  $les_cat,
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';
        }
        
        /**
        * View editar usuarios administrativos
        */ 
        function consultar($id_tip_mic_pac){                        
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");
            
            // tipos de micosis
            $sql = "
                SELECT tm.id_tip_mic, tm.nom_tip_mic, tmp.id_tip_mic_pac
                FROM tipos_micosis tm
                JOIN tipos_micosis_pacientes tmp ON(tm.id_tip_mic = tmp.id_tip_mic)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
            ";     
                                                       
            $tip_mic = ($this->SqlData->array_to_object($this->HistorialesPaciente->query($sql)));             
            
            // enfermedades de la micosis     
             $sql_enf = "
                SELECT em.id_enf_mic,em.nom_enf_mic,ep.otr_enf_mic 
                FROM enfermedades_micologicas em
                JOIN enfermedades_pacientes ep ON (ep.id_enf_mic = em.id_enf_mic AND ep.id_tip_mic_pac = $id_tip_mic_pac)
            ";
                                            
            $enf_mic = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                          
                        
            // lesiones parte del cuerpo             
            $sql = "
                SELECT l.nom_les,cc.nom_cat_cue,pc.nom_par_cue,lpcp.otr_les_par_cue
                FROM tipos_micosis tm 
                JOIN categorias__cuerpos_micosis ccm ON (tm.id_tip_mic = ccm.id_tip_mic)                                        
                JOIN categorias_cuerpos cc ON (cc.id_cat_cue = ccm.id_cat_cue) 
                JOIN categorias_cuerpos__lesiones ccl ON (ccl.id_cat_cue = cc.id_cat_cue) 
                JOIN lesiones l ON (l.id_les = ccl.id_les)
                JOIN tipos_micosis_pacientes tmp ON(tmp.id_tip_mic = tm.id_tip_mic)
                JOIN lesiones_partes_cuerpos__pacientes lpcp ON (lpcp.id_cat_cue_les = ccl.id_cat_cue_les AND lpcp.id_tip_mic_pac = tmp.id_tip_mic_pac)
                JOIN partes_cuerpos__categorias_cuerpos pccc ON (pccc.id_par_cue_cat_cue = lpcp.id_par_cue_cat_cue)
                JOIN partes_cuerpos pc ON (pc.id_par_cue = pccc.id_par_cue)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
                ORDER BY nom_par_cue 
                ;
            ";
            $les_cat = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                $sql
            ))); 
            
            // estudios micologicos          
            $sql = "
                SELECT nom_tip_est_mic, nom_tip_exa, te.id_tip_exa,otr_tip_est_mic
                FROM tipos_micosis_pacientes tmp
                JOIN tipos_micosis tm ON (tm.id_tip_mic = tmp.id_tip_mic)
                JOIN tipos_estudios_micologicos tem ON (tem.id_tip_mic = tm.id_tip_mic)
                JOIN tipos_examenes te ON(te.id_tip_exa = tem.id_tip_exa)
                JOIN tipos_micosis_pacientes__tipos_estudios_micologicos tmptem ON (tmptem.id_tip_est_mic = tem.id_tip_est_mic AND tmp.id_tip_mic_pac = tmptem.id_tip_mic_pac)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
                ORDER BY nom_tip_exa DESC              
            ";
            $estudios_micologicos = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                $sql
            ))); 
            
            // forma de infeccion   
            $sql = "
                SELECT des_for_inf,otr_for_inf 
                FROM tipos_micosis_pacientes tmp 
                JOIN forma_infecciones__pacientes fip ON (fip.id_tip_mic_pac = tmp.id_tip_mic_pac)
                JOIN forma_infecciones	fi ON(fi.id_for_inf = fip.id_for_inf)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
                ORDER BY des_for_inf              
            ";
            $for_inf = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query(
                $sql
            ))); 
                                     
            $title = __("Consulta de categoría micosis",true);
            
            $data = Array(
                "for_inf"           =>  $for_inf,
                "tip_mic"           =>  $tip_mic,                
                "enf_mic"           =>  $enf_mic,
                "les_cat"           =>  $les_cat,
                "est_mic"           =>  $estudios_micologicos,
                "title"             =>  $title                                
            );                                         
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
         
        /**
        * View editar usuarios administrativos
        */ 
        function modificar($id_tip_mic_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
                       
            $sql = "
                SELECT tm.id_tip_mic, tm.nom_tip_mic, tmp.id_tip_mic_pac
                FROM tipos_micosis tm
                JOIN tipos_micosis_pacientes tmp ON(tm.id_tip_mic = tmp.id_tip_mic)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
            ";                                                
            $arr_query = ($this->HistorialesPaciente->query($sql));
            $tipos_micosis = ($this->SqlData->array_to_object($arr_query)); 
                                                                        
            $title = __("Modificar paciente",true);
            
            $data = Array(                                
                "tipos_micosis"     =>  $tipos_micosis,                                         
                "title"             =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        /**
        * Registrando usuarios pacientes
        */
        function event_registrar(){                          
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
                                     
            $hdd_id_his              = $_POST["hdd_id_his"];
            $hdd_id_tip_mic          = $_POST["cmb_tipos_micosis"];            
            $hdd_chk_enf_pac         = $_POST["hdd_chk_enf_pac"];
            $hdd_tip_est_mic         = $_POST["hdd_chk_tip_est_mic"];
            $hdd_chk_for_inf         = $_POST["hdd_chk_for_inf"];
            
            if (isset($_POST["hdd_les"])){
                $hdd_les    = $_POST["hdd_les"];
            } 
            else{
                $hdd_les    = "";    
            }
            
            if (isset($_POST["txt_otr_enf_mic"])){
                $txt_otr_enf_mic            = $_POST["txt_otr_enf_mic"];
                $id_hdd_otr_enf_mic         = $_POST["hdd_txt_otr_enf_mic"];
            } else {
                $txt_otr_enf_mic            = "";
                $id_hdd_otr_enf_mic         = -1;
            }
            
            if (isset($_POST["txt_otr_for_inf"])){
                $txt_otr_for_inf    =   $_POST["txt_otr_for_inf"];
                $id_hdd_otr_for_inf =   $_POST["hdd_txt_otr_for_inf"];
            } else {
                $txt_otr_for_inf    =   "";
                $id_hdd_otr_for_inf =   -1;
            }                        
            
            $hdd_str_otr_les        =   $_POST["hdd_str_otr_les"];
            $hdd_str_otr_est_mic    =   $_POST["hdd_str_otr_est_mic"];
            
            $hdd_str_pos            =   $_POST["hdd_str_pos"];
                                   
            $id_doc         = $this->Session->read("medico.id_usu");
                
            $sql = $this->HistorialesPaciente->MedInsertarMicosisPaciente(
                        $hdd_id_his,
                        $hdd_id_tip_mic,
                        $hdd_chk_enf_pac,
                        $hdd_les,
                        $hdd_tip_est_mic,
                        $hdd_chk_for_inf,
                        
                        $txt_otr_enf_mic,
                        $id_hdd_otr_enf_mic,
                        
                        $id_hdd_otr_for_inf,
                        $txt_otr_for_inf,
                        
                        $hdd_str_otr_les,
                        $hdd_str_otr_est_mic,
                        
                        $hdd_str_pos,
                        
                        $id_doc
            );
                      
            $arr_query = ($this->HistorialesPaciente->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"Se ha insertado los datos correctamente"));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"Ya existe una enfermedad registrado para este paciente"));                    
                    break;
                    
            }                   
            
            die;
        }
        
         /**
        * Editando paciente
        */ 
        function event_modificar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            
            $tipos_micosis_pacientes = $_POST["hdd_tipos_micosis_pacientes"];                                                  
            $hdd_chk_enf_pac         = $_POST["hdd_chk_enf_pac"];
            $hdd_chk_est_pac         = $_POST["hdd_chk_tip_est_mic"];
            $hdd_chk_for_inf         = $_POST["hdd_chk_for_inf"];
            
            if (isset($_POST["hdd_les"])){
                $hdd_les                 = $_POST["hdd_les"];
            } else {
                $hdd_les                 = "";    
            }
            
            if (isset($_POST["txt_otr_enf_pac"])){
                $txt_otr_enf_pac    =   $_POST["txt_otr_enf_pac"];
                $id_hdd_id_otr         =   $_POST["hdd_txt_otr_enf_pac"];
            } else {
                $txt_otr_enf_pac    =   "";
                $id_hdd_id_otr         =   -1;
            }
            
            if (isset($_POST["txt_otr_for_inf"])){
                $txt_otr_for_inf    =   $_POST["txt_otr_for_inf"];
                $id_hdd_otr_for_inf =   $_POST["hdd_txt_otr_for_inf"];
            } else {
                $txt_otr_for_inf    =   "";
                $id_hdd_otr_for_inf =   -1;
            }
            
            $hdd_str_otr_les        =   $_POST["hdd_str_otr_les"];
            $hdd_str_otr_est_mic    =   $_POST["hdd_str_otr_est_mic"];    
            
            $hdd_str_pos            =   $_POST["hdd_str_pos"];  
                              
            $id_doc                 = $this->Session->read("medico.id_usu");
            
                
            $sql = $this->HistorialesPaciente->MedModificarMicosisPaciente(
                $tipos_micosis_pacientes,
                $hdd_chk_enf_pac,
                $hdd_les,
                $hdd_chk_est_pac,
                $hdd_chk_for_inf,
                
                $txt_otr_enf_pac,
                $id_hdd_id_otr,
                
                $hdd_str_otr_les,
                
                $id_hdd_otr_for_inf,
                $txt_otr_for_inf,
                
                $hdd_str_otr_est_mic,
                
                $hdd_str_pos,
                
                $id_doc
            );
                      
            $arr_query = ($this->HistorialesPaciente->query($sql));
                             
            $result = $this->SqlData->ResultNum($arr_query);        
            
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"Se han modificado los datos correctamente"));
                    break;                
                    
            }                               
            die;
        }
        
         /**
         * Eliminando usuario administrativo
         */
         
         function event_eliminar($id_tip_mic_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"json");
            $id_doc         = $this->Session->read("medico.id_usu");
            
            $sql = $this->HistorialesPaciente->MedEliminarMicosisPaciente($id_tip_mic_pac,$id_doc);            
                        
            $arr_query = ($this->HistorialesPaciente->query($sql));
            $result = ($this->SqlData->array_to_object($arr_query));                             
            $result = $this->SqlData->ResultNum($arr_query);            
                        
            switch($result){
                case 1:
                    die($this->FormatMessege->BoxStyle($result,"Se han eliminado las enfermedades correctamente."));
                    break;
                case 0:
                     die($this->FormatMessege->BoxStyle($result,"El tipo de enfermedad no existe."));                    
                    break;                            
            }         
         }  
         
         function event_enfermedades_registrar($id_tip_mic){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");    
                    
            $sql_enf = "SELECT em.id_enf_mic,em.nom_enf_mic
                        FROM enfermedades_micologicas em
                        WHERE em.id_tip_mic = $id_tip_mic";
          
                                            
            $enf_mic = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                         
            
            $title = __("Enfermedades Micológicas",true);
            
            $data = Array(                
                "enf_mic"     =>  $enf_mic,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';        
                                   
         } 
         
         function event_enfermedades_modificar($id_tip_mic_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe");    
                    
            $sql_enf = "SELECT 
                            em.id_enf_mic,
                            em.nom_enf_mic, 
                            ep.id_enf_mic AS check_id , 
                            ep.id_enf_pac, 
                            tmp.id_tip_mic_pac,
                            ep.otr_enf_mic  
                        FROM 
                            tipos_micosis_pacientes tmp
                            JOIN tipos_micosis tm ON (tm.id_tip_mic = tmp.id_tip_mic)
                            JOIN enfermedades_micologicas em ON (em.id_tip_mic = tm.id_tip_mic) 
                            LEFT JOIN enfermedades_pacientes ep ON (ep.id_enf_mic = em.id_enf_mic AND ep.id_tip_mic_pac = tmp.id_tip_mic_pac) 
                        WHERE 
                            tmp.id_tip_mic_pac = $id_tip_mic_pac
                       ";
          //echo $sql_enf;
                                            
            $enf_mic = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                         
            
            $title = __("Enfermedades Micológicas",true);
            
            $data = Array(                
                "enf_mic"     =>  $enf_mic,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'ajax';        
                                   
         }    
         
         function event_estudios_micologicos_registrar($id_tip_mic){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
            
            $sql_enf = 
                "SELECT tem.id_tip_est_mic,tem.nom_tip_est_mic, nom_tip_exa, te.id_tip_exa  
                FROM tipos_estudios_micologicos tem 
                JOIN tipos_examenes te ON(te.id_tip_exa = tem.id_tip_exa)
                WHERE id_tip_mic = $id_tip_mic ORDER BY nom_tip_exa DESC";
            //debug($sql_enf);                                            
            $estudios = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                                    
            $title = __("Estudios Micológicos",true);
            
            $data = Array(                
                "estudios"     =>  $estudios,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);                        
         }   
         
         function event_estudios_micologicos_modificar($id_tip_mic_pac){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
            
            $sql_enf = 
                "
                SELECT tem.id_tip_est_mic, tem.nom_tip_est_mic, 
                nom_tip_exa, tmptem.id_tip_mic_pac,te.nom_tip_exa,te.id_tip_exa,
                tmptem.otr_tip_est_mic,(CASE WHEN ep.exa_pac_est IS NULL THEN 3 ELSE ep.exa_pac_est END) AS exa_pac_est
                FROM tipos_micosis_pacientes tmp
                JOIN tipos_micosis tm ON (tmp.id_tip_mic = tm.id_tip_mic)
                JOIN tipos_estudios_micologicos tem ON (tem.id_tip_mic = tm.id_tip_mic)
                LEFT JOIN tipos_micosis_pacientes__tipos_estudios_micologicos tmptem ON (tmptem.id_tip_est_mic = tem.id_tip_est_mic AND tmp.id_tip_mic_pac = tmptem.id_tip_mic_pac)                
                JOIN tipos_examenes te ON (te.id_tip_exa = tem.id_tip_exa)
                LEFT JOIN examenes_pacientes ep ON (ep.id_tip_exa = te.id_tip_exa AND ep.id_tip_mic_pac = tmp.id_tip_mic_pac)                                
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac 
                ORDER BY te.nom_tip_exa DESC
                ";
                                                                
              //debug($sql_enf);                              
            $estudios = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                                    
            $title = __("Estudios Micológicos",true);
            
            $data = Array(                
                "estudios"     =>  $estudios,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);                        
         }       
         
         function event_forma_infeccion_registrar($id_tip_mic){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
            
            $sql_enf = 
            "
            SELECT fi.id_for_inf, fi.des_for_inf FROM forma_infecciones fi 
                JOIN forma_infecciones__tipos_micosis fitm ON (fitm.id_for_inf = fi.id_for_inf)
            WHERE fitm.id_tip_mic = $id_tip_mic
            ";
                                        
            $forma_infeccion = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                                    
            $title = __("Forma de infección",true);
            
            $data = Array(                
            "forma_infeccion"     =>  $forma_infeccion,                                         
            "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);         
         }    
         
          function event_forma_infeccion_modificar($id_tip_mic_pac){            
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session,"iframe"); 
            
            $sql_enf = 
                "
                SELECT fi.id_for_inf, fi.des_for_inf, fip.id_tip_mic_pac, fip.otr_for_inf 
                FROM tipos_micosis tm
                    JOIN tipos_micosis_pacientes tmp ON (tmp.id_tip_mic = tm.id_tip_mic)
                    JOIN forma_infecciones__tipos_micosis fitm ON(fitm.id_tip_mic = tm.id_tip_mic)
                    JOIN forma_infecciones fi ON(fi.id_for_inf = fitm.id_for_inf)
                    LEFT JOIN forma_infecciones__pacientes fip ON (fip.id_for_inf = fi.id_for_inf AND fip.id_tip_mic_pac = tmp.id_tip_mic_pac)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
                ";
                                            
            $forma_infeccion = ($this->SqlData->array_to_objects($this->HistorialesPaciente->query($sql_enf)));                                                    
            $title = __("Estudios Micológicos",true);
            
            $data = Array(                
                "forma_infeccion"     =>  $forma_infeccion,                                         
                "title"       =>  $title                                
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);                        
         }       
    }
?>