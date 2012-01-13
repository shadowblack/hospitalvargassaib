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
//die('$result-->'.$result.'   ' . $result_fec);
?>
<script>
    jQuery(function(){ 
        jQuery.post("grafico",{fil_enf: "<?php print $result;?>",fil_fec: "<?php print $result_fec;?>"},function(data){
            jQuery("#div_grafico_tip_les").html(data);
        },"html");
        
        jQuery.post("resumen",{fil_enf: "<?php print $result;?>",fil_fec: "<?php print $result_fec;?>"},function(data){
            jQuery("#div_resumen_tip_les").html(data);
        },"html");
    });
</script>
<table style="width:540px;margin-top: 20px;overflow: auto; " border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
		<td style="text-align: center;">
			<div id="div_resumen_tip_les" style="text-align: center;"></div>
		</td>
	</tr>
    <tr><td height="20px"></td></tr>
    <tr>
        <td style="text-align: center;">
            <div id="div_grafico_tip_les" style="text-align: center;" ></div>
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