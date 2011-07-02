<?php 
    switch($T_V_TYPE){
        case 1:
            ?>
                <div id="dialog" title="<?php echo __("Mensaje",true)?>" style="text-align:center;display:none;overflow: hidden;">
                    <table style="height: 70px;" align="center">
                        <tr>
                            <td valign="center" class="">    
                                <img src="<?php echo $this->webroot."img/icon/loadinfo.net.gif"?>">                          
                                <div id="dialog_messege" class="ui-widget">
                        			<div class="" style="margin-top: 15px; padding: 0 .7em;">         				
                                            <span class="" style="float: left; margin-right: .3em;"></span>
                        				    <div id="dialog_text" class="" style="text-align: left;min-width: 240px;">&nbsp;</div>                        
                        			</div>
                        		</div>
                            </td>
                        </tr>
                    </table>              
                </div>
            <?php
        break;
        case 2:
            ?>
                <div id="dialog" title="<?php echo __("Validando Usuario",true)?>" style="text-align:center;display:none;overflow: hidden;">
                    <table style="height: 70px;" align="center">
                        <tr>
                            <td valign="center" class="">    
                                <img src="<?php echo $this->webroot."img/icon/loadinfo.net.gif"?>">                          
                                <div id="dialog_messege" class="ui-widget" style="width: 240px;">
                        			<div class="" style="margin-top: 15px; padding: 0 .7em;">         				
                                            <span class="" style="float: left; margin-right: .3em;"></span>
                        				    <table>
                                                <tr>
                                                    <td>
                                                        <div id="dialog_text" class="" style="text-align: left;">&nbsp;</div>
                                                    </td>
                                                    <td>
                                                        <img id="cargador_volatile" src='<?php echo $this->webroot?>/img/icon/indicator.gif' style="display: none;">   
                                                    </td>
                                                </tr>
                                            </table>                      
                        			</div>
                        		</div>
                            </td>
                        </tr>
                    </table>              
                    </div>
            <?php
        break;
        
    }
?>