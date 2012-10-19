<?php
    class MedicoEstadisticaGeneroController extends Controller{
        
        var $name = "MedicoEstadisticaGenero";
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
            
            $title = __("Buscar Género",true);
           
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
                
                $where = "fec_reg_pac >= '".$fec_ini."' AND fec_reg_pac < '".$fec_fin."'";
            }
            
            
            if(isset($_POST['sel_gen_pac']) && $_POST['sel_gen_pac'] != '0'){
                 $gen_pac = $_POST["sel_gen_pac"];
                 $where .= " AND sex_pac = '".$gen_pac."'";
            }
            else{
                $where .= "";
            }
                                      
            $data = Array(
                "fec_ini"    => $_POST['txt_fec_ini'],
                "fec_fin"    => $_POST['txt_fec_fin'],
                "result"  => $where,
                "title" =>  __("Porcentaje de pacientes por Género, Masculino y Femenino para la fecha",true)." <font style='color:blue'>".$_POST['txt_fec_ini']."</font> y <font style='color:red'>".$_POST['txt_fec_fin']."</font>"     
            ); 
            
            $this->set($data);          
            $this->layout = 'default';
         
        }
        
        function grafico(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where = 'WHERE '.$_POST['fil'];
            $sql = "SELECT  count(*) AS cantidad, 
                            (SELECT count(*) FROM  pacientes ".$where.") AS total_pac,
                        	CASE
                        	    WHEN sex_pac = 'F' THEN 'Femenino' ELSE 'Masculino'
                        	END AS genero
                	FROM pacientes
                    ".$where."
                	GROUP BY sex_pac";
            
           // die($sql);       
            $arr_query = ($this->Paciente->query($sql));
            $genero = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(450,250);
            
            $this->Ofc->set_ofc_title('Cantidad de Género', '{font-size: 15px; color: #0CB760}');    
            
            $this->Ofc->init();
            $this->Ofc->setup();
            
             //pie chart
            $cant = array();
            $data = array();
            
            foreach($genero as $row){  
                $porcentaje = round(($row->cantidad * 100 / $row->total_pac),'2');
                $cant[] = $porcentaje;      
                $data[] = $row->genero;
            }            
            
            $this->Ofc->set_ofc_data($cant);
            $this->Ofc->pie_values($data);  
           
            $this->Ofc->pie(60,'#505050','{font-size: 12px; color: #404040;');  
            $this->Ofc->pie_slice_colors(array('#d01f3c','#356aa0'));
            
            echo $this->Ofc->ofc_render(); 
            
            die();
        }
        
       
        
        function resumen(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $where = 'WHERE '.$_POST['fil'];
            $sql = "SELECT 	count(*) AS cantidad,
                            (SELECT count(*) FROM  pacientes ".$where.") AS total_pac,
                    		CASE
                    		    WHEN sex_pac = 'F' THEN 'Femenino' ELSE 'Masculino'
                    		END AS genero
                	FROM pacientes
                    ".$where."
                	GROUP BY sex_pac";
           
              //debug($sql);      
            $arr_query = ($this->Paciente->query($sql));
            $genero = ($this->SqlData->array_to_objects($arr_query)); 
                    
            $title = __("Registro de paciente",true);
            
            $data = Array(
                "genero"  => $genero,                                         
                "title"   => $title             
            ); 
            
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>