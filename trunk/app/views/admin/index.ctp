<?php   
    //echo $url_img =  $this->webroot."img/menu_top/"; 
    //echo "http://127.0.0.1$url_img"."img/menu_top/8_01.jpg";die;
?>
<script type="text/javascript">
	jQuery(function(){
		// Accordion
		jQuery("#accordion").accordion({
		      header: "h3",              
              autoHeight:false
                   
        });
        
        jQuery("#reg_usu_adm").click(function(){
           jQuery("#frame_content").attr("src","<?php echo $this->Html->url('/admin_usuario_administrativo/registrar')?>");
		});
        
       
    
    });
</script>
<style type="text/css">
    .font_estandar{
        font-size: 8pt;
    }
</style>
<div style='' class="top_menu_fondo">   
   <table style="width:100%" border="0" align="center">
    <tr>
        <td style="height: 125px;">
            <!-- Banner -->banner
        </td>
    </tr>
    <tr>
        <td style="height: 122px;">
            <!-- Banner -->banner2
        </td>
    </tr>
    <tr>
         <td style="height: 35px;">
            
        </td>
    </tr>
    <tr>
        <td style="height: 550px;" valign="top" align="center">
            <table border="0" style="margin-top: 32px;">
                <tr>
                    <td>
                        <table class="menu_top_window" border="0" cellpadding="0" cellspacing="0" >
                           <!--Top-->
                            <tr>
                                <td class="top_menu_window_top_left">
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_circle">
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_center" style="width:200px">
                                    <!-- Dinamic -->
                                    &nbsp;
                                </td>
                                <td class="top_menu_window_top_right">                    
                                    &nbsp;
                                </td>
                            </tr>
                            <!--Cuerpo-->
                            <tr>
                                <td class="top_menu_window_body_left">
                                    
                                </td>                
                                <td valign="top" class="top_menu_window_body_center" colspan="2"  style="width:200px;height: 400px;">
                                    <!-- Dinamic -->
                                    <div id="accordion">
                                        <?php if ($cua){?>
                            			<div>
                            				<h3><a href="#"><?php __("Usuarios Administrativos")?></a></h3>
                            				<div style="">                                               
                                                <div style="height: 200px;">
                                                    <a href="javascript:void(0)"><?php __("Agregar Administrador")?></a>
                                                </div>
                                            </div>
                            			</div>
                                        <?php } ?>
                            			<div>
                            				<h3><a href="#">Second</a></h3>
                            				<div>Phasellus mattis tincidunt nibh.</div>
                            			</div>
                            			<div>
                            				<h3><a href="#">Third</a></h3>
                            				<div>Nam dui erat, auctor a, dignissim quis.</div>
                            			</div>
                            		</div>                                  
                                </td>
                                <td class="top_menu_window_body_right">                    
                                    
                                </td>
                            </tr>
                            <!--Footer-->
                            <tr>
                                <td class="top_menu_window_footer_left">
                                    
                                </td>
                               
                                <td class="top_menu_window_footer_center" colspan="2">
                                    <!-- Dinamic -->
                                    
                                </td>
                                <td class="top_menu_window_footer_right">                    
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <table class="menu_top_window" border="0" cellpadding="0" cellspacing="0" >
                           <!--Top-->
                            <tr>
                                <td class="top_menu_window_top_left">
                                   
                                </td>
                                <td class="top_menu_window_top_circle">
                                   
                                </td>
                                <td class="top_menu_window_top_center" style="width:600px;">
                                    <!-- Dinamic -->
                                    
                                </td>
                                <td class="top_menu_window_top_right">                    
                                   
                                </td>
                            </tr>
                            <!--Cuerpo-->
                            <tr>
                                <td class="top_menu_window_body_left">
                                    
                                </td>                
                                <td class="top_menu_window_body_center" colspan="2"  style="width:600px;height: 400px;">
                                    <!-- Dinamic -->
                                  
                                </td>
                                <td class="top_menu_window_body_right">                    
                                    
                                </td>
                            </tr>
                            <!--Footer-->
                            <tr>
                                <td class="top_menu_window_footer_left">
                                    
                                </td>
                               
                                <td class="top_menu_window_footer_center" colspan="2">
                                    <!-- Dinamic -->
                                    
                                </td>
                                <td class="top_menu_window_footer_right">                    
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
           
        </td>                
    </tr>
    <tr>
        <td style="height: 50px;">
            <!-- Footer -->
        </td>
    </tr>
   </table>
       
</div>