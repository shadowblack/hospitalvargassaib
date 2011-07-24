<?php
/**
 * Clase creada que especifica el formato de las cadenas 
 */
 
 /**
 * Realiza el tipico history.back de javascript implementado en php para mantener la session 
 * @author Luis Marin
 * @access Public 
 * @type Helper
 * @email ninja.aoshi@gmail.com
 * @url http://www.pokodetodo.com/node/47
 * @since 17.07.2011
 */
 class HistoryHelper extends AppHelper{

    function GetHistory($json_history){
        return "
             var json = $json_history        
                jQuery.each(json,function(key,value){
                    var _select = (jQuery(\"#\"+key)),
                    tag         = _select.get(0).tagName,
                    type        = _select.attr(\"type\");
                    switch(tag){
                        case \"INPUT\":
                            if(type == \"text\" || type == \"password\" || type == \"hidden\"){
                                _select.val(value);
                            }
                        break;
                        case \"SELECT\":
                            _select.val(value);
                        break;
                    }
                })
        ";
    }
    
    function Url($url){
         
        return $url."/history:true";
    }
}
?>