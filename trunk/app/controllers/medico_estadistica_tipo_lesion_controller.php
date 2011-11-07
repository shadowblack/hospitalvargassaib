<?php
    class MedicoEstadisticaTipoLesionController extends Controller{
        
        var $name = "MedicoEstadisticaTipoLesion";
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
            
            $sql = " SELECT  l.id_les,l.nom_les
	                   FROM lesiones l
	                   JOIN categorias_cuerpos__lesiones ccl ON(l.id_les = ccl.id_les) ORDER BY l.nom_les";	
                       
           	$arr_query = $this->Paciente->query($sql);
            $tipo_lesion = $this->SqlData->array_to_objects($arr_query);
            
            $title = __("Búsqueda por Tipo de Lesión",true);
                        
            $data = Array(
               "tipo_lesion" => $tipo_lesion,
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
                
                $where = "fec_reg_pac >= '".$fec_ini."' AND fec_reg_pac < '".$fec_fin."'";
            }
            
            if(isset($_POST['sel_tip_les']) && $_POST['sel_tip_les'] != 0){
                $id_les = $_POST["sel_tip_les"];  
                $where .= " AND l.id_les =".$id_les; 
            }
            else{
                $where .= "";
            }
                                      
            $data = Array(
                "result"  => $where     
            ); 
            
            $this->set($data);          
            $this->layout = 'default';
        }
        
        function grafico(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where = 'WHERE '.$_POST['fil'];
            
            $sql = "    SELECT 	count(lp.id_pac) AS cantidad, lp.nom_les,
                    	(SELECT count(*) FROM  pacientes ".$where.") AS total_pac
                    	FROM (	SELECT DISTINCT hp.id_pac, l.nom_les 
                        		FROM pacientes p 
                        			JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac) 
                        			JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his) 
                        			JOIN lesiones_partes_cuerpos__pacientes lpcp ON(tmp.id_tip_mic_pac = lpcp.id_tip_mic_pac) 
                        			JOIN categorias_cuerpos__lesiones ccl ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les) 
                        			JOIN lesiones l ON(ccl.id_les = l.id_les) 
                        	       ".$where."
                    		ORDER BY l.nom_les
                    	)
                    AS lp GROUP BY lp.nom_les";
            
            //die($sql);       
            $arr_query = ($this->Paciente->query($sql));
            $tip_les = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(550,230);
            
            $cant = array();
            $data = array();
            
            foreach($tip_les as $row){
                $total =  $row->total_pac;
                $porcentaje = ($row->cantidad * 100) / $total;
                $cant[] =   $porcentaje;      
                $data[] =   $row->nom_les;
            }
            
            $this->Ofc->set_ofc_title( 'Tipo de Lesión', '{font-size: 15px; color: #0CB760}' );
            $this->Ofc->set_ofc_x_info($data, array('size'=>10,'color'=>'0x000000','orientation'=>0,'step'=>2));
            $this->Ofc->set_ofc_y_info(100,10,array('text'=>'','size'=>12,'color'=>'#0CB760'));
         
            $this->Ofc->init();
            $this->Ofc->setup();
            $this->Ofc->set_ofc_data($cant);
            $this->Ofc->area_hollow(2,3,25,'0x80a033','',10);
            //$this->Ofc->bar( 3, 5, '#0CB760', 'Downloads', 10);
            echo $this->Ofc->ofc_render();
           
            die();
        }
        
       
        
        function resumen(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where = 'WHERE '.$_POST['fil'];
           $sql = "    SELECT 	count(lp.id_pac) AS cantidad, lp.nom_les,
                    	        (SELECT count(*) FROM  pacientes ".$where.") AS total_pac
                    	FROM (	SELECT DISTINCT hp.id_pac, l.nom_les 
                        		FROM pacientes p 
                        			JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac) 
                        			JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his) 
                        			JOIN lesiones_partes_cuerpos__pacientes lpcp ON(tmp.id_tip_mic_pac = lpcp.id_tip_mic_pac) 
                        			JOIN categorias_cuerpos__lesiones ccl ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les) 
                        			JOIN lesiones l ON(ccl.id_les = l.id_les) 
                        	       ".$where."
                    		ORDER BY l.nom_les
                    	)
                    AS lp GROUP BY lp.nom_les";
                    
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