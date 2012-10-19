<?php ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="html"/>
	<xsl:template match="/">
        <head>
            
            <link rel="stylesheet" type="text/css" href="<?php echo $this->Html->webroot."css/detalle.css";  ?>"/>
        </head>
		<div id="contenedorListado" class="fondo_m">
			<table width="400" border="0" align="center">
				<tr>
					<td></td>
				</tr>
				<xsl:comment>
				*********************************************************************************
					por cada nodo tabla dentro del documento xml 
					pintamos una fila con su tabla hija
				**********************************************************************************
				</xsl:comment>
				<xsl:for-each select="//tabla">
				<tr>
					<td>
						<table width="350" border="1" cellpadding="0" cellspacing="0" align="center">
							<th colspan="4" style="font-size:11px">
								<xsl:value-of select="@nombre"/>
							</th>
							<tr>
								<td class="lista_fondo" align="center">
									<span>Campo</span> 
								</td>
								<td align="center">
									<span>Actual</span>
								</td>
								<td align="center">
									<span>Anterior</span>
								</td>
								<td align="center">
									<span>¿Cambió?</span>
								</td>
							</tr>
							<xsl:for-each select="./campo">
								<tr>
									<td>
										<span>
											<xsl:value-of select="@nombre"/>
										</span>
									</td>
									<td>
										<span>
											<xsl:value-of select="./actual"/>
										</span>
									</td>
									<td>
										<span>
											<xsl:value-of select="./anterior"/>
										</span>
									</td>
									<td>
										<span>
											<xsl:if test="./actual = ./anterior">
												No
											</xsl:if>
    										<xsl:if test="not(./actual = ./anterior)">
    											Si
    										</xsl:if>
										</span>
									</td>
								</tr>
							</xsl:for-each>
						</table>
					</td>
				</tr>
				</xsl:for-each>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td>
									<input name="btn_imprimir" type="button" value="Imprimir" onClick="JavaScript:window.print();"/>
								</td>
								<td>
									<input name="btn_cerrar" type="button" value="Cerrar" onClick="JavaScript:window.close();"/>
								</td>									
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
</xsl:stylesheet>