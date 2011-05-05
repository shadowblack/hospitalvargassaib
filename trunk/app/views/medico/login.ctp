<script type="text/javascript">
        /*Agregando Clase CSS para el fondo del login*/
       jQuery("body:eq(0)").addClass("standar_fondo_login");    
</script>

<table align="center" cellpadding="0" cellspacing="0"  border="0" >
    <tr>
        <td class="top_menu_login_doc_izquierdo" style="width: 50%;">
            &nbsp;
        </td>
        <td class="top_menu_login_doc_center" style="width: 1024px;">            
            <div style="width: 1024px;">&nbsp;</div>
        </td>
        <td class="top_menu_login_doc_derecho" style="width: 50%;">
            
        </td>
    </tr>
</table>

<table class="standar_position" style="width: 100%;top: 350px; z-index: 1;" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" style="">            
            <table border="0" style="width: 222px;">
                <tr>
                    <td align="right" class="standar_font" style="width: 210px;">
                        <?php echo __("Login",true)?>:
                    </td>
                    <td style="width: 4px;">
                        &nbsp;                        
                    </td>
                    <td align="center" style="">
                        <input type="text" id="log_med_usu" name="log_med_usu" style="border: 0px; color: #FFFFFF;">
                    </td>
                </tr>
                <tr>
                    <td style="_height: 20px;height: 30px;">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;                        
                    </td>
                    <td>
                        &nbsp;                        
                    </td>
                </tr>
                 <tr>
                    <td align="right" class="standar_font">
                        <?php echo __("Contraseña",true)?>:
                    </td>
                    <td>
                        &nbsp;                        
                    </td>
                    <td align="center">
                        <input type="password" id="pas_med_usu" name="pas_med_usu" style="border: 0px; color: #FFFFFF;">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 73px;">
                        &nbsp;
                    </td>                    
                </tr>
                <tr>
                    <td align="center" colspan="3" class="standar_font">                    
                        <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
                            <a href="<?php echo $html->url("/medico")?>">
                                <br/>
                                <?php echo __("Aceptar",true)?></a>
                            </a>
                        </div>                                                                         
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table class="standar_position" style="width: 100%;top: 258px;" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td align="left">
            <img src="<?php echo $this->webroot."img/img_formulari_inicio/fondo_inici_mano.png"?>" >
        </td>
    </tr>
</table>
