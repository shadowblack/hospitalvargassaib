<script type="text/javascript">                                    
        jQuery(function() {  
        });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>    		
    
        
        <fieldset style="" class="standar_fieldset_content">
            <div id="contenedor" class="standar_div">
                 <table  width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
                	<tr>
                		<th width="100%" style="font-size:10px;text-align: center;"><?php print __('Enfermedades Micológicas',true); ?></th>
                	</tr>
                	<tr>
                		<td>	                                                                       
                            <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Datos del Paciente",true)?>
                                    </td>                        
                                </tr>
                                <tr>
                                    <td valign="top" colspan="4" style="margin-left: 10px;">        
                                        <span class="standar_font_sub">
                                            <?php echo __("Nro. Historia",true)?>:
                                        </span><br /> 
                                        <span class="standar_font"><?php echo $this->FormatString->NumbersZero($dat_pac->id_his,6);?></span>                                                        
                                    </td>
                                    <td valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font_sub">
                                            <?php echo __("Fecha Historia",true)?>:
                                        </span><br />  
                                        <span class="standar_font"><?php echo $dat_pac->fec_his;?></span>                                                        
                                    </td>  
                                    <td valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font_sub">
                                            <?php echo __("Nombre/cédula",true)?>:
                                        </span><br />  
                                        <span class="standar_font" ><?php echo $dat_pac->nom_pac;?></span>                                                        
                                    </td>                      
                                </tr>
                                <tr><td height="10px" colspan="10"></td></tr>                                                                                            
                            </table>   
                              
                                                                     
                            <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Tipo de Enfermedad ",true)?><?php echo $tip_mic->nom_tip_mic?>
                                    </td>                        
                                </tr>
                                <?php 
                                if (count($enf_mic)==0)
                                {  
                                ?>
                                <tr>
                                    <td valign="top">
                                        <div class="standar_not_register">
                                            <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                                        </div>
                                    </td>
                                </tr>            
                                <?php 
                                } 
                                else 
                                { 
                                ?>   
                                <tr>
                                    <td valign="top">        
                                        <div style="line-height: 10px;">
                                            <table >                                                                    
                                            <?php foreach($enf_mic as $row):?>
                                                <tr>
                                                    <td class="standar_font"><?php echo $row->nom_enf_mic.($row->otr_enf_mic == "" ? "" : " (".$row->otr_enf_mic.")")?></td>
                                                </tr>
                                            <?php endforeach;?>
                                            </table>
                                        </div>
                                    </td>                       
                                </tr>
                                <?php 
                                } 
                                ?> 
                                <tr><td height="10px" colspan="10"></td></tr>                                                                                            
                            </table>
                                
                            <table border="0" align="center" style="width: 100%;margin-left: 10px;" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="standar_font_sub lista_fondo" style="font-weight: bold;">
                                        <?php __("Categoría")?>
                                    </td>
                                    <td class="standar_font_sub lista_fondo" style="font-weight: bold;">
                                        <?php __("Parte del cuerpo")?>
                                    </td>
                                    <td class="standar_font_sub lista_fondo" style="font-weight: bold;">
                                        <?php __("Nombre de la lesión")?>
                                    </td>                        
                                </tr>
                                <?php 
                                if (count($les_cat)==0)
                                {  
                                ?>
                                <tr>
                                    <td valign="top">
                                        <div class="standar_not_register">
                                            <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                                        </div> 
                                    </td>
                                </tr>           
                                <?php 
                                } 
                                else 
                                { 
                                foreach($les_cat as $row):?>                    
                                <tr>
                                    <td class="standar_font"><?php echo $row->nom_cat_cue?></td>
                                    <td class="standar_font"><?php echo $row->nom_par_cue?></td>                            
                                    <td class="standar_font"><?php echo $row->nom_les.($row->otr_les_par_cue == "" ? "" : " (".$row->otr_les_par_cue.")")?></td>
                                </tr>
                                <?php 
                                endforeach;
                                } 
                                ?>
                                <tr><td height="10px" colspan="10"></td></tr> 
                            </table>
                                
                                
                            <table border="0" align="center" style="width: 100%;margin-left: 10px;" cellpadding="0" cellspacing="0">                    
                                <?php
                                $id_tip_exa = "";  
                                foreach($est_mic as $row):                               
                                    if ($id_tip_exa <> $row->id_tip_exa)
                                    {
                                        $id_tip_exa = $row->id_tip_exa;                
                                    ?><tr><td height="10px" colspan="10"></td></tr>
                                    <tr>                               
                                        <td class="standar_font_sub lista_fondo" >
                                            <?php __("Estudios para (".$row->nom_tip_exa.")")?>
                                        </td>
                                                           
                                    </tr>
                                        
                                    <?php   
                                    } 
                                    if (count($est_mic)==0)
                                    {  
                                    ?>
                                    <tr>
                                        <td valign="top">
                                            <div class="standar_not_register">
                                                <span class="standar_not_register"><?php echo __("No hay registros asociados",true)?></span>
                                            </div>
                                        </td>
                                    </tr>            
                                    <?php  
                                    } 
                                    else 
                                    { 
                                    ?>          
                                    <tr>
                                        <td class="standar_font"><?php echo (strtoupper($row->nom_tip_est_mic) == "OTROS" ? $row->nom_tip_est_mic." (".$row->otr_tip_est_mic.")" : $row->nom_tip_est_mic)?></td>                                         
                                    </tr>
                                    <?php 
                                    } 
                                    ?>  
                                <?php 
                                endforeach;
                                ?>
                                <tr><td height="10px" colspan="10"></td></tr> 
                            </table>                           
                             
                                
                            <table border="0" align="center" style="width: 100%;margin-left: 10px;" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="standar_font_sub lista_fondo" >
                                        <?php __("Forma de infección")?>
                                    </td>                                                                  
                                </tr>
                                <?php 
                                if (count($for_inf)==0)
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
                                    <?php foreach($for_inf as $row):?>                    
                                    <tr>
                                        <td class="standar_font"><?php echo $row->des_for_inf.($row->otr_for_inf == "" ? "" : " (".$row->otr_for_inf.")")?></td>
                                    </tr>
                                    <?php endforeach;?>
                                <?php 
                                } 
                                ?> 
                                <tr><td height="10px" colspan="10"></td></tr> 
                            </table>
                        </td> 
                    </tr>
                    <tr class="noimprimir">
                		  <td colspan="6">
                			 <table align="center" border="0" cellspacing="0" cellpadding="5" border="1">
                				<tr>
                					<td>					
                						<input name="btn_imprimir" type="button" onclick="JavaScript:window.print();" value=" <?php print __('Imprimir',true); ?>">
                					</td>
                				</tr>
                			 </table>
                		  </td>
                	   </tr>
                </table>
            </div>                                                          
        </fieldset>