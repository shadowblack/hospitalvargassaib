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
            <a href="<?php echo $this->Html->url("/MedicoInformacionPaciente/index/$id_his/$id_pac")?>">Información</a>
        </td>
        <td>
            <a href="<?php echo $this->Html->url("/MedicoMuestrasPaciente/index/$id_his/$id_pac")?>">|Muestras</a>
        </td>       
        <td>
            <a href="<?php echo $this->Html->url("/MedicoConfiguracionEnfermedadesPaciente/listar/$id_his/$id_pac")?>">|Enfermedades</a>            
        </td>
         <td>
            <a href="<?php echo $this->Html->url("registrar")?>">|Estudios</a>                        
        </td>
   </tr>
</table>