<?php
    class MedicoEstadisticaTipoLesionController extends Controller{
        
        var $name = "MedicoEstadisticaTipoLesion";
        var $uses = Array("Paciente","TiposMicosi");
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
            
            $sql = " SELECT id_tip_mic, nom_tip_mic FROM tipos_micosis";
                       
           	$arr_query = $this->Paciente->query($sql);
            $tipo_micosis = $this->SqlData->array_to_objects($arr_query);
            
          
            $title = __("Búsqueda por Tipo de Enfermedades Micológicas",true);
                  
            $data = Array(
               "tipo_micosis" => $tipo_micosis,
               "title" => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
        
        function event_enfermedad_micologica($id_tip_mic){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
             //print '-->>'.$id_tip_mic;
            $sql = "SELECT * 
                    FROM enfermedades_micologicas 
                    LEFT JOIN tipos_micosis USING(id_tip_mic)
                    WHERE id_tip_mic = $id_tip_mic";
               // print '-->>'.$sql;
                           
           	$arr_query = $this->Paciente->query($sql);
            $tipo_enf_mic = $this->SqlData->array_to_objects($arr_query);
            
            $data = Array(
               "tipo_enf_mic"  => $tipo_enf_mic
            );
          
            $this->set($data);             
            $this->layout = 'ajax';
        }
        
        function contenido(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
                
                $where_fec = "fec_reg_pac >= '".$fec_ini."' AND fec_reg_pac < '".$fec_fin."'";
            }
            
            if(isset($_POST['id_enfermedad']) && $_POST['id_enfermedad'] != ''){
                $id_enf_mic = $_POST["id_enfermedad"];
                $id_enf_mic = str_replace(",","','",$id_enf_mic);
                //print $id_les;  
                $where = " AND em.id_enf_mic IN ('$id_enf_mic')"; 
            }
            else{
                $where = "";
            }
            
            $tip_mic = $this->SqlData->CakeArrayToObject($this->TiposMicosi->find("first",Array("conditions"=>Array("TiposMicosi.id_tip_mic"=>$_POST['sel_tip_mic']))));                                
            $data = Array(
                "tip_mic"    => $tip_mic,
                "fec_ini"    => $_POST['txt_fec_ini'],
                "fec_fin"    => $_POST['txt_fec_fin'],
                "result"  => $where,
                "result_fec" => $where_fec,
                "title" =>  __("Lesiones presentes en pacientes con Micosis ".$tip_mic->TiposMicosi->nom_tip_mic." durante la fecha",true)." <font style='color:blue'>".$_POST['txt_fec_ini']."</font> y <font style='color:red'>".$_POST['txt_fec_fin']."</font>"        
            ); 
            
            $this->set($data);          
            $this->layout = 'default';
        }
        
        function grafico(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where_fec = 'WHERE '.$_POST['fil_fec'];
            $where_enf = $_POST['fil_enf'];
            
             $sql = "    SELECT 	count(epac.id_pac) AS cantidad, epac.nom_enf_mic,
                        	(SELECT count(*) FROM  pacientes $where_fec) AS total_pac
                        FROM (	SELECT DISTINCT hp.id_pac, em.nom_enf_mic, em.id_enf_mic
                        		FROM pacientes p 
                        			JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac) 
                        			JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
                        			JOIN tipos_micosis tm ON (tmp.id_tip_mic = tm.id_tip_mic) 
                        			JOIN enfermedades_micologicas em ON (tm.id_tip_mic = em.id_tip_mic)
                        			JOIN enfermedades_pacientes ep ON (em.id_enf_mic = ep.id_enf_mic AND tmp.id_tip_mic_pac = ep.id_tip_mic_pac)
                    	        $where_fec $where_enf
                        	ORDER BY em.nom_enf_mic
                        )
                        AS epac GROUP BY epac.nom_enf_mic";
            
            //die($sql);       
            $arr_query = ($this->Paciente->query($sql));
            $tip_les = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(550,230);
            
            $cant = array();
            $data = array();         
            
            foreach($tip_les as $row){
                $porcentaje = round(($row->cantidad * 100 / $row->total_pac),'2');
                $cant[] =   $porcentaje;      
                $data[] =   $row->nom_enf_mic;
            }
            
            $this->Ofc->set_ofc_title( 'Tipo de Enfermedades Micológicas', '{font-size: 15px; color: #0CB760}' );
            $this->Ofc->set_ofc_x_info($data, array('size'=>10,'color'=>'0x000000','orientation'=>0,'step'=>2));
            $this->Ofc->set_ofc_y_info(100,10,array('text'=>'','size'=>12,'color'=>'#0CB760'));
         
            $this->Ofc->init();
            $this->Ofc->setup();
            $this->Ofc->set_ofc_data($cant);
            //$this->Ofc->area_hollow(2,3,25,'0x80a033','',10);            
            $this->Ofc->bar(50, '0x80a033', 'Muestra', 10 );
            echo $this->Ofc->ofc_render();
           
            die();
        }
        
       
        
        function resumen(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where_fec = 'WHERE '.$_POST['fil_fec'];
            $where_enf = $_POST['fil_enf'];
            
             $sql = "   SELECT 	count(epac.id_pac) AS cantidad, epac.nom_enf_mic,
                        	(SELECT count(*) FROM  pacientes $where_fec) AS total_pac
                        FROM (	SELECT DISTINCT hp.id_pac, em.nom_enf_mic, em.id_enf_mic
                        		FROM pacientes p 
                        			JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac) 
                        			JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
                        			JOIN tipos_micosis tm ON (tmp.id_tip_mic = tm.id_tip_mic) 
                        			JOIN enfermedades_micologicas em ON (tm.id_tip_mic = em.id_tip_mic)
                        			JOIN enfermedades_pacientes ep ON (em.id_enf_mic = ep.id_enf_mic AND tmp.id_tip_mic_pac = ep.id_tip_mic_pac)
                    	        $where_fec $where_enf
                        	ORDER BY em.nom_enf_mic
                        )
                        AS epac GROUP BY epac.nom_enf_mic";
            //debug($sql);        
            $arr_query = ($this->Paciente->query($sql));
            $tip_les = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $title = __("",true);
            
            $data = Array(
                "tip_les"  => $tip_les,                                         
                "title"   => $title             
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>