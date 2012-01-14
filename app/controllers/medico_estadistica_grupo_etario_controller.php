<?php
    class MedicoEstadisticaGrupoEtarioController extends Controller{
        
        var $name = "MedicoEstadisticaGrupoEtario";
        var $uses = Array("Paciente");
        var $components =   Array("Login","SqlData","FormatMessege","Session","History","Ofc");
        var $helpers =      Array("Paginator");
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
            
            $title = __("Búsqueda por Grupo Etario",true);
           
            $data = Array(
               "title" => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        function contenido(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
                
                $where_fec = "fec_reg_pac >= '".$fec_ini."' AND fec_reg_pac < '".$fec_fin."'";
            }
            
            if(isset($_POST['sel_gru_eta']) && $_POST['sel_gru_eta'] != '0'){
                 $gru_eta_pac = $_POST["sel_gru_eta"];
                 
                 switch ($gru_eta_pac) {
                    case '1':
                        $condicion = " 0 and 12 "; break;
                    case '2':
                        $condicion = " 13 and 17 "; break;
                    case '3':
                        $condicion = " 18 and 28 "; break;
                    case '4':
                        $condicion = " 29 and 35 "; break;
                    case '5':
                        $condicion = " 36 and 59 "; break;
                    case '6':
                        $condicion = " >= 60 "; break;
                }
                $where_gru = " AND substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between ".$condicion; 
            }
            else{
                $where_gru = "";
            }
                                      
            $data = Array(
                "where_fec"  => $where_fec,
                "where_gru"  => $where_gru  
            ); 
            
            $this->set($data);          
            $this->layout = 'default';
        }
        
        function grafico(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where_fec = 'WHERE '.$_POST['fil_fec'];
            $where_gru = $_POST['fil_gru'];
            
            $sql = "SELECT  count(*) AS cantidad,
                            (SELECT count(*) FROM  pacientes $where_fec) AS total_pac,
                            CASE
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 0 and 12  THEN 'Infante'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 13 and 17 THEN 'Adolescente'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 18 and 28 THEN 'Joven'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 29 and 35 THEN 'Adulto Joven'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 36 and 59 THEN 'Adulto'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int >= 60 THEN 'Adulto Mayor'
                            END AS grupo
                    FROM pacientes
                    $where_fec  $where_gru
                    GROUP BY grupo
                    ORDER BY grupo desc";
            
            //die($sql);       
            $arr_query = ($this->Paciente->query($sql));
            $gru_eta = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(500,230);
            
            $cant = array();
            $data = array();
                       
            foreach($gru_eta as $row){  
               $porcentaje = round(($row->cantidad * 100 / $row->total_pac),'2');
               $cant[] = $porcentaje;            
               $data[] = $row->grupo;
            }
            
            $this->Ofc->set_ofc_title( 'Grupo Etario', '{font-size: 15px; color: #0CB760}' );
            $this->Ofc->set_ofc_x_info($data, array('size'=>10,'color'=>'0x000000','orientation'=>0,'step'=>0));
            $this->Ofc->set_ofc_y_info(100,10,array('text'=>'','size'=>12,'color'=>'#0CB760'));
         
            $this->Ofc->init();
            $this->Ofc->setup();
            $this->Ofc->set_ofc_data( $cant );
            $this->Ofc->bar( 3, 5, '#0CB760','', 'Downloads', 10);
            echo $this->Ofc->ofc_render();
           
            die();
        }
        
       
        
        function resumen(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where_fec = 'WHERE '.$_POST['fil_fec'];
            $where_gru = $_POST['fil_gru'];
            
            $sql = "SELECT  count(*) AS cantidad,
                            (SELECT count(*) FROM  pacientes $where_fec) AS total_pac,
                            CASE
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 0 and 12  THEN 'Infante (0-12)'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 13 and 17 THEN 'Adolescente (13-17)'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 18 and 28 THEN 'Joven (18-28)'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 29 and 35 THEN 'Adulto Joven (29-35)'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 36 and 59 THEN 'Adulto (36-59)'
                                WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int >= 60 THEN 'Adulto Mayor (60 o mas)'
                            END AS grupo
                    FROM pacientes
                    $where_fec $where_gru
                    GROUP BY grupo
                    ORDER BY grupo desc";
                    
            $arr_query = ($this->Paciente->query($sql));
            $gru_eta = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $title = __("",true);
            
            $data = Array(
                "gru_eta"  => $gru_eta,                                         
                "title"   => $title             
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>