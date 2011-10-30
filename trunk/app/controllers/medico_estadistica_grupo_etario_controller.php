<?php
    class MedicoEstadisticaGrupoEtarioController extends Controller{
        
        var $name = "MedicoEstadisticaGrupoEtario";
        var $uses = Array();
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
        
        
        function grafico(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
           
           $this->Ofc->set_ofc_webroot($this->webroot);
            $this->Ofc->set_ofc_size(500,300);
         
            srand((double)microtime()*1000000);
            $data_1 = array();
            $data_2 = array();
            $data_3 = array();
            for( $i=0; $i<12; $i++ )
            {
              $data_1[] = rand(14,19);
              $data_2[] = rand(8,13);
              $data_3[] = rand(1,7);
            }
            $this->Ofc->set_ofc_title( 'CakePHP for Vietnamese', '{font-size: 20px; color: #736AFF}' );
            $month = array( 'January','February','March','April','May','June','July','August','Spetember','October','November','December' );
            $this->Ofc->set_ofc_x_info($month, array('size'=>10,'color'=>'0x000000','orientation'=>0,'step'=>2));
            $this->Ofc->set_ofc_y_info(20,4,array('text'=>'cakephpvn.org','size'=>12,'color'=>'#736AFF'));
         
            $this->Ofc->init();
            $this->Ofc->setup();
            $this->Ofc->set_ofc_data( $data_1 );
            $this->Ofc->bar( 3, 5, '0xCC3399', 'Downloads', 10);
            echo $this->Ofc->ofc_render();die;
            $title = __("Reporte de transacciones",true);
            $grafico = $this->Ofc->ofc_render();
            $data = Array(
                "grafico" => $grafico             
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
           // $this->layout = 'ajax';
            
          
        }
        
        function busqueda(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
        }
        
        function event_listar(){
            $this->Login->autenticacion_usuario($this,"/medico/login",$this->group_session);
            
            $ids_usu =  $_POST["id_usuarios"];
            $ids_tra = $_POST["id_transacc"];
            
            if(isset($_POST['txt_fec_ini']) && isset($_POST['txt_fec_fin'])){
                $fec_ini = $this->SqlData->date_to_postgres($_POST["txt_fec_ini"])." 00:00";
                $fec_fin = $this->SqlData->date_to_postgres($_POST["txt_fec_fin"])." 23:59";
            }
            
            $this->paginate = array(
                'limit' => 25,
                'fields' => Array(
                                    "vat.fecha_tran",
                                    "vat.nom_ape_usu",
                                    "vat.log_usu",
                                    "vat.detalle",
                                    "Transaccione.des_tip_tra",
                                    "vat.data_xml",
                                    "vat.id_tip_tra",
                                    "vat.cod_tip_tra",
                                    "vat.id_mod"
                ),
                "joins" => array(
                    Array(
                        "table"      => "view_auditoria_transacciones",
                        "alias"      => "vat",
                        "conditions" => "vat.id_tip_tra = Transaccione.id_tip_tra"
                    )
                ),
                "conditions" => Array(
                    "vat.id_tip_usu_usu" => explode(",",$ids_usu),                                
                    "vat.id_tip_tra" => explode(",",$ids_tra),
                    "CAST(vat.fecha_tran AS DATE) >=" => "$fec_ini",
                    "CAST(vat.fecha_tran AS DATE) <=" => "$fec_fin"
                ),
                "order" => "CAST(vat.fecha_tran AS DATE) DESC" 
            ); 
   
            $arr_query = $this->paginate("Transaccione");
            $auditoria = $this->SqlData->CakeArrayToObjects($arr_query);             
            
            $title = __("Reporte de transacciones",true);
            $data = Array(
                "auditoria" => $auditoria,
                "title"     => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>