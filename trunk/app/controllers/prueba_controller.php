<?php
    class PruebaController extends Controller{
        var $name="Prueba";
        var $uses = Array();
        function index(){
            $var = "hola";
            $this->set("prueba",$var);
        }
        function prueba2($paran){            
            echo $paran;            
        }       
    }
?>