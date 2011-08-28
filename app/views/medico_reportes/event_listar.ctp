<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: transacciones.ctp
PARÁMETROS: ids de los usuarios, ids de las transacciones, las fechas de inicio y fin
DESCRIPCIÓN: Reporte que muestra las transacciones realizadas por los usuarios del sistema
AUTOR: Lisseth Lozada
FECHA DE MODIFICACIÓN: 20/08/2011
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
</script>

<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 685px;">
                   <?php print __('Listado de Transacciones del Sistema', true); ?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content">
            <table  width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
            	<tr>
            		<th width="100%" style="font-size:10px;text-align: center;"><?php print __('Transacciones del Sistema',true); ?></th>
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
                                                    <?php print __('Nombre',true);?>
                                                </td>
                                                 <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Usuario',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Transacción',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php print __('Fecha',true);?>
                                                </td>
                                                <td align="center" class="standar_font lista_fondo">
                                                    <?php  print __('Detalle',true);?>
                                                </td>
            								</tr>
            								<?php
            								if (count($auditoria) > 0)
            								{
            									// Recorre el resultado de la consulta
            									foreach($auditoria  as $row)
            									{										
                    								?>
                    								<tr class="celda_blanco_text_azul" >
                                                        <td class="standar_font" align="center"><?php echo $row->nom_ape_usu; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->log_usu;?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->des_tip_tra; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->fecha_tran; ?></td>
                                                        <td class="standar_font" align="center">
                                                        <?php 
                                                            if ($row->detalle != 'Si')
                    										{
                    											print '&nbsp;'.$row->detalle;
                    										}
                    										else
                    										{
                                                        ?>
                                                        <a class="texto_link" href="">
                											<?php print '&nbsp;'.$row->detalle; ?>
                										</a>
                									
                										<?php 
                										}
                										?>
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
            					<td colspan="6"  align="center" height="30" style="border: #DEDEDE 2px solid;">
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
            	
            			</table>
            		</td>
            	</tr>
            	<tr class="">
            		<td colspan="6">
            			<table align="center" border="0" cellspacing="0" cellpadding="5" border="1">
            				<tr>
            					<td>					
            						<input name="btn_volver" 	type="submit" value=" <?php print __('Volver',true); ?>" onclick="history.back()">
            					</td>
            				</tr>
            			</table>
            		</td>
            	</tr>
            </table>
        </fieldset>
    </div>       
</div>