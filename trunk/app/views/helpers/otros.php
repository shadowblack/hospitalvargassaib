<?php

/**
 * @author Luis Marin
 * @Description Automatiza cuando se tenga que mostrar otros
 * @date 04/12/204 
 */ 
class OtrosHelper extends AppHelper
{   
    private $str    = "OTROS";
    private $attr   = "";
    private $other  = "";
    
    function Script()
    {        
        return 
        "f_otros = function(self){                                
            var _otros = jQuery(self).attr(\"otros\"),                                               
            _checked = jQuery(self).is(\":checked\");
                jQuery(\"input[name=\'\"+_otros+\"\']\")
                .attr(\"disabled\",!_checked)
                .css(\"display\",_checked ? \"block\" : \"none\");                                  
        }   
        var _select_checkbox_otros = \":checkbox[otros]\";         
        f_otros(_select_checkbox_otros);  
         
        jQuery(_select_checkbox_otros).click(function(){
            f_otros(this);
        });";
    }
    
    function Attr($other,$attr){        
        $this->attr = $attr;
        $this->other = $other;
        return (strtoupper($this->other) == $this->str ? "otros = '".$this->attr."'" : ""); 
    }
    
    function Text(){
        echo $this->other;
        if (strtoupper($this->other)  == $this->str)
            return '<input type="text" name="'.$this->attr.'" value="" style="width: 100%;display:none" class="required standar_margin" maxlength="20">';
        else
            return "";
    }
}
?>