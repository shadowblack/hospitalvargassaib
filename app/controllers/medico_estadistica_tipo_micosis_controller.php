<?php
    class MedicoEstadisticaTipoMicosisController extends Controller{
        
        var $name = "MedicoEstadisticaTipoMicosis";
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
            
            $sql = " SELECT * FROM tipos_micosis ORDER BY nom_tip_mic ";	
                       
           	$arr_query = $this->Paciente->query($sql);
            $tipo_micosis = $this->SqlData->array_to_objects($arr_query);
            
            $title = __("Búsqueda por Tipo de Micosis",true);
                        
            $data = Array(
               "tipo_micosis" => $tipo_micosis,
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
                
                $where = "p.fec_reg_pac >= '".$fec_ini."' AND p.fec_reg_pac < '".$fec_fin."'";
            }
            
            if(isset($_POST['sel_tip_mic']) && $_POST['sel_tip_mic'] != 0){
                $id_tip_mic = $_POST["sel_tip_mic"];  
                $where .= " AND tm.id_tip_mic =".$id_tip_mic; 
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
            $sql = "    SELECT count(ptm.id_pac) AS cantidad,
                        	ptm.nom_tip_mic
                        FROM 
                        	(SELECT DISTINCT 
                        		p.id_pac,
                        		tm.nom_tip_mic
                        	FROM pacientes p
                        		JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac)
                        		JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
                        		JOIN tipos_micosis tm ON(tmp.id_tip_mic = tm.id_tip_mic)
                        	".$where."	
                        	ORDER BY tm.nom_tip_mic) AS ptm
                        GROUP BY ptm.nom_tip_mic";
            
            //die($sql);       
            $arr_query = ($this->Paciente->query($sql));
            $tip_mic = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(450,230);
            
            
            $this->Ofc->set_ofc_title('Tipo de Micosis', '{font-size: 15px; color: #0CB760}');
            $this->Ofc->init();
            $this->Ofc->setup();
            
             //pie chart
            $total = 0;
            $cant = array();
            $data = array();
            
            foreach($tip_mic as $row){  
                $total  = $total + $row->cantidad;
            }
            
            foreach($tip_mic as $row){  
               $porcentaje = $row->cantidad * 100 / $total;
               $cant[] =   $porcentaje;     
               $data[] =   $row->nom_tip_mic;
            }
            $this->Ofc->set_ofc_data($cant);
            $this->Ofc->pie_values($data);  
           
            $this->Ofc->pie(60,'#505050','{font-size: 12px; color: #404040;');  
            $this->Ofc->pie_slice_colors(array('#1ECEB4','#9E9735','#ED4321'));
            
            echo $this->Ofc->ofc_render(); 
           
            die();
        }
        
       
        
        function resumen(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where = 'WHERE '.$_POST['fil'];
            $sql = "    SELECT count(ptm.id_pac) AS cantidad,
                        	ptm.nom_tip_mic
                        FROM 
                        	(SELECT DISTINCT 
                        		p.id_pac,
                        		tm.nom_tip_mic
                        	FROM pacientes p
                        		JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac)
                        		JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
                        		JOIN tipos_micosis tm ON(tmp.id_tip_mic = tm.id_tip_mic)
                        	".$where."	
                        	ORDER BY tm.nom_tip_mic) AS ptm
                        GROUP BY ptm.nom_tip_mic";
                    
            $arr_query = ($this->Paciente->query($sql));
            $tip_mic = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $title = __("",true);
            
            $data = Array(
                "tip_mic"  => $tip_mic,                                         
                "title"   => $title             
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>