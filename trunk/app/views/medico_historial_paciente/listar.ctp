<?php

    $_V_LIST    = $this->Html->url("event_listar/$id_pac");
    $_V_EDIT    = $this->Html->url("modificar");
    $_V_DEL     = $this->Html->url("event_eliminar");
    $_V_CONS    = $this->Html->url("consultar");
    $_V_DEL_MEN = __("¿Desea eliminar el Historial",TRUE);
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
   <?php echo $this->Loader->DivPaginatorPost()?>
   //width: 452px; height: 478px; z-index: 2002; left: 465px; top: 288px; background-color: rgb(242, 245, 247); opacity: 1;
   function info(id_his,id_pac){               
        var _id = "inf_his"+id_pac;  
        var url = "<?php echo $this->Html->url("/MedicoWindows/medico_informacion_paciente/")?>"+id_his+"/"+id_pac;   
        parent.util.openWindow(_id,"<?php echo __("Información del historial",true)?>",url,0,0,undefined,280);  
              
   }
   
   jQuery(function(){
        <?php echo $this->History->GetHistory($history)?>
        jQuery("#tabs-1").css("display","block");
        jQuery( "#tabs" ).tabs();
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery("#btn_buscar").click(function(){                                                       
            paginator_div("<?php echo $_V_LIST ?>",jQuery("#consulta"));            
        })
        
        jQuery("#btn_buscar").trigger("click");
        
        // Mostrando ventana para crear usuarios
        jQuery("#btn_crear").click(function(){            
            parent.document.getElementById("frame_content").src = "<?php echo $this->Html->url("registrar")?>/<?php echo $id_pac?>";
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
                <li>
                    <a href="#tabs-1" style="width: 680px;">
                        <?php echo __("Páginas de historias",true)?>
                    </a>
                </li>            
            </ul>
            <fieldset class="standar_fieldset_content">
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
                            <div id="content" style="height: 274px;width:630px ; overflow-y:auto ;" class="lista_standar">
                                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table style="width: 100%; border="0" class="" align="center">
                                <tr>                                   
                                    <td  align="center" style="height: 0" valign="bottom">
                                        <input type="button" name="btn_volver" value="Volver" onclick="window.location.href='<?php echo $this->History->Url($this->Html->url("/MedicoConfiguracionPaciente/listar"))?>'">                                        
                                    </td>
                                </tr>
                            </table>   
                        </td>
                    </tr>
                </table>            	
            </form>
    </fieldset>
</div>
