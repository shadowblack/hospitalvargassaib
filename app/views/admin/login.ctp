<?php


    
?>

<script type="text/javascript">
    jQuery(function(){
       jQuery("#login").validate({            
       });        
    });
</script>

<style type="text/css">
    
</style>
<div style="margin-top: 20%; width: 100%; margin-left: auto;margin-right: auto; text-align: center;">
    <form action="<?php echo $html->url("/admin/val_usu")?>" id="login" name="login" method="post">    
        <table border="0" style="width: 250px;" align="center">
            <tr>
                <td>
                     <label for="log_usu"  class="font_estandar"><?php echo __("Login");?>:</label>
    			     <input type="text" id="log_usu" name="log_usu" class="text required" minlength="3" maxlength="100" />
                </td>
            </tr>
            <tr>
                <td>    
                     <label for="pas_log" class="font_estandar"><?php echo __("Contraseña");?>:</label>
    			     <input type="password" id="pas_log" name="pas_log" class="password required" minlength="3" maxlength="100"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="Aceptar" name="btn_ace" id="btn_ace">
                </td>
            </tr>
            <tr>
                <td>
                    <div id="">
                        
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>

