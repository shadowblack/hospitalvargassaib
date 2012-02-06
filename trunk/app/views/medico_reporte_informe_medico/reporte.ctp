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
                		<th width="100%" style="font-size:10px;text-align: center;"><?php print __('LABORATORIO DE MICOLOGÍA',true); ?></th>
                	</tr>
                	<tr>
                		<td>	                                                                       
                            <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Nro. de Historia",true)?>
                                    </td>                        
                                </tr>
                                <tr>
                                    <td valign="top" colspan="4" style="margin-left: 10px;">        
                                       <span class="standar_font"><?php echo $this->FormatString->NumbersZero($dat_pac->id_his,6);?></span>                                                        
                                    </td>
                                </tr>
                                <tr><td height="10px" colspan="10"></td></tr>
                             </table> 
                             <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Ordenado Por",true)?>
                                    </td>  
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Fecha Historia",true)?>
                                    </td>                       
                                </tr>
                                <tr>
                                    <td colspan="10" valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font"><?php echo $dat_pac->ord_por;?></span>                                                        
                                    </td>  
                                    <td valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font"><?php echo $dat_pac->fec_his;?></span>                                                        
                                    </td>               
                                </tr>
                                <tr><td height="10px" colspan="10"></td></tr>
                             </table> 
                             <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Nombre del paciente",true)?>
                                    </td>  
                                    <td colspan="10" width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Cédula del paciente",true)?>
                                    </td>                       
                                </tr>
                                <tr>
                                    <td colspan="10" valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font"><?php echo $dat_pac->nom_pac;?></span>                                                        
                                    </td>  
                                    <td valign="top" style="margin-left: 10px;">        
                                        <span class="standar_font"><?php echo $dat_pac->ced_pac;?></span>                                                        
                                    </td>               
                                </tr>
                                <tr><td height="10px" colspan="10"></td></tr>
                             </table> 
                             <table style="width:100%;margin-left: 10px;" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="184" class="standar_font_sub lista_fondo" style="font-weight: bold;" valign="top">
                                        <?php echo __("Material de la muestra clínica",true)?>
                                    </td>                        
                                </tr>
                                <?php 
                                if (count($mue_cli)==0)
                                {  
                                ?>
                                <tr>
                                    <td valign="top">
                                        <div class="standar_not_register">
                                            <span class="standar_not_register"><?php echo __("Ninguno",true)?></span>
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
                                            <?php foreach($mue_cli as $row):?>
                                                <tr>
                                                    <td class="standar_font"><?php echo $row->nom_mue_cli.($row->otr_mue_cli == "" ? "" : " (".$row->otr_mue_cli.")")?></td>
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
                                            <span class="standar_not_register"><?php echo __("Ninguna",true)?></span>
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
                                    <td colspan="5" class="standar_font_sub lista_fondo" style="font-weight: bold;">
                                        <?php __("Región afectada")?>
                                    </td>                
                                </tr>
                                <?php 
                                if (count($les_cat)==0)
                                {  
                                ?>
                                <tr>
                                    <td valign="top">
                                        <div class="standar_not_register">
                                            <span class="standar_not_register"><?php echo __("Ninguna",true)?></span>
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
                                if (count($est_mic)==0)
                                {  
                                ?>
                                <tr>
                                    <td>
                                		<div class="standar_not_register">
                                			<span class="standar_not_register"><?php echo __("Ninguna",true)?></span>
                                		</div>
                                    </td> 
                                </tr>           
                            	<?php  
                                } 
                                else 
                                { 
                                ?>
                            	<table border="0" align="center" style="width: 550px;margin-left: 10px;" cellpadding="0" cellspacing="0">                    
                            		<?php
                        			$id_tip_exa = "";  
                        			foreach($est_mic as $row):                               
                        				if ($id_tip_exa <> $row->id_tip_exa)
                                        {
                        					$id_tip_exa = $row->id_tip_exa;                
                        				?>
                        				<tr>                               
                        					<td class="standar_font_sub lista_fondo" >
                        						<?php __("$row->nom_tip_exa")?> <?php __(" Positivo")?>: <?php echo ($row->exa_pac_est == 0 ? __("Si") : ($row->exa_pac_est == 1 ? __("No") : "N/A"))?>
                        					</td>                   
                        				</tr>
                        				<tr style="<?php echo($row->exa_pac_est == 1 ? "display:block" : "display:none")?>">
                        					<td class="standar_font" style="background-color: white; width:540px">
                        						<span style="font-weight: bold;"><?php echo __("Observación")?>:</span> <?php echo $row->obs_exa_pac?>
                        					</td>
                        				</tr>
                                           
                            		  <?php 
                                      } 
                                      ?>
                                      			   
                            			<tr>
                            				<td class="standar_font"><?php echo (strtoupper($row->nom_tip_est_mic) == "OTROS" ? $row->nom_tip_est_mic." (".$row->otr_tip_est_mic.")" : $row->nom_tip_est_mic)?></td>                                         
                            			</tr>
                                        <tr><td height="10px" colspan="10"></td></tr> 
                            		<?php 
                                    endforeach;
                                    ?>
                            	</table> 
                            	<?php 
                                } 
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
                                <tr>
                                    <td valign="top">
                                        <div class="standar_not_register">
                                            <span class="standar_not_register"><?php echo __("Ninguna",true)?></span>
                                        </div> 
                                    </td>
                                </tr>           
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