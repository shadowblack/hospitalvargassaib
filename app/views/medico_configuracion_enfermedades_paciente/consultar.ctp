<script type="text/javascript">                                    
        jQuery(function() {
                        
           // jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();                      
                                       
        });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" >
                    <?php echo __("Micosis",true)?>
                </a>
            </li>
            <li>
                <a href="#tabs-2" >
                    <?php echo __("Descripción de la lesion",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
                     
            <div id="tabs-1" style="height: 325px;" class="standar_fieldset_child">                                          
                <table style="width:540px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="font-standar lista_fondo" valign="top">
                            <?php echo __( "Tipos de enfermedades",true)?>
                        </td>                        
                    </tr>
                    <tr>
                        <td valign="top">        
                            <span class="standar_font_sub" style="margin-left: 10px;"><?php echo $tip_mic->nom_tip_mic?></span>                                                          
                            <div style="line-height: 10px;">
                                <table style="margin-left: 20px;">                                                                    
                                <?php foreach($enf_mic as $row):?>
                                    <tr>
                                        <td class="standar_font"><?php echo $row->nom_enf_mic?></td>
                                    </tr>
                                <?php endforeach;?>
                                </table>
                            </div>
                        </td>                       
                    </tr>                                                                                            
                </table>
             </div> 
             <div id="tabs-2" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <table border="0" align="center" style="width: 550px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="lista_fondo">
                            <?php __("Categoria")?>
                        </td>
                        <td class="lista_fondo">
                            <?php __("Parte del cuerpo")?>
                        </td>
                        <td class="lista_fondo">
                            <?php __("Nombre de la lession")?>
                        </td>                        
                    </tr>
                    <?php foreach($les_cat as $row):?>                    
                        <tr>
                            <td class="standar_font"><?php echo $row->nom_cat_cue?></td>
                            <td class="standar_font"><?php echo $row->nom_par_cue?></td>                            
                            <td class="standar_font"><?php echo $row->nom_les?></td>
                        </tr>
                    <?php endforeach;?>
                </table>                   
                <!-- Contenido de las enfermedades -->
             </div>               
             <table style="width: 100%;" class="">
                <tr>                    
                    <td  align="center" style="height: 0" valign="bottom">
                        <input type="button" name="btn_volver" value="Volver" onclick="window.location.href='<?php echo $_SERVER["HTTP_REFERER"]?>'">                       
                    </td>
                </tr>
            </table>                                                                   
        </fieldset>
    </div>       