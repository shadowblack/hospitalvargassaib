<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/css/esti_esta.css"?>"/>
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
    <div id="tabs" style="overflow: auto;">
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
                                                    #
                                                </td>
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
					                            // debug($auditoria);
            									// Recorre el resultado de la consulta
            									foreach($auditoria  as $row)
            									{										
                    								?>
                    								<tr class="celda_blanco_text_azul" >
                                                        <td class="standar_font" align="center"><?php echo $i= $paginator->NumRowPre(); ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->vat->nom_ape_usu; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->vat->log_usu;?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->Transaccione->des_tip_tra; ?></td>
                                                        <td class="standar_font" align="center"><?php echo $row->vat->fecha_tran; ?></td>
                                                        <td class="standar_font" align="center">
                                                        
                                                        <div class="listar_reporte">
                                                        <ul><li>
                                                        <?php 
                                                        if ($row->vat->detalle != 'Si')
                										{
                											print $row->vat->detalle;
                                                            ?>
                                                            <img src="<?php echo $this->webroot?>/img/no.png" width="10" height="10"/>
                                                            <?php
                                                            
                										}
                										else
                										{
                                                        ?>
                                                        
                                                        <a  href="javascript:visualizarDetalle('<?php print ($i);?>',450,350);">
                											<span >
                                                                <!--?php print $row->vat->detalle; ?-->
                                                                <img src="<?php echo $this->webroot?>/img/si.png" width="10" height="10"/>
                                                            </span>
                										</a>
                                                        </li>
                                                        </ul>
                                                        </div>
                                                        
                                                        
                                                        <form action="<?php echo $this->Html->url("/MedicoXml/event_listar_xml")?>" method="post" id="<?php print ($i);?>" target="Detalle">
        													<input name="data_xml"     type="hidden" value="<?php echo urlencode($row->vat->data_xml); ?>">
        													<input name="id_tip_tra"   type="hidden" value="<?php echo $row->vat->id_tip_tra; ?>">
        													<input name="id_mod"       type="hidden" value="<?php echo $row->vat->id_mod; ?>">
        													<input name="cod_tip_tra"  type="hidden" value="<?php echo $row->vat->cod_tip_tra; ?>">
        												</form>
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
 