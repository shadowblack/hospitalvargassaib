<script type="text/javascript">             
        jQuery(function() { 
            jQuery("body").addClass("standar_background_color");             
        });
</script>
<div class="standar_window_fieldset_child lista_standar" style="overflow-y: auto;margin-top: 5px;">                   
    <table style="width:98%; border" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>                
            <td width="144" class="standar_font lista_fondo" valign="top">
                <?php __("Muestras Clinicas");?>                                
            </td>                                                                                       
        </tr>
        <tr>
            <td valign="top" >
                <div class="standar_margin ">
                    <ol class="standar_list">
                        <?php foreach($muestras_clinicas as $row): ?>
                            <li><?php echo $row->nom_mue_cli?></li>
                        <?php endforeach ?>
                    </ol>
                </div>
            </td>            
        </tr>                                                                      
    </table>
 </div>                
<table style="width: 100%;" border="0" class="">
    <tr>            
        <td  align="center" style="height: 0" valign="bottom">
            <input type="button" value="<?php echo __("Volver",true)?>" onclick="parent.window.location.href=parent.page">
        </td>           
    </tr>
</table>                                                               