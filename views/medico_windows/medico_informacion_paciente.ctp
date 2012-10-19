<?php echo $this->Html->script("jquery/jquery-ui-1.8.11.custom/js/jquery-ui-1.8.11.custom.min.js"); ?>
<link rel="stylesheet" type="text/css" href="<?php echo $this->webroot."/css/esti_esta.css"?>"/>
<script type="text/javascript">        
    jQuery("body").addClass("standar_background_color");
    top.util.win["inf_his<?php echo $id_pac?>"]
        .setFooterContent("<?php echo __("Página #",true).$this->FormatString->NumbersZero($result->HistorialesPaciente->id_his,6). __(", Paciente: ",true).$result->Paciente->nom_pac." ".$result->Paciente->ape_pac?>");
    top.util.win["inf_his<?php echo $id_pac?>"]._resize(425,280)
</script>
<?php
    
?>
<script type="text/javascript">
				     
                
                 // Script para opacidad de los iconos
                    jQuery(document).ready(function () {
                      jQuery(".fadeimagen").fadeTo(1, 0.3);
                      jQuery(".fadeimagen").hover(
                        function () {
                          jQuery(this).fadeTo("fast", 1);
                        },
                        function () {
                          jQuery(this).fadeTo("normal", 0.3);
                        }
                      );
                    });	                                   
               
</script>
<div style="height: 500px;margin-top: 35px;">                
<table align="center">
   <tr>
        <td>
            <div class="contenedor" style="text-align: center;">
                <ul>    
                    <a href="<?php echo $this->Html->url("/MedicoInformacionPaciente/index/$id_his/$id_pac")?>">                        
                        <center style="margin-right: 20px;">
                            <img width="100" border="0" class="fadeimagen" src="<?php echo $this->webroot."img/icono1.png"?>"/>
                        </center>                                
                        <?php echo __("Información",true)?>
                    </a>
                </ul>
            </div>                                                                                                   
        </td>
        <td>
        
            <div class="contenedor" style="text-align: center;">
                <ul>
                    <a href="<?php echo $this->Html->url("/MedicoMuestrasPaciente/index/$id_his/$id_pac")?>">
                        <center style="margin-right: 20px;">                                                                                
                            <img width="100" border="0" class="fadeimagen" src="<?php echo $this->webroot."img/icono2.png"?>"/>
                        </center>
                            <?php echo __("Muestras",true)?>
                    </a>                    
                </ul>
           </div>                               
        </td>       
        <td>
            <div class="contenedor" style="text-align: center;">
                <ul>
                    <a href="<?php echo $this->Html->url("/MedicoConfiguracionEnfermedadesPaciente/listar/$id_his/$id_pac")?>">
                        <center style="margin-right: 20px;">
                            <img width="100" border="0" class="fadeimagen" src="<?php echo $this->webroot."img/icono3.png"?>"/>
                        </center>
                            <?php echo __("Enfermedades",true)?></a>
                    </a>                    
                </ul>
           </div>
        </td>         
   </tr>
</table>
</div>