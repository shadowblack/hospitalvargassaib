<?php
class SqlDataComponent extends Object
{
    /*
    * tranformando sql resultado directo y numerico
    */
    
    function result_num($arr){
        return (int)$arr[0][0]["result"];
    }
    
    /**
    * Convirtiendo array en objeto
    * return object or false
    */
    function array_to_object($array = array()) {
        $array = $array[0][0];
        if (!empty($array)) {
            $data = false;
    
            foreach ($array as $akey => $aval) {
                $data -> {$akey} = $aval;
            }
    
            return $data;
        }
    
        return false;
    }
     /**
    * Convirtiendo array en objetos cuando son multiples registros
    * return object or false
    */
    function array_to_objects($array = array()) {
        
        
        if (!empty($array)) {
            $data = Array();
            $dataArray = Array();
            $i=0;
             foreach ($array as $akey => $val_arr) {
                $data = false;
                foreach ($val_arr[0] as $arr_akey => $arr_aval) {                    
                    $data -> {$arr_akey} = $arr_aval;
                    $dataArray[$i] = $data;        
                }
                $i++;
             }
            
            return $dataArray;
        }
    
        return false;
    }
}
?>