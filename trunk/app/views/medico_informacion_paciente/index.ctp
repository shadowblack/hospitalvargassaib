<script type="text/javascript">
    jQuery("body").addClass("standar_background_color");
</script>
<script type="text/javascript">                 
    parent.parent.util.win["inf_his<?php echo $id_pac?>"]._resize(600,400);
    jQuery(function() {
         jQuery("a").click(function(){
           var _iframe = "<iframe src=\"%%%\" frameborder=\"0\" width=\"100%\" height=\"350\" align=\"left\" style=\"padding: 0;margin: 0;\"></iframe>";        
           switch(jQuery(this).attr("href")){
                case "#tabs-1":
                    var _url = "<?php echo $this->Html->url("/MedicoInformacionPaciente/registrar/$id_his/$id_pac")?>";                    
                    jQuery("#tabs-1").html(_iframe.replace("%%%",_url));
                    
                break;
                case "#tabs-2":
                    var _url = "<?php echo $this->Html->url("/MedicoInformacionPaciente/registrar")?>";                    
                    jQuery("#tabs-2").html(_iframe.replace("%%%",_url));
                    
                break;
                case "#tabs-3":
                    var _url = "<?php echo $this->Html->url("/MedicoInformacionPaciente/registrar")?>";                    
                    jQuery("#tabs-3").html(_iframe.replace("%%%",_url));
                    
                break;
                case "#tabs-4":
                    var _url = "<?php echo $this->Html->url("/MedicoInformacionPaciente/registrar")?>";                    
                    jQuery("#tabs-4").html(_iframe.replace("%%%",_url));
                    
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
                <?php echo __("Seguimiento",true)?>
            </a>            
        </li> 
        <li>
            <a href="#tabs-2" >
                <?php echo __("Agregar",true)?>
            </a>            
        </li>
        <li>
            <a href="#tabs-3" >
                <?php echo __("Editar",true)?>
            </a>            
        </li>  
        <li>
            <a href="#tabs-4" >
                <?php echo __("Eliminar",true)?>
            </a>            
        </li>            
    </ul>
    <div id="tabs-1" style="width: 100%;height: 318px;padding: 0;">&nbsp;
    </div> 
    <div id="tabs-2" style="width: 100%;height: 318px;padding: 0;">&nbsp;      
    </div>
    <div id="tabs-3" style="width: 100%;height: 318px;padding: 0;">&nbsp;
    </div>  
    <div id="tabs-4" style="width: 100%;height: 318px;padding: 0;">&nbsp;
    </div>     
</div>