<?php
class LoginComponent extends Object{       
    /*
    * Borrando la cache del navegador
    */
    function no_cache(){
        //print_r($_COOKIE);die;
        //setcookie("CAKEPHP", "", 0);
        #header("Expires: Mon, 20 Mar 1998 12:01:00 GMT");
        #header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");

    }
    
    /**
    * Validando transacciones
    */
    function validar_permisos($mods, $mod){
        $arr_mod = explode(",",$mods);
        return in_array($mod,$arr_mod);
    }
    
    /**
     * Validando que el usuario este logeado en el sistema
     */
    function autenticacion_usuario($self,$page,$group = "",$config = ""){ 
       // print_r($self->Session);
       if (!$self->Session->check($group)){ 
        
            switch($config){
                case "iframe":
                    $self->cakeError('session_expired',Array("name"=>"Session Out","message"=>"ha expirado."));
                break;
                /*Es necesario tener habilitado el componente FormatMessege para que funcione*/
                case "json":
                    die($self->FormatMessege->BoxStyle(20,"Session Out, por favor ingresar nuevamente al sistema."));
                break;
                default:
                    $self->redirect($page);
                    die;
                break;
            }                  
            
       }
       
       /*
        if (!$self->Session->read(($group <> "" ? $group."." : "")."id_usu"))        
                $self->redirect($page);
                */
    }
    
    /**
     * Validando que el usuario este logeado en el sistema json
     */
    function autenticacion_usuario_json($self){
        if (!$self->Session->read("id_usu"))
            /*Es necesario tener habilitado el componente FormatMessege para que funcione*/
            die($self->FormatMessege->BoxStyle(20,"Por favor inicie session en el sistema."));
    }
}
?>