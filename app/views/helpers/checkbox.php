<?php
/**
 * Convirtiendo checkbox seleccionados en cadenas de texto en un campo hidden  25/12/2011
 * @author Luis Marin
 */   
class CheckboxHelper extends AppHelper{          
    function Multiple($checkbox_name,$form_select, $global = false){
        $function = str_replace("_","",$checkbox_name);
        return "         
        if (jQuery(\"[name='hdd_".substr($checkbox_name,0,strlen($checkbox_name)-1)."']\").length == 0)      
            jQuery(\"$form_select\").append(\"<input type='text' name='hdd_".substr($checkbox_name,0,strlen($checkbox_name)-1)."' value=''>\");
        
        // si no existe la funcion la construye
        if(!window.".$function."){
             ".(!$global ? "var" : "")." ".$function." = function(){
                var _arr_str = new Array();
                jQuery(\"[name^='".$checkbox_name."']:checked\").each(function(i,obj){
                    _arr_str.push(obj.value)
                });        
                var _str = _arr_str.join(\",\");
                jQuery(\"[name='hdd_".substr($checkbox_name,0,strlen($checkbox_name)-1)."']\").val(_str);
            }
        }
        ".$function."();
        jQuery(\"[name^='".$checkbox_name."']\").click(function(){            
            ".$function."();
        }); 
                       
        ";
        }       
}
?>