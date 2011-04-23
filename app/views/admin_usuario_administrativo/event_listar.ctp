<table style="width: 450px;" align="center">
    <tr class="">
        <td align="center" class="standar_font lista_fondo">
            #
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Login")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Nombre")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Apellido")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Modificar")?>
        </td>
        <td align="center" class="standar_font lista_fondo">
            <?php __("Eliminar")?>
        </td>        
    </tr>

<?php    
    $i = 0;
    foreach ($results as $row){
        $i ++;
        ?>
            <tr>
                <td class="standar_font"><?php echo $i ?></td>
                <td class="standar_font"><?php echo $row->log_usu_adm ?></td>
                <td class="standar_font"><?php echo $row->nom_usu_adm ?></td>
                <td class="standar_font"><?php echo $row->ape_usu_adm ?></td>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->id_usu_adm?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar usuario administrador",true)." ".$row->log_usu_adm?>" class="border" src="<?php echo $this->webroot?>/img/icon/page_white_edit.png"></a></td>
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->id_usu_adm?>','<?php echo $row->log_usu_adm?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar usuario administrador",true)." ".$row->log_usu_adm?>" class="border" src="<?php echo $this->webroot?>/img/icon/cancel.png"></a></td>
            </tr>        
        <?php
    }
?>
</table>