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
        header ("Expires: Thu, 27 Mar 1980 23:59:00 GMT"); //la pagina expira en una fecha pasada
        header ("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); //ultima actualizacion ahora cuando la cargamos
        header ("Cache-Control: no-cache, must-revalidate"); //no guardar en CACHE
        header ("Pragma: no-cache");
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