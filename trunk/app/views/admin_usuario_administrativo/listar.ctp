<?php
    $_V_LIST    = $this->Html->url("/AdminUsuarioAdministrativo/event_listar");
    $_V_EDIT    = $this->Html->url("/AdminUsuarioAdministrativo/modificar");
    $_V_DEL     = $this->Html->url("/AdminUsuarioAdministrativo/event_eliminar");
    $_V_RES     = $this->Html->url("/AdminUsuarioAdministrativo/event_restablecer");
    $_V_DEL_MEN = __("¿Desea eliminar el usuario administrativo?",TRUE);
    $_V_RES_MEN = __("¿Desea restablecer la contraseña del usuario administrativo?",TRUE);
    //include_once("../libs/_list_ajax.php");
    echo $this->element("list_ajax",Array(
        "_V_LIST"       => $_V_LIST,
        "_V_EDIT"       => $_V_EDIT,
        "_V_DEL"        => $_V_DEL,
        "_V_DEL_MEN"    => $_V_DEL_MEN,
        "_V_RES"        => $_V_RES,
        "_V_RES_MEN"    => $_V_RES_MEN
    ));
?>

<script type="text/javascript">
     <?php echo $this->Loader->DivPaginator()?>        
    
    jQuery(function(){
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs();   
                        
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
    //$T_V_TYPE = 1;
    //include_once("../libs/_dialog.php");  
    echo $this->element("dialog",Array("T_V_TYPE" => 1));  
?>

<div id="tabs-1" style="display: none;">    		
    <div id="tabs">
        <ul>
            <li>
                <a href="#tabs-1" style="width: 680px;">
                    <?php echo __("Administradores",true)?>
                </a>
            </li>            
        </ul>
        <fieldset style="height: 340px;"> 
            <form name="consulta" id="consulta" onsubmit="return false">
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center">
                            <fieldset style="width: 460px;">
                                <legend style="font-weight: bold;"><?php echo __("Condiciones de Búsqueda",true)?></legend>
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
                            </fieldset>
                        </td>    
                    </tr>
                    <tr>
                        <td align="center" style="">
                            <div id="content" style="height: 260px;width:460px;overflow-y:auto;overflow-x: hidden;" class="lista_standar">
                                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
                            </div>
                        </td>
                    </tr>
                </table>
            </form>        
        </fieldset>         
    </div>
</div>    
