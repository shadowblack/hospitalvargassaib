<?php
    class MedicoXmlController extends Controller{
        var $name = "MedicoXml";
        var $uses = Array();
       


        function index(){
            
        }
        
     
        function event_listar_xml(){
            
            header('Content-Type: application/xml');
        	print '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>';
        	print '<?xml-stylesheet href="$this->Html->url("/MedicoXml/event_listar_xml")" type="text/xsl"?>';
        	print( str_replace('<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>','',urldecode($_REQUEST['data_xml'])));
            
            
            $title = __("Transacciones de Usuarios",true);
           
            $data = Array(
                "title"           => $title
            );
          
            $this->set($data);
            $this->set('title_for_layout', $title);            
            $this->layout = 'default';
        }
    }
?>