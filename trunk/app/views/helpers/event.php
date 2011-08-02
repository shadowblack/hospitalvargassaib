<?php
/**
 * @author Luis Marin
 * @name EventHelper
 * Fecha: 16/06/2011 11:21pm
 * Carga todo aquello que tenga que ver con algun elemento loading
 */
class EventHelper extends AppHelper{
   /**
     * @author Luis Marin
     * @name Insert
     * @return String Javascript
     * Fecha: 08/01/2011 11:21am
     * Proporciona una estructura de registro en forma de ajax proporcionando datos que posteriormente 
     * se leen en el include dialogo
     */
    function Insert($url,$select,$target=""){
        $jquery = "            
         var array_form = jQuery(\"$select\").serializeArray();              
            jQuery.ajax({
                url:\"$url\",                    
                type: \"POST\",
                data: array_form,
                dataType: \"json\",                                      
                error:function(){alert(\"Error json\")},
                success: function(data){                                                                     
                    eval(\"data=\"+data);   
                    
                    jQuery(\"#dialog #dialog_messege\").css(\"display\",\"block\");jQuery(\"#dialog img\").css(\"display\",\"none\"); 
                                                                 
                    var _select = \"#dialog #dialog_text\";                      
                    jQuery(_select).empty();
                    jQuery(_select).text(data.coment);
                    
                    _select = \"#dialog td > div > div\";
                    jQuery(_select).attr(\"class\",\"\");
                    jQuery(_select).addClass(data.class_background);
                    
                    _select = \"#dialog span\";
                    jQuery(_select).attr(\"class\",\"\");
                    jQuery(_select).addClass(data.class_icon);
                    
                    jQuery(\"#dialog\").dialog(\"destroy\");
                    jQuery(\"#dialog\").dialog({
                        modal:true,
                        minHeight: 150,                            
                        buttons: [
                            {
                                text: '".__("Aceptar",true)."',
                                click: function() {                                     
                                    jQuery(this).dialog(\"close\");
                                    if (data.event > 0){
                                        ".(!empty($target) ? ($target == "back" ? "history.back()" : "window.location.href = '$target';") : "")."
                                    } 
                                }
                            }
                        ],
                        resizable: false
                    }).css(\"display\",\"block\");                                                                                            
                }                   
            });
            
            jQuery(\"#dialog\").dialog(\"destroy\");
            jQuery(\"#dialog #dialog_messege\").css(\"display\",\"none\");jQuery(\"#dialog img\").css(\"display\",\"block\");                
            jQuery(\"#dialog\").dialog({                            
                resizable: false
            }).css(\"display\",\"block\");
        ";
        return $jquery;
    }   
     
    /**
     * @author Luis Marin
     * @name Insert
     * @return String Javascript jquery
     * Fecha: 08/01/2011 11:21am
     * Proporciona una estructura de actualizacion en forma de ajax proporcionando datos que posteriormente 
     * se leen en el include dialogo
     */
    function Update($url,$select,$target = ""){
        $jquery = "             
                var array_form = jQuery(\"$select\").serializeArray();
                jQuery.ajax({
                    url: \"$url\",
                    type: \"POST\",
                    data: array_form,
                    dataType: \"json\",
                    error: function() {
                        alert(\"Consultar con el Programador o desarrollador\")
                    },
                    success: function(data) {
                        eval(\"data=\" + data);

                        jQuery(\"#dialog #dialog_messege\").css(\"display\", \"block\");
                        jQuery(\"#dialog img\").css(\"display\", \"none\");

                        var _select = \"#dialog #dialog_text\";
                        jQuery(_select).empty();
                        jQuery(_select).text(data.coment);

                        _select = \"#dialog td > div > div\";
                        jQuery(_select).attr(\"class\", \"\");
                        jQuery(_select).addClass(data.class_background);

                        _select = \"#dialog span\";
                        jQuery(_select).attr(\"class\", \"\");
                        jQuery(_select).addClass(data.class_icon);

                        jQuery(\"#dialog\").dialog(\"destroy\");
                        jQuery(\"#dialog\").dialog({
                            modal: true,
                            minHeight: 150,
                            buttons: [{
                                text: '".__("Aceptar", true)."',
                                click: function() {                                    
                                    jQuery(this).dialog(\"close\");
                                    if (data.event > 0){
                                        ".
                                            ($target <> false ? (!empty($target) ? ($target == "back" ? "history.back()" : "window.location.href = '$target';") : "") : "")
                                        ." 
                                    }
                                }
                            }],
                            resizable: false
                        }).css(\"display\", \"block\");
                    }
                });

                jQuery(\"#dialog\").dialog(\"destroy\");
                jQuery(\"#dialog #dialog_messege\").css(\"display\", \"none\");
                jQuery(\"#dialog img\").css(\"display\", \"block\");
                jQuery(\"#dialog\").dialog({
                    resizable: false
                }).css(\"display\", \"block\");
        ";
        
        return $jquery;
    }       
    
     /**
     * @author Luis Marin
     * @name Event
     * @return String Javascript jquery
     * Fecha: 08/01/2011 11:21am
     * Proporciona una estructura de validacion de usuario en forma de ajax proporcionando datos que posteriormente 
     * se leen en el include dialogo para la validacion
     */
    function Valid($url,$select,$redirect=""){
        $jquery = "                                                                     
                var array_form = jQuery(\"$select\").serializeArray();
                jQuery(\"#cargador_volatile\").css(\"display\",\"block\");              
                jQuery.ajax({
                    url:\"$url\",                    
                    type: \"POST\",
                    data: array_form,
                    dataType: \"json\",                                      
                    error:function(){alert(\"Error json\")},
                    success: function(data){                                                                     
                        eval(\"data=\"+data);   
                        
                        jQuery(\"#dialog #dialog_messege\").css(\"display\",\"block\");jQuery(\"#dialog img\").css(\"display\",\"none\"); 
                                                                     
                        var _select = \"#dialog #dialog_text\";                      
                        jQuery(_select).empty();
                        jQuery(_select).text(data.coment);
                        
                        _select = \"#dialog td > div > div\";
                        jQuery(_select).attr(\"class\",\"\");
                        jQuery(_select).addClass(data.class_background);
                        
                        _select = \"#dialog span\";
                        jQuery(_select).attr(\"class\",\"\");
                        jQuery(_select).addClass(data.class_icon);
                        
                        jQuery(\"#dialog\").dialog(\"destroy\");
                        jQuery(\"#dialog\").dialog({
                            modal:true,
                            minHeight: 150,                            
                            buttons: [
                                {
                                    text: '".__("Aceptar",true)."',
                                    click: function() { 
                                        jQuery(this).dialog(\"close\"); 
                                    }
                                }
                            ],
                            resizable: false
                            }).css(\"display\",\"block\");                                                                                                            if (data.event == 1){
                                 jQuery(\"#cargador_volatile\").css(\"display\",\"block\");
                                ".(!empty($redirect) ? "window.location.href = \"$redirect\";" : "")."
                        }
                    }                   
                });
                
                jQuery(\"#dialog\").dialog(\"destroy\");
                jQuery(\"#dialog #dialog_messege\").css(\"display\",\"none\");jQuery(\"#dialog img\").css(\"display\",\"block\");                
                jQuery(\"#dialog\").dialog({                            
                    resizable: false
                }).css(\"display\",\"block\"); 
        ";
        
        return $jquery;
    }                   
}
?>