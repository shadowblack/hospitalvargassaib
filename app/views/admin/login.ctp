<?php


    
?>
<script type="text/javascript">
    jQuery("body:eq(0)").addClass("standar_fondo_login");    
    jQuery(function(){
       jQuery("#login").validate({  
            submitHandler: function(form) {                
   	            //jQuery(form).ajaxSubmit();
             var array_form = jQuery("input[type=text],input[type=password]").serializeArray();                
            
            //jQuery(form).ajaxSubmit();
                var array_form = jQuery("form").serializeArray();
                jQuery("#cargador_volatile").css("display","block");              
                jQuery.ajax({
                    url:"<?php echo $this->Html->url("/admin/validar_usuario")?>",                    
                    type: "POST",
                    data: array_form,
                    dataType: "json",                                      
                    error:function(){alert("Error json")},
                    success: function(data){                                                                     
                        eval("data="+data);   
                        
                        jQuery("#dialog #dialog_messege").css("display","block");jQuery("#dialog img").css("display","none"); 
                                                                     
                        var _select = "#dialog #dialog_text";                      
                        jQuery(_select).empty();
                        jQuery(_select).text(data.coment);
                        
                        _select = "#dialog td > div > div";
                        jQuery(_select).attr("class","");
                        jQuery(_select).addClass(data.class_background);
                        
                        _select = "#dialog span";
                        jQuery(_select).attr("class","");
                        jQuery(_select).addClass(data.class_icon);
                        
                        jQuery("#dialog").dialog("destroy");
                        jQuery("#dialog").dialog({
                            modal:true,
                            minHeight: 150,                            
                            buttons: [
                                {
                                    text: '<?php echo __("Aceptar",true)?>',
                                    click: function() { 
                                        jQuery(this).dialog("close"); 
                                    }
                                }
                            ],
                            resizable: false
                            }).css("display","block");                                                                                                            if (data.event == 1){
                                 jQuery("#cargador_volatile").css("display","block");
                                window.location.href = "<?php echo $this->Html->url("/admin") ?>";
                        }
                    }                   
                });
                
                jQuery("#dialog").dialog("destroy");
                jQuery("#dialog #dialog_messege").css("display","none");jQuery("#dialog img").css("display","block");                
                jQuery("#dialog").dialog({                            
                    resizable: false
                }).css("display","block");    

            }   
           });     
    });
</script>

<style type="text/css">
    label{
        text-align: right;  
    }
    label.error{        
        display: inline;
        margin-left: 50px;
        width: auto;
    }
</style>
<?php 
    $T_V_TYPE = 2;
    include_once("../libs/_dialog.php");  
?>
<table align="center" cellpadding="0" cellspacing="0"  border="0" class="standar_position">
    <tr>
        <td class="top_menu_login_doc_izquierdo" style="width: 50%;">&nbsp;
            
        </td>
        <td class="top_menu_login_index_center_adm" style="width: 1024px;">            
            <div style="width: 1024px;">&nbsp;</div>
        </td>
        <td class="top_menu_login_doc_derecho" style="width: 50%;">
            &nbsp;
        </td>
    </tr>
</table>
 <form action="<?php echo $html->url("/admin/val_usu")?>" id="login" name="login" method="post">  
<table class="standar_position" style="width: 100%;top: 350px; z-index: 1;" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" style="">   
            
            <table style="width: 1024px;" align="center">
                <tr>
                    <td align="center">                        
                    	<table border="0" style="width: 825px;" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td align="right" class="standar_font" style="width: 400px;">
                                	<label for="log_usu"  class="standar_font"><?php echo __("Login");?>:</label>                                </td>
                                <td style="width: 15px;">
                                	&nbsp;                                
                                </td>
                                
                                <td align="left" style="">
                                    <input type="text" id="log_usu" name="log_usu" class="text required" minlength="3" maxlength="100" style="border: 0px; color: black;"/>                                
                                 </td>
                                 
                            </tr>
                            
                            <tr>
                                <td style="_height: 20px;height: 33px;">
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
                                    <label for="pas_log" class="standar_font"><?php echo __("Clave");?>:</label>                                </td>
                                
                                <td>
                                	&nbsp;                                
                                </td>
                                
                                <td align="left">
                                    <input type="password" id="pas_log" name="pas_log" class="password required" minlength="3" maxlength="100" style="border: 0px; color: black ;"/>                                
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="3" style="height: 73px;">
                                	&nbsp;                                
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
 		
        
        </td>
    </tr>
</table>
</form>
        

<table class="standar_position" style="width: 100%;top: 258px;" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td align="left">
            <img src="<?php echo $this->webroot."img/img_formulari_inicio/fondo_inici_mano.png"?>" >
        </td>
    </tr>
</table>