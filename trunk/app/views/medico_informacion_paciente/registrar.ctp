<script type="text/javascript">   
          
        jQuery(function() { 
            jQuery("body").addClass("standar_background_color");
            <?php echo $this->Checkbox->Multiple("chk_cen_sal_","#pacientes") ?>
            <?php echo $this->Checkbox->Multiple("chk_tip_con_","#pacientes") ?>
            <?php echo $this->Checkbox->Multiple("chk_ani_","#pacientes") ?>            
            <?php echo $this->Checkbox->Multiple("chk_tra_","#pacientes") ?>
                                   
            jQuery("#tabs-1").css("display","block");
            jQuery( "#tabs" ).tabs();                                                   		

            jQuery("#pacientes").validate({                
                submitHandler: function(form) {
                    <?php echo $this->Event->Update($this->Html->url("event_registrar"),"form",false)?>                   
                }
            });     
           <?php echo $this->Otros->Script()?>
    });
</script>
<style type="text/css">
    label.error { width: 150px; text-align: left; }    
</style>

<?php   
    echo $this->element("dialog",Array("T_V_TYPE" => 1));
?>
        
<form name="pacientes" id="pacientes" >
   <input type="hidden" name="hdd_id_his" value="<?php echo $id_his?>">
    <div class="standar_window_fieldset_child lista_standar" style="overflow-y: auto;margin-top: 5px;">                   
        <table style="width:98%; border" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>                
                <td width="144" class="standar_font lista_fondo" valign="top">
                    <?php __("Referido del centro de salud");?>                                
                </td>
                <td width="8" class="standar_font" valign="top">
                    &nbsp;
                </td>
                <td width="144" class="standar_font lista_fondo" valign="top">
                    <?php __("Tipo de consulta");?>                                
                </td>
                <td width="8" class="standar_font" valign="top">
                    &nbsp;
                </td>
                <td width="184" class="standar_font lista_fondo" valign="top">
                    <?php echo __("Contacto con animales",true)?>
                </td>                                                                             
            </tr>
            <tr>
                <td valign="top" >
                    <div class="standar_margin ">
                        <ol class="standar_list">
                            <?php foreach($centros_salud as $row): ?>
                                <li><input name="chk_cen_sal_<?php echo $row->CentroSalud->id_cen_sal?>" class="standar_input_checkbox" type="checkbox" value="<?php echo $row->CentroSalud->id_cen_sal?>" <?php echo (!empty($row->csp->id_cen_sal) ? "checked='checked'" : "")?>><?php echo $row->CentroSalud->nom_cen_sal?></li>
                            <?php endforeach ?>
                        </ol>
                    </div>
                </td>
                <td>
                    &nbsp;
                </td >
                <td valign="top">
                    <div class="standar_margin ">
                        <ol class="standar_list">
                            <?php foreach($tipos_consultas as $row): ?>
                                <li><input name="chk_tip_con_<?php echo $row->TiposConsulta->id_tip_con?>" class="standar_input_checkbox" type="checkbox" value="<?php echo $row->TiposConsulta->id_tip_con?>" <?php echo (!empty($row->tcp->id_tip_con) ? "checked='checked'" : "")?>><?php echo $row->TiposConsulta->nom_tip_con?></li>
                            <?php endforeach ?>
                        </ol>
                    </div>
                </td>
                <td>
                    &nbsp;
                </td>
                <td valign="top">
                    <div class="standar_margin">
                        <ol class="standar_list">
                            <?php foreach($animales as $row): ?>
                                <li>
                                    <input name="chk_ani_<?php echo $row->Animale->id_ani?>" class="standar_input_checkbox" type="checkbox" value="<?php echo $row->Animale->id_ani?>" <?php echo (!empty($row->ca->id_ani) ? "checked='checked'" : ""); echo $this->Otros->Attr($row->Animale->nom_ani,"txt_otr_ani") ?> ><?php echo $row->Animale->nom_ani?>
                                    <?php echo $this->Otros->Text();?>
                                </li>
                            <?php endforeach ?>
                        </ol>
                    </div>
                </td>
            </tr>
            <tr>                                          
                <td class="standar_font lista_fondo" valign="top">
                    <?php __("Tratamientos previos");?>                                
                </td> 
                 <td class="standar_font" valign="top">
                    &nbsp;
                 </td>  
                 <td class="standar_font lista_fondo">
                     <?php echo __("Tiempo de Evolución",true)?>  
                 </td>  
                 <td class="standar_font" valign="top">
                    &nbsp;
                 </td> 
                 <td class="standar_font lista_fondo" valign="top">
                    &nbsp;
                 </td>                         
            </tr>
            <tr>                               
                <td valign="top">
                     <div class="standar_margin ">
                        <ol class="standar_list">
                            <?php foreach($tratamientos as $row): ?>
                                <li><input name="chk_tra_<?php echo $row->Tratamiento->id_tra?>" class="standar_input_checkbox" type="checkbox" value="<?php echo $row->Tratamiento->id_tra?>" <?php echo (!empty($row->tp->id_tra) ? "checked='checked'" : "")?>><?php echo $row->Tratamiento->nom_tra?></li>
                            <?php endforeach ?>
                        </ol>
                    </div>
                </td>
                <td>
                    &nbsp;
                </td>              
                <td valign="top">                               
                    <input type="text" name="txt_tie_evo" value="<?php echo (count($tie_evo) > 0 ? ($tie_evo->TiempoEvolucione->tie_evo) : "")?>" style="width: 100%;" class="required standar_margin" maxlength="20">                   
                </td>
            </tr>                                                                      
        </table>
     </div> 
     <table style="width: 100%;" border="0" class="">
        <tr>
            <td  align="right" style="height: 0" valign="bottom">
                <input type="submit" name="btn_aceptar" value="<?php echo __("Aceptar",true)?>">
            </td>
            <td  align="left" style="height: 0" valign="bottom">
                <input type="button" value="<?php echo __("Volver",true)?>" onclick="parent.window.location.href=parent.page">
            </td>           
        </tr>
    </table>                                                                           
</form>    
