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
<div style="margin-top: 20%; width: 100%; margin-left: auto;margin-right: auto; text-align: center;">
    <form action="<?php echo $html->url("/admin/val_usu")?>" id="login" name="login" method="post">    
        <table border="0" style="width: 250px;" align="center">
            <tr>
                <td>
                     <label for="log_usu"  class="standar_font"><?php echo __("Login");?>:</label>
    			     <input type="text" id="log_usu" name="log_usu" class="text required" minlength="3" maxlength="100" />
                </td>
            </tr>
            <tr>
                <td>    
                     <label for="pas_log" class="standar_font"><?php echo __("Contraseña");?>:</label>
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

