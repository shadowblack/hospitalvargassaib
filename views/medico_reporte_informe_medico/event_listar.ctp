<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: event_listar.ctp
PARÁMETROS: Cédula, Nombre, Apellido, Nro. Historia y las fechas de inicio y fin
DESCRIPCIÓN: Reporte que muestra un listado para generar el informe médico del paciente
AUTOR: Lisseth Lozada
FECHA DE CREACIÓN: 05/02/2012
SIGIS. C.A
-----------------------------------------------------------------------------------------------
*/
?>		
<script type="text/javascript" src="<?php echo $this->webroot?>/js/script/util.js"></script>
<script language="JavaScript" src="<?php echo $this->webroot?>/js/script/operaciones.js"></script>		
<script language="Javascript">

     jQuery(function(){
        jQuery("#tabs-1").css("display","block");
        jQuery("#tabs").tabs();     
        parent.jQuery("#title_content").html("<?php echo $title;?>");
      });
    
    function generarInforme(id_tip_mic_pac){
        var url = "<?php echo $this->Html->url("/MedicoReporteInformeMedico/reporte");?>/"+id_tip_mic_pac;
        parent.util.openWindow("prueba","<?php echo __("Reporte del Informe médico",true)?>",url,0,0,500,380); 
    }
</script>

<div id="tabs-1" style="display: none;">    		
    <div id="tabs" style="overflow: auto;">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 685px;">
                   <?php print __('Listado', true); ?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content">
            <table  width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
            	<tr>
            		<th width="100%" style="font-size:10px;text-align: center;"><?php print __('Informes médicos',true); ?></th>
            	</tr>
            	<tr>
            		<td>
            			<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
            				<tr>
            					<td valign="top">
            						<div class="div_reportes">
            							<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
            								<tr class="celdas_gris_reporte" align="center">
                                                <td align="center" class="standar_font lista_fondo">
                                                    #
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Nro.Historia',true);?>
                                                </td>
                                                 <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Fecha Historia',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Cédula',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Nombre',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php  print __('Apellido',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php  print __('Tipo de Micosis',true);?>
                                                </td>
            								</tr>
            								<?php
            								if (count($tip_enf_mic_pac) > 0)
            								{
					                             //debug($tip_enf_mic_pac);
            									// Recorre el resultado de la consulta
            									foreach($tip_enf_mic_pac  as $row)
            									{										
                    								?>
                    								<tr class="celda_blanco_text_azul" >
                                                        <td class="standar_font" align="center"><?php echo $paginator->NumRowPre(); ?></td>
                                                        <td class="standar_font" align="center"><?php echo $this->FormatString->NumbersZero($row->vtemp->num_his,6); ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->vtemp->fec_his;?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->Paciente->ced_pac; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->Paciente->nom_pac; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->Paciente->ape_pac; ?></td>
                                                        <td class="standar_font" align="center" onclick="generarInforme('<?php echo $row->vtemp->id_tip_mic_pac;?>');">
                                                            <div class="listar_reporte">
                                                                <ul>
                                                                    <li>
                                                                        <a>
                                                                            <?php echo $row->vtemp->nom_tip_mic; ?>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            
                                                        </td>
                                                    </tr>
                    								<?php								
            									}
            								?>
            							</table>
            						</div>
            					</td>
            				</tr>
            							<?php 
            							}
            							else
            							{
            							?>		
            				<tr>
            					<td colspan="7"  align="center" height="30" style="border: #DEDEDE 2px solid;">
            						<span class="standar_font lista_fondo">
            						<?php
            							// Imprime el total de registros encontrados
            							print __('No existen registros de acuerdo a la búsqueda realizada',true);
            						?>
            						</span>
            					</td>
            				</tr>
            							<?php 
            							}
            							?>
                            <tr><td height="10px"></td></tr>  
                            <tr>
                                <td colspan="5" align="center">                                    
                                    <span class="pag_first"><?php echo $paginator->first();?></span>
                                    <span class="pag_numbers"><?php echo $paginator->numbers();?></span>
                                    <span class="pag_last"><?php echo $paginator->last();?></span>
                                </td>
                            </tr>
            	
            			</table>
            		</td>
            	</tr>
            	<tr class="">
            		<td colspan="6">
            			<table align="center" border="0" cellspacing="0" cellpadding="5" border="1">
            				<tr>
            					<td>					
            						<input name="btn_volver" type="submit" value=" <?php print __('Volver',true); ?>" onclick="history.back()">
            					</td>
            				</tr>
            			</table>
            		</td>
            	</tr>
            </table>
        </fieldset>
    </div>       
</div>