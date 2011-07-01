<?php

    $_V_LIST    = $this->Html->url("event_listar");
    $_V_EDIT    = $this->Html->url("modificar");
    $_V_DEL     = $this->Html->url("event_eliminar");
    $_V_CONS    = $this->Html->url("consultar");
    $_V_DEL_MEN = __("¿Desea eliminar al paciente",TRUE);
    include_once("../libs/_list_ajax.php");
?>

<script type="text/javascript"> 
   <?php echo $this->Loader->DivPaginatorPost()?>
   
   jQuery(function(){
    jQuery("#tabs-1").css("display","block");
    jQuery( "#tabs" ).tabs();
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery("#btn_buscar").click(function(){                                                       
            paginator_div("<?php echo $_V_LIST ?>",jQuery("#consulta"));            
        })
        
        jQuery("#btn_buscar").trigger("click");
        
        // Mostrando ventana para crear usuarios
        jQuery("#btn_crear").click(function(){            
            parent.document.getElementById("frame_content").src = "<?php echo $this->Html->url("registrar")?>/<?php echo $id?>";
        });                       
   });       
</script>
<?php 

    $T_V_TYPE = 1;
    include_once("../libs/_dialog.php");  
    
?>
<div id="tabs-1" style="display: none;">   

    <div id="tabs">
            <ul>
                <li>
                    <a href="#tabs-1" style="width: 663px;">
                        <?php echo __("Páginas de historias",true)?>
                    </a>
                </li>            
            </ul>
            <fieldset>
            <form name="consulta" id="consulta" onsubmit="return false">                	    
                    <table style="width: 100%;" border="0" class="">
                    <tr>
                        <td align="center">
                            <table style="" border="0">
                                <tr>
                                    <td class="standar_font" style="width:150px;" align="left">
                                        <?php echo __("Número de historia",true)?>:
                                    </td>
                                    <td>
                                        <input type="text" id="num_his" name="num_his" align="left">
                                    </td>                    
                                    <td class="standar_font" align="left">
                                        <?php echo __("Descripción de la historia",true)?>:
                                    </td>                   
                                    <td align="left">
                                        <input type="text" id="des_his" name="des_his">
                                    </td>
                                    <td align="left">
                                        <input type="button" id="btn_crear" name="btn_crear" value="<?php echo __("Crear",true)?>">
                                    </td>                                        
                                </tr>    
                                <tr>
                                    <td class="standar_font" align="left">
                                        <?php echo __("Nombre del doctor",true)?>:
                                    </td>
                                    <td align="left">
                                        <input type="text" id="nom_doc" name="nom_doc">
                                    </td> 
                                    <td colspan="2">
                                        &nbsp;
                                    </td>                   
                                    <td colspan="0" align="right" align="left">                        
                                        <input type="button" id="btn_buscar" name="btn_buscar" value="<?php echo __("Buscar",true)?>">                    
                                    </td>
                                </tr>                            
                            </table>
                        </td>    
                    </tr>
                    <tr>
                        <td align="center" style="">
                            <div id="content" style="height: 264px;width:630px ; overflow-y:auto ;" class="lista_standar">
                                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table style="width: 100%; border="0" class="" align="center">
                                <tr>                                   
                                    <td  align="center" style="height: 0" valign="bottom">
                                        <input type="button" name="btn_volver" value="Volver" onclick="history.back()">
                                    </td>
                                </tr>
                            </table>   
                        </td>
                    </tr>
                </table>            	
            </form>
    </fieldset>
</div>
