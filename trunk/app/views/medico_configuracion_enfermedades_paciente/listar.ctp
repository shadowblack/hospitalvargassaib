<?php
    $_V_LIST    = $this->Html->url("event_listar/$id_his");
    $_V_EDIT    = $this->Html->url("modificar");
    $_V_DEL     = $this->Html->url("event_eliminar");
    $_V_CONS    = $this->Html->url("consultar");
    $_V_DEL_MEN = __("¿Desea eliminar al paciente",TRUE);
    //include_once("../libs/_list_ajax.php");
    
    echo $this->element("list_ajax",Array(
        "_V_CONS"       => $_V_CONS,
        "_V_LIST"       => $_V_LIST,
        "_V_EDIT"       => $_V_EDIT,
        "_V_DEL"        => $_V_DEL,
        "_V_DEL_MEN"    => $_V_DEL_MEN
    ));    
   
?>

<script type="text/javascript"> 
    var page = "<?php echo $_SERVER["HTTP_REFERER"]?>";                
    parent.parent.util.win["inf_his<?php echo $id_pac?>"]._resize(600,470);
    <?php echo $this->Loader->DivPaginatorPost()?>
       
    jQuery(function(){           
        <?php echo $this->History->GetHistory($history)?>
    
        jQuery("#tabs-1").css("display","block");
        jQuery("#tabs" ).tabs();
               
        jQuery("#btn_buscar").click(function(){                                                                 
            paginator_div("<?php echo $_V_LIST ?>",jQuery("#consulta"));
        })
        
        jQuery("#btn_buscar").trigger("click");
        
        // Mostrando ventana para crear usuarios
        jQuery("#btn_crear").click(function(){            
            window.location.href="<?php echo $this->Html->url("registrar/$id_his")?>";
        });                       
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
                <li style="width: 100%;">
                    <a href="#tabs-1" style="width: 100%;">
                        <?php echo __("$title",true)?>
                    </a>
                </li>            
            </ul>
            <fieldset class="standar_fieldset_content">
            <?php
            
            ?>
            	     
            <form name="consulta" id="consulta" onsubmit="return false">                                                         
                <table style="width: 100%;" border="0" >
                    <tr>
                        <td align="center">
                            <table style="width:460px" border="0" style="margin-top: 10px;;">
                                <tr>                                                                                        
                                    <td align="right">
                                        <input type="button" id="btn_crear" name="btn_crear" value="<?php echo __("Crear",true)?>">                                                          
                                        <input type="button" id="btn_buscar" name="btn_buscar" value="<?php echo __("Actualizar",true)?>">                                                            
                                    </td>                                      
                                </tr>                                                        
                            </table>
                        </td>    
                    </tr>
                <tr>
                    <td align="center" style="">
                        <div id="content" style="height: 300px;width:460px; overflow-y:auto ;" class="lista_standar">
                            <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
                        </div>
                    </td>
                </tr>
            </table>
                                 
        </form>
        </fieldset>
    </div>
</div>
