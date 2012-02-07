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
        <?php if($isPermitedModOpe || $isPermitedEliOpe || $isPermitedResOpe): ?>
        <td align="center" class="standar_font lista_fondo" colspan="3">
            <?php __("Opciones")?>
        </td>
         <?php endif; ?>     
    </tr>

<?php    

    $i = 0;
    foreach ($results as $row){
        $i ++;
        ?>
            <tr>
                <td class="standar_font"><?php echo $paginator->NumRowPre();  ?></td>
                <td class="standar_font"><?php echo $row->Doctore->log_doc ?></td>
                <td class="standar_font"><?php echo $row->Doctore->nom_doc ?></td>
                <td class="standar_font"><?php echo $row->Doctore->ape_doc ?></td>
                <?php if($isPermitedModOpe) : ?>
                <td class="standar_font" align="center"><a onclick="edit('<?php echo $row->Doctore->id_doc?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Modificar operador",true)." ".$row->Doctore->log_doc?>" class="border" src="<?php echo $this->webroot?>/img/icon/page_white_edit.png"></a></td>
                <?php endif;
                      if($isPermitedEliOpe): ?>
                <td class="standar_font" align="center"><a onclick="del('<?php echo $row->Doctore->id_doc?>','<?php echo $row->Doctore->log_doc?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Eliminar operador",true)." ".$row->Doctore->log_doc?>" class="border" src="<?php echo $this->webroot?>/img/icon/cancel.png"></a></td>
                <?php endif;
                      if($isPermitedResOpe): ?>
                <td class="standar_font" align="center"><a onclick="res('<?php echo $row->Doctore->id_doc?>','<?php echo $row->Doctore->log_doc?>')" href="javascript:void(0)" class="border"><img title="<?php echo __("Restablecer contraseña al operador",true)." ".$row->Doctore->log_doc?>" class="border" src="<?php echo $this->webroot?>img/icon/restablecer_clave.gif"></a></td>
                <?php endif;?>
            </tr>        
        <?php
    }
?>
</table>
<?php echo $paginator->first();?>
<?php echo $paginator->numbers();?>
<?php echo $paginator->last();?>