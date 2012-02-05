<?php
    class MedicoReportesEnfermedadesMicologicasPacientesController extends Controller{
        var $name = "MedicoReportesEnfermedadesMicologicasPacientes";
        var $uses = Array("Paciente","HistorialesPaciente","TiposMicosisPaciente","TiposMicosi");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History");
        var $helpers =      Array("Paginator","FormatString");
        protected $group_session = "medico";
        /**
         * Entrando a la aplicacion administrativa
         */
        function index(){
            //$this->Login->no_cache();
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
        }
        
        
        function busqueda(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            // Se realiza el query para obtener los tipos de micosis
            $sql = "SELECT id_tip_mic, nom_tip_mic FROM tipos_micosis ORDER BY nom_tip_mic";					
		   	$arr_query = $this->TiposMicosi->query($sql);
            $tipo_enfermedad_micologica = $this->SqlData->array_to_objects($arr_query); 
            
            $title = __("Buscar Enfermedades Micológicas",true);
           
            $data = Array(
                "tipo_enfermedad_micologica" => $tipo_enfermedad_micologica,
                "title" => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        function event_listar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            if (count($_POST) > 0){
                $this->Session->write("medico.paginacion",$_POST);
            } else {
                $_POST = $this->Session->read("medico.paginacion");         
            }
            
            $ced_pac = $_POST["txt_ced_pac"];
            $nom_pac = $_POST["txt_nom_pac"];
            $ape_pac = $_POST["txt_ape_pac"];
            
            if(isset($_POST['cmb_tip_enf_mic']) && $_POST['cmb_tip_enf_mic'] != 0){
                 $tip_enf = $_POST["cmb_tip_enf_mic"];
                 $where_tip_enf = '"vtemp.id_tip_mic" = "'."'".$tip_enf."'";
            }
            else{
                $tip_enf = "";
                $where_tip_enf = "";
            }
           
            $num_his = $_POST["txt_num_his"];
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
            }
            
            $this->paginate = array(
                'limit' => 12,
                'fields' => Array(  "vtemp.num_his",
                                    "vtemp.fec_his",
                                    "vtemp.id_tip_mic",
                                    "vtemp.nom_tip_mic",
                                    "vtemp.id_tip_mic_pac",
                                    "Paciente.ced_pac",
                                    "Paciente.nom_pac",
                                    "Paciente.ape_pac"
                ),
                "joins"=>Array(
                    Array(
                        "table" => "view_tipo_enfermedades_mic_pac",
                        "alias" => "vtemp",
                        "conditions" => "vtemp.id_pac = Paciente.id_pac"
                    )
                ),
                "conditions" => Array(
                    "Paciente.ced_pac ilike" => "%$ced_pac%",                                
                    "Paciente.nom_pac ilike" => "%$nom_pac%",
                    "Paciente.ape_pac ilike" => "%$ape_pac%",
                    "CAST(vtemp.fec_his AS DATE) >=" => "$fec_ini",
                    "CAST(vtemp.fec_his AS DATE) <=" => "$fec_fin",
                    "vtemp.num_his ilike" => "%$num_his%",
                    $where_tip_enf
                ),
                "order" => "vtemp.nom_tip_mic ASC"
            );
          
            $arr_query = $this->paginate("Paciente"); 
            $tip_enf_mic_pac = $this->SqlData->CakeArrayToObjects($arr_query);            
            
            $title = __("Listar Enfermedades Micológicas",true);
            $data = Array(
                "tip_enf_mic_pac" => $tip_enf_mic_pac,
                "title"     => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        
        function reporte($id_tip_mic_pac){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            // tipos de micosis
            $sql = "
                SELECT tm.id_tip_mic, tm.nom_tip_mic, tmp.id_tip_mic_pac
                FROM tipos_micosis tm
                JOIN tipos_micosis_pacientes tmp ON(tm.id_tip_mic = tmp.id_tip_mic)
                WHERE tmp.id_tip_mic_pac = $id_tip_mic_pac
            ";     
                                                       
            $tip_mic = ($this->SqlData->array_to_object($this->TiposMicosi->query($sql))); 
            
            // enfermedades de la micosis     
             $sql_enf = "
                SELECT em.id_enf_mic,em.nom_enf_mic,ep.otr_enf_mic 
                FROM enfermedades_micologicas em
                JOIN enfermedades_pacientes ep ON (ep.id_enf_mic = em.id_enf_mic AND ep.id_tip_mic_pac = $id_tip_mic_pac)
            ";
                                            
            $enf_mic = ($this->SqlData->array_to_objects($this->TiposMicosi->query($sql_enf)));
            
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
            $les_cat = ($this->SqlData->array_to_objects($this->TiposMicosi->query($sql))); 
            
            $title = __("Reporte de Enfermedades Micológicas",true);
           
            $data = Array(
                "tip_mic" => $tip_mic,
                "enf_mic" => $enf_mic,
                "les_cat" => $les_cat,
                "title"   => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>