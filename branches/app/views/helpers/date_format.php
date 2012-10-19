<?php
    class DateFormatHelper extends AppHelper{
        /**
         * Convirtiendo fecha 2011-12-25 a data current PostGres  25/12/2011
         */     
        function PostgresToDate($date_postgres){
            $exp = "^([0-9]{1,4})+\-([0-9]{1,2})+\-([0-9]{1,2})$";
            preg_match_all("/$exp/",$date_postgres,$out,PREG_PATTERN_ORDER);                
            return $out[3][0]."/".$out[2][0]."/".$out[1][0];    
        }       
    }
//^([0-9]{1,4})+\-([0-9]{1,2})+\-([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2})
//2011-06-26 01:40:26.332-04:30
?>