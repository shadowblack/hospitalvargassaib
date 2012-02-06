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
            		<th width="100%" style="font-size:10px;text-align: center;"><?php print __('Resumen',true); ?></th>
            	</tr>
				<tr>
					<td valign="top">
						<div class="div_reportes" style="overflow: auto; height: 70px;">
							<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" >
								<tr class="celdas_gris_reporte" align="center">
                                    <td align="left" class="standar_font lista_fondo">
                                        <?php print __('Grupo Etario',true);?>
                                    </td>
                                    <td align="center" class="standar_font lista_fondo">
                                        <?php print __('%',true);?>
                                    </td>                                     
								</tr>
								<?php
								if (count($gru_eta) > 0)
								{ 
									foreach($gru_eta  as $row)
									{		
				                        $porcentaje = round(($row->cantidad * 100 / $row->total_pac),'2');
        								?>
        								<tr class="celda_blanco_text_azul" >                                            
                                            <td class="standar_font" align="left"><?php echo $row->grupo;?></td>
                                            <td class="standar_font" align="center">
                                                <?php echo $porcentaje; ?>
                                                <input type="hidden" id="scantidad" value="<?php echo $row->total_pac;?>">
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