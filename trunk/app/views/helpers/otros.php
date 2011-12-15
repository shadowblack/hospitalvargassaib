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
    private $id;
    
    function Script()
    {        
        return 
        "f_otros = function(self){  
            jQuery(self).each(function(i){
                var _otros = jQuery(this).attr(\"otros\"),                                               
                _checked = jQuery(this).is(\":checked\");
                    jQuery(\"input[name=\'\"+_otros+\"\']\")
                    .attr(\"disabled\",!_checked)
                    .css(\"display\",_checked ? \"block\" : \"none\");  
            });                                            
        }   
        var _select_checkbox_otros = \":checkbox[otros]\";         
        f_otros(_select_checkbox_otros);  
         
        jQuery(_select_checkbox_otros).click(function(){
            f_otros(this);
        });";
    }
    
    /**
     * @name Attr
     * @return "Devuelve el atributo 'otros' que se muestra en la etiqueta, se usa para contruir el campo con la ayuda del metodo Text"
     * @param $id(id de la tabla a utilizar), 
     *        $other_row(el valor del registro de clave que identifica el otros, ejemplo 'otros'),
     *        $attr_name(Muestra proporciona el nombre que tendra en campo texto que se genera y el campo hidden)
     */ 
    function Attr($id,$other_row,$attr_name){        
        $this->attr = $attr_name;
        $this->other = $other_row;
        $this->id = $id;
        return (strtoupper($this->other) == $this->str ? "otros = '".$this->attr."'" : ""); 
    }
    
    /**
     * @name Text
     * @return "Devuelve el HTML del campo de texto otros y es el encargado de construir el hidden que contiene el id del animal otros"
     * @param $maxlength:(El tamaño del campo texto que se mostrara), $value:(El valor del campo, si por defecto se tiene que mostrar algo)
     */    
    function Text($maxlength,$value = ""){        
        if (strtoupper($this->other)  == $this->str)
            return '<input type="text" name="'.$this->attr.'" value="'.$value.'" style="width: 100%;display:none" class="required standar_margin" maxlength="$maxlength">'.
                   '<input type="hidden" name="hdd_'.$this->attr.'" value="'.$this->id.'"';
        else
            return "";
    }
}
?>