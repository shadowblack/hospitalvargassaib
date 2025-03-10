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
                    <?php echo __("Descripción de la lesión",true)?>
                </a>
            </li> 
            <li>
                <a href="#tabs-3" >
                    <?php echo __("Estudios Micológicos",true)?>
                </a>
            </li>            
            <li>
                <a href="#tabs-4" >
                    <?php echo __("Forma de Infección",true)?>
                </a>
            </li>
        </ul>
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
                     
            <div id="tabs-1" style="height: 325px;" class="standar_fieldset_child">   
                <?php if (count($enf_mic)==0){  ?>
                    <div class="standar_not_register">
                        <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                    </div>            
                <?php } else { ?>                                        
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
                                        <td class="standar_font"><?php echo $row->nom_enf_mic.($row->otr_enf_mic == "" ? "" : " (".$row->otr_enf_mic.")")?></td>
                                    </tr>
                                <?php endforeach;?>
                                </table>
                            </div>
                        </td>                       
                    </tr>                                                                                            
                </table>
                <?php } ?>
             </div> 
             <div id="tabs-2" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <?php if (count($les_cat)==0){  ?>
                    <div class="standar_not_register">
                        <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                    </div>            
                <?php } else { ?>
                <table border="0" align="center" style="width: 550px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="lista_fondo">
                            <?php __("Categoría")?>
                        </td>
                        <td class="lista_fondo">
                            <?php __("Parte del cuerpo")?>
                        </td>
                        <td class="lista_fondo">
                            <?php __("Nombre de la lesión")?>
                        </td>                        
                    </tr>
                    <?php foreach($les_cat as $row):?>                    
                        <tr>
                            <td class="standar_font"><?php echo $row->nom_cat_cue?></td>
                            <td class="standar_font"><?php echo $row->nom_par_cue?></td>                            
                            <td class="standar_font"><?php echo $row->nom_les.($row->otr_les_par_cue == "" ? "" : " (".$row->otr_les_par_cue.")")?></td>
                        </tr>
                    <?php endforeach;?>
                </table>
                <?php } ?>                                   
             </div>
             <div id="tabs-3" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <?php if (count($est_mic)==0){  ?>
                    <div class="standar_not_register">
                        <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                    </div>            
                <?php  } else { ?>
                <table border="0" align="center" style="width: 550px;" cellpadding="0" cellspacing="0">                    
                    <?php
                        $id_tip_exa = "";  
                        foreach($est_mic as $row):                               
                            if ($id_tip_exa <> $row->id_tip_exa){
                                $id_tip_exa = $row->id_tip_exa;                
                            ?>
                            <tr>                               
                                <td class="standar_font_sub lista_fondo" >
                                    <?php __("Estudios para (".$row->nom_tip_exa.")")?> <?php __("Positivo")?>: <?php echo ($row->exa_pac_est == 0 ? __("Si") : ($row->exa_pac_est == 1 ? __("No") : "N/A"))?>
                                </td>                   
                            </tr>
                            <tr style="<?php echo($row->exa_pac_est == 1 ? "display:block" : "display:none")?>">
                                <td style="background-color: white; width:540px">
                                    <?php echo __("Descripción")?>: <?php echo $row->obs_exa_pac?>
                                </td>
                            </tr>   
                    <?php } ?> 
                                           
                        <tr>
                            <td class="standar_font"><?php echo (strtoupper($row->nom_tip_est_mic) == "OTROS" ? $row->nom_tip_est_mic." (".$row->otr_tip_est_mic.")" : $row->nom_tip_est_mic)?></td>                                         
                        </tr>
                    <?php endforeach;?>
                </table> 
                <?php } ?>                                  
             </div> 
             <div id="tabs-4" style="height: 325px; overflow-y: auto;" class="standar_fieldset_child">
                <?php if (count($for_inf)==0){  ?>
                    <div class="standar_not_register">
                        <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                    </div>            
                <?php  } else { ?>
                <table border="0" align="center" style="width: 550px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="lista_fondo">
                            <?php __("Forma de infección")?>
                        </td>                                                                  
                    </tr>
                    <?php foreach($for_inf as $row):?>                    
                        <tr>
                            <td class="standar_font"><?php echo $row->des_for_inf.($row->otr_for_inf == "" ? "" : " (".$row->otr_for_inf.")")?></td>
                        </tr>
                    <?php endforeach;?>
                </table> 
                <?php } ?>                                  
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