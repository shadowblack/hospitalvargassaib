<script type="text/javascript">             
        jQuery(function() { 
            jQuery("body").addClass("standar_background_color");             
        });
</script>
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
                            <li><?php echo $row->CentroSalud->nom_cen_sal.($row->csp->otr_cen_sal == "" ? "" : " (".$row->csp->otr_cen_sal.")")?></li>
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
                            <li><?php echo $row->TiposConsulta->nom_tip_con.($row->tcp->otr_tip_con == "" ? "" : " (".$row->tcp->otr_tip_con.")")?></li>
                        <?php endforeach ?>
                    </ol>
                </div>
            </td>
            <td>
                &nbsp;
            </td>
            <td valign="top">
                <div class="standar_margin ">
                    <ol class="standar_list">
                        <?php foreach($animales as $row): ?>
                            <li><?php echo $row->Animale->nom_ani.($row->ca->otr_ani == "" ? "" : " (".$row->ca->otr_ani.")")?></li>
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
                            <li><?php echo $row->Tratamiento->nom_tra.($row->tp->otr_tra == "" ? "" : " (".$row->tp->otr_tra.")")?></li>
                        <?php endforeach ?>
                    </ol>
                </div>
            </td>
            <td>
                &nbsp;
            </td>              
            <td valign="top" class="standar_font">                               
                <?php echo (count($tie_evo) > 0 ? ($tie_evo->TiempoEvolucione->tie_evo) : "")?>                   
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