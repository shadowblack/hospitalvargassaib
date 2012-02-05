<?php
/*
-----------------------------------------------------------------------------------------------
ARCHIVO: busqueda.php
PARÁMETROS: (ningunos)
DESCRIPCIÓN: página de búsqueda para visualizar el reporte de las transacciones realizadas.
AUTOR: Lisseth Lozada
FECHA DE CREACIÓN: 04/04/2011
SIGIS. C.A
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
		var arrayUsuarios = new Array();
		var arrayTransac = new Array();
                  
		var fec_ini = jQuery("#txt_fec_ini").val();
        var fec_fin = jQuery("#txt_fec_fin").val();
	
			
		if(fec_ini > fec_fin){
			alert("<?php print __('La fecha Final no puede ser menor a la inicial',true);?>");
			retVal = false;
		}
		else
		{
            jQuery("#cmb_usuarios").each(function(){
                if(jQuery(this).find("option:selected"))
                {
                    arrayUsuarios.push(jQuery(this).val());
                }
            });
            jQuery("#id_usuarios").val(arrayUsuarios);
                      
            
            jQuery("#cmb_transacciones").each(function(){
                if(jQuery(this).find("option:selected"))
                {
                    arrayTransac.push(jQuery(this).val());
                }
            });
            jQuery("#id_transacc").val(arrayTransac);
            
            if(jQuery("#id_usuarios").val() == '')
            {
                alert("<?php print __('Debe seleccionar al menos un usuario de la lista',true);?>");
                retVal = false;
            }
            
            if(jQuery("#id_transacc").val() == '')
            {
                alert("<?php print __('Debe seleccionar al menos una transacción de la lista',true);?>");
                retVal = false;
            }
            
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
    
    function trabajo_lista(lista) {
       	// Función que permite seleccionar los registros de la lista
		for(var i=0; i<lista.options.length; i++)  {
			lista.options[i].selected = true
		}
	}

</script>
<?php 
   // echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>

<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                   <?php print __('Condiciones de Búsqueda', true); ?>
                </a>
            </li>            
        </ul>
        <fieldset style="" class="standar_fieldset_content">
            <form method="post" action="<?php echo $this->Html->url("/MedicoReportes/event_listar")?>" name="frmBusqueda" id="frmBusqueda" onsubmit="return Validar()"> 
                <div style="" class="standar_fieldset_child"> 
                	<input type="hidden" id="id_usuarios" name="id_usuarios" value="">
                	<input type="hidden" id="id_transacc" name="id_transacc" value="">
                	<table width="560" border="0" align="center" cellpadding="0" cellspacing="1" class="poner_border">
                		<tr>
                			<td>
                				<table align="center" border="0" width="100%" cellpadding="0" cellspacing="0">
                					<tr>
                						<td colspan="4">&nbsp;</td>
                					</tr>
                					<tr>
                						<td align="right" class="font-standar" valign="top" style="margin-right: 5px;" >
                							<span class="standar_asterisco">* </span><?php print __('Seleccione los Usuarios', true); ?>:
                							<input type="button" name="SelTodo" value="<?php print __('Sel. Todos', true);?>" onclick="trabajo_lista(document.frmBusqueda.cmb_usuarios)" style="margin-left: 30px;font-size:xx-small;">
    	                                </td>
                						<td align="left">
                							<select id="cmb_usuarios" name="cmb_usuarios" size="5" multiple style="width: 150px;">
                                            <?php 
                                                  foreach($usuarios_medico as $row){?>   
                                                    <option value="<?php echo $row->id_tip_usu_usu;?>" title="<?php echo $row->nom_usu_doc;?>"><?php echo $row->nom_usu_doc;?></option>
                                            <?php }?>
                							</select>
                						</td>
                						<td align="right" class="standar_margin lista_standar" valign="top" style="margin-right: 5px;" >
                							<span class="standar_asterisco">* </span><?php print __('Seleccione las Transacciones', true); ?>:
                                            <input type="button" name="SelTodo" value="<?php print __('Sel. Todos', true);?>" onclick="trabajo_lista(document.frmBusqueda.cmb_transacciones)" style="margin-left:30px;font-size:xx-small;"></div>
                						</td>
                						<td align="right" class="standar_margin lista_standar">
                							<select name="cmb_transacciones" id="cmb_transacciones" size="5" multiple style="width: 150px;">
                	                        <?php 
                                                  foreach($transacciones as $row){?>   
                                                    <option value="<?php echo $row->id_tip_tra;?>" title="<?php echo $row->des_tip_tra;?>"><?php echo $row->des_tip_tra;?></option>
                                            <?php }?>
                							</select>
                						</td>
                					</tr>
                					<tr>
                						<td colspan="4">&nbsp;</td>
                					</tr>
                					<tr>
                						<td colspan="4" align="center" class="font-standar" style="font-size:10px"> 
                							<span class="standar_asterisco">** </span><?php print __('Nota', true); ?>: 
                                            <?php print __('Puede hacer selección múltiple en la lista mediante el uso de las teclas', true); ?> <i>Ctrl</i> <?php print __('o bien', true); ?> <i>Shift</i>.
                						</td>
                					</tr>
                					<tr>
                						<td colspan="4">&nbsp;</td>
                					</tr>
                					<tr>
                						<td colspan="4">
                							<table width="100%" border="0" cellpadding="0" cellspacing="0">
                								<tr style="text-align: center; width: 100%">
                					          		<td width="50%" class="font-standar">
                						          		<span class="standar_asterisco">* </span><?php print __('Fecha Inicial', true); ?>:
                                                        <input readonly="readonly" name="txt_fec_ini" id="txt_fec_ini" value="" size="12" class="date required" />
                									</td>
                									<td width="50%" class="font-standar">
                										<span class="standar_asterisco">* </span><?php print __('Fecha Final', true); ?>:
                										<input readonly="readonly" name="txt_fec_fin" id="txt_fec_fin" value="" size="12" class="date required" />
                									</td>
                								</tr>
                								<tr>
                									<td colspan="4"   align="center" class="font-standar" style="font-size:10px">
                										<span class="standar_asterisco">** </span><?php print __('Nota', true).':'.__('El formato de la fecha es (dd/mm/aaaa)', true); ?>
                									</td>
                								</tr>
                							</table>
                						</td>
                					</tr>
                					<tr><td  colspan="4">&nbsp;</td></tr>
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
                					<tr >
                						<td  colspan="4">&nbsp;</td>
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