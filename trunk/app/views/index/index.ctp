<script type="text/javascript">
        /*Agregando Clase CSS para el fondo del login*/
       jQuery("body:eq(0)").addClass("standar_fondo_login");    
</script>

<table align="center" cellpadding="0" cellspacing="0"  border="0" >
    <tr>
        <td class="top_menu_login_index_izquierdo" style="width: 50%;">
            &nbsp;
        </td>
        <td class="top_menu_login_index_center" style="width: 1024px;">            
            <div style="width: 1024px;">&nbsp;</div>
        </td>
        <td class="top_menu_login_index_derecho" style="width: 50%;">
            
        </td>
    </tr>
</table>

<table class="standar_position" style="width: 100%;top: 350px; z-index: 1;" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" style="">     
            <br/>
            <table border="0" style="width: 600px;" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" class="standar_font" style="width: 200px;" >
                        
                        <div class="boton_medico_conf" id="boton_medico_conf" >
                            <a href="<?php echo $html->url("/admin")?>">
                                <br/>
                                <?php echo __("Administrador",true)?></a>
                            </a>
                        </div>                                                                         
                        
                    </td>
                    <td align="center" style="width: 200px;">
                        
                        <div class="boton_medico_conf" id="boton_medico_conf" >
                            <a href="<?php echo $html->url("/medico/login")?>">
                                <br/>
                                <?php echo __("Médico",true)?></a>
                            </a>
                        </div>                                                                         
                    </td>
                    <td align="center" style="width: 200px;">
                        <div class="boton_medico_conf" id="boton_medico_conf" >
                            <a href="<?php echo $html->url("/medico")?>">
                                <br/>
                                <?php echo __("Otros",true)?></a>
                            </a>
                        </div>                                                                         
                    </td>
                </tr>
                 
            </table>
        </td>
    </tr>
</table>

