<script type="text/javascript"> 
      
   function edit(id){
        window.location.href = "<?php echo $_V_EDIT?>/"+id;
   }  
   function del(id,str){ 
                
                var _select = "#dialog #dialog_text";                      
                jQuery(_select).empty();
                jQuery(_select).text("<?php echo $_V_DEL_MEN ?> '"+str+"'?");
                
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
                                        url:"<?php echo $_V_DEL?>/"+id+"/"+str+"/",                                                
                                        type: "POST",    
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
                                            jQuery("#btn_buscar").trigger("click");                                            
                                            jQuery(this).dialog("close");
                                            jQuery(this).dialog("destroy");
                                            jQuery("#dialog").dialog({
                                                modal:true,
                                                minHeight: 150,                            
                                                buttons: [
                                                    {
                                                        text: '<?php echo __("Aceptar",true)?>',
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