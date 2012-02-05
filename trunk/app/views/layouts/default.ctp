<?php echo $this->Html->docType("html4-trans"); ?>
<html>
    <head>
        <?php echo $html->charset("utf-8"); ?>
        <title>
            <?php echo __("Sistema de integración de las enfermedades dermatologicas",true); ?>
           	<?php echo $title_for_layout;?>
        </title>  
        <?php echo $this->Html->meta('icon',$this->webroot."img/icon/doctor.jpg");?>
        <?php #echo $this->Html->css('cake_log');?>     
       	<?php echo $this->Html->css('top_menu');?>
        <?php echo $this->Html->css('font');?>
        <?php echo $this->Html->css('standar');?>
        <?php echo $this->Html->css('lista');?>        
        <?php echo $this->Html->css('medico_clase_formulario');?> 
       
              
        <!-- Css acordion -->
        <link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-ui-1.8.11.custom/css/cupertino/jquery-ui-1.8.11.custom.css"?>"/>        
        <link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."css/imprimir.css"?>" media="print"/>
    
        
        <?php #echo $this->Html->script("jquery/jquery-1.5.2.js"); ?>
        <?php echo $this->Html->script("jquery/jquery-1.5.1.min.js"); ?>                            
        <?php echo $this->Html->script("jquery/jquery-validation-1.8.0/jquery.validate.min.js"); ?>        
        <?php echo $this->Html->script("jquery/jquery-validation-1.8.0/localization/messages_es.js"); ?>                                                                       
        <?php echo $this->Html->script("jquery/jquery-ui-1.8.11.custom/js/jquery-ui-1.8.11.custom.min.js"); ?>        

        <?php echo $scripts_for_layout; ?>       
        
        <!-- Css Modificacion de librerias -->
        <?php echo $this->Html->css('ui_jquery');?>
    </head>
    <body style="overflow: hidden;">         
        <?php echo $content_for_layout ?> 
        <?php echo $this->element('sql_dump'); ?>                                          
    </body>
</html>