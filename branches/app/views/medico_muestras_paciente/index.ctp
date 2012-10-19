<script type="text/javascript">
    jQuery("body").addClass("standar_background_color");
</script>
<script type="text/javascript"> 
    var page = "<?php echo $_SERVER["HTTP_REFERER"]?>";                
    parent.parent.util.win["inf_his<?php echo $id_pac?>"]._resize(600,400);
    jQuery(function() {
         jQuery("a").click(function(){
           var _iframe = "<iframe src=\"%%%\" frameborder=\"0\" width=\"100%\" height=\"320\" align=\"left\" style=\"padding: 0;margin: 0;\"></iframe>";        
           switch(jQuery(this).attr("href")){
                case "#tabs-1":                    
                    var _url = "<?php echo $this->Html->url("/MedicoMuestrasPaciente/consultar/$id_his")?>";                 
                    jQuery("#tabs-1").html(_iframe.replace("%%%",_url));
                                        
                break;
                case "#tabs-2":
                    if(jQuery("#tabs-2").find("iframe").length != 0)
                        break;
                    var _url = "<?php echo $this->Html->url("/MedicoMuestrasPaciente/registrar/$id_his/$id_pac")?>";                    
                    jQuery("#tabs-2").html(_iframe.replace("%%%",_url));
                    
                break;                             
           } 
        });
        jQuery("a:eq(0)").trigger("click");
        jQuery("#tabs").css("display","block");
        jQuery("#tabs").tabs();                        
    });
</script>

<div id="tabs" style="display: none;height: 350px;">    		    
    <ul>
        <li>
            <a href="#tabs-1" >
                <?php echo __("Muestras Clínicas",true)?>
            </a>            
        </li> 
        <li>
            <a href="#tabs-2" >
                <?php echo __("Agregar/Editar",true)?>
            </a>            
        </li>                       
    </ul>
    <div id="tabs-1" style="width: 100%;height: 318px;padding: 0;">&nbsp;
    </div> 
    <div id="tabs-2" style="width: 100%;height: 318px;padding: 0;">&nbsp;      
    </div>      
</div>