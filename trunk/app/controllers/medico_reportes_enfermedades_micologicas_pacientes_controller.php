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
            
            $title = __("Búsqueda de Enfermedades Micológicas del Paciente",true);
           
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
            
            $title = __("Reporte de Enfermedades Micológicas",true);
            $data = Array(
                "tip_enf_mic_pac" => $tip_enf_mic_pac,
                "title"     => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>