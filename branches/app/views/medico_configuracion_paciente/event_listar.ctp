<?php if (count($results)==0){  ?>
    <span class="font-standar"><?php __("No existen registros actualmente")?></span>        
<?php die; } ?>        
<table style="width: 450px;" align="center">
    <tr class="">
        <td align="center" class="standar_font lista_fondo">
            #
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Número")?>
        </td>
         <td align="center" class="standar_font lista_fondo">
            <?php __("Cédula")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Nombre")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Apellido")?>
        </td>        
        <td align="center" class="standar_font lista_fondo">
           &nbsp;
        </td>        
        <?php if ($editar):?>
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>          
        <?php endif;?> 
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>        
        <?php if ($eliminar):?>  
        <td align="center" class="standar_font lista_fondo">
            &nbsp;
        </td>
        <?php endif;?>         
    </tr>

<?php    
        
    foreach ($results as $row){                               
        ?>
            <tr>
                <td class="standar_font" align="left"><?php echo $paginator->NumRowPre() ?></td>
                <td class="standar_font" align="left"><?php echo $this->FormatString->NumbersZero($row->Paciente->num_pac,6)?></td>
                <td class="standar_font" align="left"><?php echo $row->Paciente->ced_pac ?></td>
                <td class="standar_font" align="left"><?php echo $row->Paciente->nom_pac ?></td>
                <td class="standar_font" align="left"><?php echo $row->Paciente->ape_pac ?></td>                
                <td class="standar_font" align="center"><a onclick="consult('<?php echo $row->Paciente->id_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Consultar Paciente :",true)." ".$row->Paciente->nom_pac." ".$row->Paciente->ape_pac.", ".__("Cédula",true)." ".$row->Paciente->ced_pac?>" class="border" src="<?php echo $this->webroot?>img/icon/document-scroll-icon.png"></a></td>                
                <?php if ($editar):?>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->Paciente->id_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar Paciente :",true)." ".$row->Paciente->nom_pac." ".$row->Paciente->ape_pac.", ".__("Cédula",true)." ".$row->Paciente->ced_pac?>" class="border" src="<?php echo $this->webroot?>img/icon/page_white_edit.png"></a></td>
                <?php endif;?>
                <td class="standar_font" align="center"><a onclick="his('<?php echo $row->Paciente->id_pac?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Crear Historial del paciente :")." ".$row->Paciente->nom_pac." ".$row->Paciente->ape_pac.", ".__("Cédula",true)." ".$row->Paciente->ced_pac?>" class="border" src="<?php echo $this->webroot?>img/icon/URL-historial-icon-24.png"></a></td>
                <?php if ($eliminar):?>
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->Paciente->id_pac?>','<?php echo Sanitize::paranoid($row->Paciente->nom_pac)." ".Sanitize::paranoid($row->Paciente->ape_pac).", ".__("Cédula",true)." ".Sanitize::paranoid($row->Paciente->ced_pac)?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar Paciente:",true)." ".$row->Paciente->nom_pac." ".$row->Paciente->ape_pac.", ".__("Cédula",true)." ".$row->Paciente->ced_pac?>" class="border" src="<?php echo $this->webroot?>img/icon/cancel.png"></a></td>
                <?php endif;?>
                
                
            </tr>        
        <?php
    }   
?>
</table>
<span class="pag_first"><?php echo $paginator->first();?></span>
<span class="pag_numbers"><?php echo $paginator->numbers();?></span>
<span class="pag_last"><?php echo $paginator->last();?></span>
 
    