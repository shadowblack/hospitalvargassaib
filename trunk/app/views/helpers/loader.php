<?php
    /**
     * @author Luis Marin
     * @name LoaderHelper
     * Fecha: 16/06/2011 11:21pm
     * Carga todo aquello que tenga que ver con algun elemento loading
     */
    class LoaderHelper extends AppHelper{
       /**
         * @author Luis Marin
         * @name DivPaginator
         * @return String Javascript
         * Fecha: 16/06/2011 11:21pm
         * Carga todo aquello que tenga que ver con algun elemento loading
         */
        function DivPaginator(){
            $jquery = "            
             var paginator_div = function(url){            
                    jQuery(\"#content\").html('<img id=\"cargador\" src=\"".$this->webroot."img/icon/load_list.gif\" style=\"margin-top: 120px;display: block;\">');
                    jQuery(\"#content\").load(url,function(){
                        jQuery(\"#cargador\").css(\"display\",\"none\");
                        
                               
                        jQuery(\"a[href*='/page:']\").click(function(event){
                            event.preventDefault();
                            var url = jQuery(this).attr(\"href\");
                            paginator_div(url);
                        });
                    });
                }
            ";
            return $jquery;
        }
    }
?>