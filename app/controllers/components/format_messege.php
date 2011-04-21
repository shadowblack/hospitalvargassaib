<?php
class FormatMessegeComponent extends Object
{
    /*
    * tranformando sql resultado directo y numerico
    */
    
    function box_style($result,$messege){
        switch($result){
            case 1:
                $class =    "
                    ,class_background:'ui-state-highlight ui-corner-all',
                    class_icon:'ui-icon ui-icon-info'
                 ";
            break;
            case 0:
                $class =    "
                    ,class_background:'ui-state-error ui-corner-all',
                    class_icon:'ui-icon ui-icon-alert'
                 ";
            break;            
        }
        
        $json = json_encode("{
                            event:$result,coment:'".__($messege,true)."'
                            $class
                            }");
        return $json;
    }
    
}
?>