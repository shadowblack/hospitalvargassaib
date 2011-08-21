<?php if (count($results)==0){  ?>
    <span class="font-standar"><?php __("No existen registros actualmente")?></span>        
<?php die; } ?>        
<table style="width: 450px;" align="center">
    <tr class="">
        <td align="center" class="standar_font lista_fondo">
            #
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Nombre del tipo de Micosis")?>
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
                <td class="standar_font" align="left"><?php echo $paginator->NumRowPre() ?></td>                
                <td class="standar_font" align="left"><?php echo $row->tm->nom_tip_mic ?></td>                
                <td class="standar_font" align="center"><a onclick="consult('<?php echo $row->TiposMicosisPaciente->id_tip_mic_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Consultar Tipos de Enfermedades del Paciente:",true)." ".$row->tm->nom_tip_mic;?>" class="border" src="<?php echo $this->webroot?>img/icon/document-scroll-icon.png"></a></td>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->TiposMicosisPaciente->id_tip_mic_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar Tipos de Enfermedades del Paciente :",true)." ".$row->tm->nom_tip_mic?>" class="border" src="<?php echo $this->webroot?>img/icon/page_white_edit.png"></a></td>                
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->TiposMicosisPaciente->id_tip_mic_pac?>','<?php echo $row->tm->nom_tip_mic?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar Tipos de Enfermedades del Paciente:",true)?>" class="border" src="<?php echo $this->webroot?>img/icon/cancel.png"></a></td>
            </tr>        
        <?php
    }   
?>
</table>
<?php echo $paginator->numbers();?>
 
    