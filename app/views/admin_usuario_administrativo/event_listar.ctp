<?php if (count($results)==0){  ?>
    <span class="font-standar"><?php __("No existen registros actualmente")?></span>        
<?php die;} ?>    
    
    
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
        <td align="center" class="standar_font lista_fondo" colspan="3">
            <?php __("Opciones")?>
        </td>
               
    </tr>

<?php    

    $i = 0;
    foreach ($results as $row){
        $i ++;
        ?>
            <tr>
                <td class="standar_font"><?php echo $paginator->NumRowPre() ?></td>
                <td class="standar_font"><?php echo $row->UsuariosAdministrativo->log_usu_adm ?></td>
                <td class="standar_font"><?php echo $row->UsuariosAdministrativo->nom_usu_adm ?></td>
                <td class="standar_font"><?php echo $row->UsuariosAdministrativo->ape_usu_adm ?></td>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->UsuariosAdministrativo->id_usu_adm?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar administrador",true)." ".$row->UsuariosAdministrativo->log_usu_adm?>" class="border" src="<?php echo $this->webroot?>img/icon/page_white_edit.png"></a></td>
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->UsuariosAdministrativo->id_usu_adm?>','<?php echo $row->UsuariosAdministrativo->log_usu_adm?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar administrador",true)." ".$row->UsuariosAdministrativo->log_usu_adm?>" class="border" src="<?php echo $this->webroot?>img/icon/cancel.png"></a></td>
                <td class="standar_font" align="center"><a onclick="res('<?php echo $row->UsuariosAdministrativo->id_usu_adm?>','<?php echo $row->UsuariosAdministrativo->log_usu_adm?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Restablecer contraseña al administrador",true)." ".$row->UsuariosAdministrativo->log_usu_adm?>" class="border" src="<?php echo $this->webroot?>img/icon/restablecer_clave.gif"></a></td>
            </tr>        
        <?php
    }
?>
</table>
<?php echo $paginator->numbers();?>