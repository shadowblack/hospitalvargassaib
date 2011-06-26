<?php if (count($results)==0){  ?>
    <span class="font-standar"><?php __("No existen registros actualmente")?></span>        
<?php die; } ?>        
<table style="width: 620px;" align="center">
    <tr class="">
        <td align="center" class="standar_font lista_fondo">
            #
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Número")?>
        </td>
         <td align="center" class="standar_font lista_fondo">
            <?php __("Fecha de registro")?>
        </td>
        <td align="center" class="standar_font lista_fondo" style="width: 180px;">
            <?php __("Descripción del historico")?>
        </td>
        <td align="center" class="standar_font lista_fondo" style="width: 180px;">
            <?php __("Descripción adicional del paciente")?>
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
                <td class="standar_font"><?php echo $paginator->NumRowPre() ?></td>
                <td class="standar_font"><?php echo $this->FormatString->NumbersZero($row->HistorialesPaciente->num_his,6)?></td>
                <td class="standar_font"><?php echo $row->HistorialesPaciente->fec_his ?></td>
                <td class="standar_font"><?php echo $row->HistorialesPaciente->des_his ?></td>
                <td class="standar_font"><?php echo $row->HistorialesPaciente->des_adi_pac_his ?></td>
                <td class="standar_font" align="center"><a onclick="consult('<?php echo $row->HistorialesPaciente->id_his?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Consultar Historial :",true)." ".$row->HistorialesPaciente->des_his?>" class="border" src="<?php echo $this->webroot?>img/icon/document-scroll-icon.png"></a></td>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->HistorialesPaciente->id_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar Historial :",true)." ".$row->HistorialesPaciente->des_his?>" class="border" src="<?php echo $this->webroot?>img/icon/page_white_edit.png"></a></td>                
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->HistorialesPaciente->id_pac?>','<?php echo $row->HistorialesPaciente->des_his?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar Pacientes:",true)." ".$row->HistorialesPaciente->des_his?>" class="border" src="<?php echo $this->webroot?>img/icon/cancel.png"></a></td>
                
                
            </tr>        
        <?php
    }   
?>
</table>
<?php echo $paginator->numbers();?>
 
    