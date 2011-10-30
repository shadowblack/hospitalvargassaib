<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: busqueda.php
PARÁMETROS: (ningunos)
DESCRIPCIÓN: página de búsqueda para visualizar las estadistica por tipo de micosis.
AUTOR: Lisseth Lozada
FECHA DE CREACIÓN: 30/10/2011
-----------------------------------------------------------------------------------------------
*/
?>
<script language="Javascript">

     jQuery(function(){
        jQuery("#tabs-1").css("display","block");
        jQuery("#tabs").tabs();     
        parent.jQuery("#title_content").html("<?php echo $title;?>");
       
		jQuery("#txt_fec_ini,#txt_fec_fin").datepicker({
            dateFormat: "dd/mm/yy",
			showOn: "button",
			buttonImage: "<?php echo $this->webroot?>/img/icon/calendar.png",
			buttonImageOnly: true,
            inline:true
		});
    });
    
    // Se verifica que se haya seleccionado al menos un elemento de la lista y que la fecha sea correcta
	function Validar()
	{
		var retVal = true;
		
		var fec_ini = jQuery("#txt_fec_ini").val();
        var fec_fin = jQuery("#txt_fec_fin").val();
	
			
		if(fec_ini > fec_fin){
			alert("<?php print __('La fecha Final no puede ser Menor a la inicial',true);?>");
			retVal = false;
		}
		else
		{             
            if(fec_ini == '')
            {
                alert("<?php print __('La fecha inicial es requerida',true);?>");
                retVal = false;
            }
            
            if(fec_fin == '')
            {
                alert("<?php print __('La fecha final es requerida',true);?>");
                retVal = false;
            }
		}
		return retVal;
	}
</script>
<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 653px;">
                   <?php print __('Condiciones de Búsqueda', true); ?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content">
            <form method="post" action="<?php echo $this->Html->url("/MedicoEstadisticaTipoMicosis/contenido")?>" name="frmBusqueda" id="frmBusqueda" onsubmit="return Validar()"> 
                <div style="" class="standar_fieldset_child"> 
                	<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" class="poner_border">
                		<tr>
                			<td>
                				<table align="center" border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr><td height="15px"></td></tr>
                                    <tr>
                                		<td colspan="4" width="100%" class="font-standar" style="text-align: center;font-weight: bold;"><?php print __('Datos del Paciente',true); ?></td>
                                	</tr>
                					<tr><td height="20px"></td></tr>
                					<tr>                                    
                                        <td align="right" class="font-standar" valign="top" style="margin-right: 5px;" >
                							<?php print __('Tipo de Micosis', true); ?>:
                                        </td>
                                        <td valign="top">
                                            <select id="sel_tip_mic" name="sel_tip_mic" class="required" style="width: 120px;">
                                                <option value="">--<?php echo __("Todas",true)?>--</option>
                                                <?php foreach($tipo_micosis as $row){?>   
                                                        <option value="<?php echo $row->id_tip_mic;?>" title="<?php echo $row->nom_tip_mic;?>"><?php echo $row->nom_tip_mic;?></option>
                                                <?php }?>
                                            </select>
                                        </td>
                					</tr>
                                    <tr><td height="15px"></td></tr>
                                    <tr>
                                		<td colspan="4" width="100%" class="font-standar" style="text-align: center;font-weight: bold;"><?php print __('Fecha de Registro',true); ?></td>
                                	</tr>
                                    <tr><td height="20px"></td></tr>
                       	            <tr>
    					          		<td align="right" class="font-standar">
    						          		*<?php print __('Fecha Inicial', true); ?>:
                                        </td>
                                        <td class="font-standar"  valign="top">
                                            <input name="txt_fec_ini" id="txt_fec_ini" value="" size="12" class="date required" />
                                        </td>
    									<td align="right" class="font-standar">
    										*<?php print __('Fecha Final', true); ?>:
    									</td>
                                        <td class="font-standar"  valign="top">
    										<input name="txt_fec_fin" id="txt_fec_fin" value="" size="12" class="date required" />
    									</td>
    								</tr>
                                    <tr>
    									<td colspan="4"   align="center" class="font-standar" style="font-size:10px">
    										**<?php print __('Nota', true).':'.__('El formato de la fecha es (dd/mm/aaaa)', true); ?>
    									</td>
    								</tr>
                					<tr><td height="20px"></td></tr>
                                    <tr>
                						<td  colspan="4" align="center">
                							<table  align="center">
                								<tr>
                									<td>
                										<input type="submit" value=" <?php print __('Aceptar', true); ?> ">
                										&nbsp;&nbsp;
                										<input type="reset" value=" <?php print __('Cancelar', true); ?> ">
                									</td>
                								</tr>
                							</table>			
                						</td>
                					</tr>
                				</table>
                			</td>
                		</tr>
                	</table>
                </div>
            </form>
        </fieldset>
    </div>       
</div>