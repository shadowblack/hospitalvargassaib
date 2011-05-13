<script type="text/javascript"> 
   
   jQuery(function(){
        parent.jQuery("#title_content").html("<?php echo $title;?>");
        jQuery("#btn_buscar").click(function(){
            
            var _str =  "/"+jQuery("#nom_usu_adm").val()+","
                        +jQuery("#ape_usu_adm").val()+","
                        +jQuery("#log_usu_adm").val()+"/"; 
                                           
            jQuery("#cargador").css("display","block")
            jQuery("#content").load("<?php echo $this->Html->url("/AdminUsuarioAdministrativo/event_listar")?>"+_str,function(){
                jQuery("#cargador").css("display","none")
            });
        })
        
        jQuery("#btn_buscar").trigger("click");
   });
   function edit(id){
        window.location.href = "<?php echo $this->Html->url("/AdminUsuarioAdministrativo/modificar/")?>"+id;
   }  
   function del(id,str){ 
                
                var _select = "#dialog #dialog_text";                      
                jQuery(_select).empty();
                jQuery(_select).text("<?php echo __("¿Desea eliminar el usuario administrativo",true) ?> '"+str+"'?");
                
                _select = "#dialog td > div > div";
                jQuery(_select).attr("class","");
                jQuery(_select).addClass("ui-state-highlight ui-corner-all");
                
                _select = "#dialog span";
                jQuery(_select).attr("class","");
                jQuery(_select).addClass("ui-icon ui-icon-info");
                
                jQuery("#dialog #dialog_messege").css("display","block");jQuery("#dialog img").css("display","none");
                jQuery("#dialog").dialog({                   
                    minHeight: 150,                            
                    buttons: [
                        {
                            text: '<?php echo __("Cancelar",true)?>',
                            click: function() { jQuery(this).dialog("close"); }
                        },                    
                        {
                            text: '<?php echo __("Aceptar",true)?>',
                            click: function() {      
                               jQuery.ajax({
                                        url:"<?php echo $this->Html->url("/AdminUsuarioAdministrativo/event_eliminar/")?>"+id+"/"+str+"/",                                                type: "POST",    
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
                                            alert("demo");
                                            jQuery("#btn_buscar").trigger("click");                                            
                                            jQuery(this).dialog("close");
                                            jQuery(this).dialog("destroy");
                                            jQuery("#dialog").dialog({
                                                modal:true,
                                                minHeight: 150,                            
                                                buttons: [
                                                    {
                                                        text: '<?php echo __("Aceptarr",true)?>',
                                                        click: function() { jQuery(this).dialog("close"); }
                                                    }
                                                ],
                                                resizable: false
                                            }).css("display","block");                                                                                            
                                        }                   
                                    });    
                                   
                            }
                        }
                    ],
                    resizable: false
                })
                .attr("class","")
                .addClass()                              
                .css("display","block");  
              
                
   } 
</script>
<div id="dialog" title="<?php echo __("Mensaje",true)?>" style="text-align:center;display:none;overflow: hidden;">
    <table style="height: 70px;" align="center">
        <tr>
            <td valign="center" class="">    
                <img src="<?php echo $this->webroot."img/icon/loadinfo.net.gif"?>">                          
                <div id="dialog_messege" class="ui-widget">
        			<div class="" style="margin-top: 15px; padding: 0 .7em;">         				
                            <span class="" style="float: left; margin-right: .3em;"></span>
        				    <div id="dialog_text" class="" style="text-align: left;">&nbsp;</div>                        
        			</div>
        		</div>
            </td>
        </tr>
    </table>              
</div>
<form name="consulta" id="consulta" onsubmit="return false">
    <table style="width: 100%;" border="0" class="standar_position">
    <tr>
        <td align="center">
            <table style="" border="0">
                <tr>
                    <td class="standar_font">
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
                </tr>    
                <tr>
                    <td class="standar_font">
                        <?php echo __("Login",true)?>:
                    </td>
                    <td>
                        <input type="text" id="log_usu_adm" name="log_usu_adm">
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
            <div id="content" style="height: 300px;width:460px ; overflow-y:auto ;" class="lista_standar">
                <img id="cargador" src="<?php echo $this->webroot?>img/icon/load_list.gif" style="margin-top: 120px;display: none;">
            </div>
        </td>
    </tr>
</table>
</form>
