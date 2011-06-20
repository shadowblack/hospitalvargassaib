<?php
    $_V_LIST    = $this->Html->url("/AdminUsuarioAdministrativo/event_listar");
    $_V_EDIT    = $this->Html->url("/AdminUsuarioAdministrativo/modificar");
    $_V_DEL     = $this->Html->url("/AdminUsuarioAdministrativo/event_eliminar");
    $_V_DEL_MEN = __("¿Desea eliminar el usuario administrativo?",TRUE);
    include_once("../libs/_list_ajax.php");
?>

<script type="text/javascript">
     <?php echo $this->Loader->DivPaginator()?>
    jQuery(function(){
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery("#btn_buscar").click(function(){
            
            var _str =  "/"+jQuery("#nom_usu_adm").val()+","
                        +jQuery("#ape_usu_adm").val()+","
                        +jQuery("#log_usu_adm").val()+"/"; 
                        paginator_div("<?php echo $_V_LIST ?>"+_str);                   
           
        })
        
        jQuery("#btn_buscar").trigger("click");
   });
  
</script>

<?php
    $T_V_TYPE = 1;
    include_once("../libs/_dialog.php");    
?>

<form name="consulta" id="consulta" onsubmit="return false">
    <table style="width: 100%;" border="0" class="standar_position">
    <tr>
        <td align="center">
            <table style="" border="0">
                <tr>
                    <td class="standar_font">
                        <?php echo __("Nombre",true)?>:
                    </td>
                    <td>
                        <input type="text" id="nom_usu_adm" name="nom_usu_adm">
                    </td>                    
                    <td class="standar_font">
                        <?php echo __("Apellido",true)?>:
                    </td>                   
                    <td>
                        <input type="text" id="ape_usu_adm" name="ape_usu_adm">
                    </td>                                        
                </tr>    
                <tr>
                    <td class="standar_font">
                        <?php echo __("Login",true)?>:
                    </td>
                    <td>
                        <input type="text" id="log_usu_adm" name="log_usu_adm">
                    </td>                    
                    <td colspan="0" align="right">                        
                        <input type="button" id="btn_buscar" name="btn_buscar" value="<?php echo __("Buscar",true)?>">                    
                    </td>
                </tr>                            
            </table>
        </td>    
    </tr>
    <tr>
        <td align="center" style="">
            <div id="content" style="height: 300px;width:460px ; overflow-y:auto ;" class="lista_standar">
                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
            </div>
        </td>
    </tr>
</table>
</form>