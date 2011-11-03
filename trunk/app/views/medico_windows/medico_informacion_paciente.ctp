<script type="text/javascript">        
    jQuery("body").addClass("standar_background_color");
    top.util.win["inf_his<?php echo $id_pac?>"]
        .setFooterContent("<?php echo __("Página #",true).$this->FormatString->NumbersZero($result->HistorialesPaciente->id_his,6). __(", Paciente: ",true).$result->Paciente->nom_pac." ".$result->Paciente->ape_pac?>");
    top.util.win["inf_his<?php echo $id_pac?>"]._resize(425,280)
</script>
<?php
    
?>
<table align="center" style="margin-top: 100px">
   <tr>
        <td>
        <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
            <a href="<?php echo $this->Html->url("/MedicoInformacionPaciente/index/$id_his/$id_pac")?>">
                <br/>
                <?php echo __("Información",true)?></a>
            </a>
        </div>
                                                                                       
        </td>
        <td>
        <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
            <a href="<?php echo $this->Html->url("/MedicoMuestrasPaciente/index/$id_his/$id_pac")?>">
                <br/>
                <?php echo __("Muestras",true)?></a>
            </a>
        </div> 
                                                   
        </td>       
        <td>
        <div class="boton_medico_conf" id="boton_medico_conf" style="margin-top: 5px;">
            <a href="<?php echo $this->Html->url("/MedicoConfiguracionEnfermedadesPaciente/listar/$id_his/$id_pac")?>">
                <br/>
                <?php echo __("Enfermedades",true)?></a>
            </a>
        </div>                 
        </td>         
   </tr>
</table>