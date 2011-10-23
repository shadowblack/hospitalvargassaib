<?php
    class MedicoXmlController extends Controller{
        var $name = "MedicoXml";
        var $uses = Array();
       


        function index(){
            
        }
        
     
        function event_listar_xml(){           
        	$xml = (str_replace('<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>','',urldecode($_REQUEST['data_xml'])));
            $xml = (str_replace('<?xml version="1.0" standalone="yes"?>','',$xml));  
            
            $title = __("Transacciones de Usuarios",true);           
            $data = Array(
                "xml"           => $xml
            );          
            $this->set($data);
           // $this->set('title_for_layout', $title);            
            $this->layout = 'xml';
        }
        
        function event_listar_xls(){
            $this->layout = 'xml';
        }
    }
?>