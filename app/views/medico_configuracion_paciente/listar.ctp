<?php
    $_V_LIST    = "event_listar";
    $_V_EDIT    = "modificar";
    $_V_DEL     = "event_eliminar";
    $_V_CONS    = "consultar";
    $_V_DEL_MEN = __("¿Desea eliminar al paciente",TRUE);
    include_once("../libs/_list_ajax.php");
?>

<script type="text/javascript"> 
   <?php echo $this->Loader->DivPaginator()?>
   function his (id){
        
        window.location.href = "<?php echo $this->Html->url("/MedicoHistorialPaciente/listar")?>/"+id;
   }
     
   jQuery(function(){
        jQuery( "#tabs" ).tabs
        ({
            event: "mouseover"
        });
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery("#btn_buscar").click(function(){
            
            var _str =  "/"+jQuery("#nom_usu_adm").val()+","
                        +jQuery("#ape_usu_adm").val()+","
                        +jQuery("#log_usu_adm").val()+"/"; 
                                           
            paginator_div("<?php echo $_V_LIST ?>"+_str);
        })
        
        jQuery("#btn_buscar").trigger("click");
        
        // Mostrando ventana para crear usuarios
        jQuery("#btn_crear").click(function(){            
            parent.document.getElementById("frame_content").src = "MedicoConfiguracionPaciente/Registrar";
        });                       
   });       
</script>
	
<div id="tabs-1">
    <!--    
    <h2 class="texPrincipal">
        <?php echo __("Listar/Crear/Buscar",true)?>
    </h2>          
    -->


    <div id="tabs">
            <ul>
                <li>
                    <a href="#tabs-1" style="width: 663px;">
                        <?php echo __("Listar Paciente",true)?>
                    </a>
                </li>            
            </ul>
    
                
                <?php 
                    $T_V_TYPE = 1;
                    include_once("../libs/_dialog.php");  
                ?>
                <form name="consulta" id="consulta" onsubmit="return false">
                    <fieldset>	
                        <!--
                        <legend>
                            <strong>
                                <?php echo __("Opciones",true)?>:
                            </strong>
                        </legend>
                        -->            
                        <table style="width: 100%;" border="0" >
                            <tr>
                                <td align="center">
                                    <table style="" border="0" style="margin-top: 10px;;">
                                        <tr>
                                            <td class="standar_font" style="width:70px;">
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
                                            <td>
                                                <input type="button" id="btn_crear" name="btn_crear" value="<?php echo __("Crear",true)?>">
                                            </td>                                        
                                        </tr>    
                                        <tr>
                                            <td class="standar_font">
                                                <?php echo __("Cédula",true)?>:
                                            </td>
                                            <td>
                                                <input type="text" id="log_usu_adm" name="log_usu_adm">
                                            </td> 
                                            <td colspan="2">
                                                &nbsp;
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
                                <div id="content" style="height: 300px;width:460px; overflow-y:auto ;" class="lista_standar">
                                    <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>                     
            </form>
    </div>
</div>
