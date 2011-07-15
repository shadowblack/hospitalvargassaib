<?php
    $_V_LIST    = "event_listar";
    $_V_EDIT    = "modificar";
    $_V_DEL     = "event_eliminar";
    $_V_CONS    = "consultar";
    $_V_DEL_MEN = __("¿Desea eliminar al paciente",TRUE);
    include_once("../libs/_list_ajax.php");
?>

<script type="text/javascript"> 
   <?php echo $this->Loader->DivPaginatorPost()?>
   function his(id_pac){        
        window.location.href = "<?php echo $this->Html->url("/MedicoHistorialPaciente/listar")?>/"+id_pac;
   }  
     
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
            parent.document.getElementById("frame_content").src = "MedicoConfiguracionPaciente/Registrar";
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
                        <?php echo __("Listar Paciente",true)?>
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
                                <table style="" border="0" style="margin-top: 10px;;">
                                    <tr>
                                        <td class="standar_font" style="width:70px;" align="left">
                                            <?php echo __("Nombre",true)?>:
                                        </td>
                                        <td>
                                            <input type="text" id="nom_pac" name="nom_pac">
                                        </td>                    
                                        <td class="standar_font" align="left">
                                            <?php echo __("Apellido",true)?>:
                                        </td>                   
                                        <td align="left">
                                            <input type="text" id="ape_pac" name="ape_pac">
                                        </td>
                                        <td align="left">
                                            <input type="button" id="btn_crear" name="btn_crear" value="<?php echo __("Crear",true)?>">
                                        </td>                                        
                                    </tr>    
                                    <tr>
                                        <td class="standar_font" align="left">
                                            <?php echo __("Cédula",true)?>:
                                        </td>
                                        <td align="left">
                                            <input type="text" id="ced_pac" name="ced_pac">
                                        </td> 
                                        <td colspan="2" align="left">
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
