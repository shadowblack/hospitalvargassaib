<?php
/**
 * Clase creada que especifica el formato de las cadenas 
 */
 class FormatStringHelper extends AppHelper{
/**
 * Formatea los numeros anteponiendo ceros al comienso de la cadena
 * @author Moises
 * @access Public 
 * @return String
 */
        function NumbersZero($evaluar_numero,$ceros){
            return sprintf("%0".$ceros."s", $evaluar_numero );
        }
    }
?>