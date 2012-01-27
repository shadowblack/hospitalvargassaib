<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: contenido.ctp
DESCRIPCIÓN: Carga el gráfico y su tabulación
AUTOR: Lisseth Lozada
FECHA DE MODIFICACIÓN: 30/10/2011
SIGIS. C.A
-----------------------------------------------------------------------------------------------
*/
//die($result);
?>
<script>
    jQuery(function(){
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery.post("grafico",{fil: "<?php print $result;?>"},function(data){
            jQuery("#div_grafico").html(data);
        },"html");
        
        jQuery.post("resumen",{fil: "<?php print $result;?>"},function(data){
            jQuery("#div_resumen").html(data);
        },"html");
    });
</script>
<table style="width:540px;margin-top: 20px;" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
		<td style="text-align: center;">
			<div id="div_resumen" style="text-align: center;"></div>
		</td>
	</tr>
    <tr><td height="20px"></td></tr>
    <tr>
        <td style="text-align: center;">
            <div id="div_grafico" style="text-align: center;" ></div>
        </td>
    </tr>
    <tr><td height="20px"></td></tr>
    <tr>
		<td colspan="6">
			<table align="center" border="0" cellspacing="0" cellpadding="5" border="1">
				<tr>
					<td>					
						<input name="btn_volver" type="button" value=" <?php print __('Volver',true); ?>" onclick="history.back()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>