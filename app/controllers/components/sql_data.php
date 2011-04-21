<?php
class SqlDataComponent extends Object
{
    /*
    * tranformando sql resultado directo y numerico
    */
    
    function result_num($arr){
        return (int)$arr[0][0]["result"];
    }
    
}
?>