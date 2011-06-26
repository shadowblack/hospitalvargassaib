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
        <td align="center">     
            <table border="0" cellpadding="0" cellspacing="0"  style="margin-top: 20px;">
                  <tr>
                        <td style="width: 180px;" align="center">
                        
                            <div class="boton_medico_conf" id="boton_medico_conf" >
                                <a href="<?php echo $html->url("/admin")?>">
                                    <br/>
                                    <?php echo __("Administrador",true)?></a>
                                </a>
                            </div>  
                        
                        </td>
                        <td style="width: 180px;" align="center">
                            <div class="boton_medico_conf" id="boton_medico_conf" >
                                <a href="<?php echo $html->url("/medico/login")?>">
                                    <br/>
                                    <?php echo __("Médico",true)?></a>
                                </a>
                            </div>                                                
                        </td>
                  </tr>
            </table>            
        </td>
    </tr>
</table>

