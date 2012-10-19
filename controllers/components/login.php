<?php
class LoginComponent extends Object{   
    
    function startup(&$controller)
    {        
            $this->controller = $controller;        
    }
    
    
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
               
                    $self->cakeError('session_expired',Array("name"=>"Session Out","message"=>"ha expirado.","code"=>""));
                     die;
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
    }
    
    /**
     * Validando que el usuario este logeado en el sistema json
     */
    function autenticacion_usuario_json($self){
        if (!$self->Session->read("id_usu"))
            /*Es necesario tener habilitado el componente FormatMessege para que funcione*/
            die($self->FormatMessege->BoxStyle(20,"Por favor inicie session en el sistema."));
    }
    
    /**
    * isPermitted:
    * Se busca el módulo actual ($CODTRANS en los módulos permitidos para el usuario $CODTRANSUSU
    */
    function isPermitted($_operacion, $_operaciones, $config = "iframe")
    {
        $self = $this->controller;
        if( !is_array($_operaciones) )
        {
            $_operaciones = explode(",", $_operaciones);
        }

        if (!in_array($_operacion, $_operaciones))
        {
           switch($config){
                case "iframe":
               
                    $self->cakeError('session_expired',Array("name"=>"Permisos insuficientes","message"=>"No tiene permiso para entrar a esta sección sección consulte con el administrador de sistema.","code"=>""));
                     die;
                break;
                /*Es necesario tener habilitado el componente FormatMessege para que funcione*/
                case "json":
                    die($self->FormatMessege->BoxStyle(20,"Permisos insuficientes. No tiene permiso para entrar a esta sección sección consulte con el administrador de sistema."));
                break;
                default:
                    $self->redirect($page);
                    die;
                break;
            }
        }
    }
    /**
    * buscar modulo:
    * Autor: Luis Raúl
    * Descripción: Verifica si el usuario tiene permisos, de ser asi devuelve true
    * Se busca el módulo actual ($CODTRANS en los módulos permitidos para el usuario $CODTRANSUSU, retorna verdadero o falso
    */
    function isPermittedBoolean($_operacion, $_operaciones)
    {
        if( !is_array($_operaciones) )
        {
            $_operaciones = explode(",", $_operaciones);
        }
        return in_array($_operacion, $_operaciones);
    }
}
?>