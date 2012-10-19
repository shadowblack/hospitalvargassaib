<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: resumen.ctp
DESCRIPCIÓN: Reporte que muestra la cantidad de géneros por pacientes
AUTOR: Lisseth Lozada
FECHA DE MODIFICACIÓN: 30/10/2011
SIGIS. C.A
-----------------------------------------------------------------------------------------------
*/
?>
<script language="Javascript">

    jQuery(function(){
              
    });
</script>

<table  width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
	<tr>
		<td>
			<table border="1" style="border-collapse: inherit;" align="center" cellpadding="0" cellspacing="0" width="90%">
                <tr>
            		<th colspan="2" width="100%" style="font-size:10px;text-align: center;"><?php print __('Resumen',true); ?>
                    <!--<img onclick="window.print();" style="text-align: right;cursor: pointer;" width="17px" height="17px" src="<?php echo $this->webroot?>img/icon/print.gif" title="<?php print __("Imprimir Resumen", true);?>" />-->
                    </th>
                    
            	</tr>
				<tr>
					<td valign="top" >
						<div class="div_reportes" style="overflow: auto; height: 50px;">
							<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
								<tr class="celdas_gris_reporte" align="center">                                    
                                     <td align="left" class="standar_font lista_fondo">
                                        <?php print __('Género',true);?>
                                    </td>
                                    <td align="center" class="standar_font lista_fondo">
                                        <?php print __('Cantidad',true);?>
                                    </td>
                                    <td align="center" class="standar_font lista_fondo">
                                        <?php print __('%',true);?>
                                    </td>                                    
								</tr>
								<?php
								if (count($genero) > 0)
								{ 
									foreach($genero  as $row)
									{		
									    $porcentaje = round(($row->cantidad * 100 / $row->total_pac),'2');
        								?>
        								<tr class="celda_blanco_text_azul" >                                            
                                            <td class="standar_font" align="left"><?php echo $row->genero;?></td>
                                            <td class="standar_font" align="center"><?php echo $row->cantidad;?></td>
                                            <td class="standar_font" align="center"><?php echo $porcentaje.''; ?><input type="hidden" id="scantidad" value="<?php echo $row->total_pac;?>"></td>
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
</table>