<?php
class LoginComponent extends Object
{
    /*
    * Combirtiendo array en obejto
    */
    function array_to_object($array = array()) {
        if (!empty($array)) {
            $data = false;
    
            foreach ($array as $akey => $aval) {
                $data -> {$akey} = $aval;
            }
    
            return $data;
        }
    
        return false;
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
    
    /*
    * Validando transacciones
    */
    function validar_permisos($mods, $mod){
        $arr_mod = explode(",",$mods);
        return in_array($mod,$arr_mod);
    }
}
?>