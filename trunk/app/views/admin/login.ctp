<?php


    
?>

<script type="text/javascript">
    jQuery(function(){
       jQuery("#login").validate({  
            submitHandler: function(form) {                
   	            //jQuery(form).ajaxSubmit();
                var array_form = jQuery("input[type=text],input[type=password]").serializeArray();
                
                jQuery.ajax({
                    url:"<?php echo $this->Html->url("/admin/validar_usuario")?>",                    
                    type: "POST",
                    data: array_form,
                    dataType: "json", 
                                     
                    error:function(){alert("error")},
                    success: function(data){                         
                        eval('var data='+data);
                       if (data.event == 1){
                            window.location.href = "<?php echo $this->Html->url("/admin") ?>";
                       } else {
                            var _coment = data.coment;   
                            alert(_coment);                                                      
                       }
                    }
                   
                });
            }

       });        
    });
</script>

<style type="text/css">
    
</style>

 <form action="<?php echo $html->url("/admin/val_usu")?>" id="login" name="login" method="post">    
<table align="center" cellpadding="0" cellspacing="0"  border="0" >
    <tr>
        <td class="top_menu_login_doc_izquierdo" style="width: 50%;">&nbsp;
            
        </td>
        <td class="top_menu_login_index_center_adm" style="width: 1024px;">            
            <div style="width: 1024px;">&nbsp;</div>
        </td>
        <td class="top_menu_login_doc_derecho" style="width: 50%;">
            
        </td>
    </tr>
</table>

<table class="standar_position" style="width: 100%;top: 350px; z-index: 1;" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" style="">            
            <table border="0" style="width: 100px;" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" class="standar_font" style="width: 210px;">
                        <label for="log_usu"  class="standar_font"><?php echo __("Login");?>:</label>
                    </td>
                    <td style="width: 4px;">&nbsp;
                                                
                    </td>
                    <td align="center" style="">
                        <input type="text" id="log_usu" name="log_usu" class="text required" minlength="3" maxlength="100" style="border: 0px; #FFFFFF;"/>
                    </td>
                </tr>
                <tr>
                    <td style="_height: 20px;height: 30px;">&nbsp;
                        
                    </td>
                    <td>&nbsp;
                                                
                    </td>
                    <td>&nbsp;
                                                
                    </td>
                </tr>
                 <tr>
                    <td align="right" class="standar_font">
                        <label for="pas_log" class="standar_font"><?php echo __("Contraseña");?>:</label>
                    </td>
                    <td>&nbsp;
                                                
                    </td>
                    <td align="center">
                        <input type="password" id="pas_log" name="pas_log" class="password required" minlength="3" maxlength="100" style="border: 0px; #FFFFFF;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 73px;">&nbsp;
                        
                    </td>                    
                </tr>
                <tr>
                    <td align="center" colspan="3" class="standar_font">                    
                        <input type="submit" value="Aceptar" name="btn_ace" id="btn_ace" >                                                                  
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
</form>