<?php echo $this->Html->docType("html4-trans"); ?>
<html>
    <head>
        <?php echo $html->charset(); ?>
        <title>
            <?php echo __("Sistema de integración de las enfermedades dermatologicas"); ?>
           	<?php echo $scripts_for_layout;?>
        </title>        
       	<?php echo $this->Html->css('top_menu');?>
        <?php echo $this->Html->css('font');?>
        <?php echo $this->Html->css('standar');?>
        <!-- Css acordion -->
         <link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery/jquery-ui-1.8.10.custom/css/cupertino/jquery-ui-1.8.10.custom.css"?>" />
         
        <!-- Css validator-->
         <link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."js/jquery-validate.password/jquery.validate.password.css"?>" />      
        
        <?php echo $this->Html->script("jquery/jquery-1.5.1.min.js"); ?>
        <?php echo $this->Html->script("jquery/jquery-ui-1.8.10.custom/js/jquery-ui-1.8.10.custom.min.js"); ?>
        <?php echo $this->Html->script("jquery/jquery-validate/jquery.validate.min.js"); ?>        
        <?php echo $this->Html->script("jquery/jquery-validate/localization/messages_es.js"); ?>
        <?php echo $scripts_for_layout; ?>       
    </head>
    <body style="width: 100%;text-align: center;padding: 0 0 0 0;margin: 0 auto 0 auto;overflow: auto; background-color: #EAF8F8;">
        <div id="container">
            <div id="content" style="">
                <?php echo $content_for_layout ?>
            </div>        
        </div>
    </body>
</html>