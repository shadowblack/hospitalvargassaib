<script type="text/javascript">                                    
        jQuery(function() {
           //jQuery( "#tabs" ).tabs();   
        });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>    		
    
        
        <fieldset style="" class="standar_fieldset_content"> 	                                                                       
                     
              
                <?php 
                if (count($enf_mic)==0)
                {  
                ?>
                <div class="standar_not_register">
                    <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                </div>            
                <?php 
                } 
                else 
                { 
                ?>                                        
                <table style="width:540px;" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="184" class="font-standar lista_fondo" style="font-weight: bold;" valign="top">
                            <?php echo __( "Tipos de enfermedades",true)?>
                        </td>                        
                    </tr>
                    <tr>
                        <td valign="top">        
                            <!--<span class="standar_font_sub" style="margin-left: 10px;"><?php echo $tip_mic->nom_tip_mic?></span>-->                                                          
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
                <?php 
                } 
                ?>
             
                <?php 
                if (count($les_cat)==0)
                {  
                ?>
                <div class="standar_not_register">
                    <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                </div>            
                <?php 
                } 
                else 
                { 
                ?>
                <table border="0" align="center" style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="font-standar lista_fondo" style="font-weight: bold;">
                            <?php __("Categoría")?>
                        </td>
                        <td class="font-standar lista_fondo" style="font-weight: bold;">
                            <?php __("Parte del cuerpo")?>
                        </td>
                        <td class="font-standar lista_fondo" style="font-weight: bold;">
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
                <?php 
                } 
                ?>                                   
             
                                                                              
        </fieldset>