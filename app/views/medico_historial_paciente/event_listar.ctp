<?php if (count($results)==0){  ?>
    <span class="font-standar"><?php __("No existen registros actualmente")?></span>        
<?php die; }?>
<table style="width: 610px;" align="center">
    <tr class="">
        <td align="center" class="standar_font lista_fondo">
            #
        </td>
        <td align="center" class="standar_font lista_fondo" >            
            <?php __("Página de Historial"); echo " ".$this->FormatString->NumbersZero($results[0]->HistorialesPaciente->id_his,6)?>
        </td>
         <td align="center" class="standar_font lista_fondo" style="width: 120px;">
            <?php __("Fecha de registro")?>
        </td>
        <td align="center" class="standar_font lista_fondo" style="width: 175px;" >
            <?php __("Descripción del histórico")?>
        </td>
        <td align="center" class="standar_font lista_fondo" style="width: 175px;" >
            <?php __("Descripción adicional del paciente")?>
        </td>
        <td align="center" class="standar_font lista_fondo" style="width: 120px;" >
            <?php __("Nombre del operador")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
           &nbsp;
        </td>
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>  
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>   
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>         
    </tr>

<?php            
    foreach ($results as $row){                               
        ?>
            <tr>
                <td class="standar_font" align="left" valign="top"><?php echo $paginator->NumRowPre() ?></td>
                <td class="standar_font" align="left" valign="top"><?php echo $this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?></td>
                <td class="standar_font" align="left" valign="top"><?php echo $row->HistorialesPaciente->fec_his ?></td>
                <td class="standar_font" align="left" valign="top"><?php echo $row->HistorialesPaciente->des_his ?></td>
                <td class="standar_font" align="left" valign="top"><?php echo $row->HistorialesPaciente->des_adi_pac_his ?></td>
                <td class="standar_font" align="left" valign="top"><?php echo $row->Doctore->nom_doc." ".$row->Doctore->ape_doc ?></td>
                <td class="standar_font" align="center" valign="top"><a onclick="consult('<?php echo $row->HistorialesPaciente->id_his?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Consultar Historial :",true)." ".$this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?>" class="border" src="<?php echo $this->webroot?>img/icon/document-scroll-icon.png"></a></td>
                <td class="standar_font" align="center" valign="top"><a onclick="edit('<?php echo $row->HistorialesPaciente->id_his?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar Historial :",true)." ".$this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?>" class="border" src="<?php echo $this->webroot?>img/icon/page_white_edit.png"></a></td>
                <td class="standar_font" align="center" valign="top"><a onclick="info('<?php echo $row->HistorialesPaciente->id_his?>','<?php echo $row->HistorialesPaciente->id_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Estudios e información del historial:",true)." ".$this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?>" class="border" src="<?php echo $this->webroot?>img/icon/task-list-icon.png"></a></td>
                <td class="standar_font" align="center" valign="top"><a onclick="del('<?php echo $row->HistorialesPaciente->id_his?>','<?php echo $this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Estudios e información del historial:",true)." ".$this->FormatString->NumbersZero($row->HistorialesPaciente->pag_his,6)?>" class="border" src="<?php echo $this->webroot?>img/icon/cancel.png"></a></td>
                
                
            </tr>        
        <?php
    }   
?>
</table>
<?php echo $paginator->numbers();?>
 
    