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
    * return object or array zero
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
    
        return Array();
    }
     /**
    * Convirtiendo array en objetos cuando son multiples registros
    * return object or array zero
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
    
        return Array();
    }
    
    /**
     * Convirtiendo fecha 25/12/2011 a data current PostGres  2011-12-25
     */     
     function date_to_postgres($str){
        $exp = "^([0-9]{1,2})+\/([0-9]{1,2})+\/([0-9]{1,4})$";
        preg_match_all("/$exp/",$str,$out,PREG_PATTERN_ORDER);                
        return $out[3][0]."-".$out[1][0]."-".$out[2][0];    
     }
     /**
     * Convirtiendo fecha 2011-12-25 a data current PostGres  25/12/2011
     */     
     function postgres_to_date($str){
        $exp = "^([0-9]{1,4})+\-([0-9]{1,2})+\-([0-9]{1,2})$";
        preg_match_all("/$exp/",$str,$out,PREG_PATTERN_ORDER);                
        return $out[3][0]."/".$out[2][0]."/".$out[1][0];        
     }
}
?>