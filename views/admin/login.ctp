<?php


    
?>
<script type="text/javascript">
    jQuery("body:eq(0)").addClass("standar_fondo_login");    
    jQuery(function(){
        
        jQuery("#link_aceptar").click(function(){
            jQuery("#login").submit();
        })
        
        
        
       jQuery("#login").validate({  
            submitHandler: function(form) {
                <?php echo $this->Event->Valid($this->Html->url("/admin/validar_usuario"),"input[type=text],input[type=password]",$this->Html->url("/admin"))?>                             
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
    //$T_V_TYPE = 2;
    //include_once("../libs/_dialog.php");  
    echo $this->element("dialog",Array("T_V_TYPE" => 2));
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
                            	<td align="right" class="standar_font" style="width: 409px;">
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
                               
                                
                                
                                 <table>
                                    <tr><br/>
                                    <td>
                                     
                                    
                                    <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
                                            <a href="javascript:void(0)" id="link_aceptar" name="link_aceptar">
                                                <br/>
                                                <?php echo __("Aceptar",true)?></a>
                                            </a>
                                        </div>
                                    </td>
                                 
                                    <td>
                                    
                                    
                                    <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
                                                                                        
                                            
                                            <a href="<?php echo $this->Html->url("/")?>" id="link_aceptar" name="link_aceptar">
                                                <br/>
                                                <?php echo __("Inicio",true)?></a>
                                            </a>
                                        </div>
                                    </td>
                                    
                                    </table>
                                
                                
                                
                                
                                             
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