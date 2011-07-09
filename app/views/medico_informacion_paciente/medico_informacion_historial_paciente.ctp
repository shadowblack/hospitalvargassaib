<script type="text/javascript">
    parent.util.win["inf_his"]
    .setFooterContent("<?php echo __("Página #",true).$this->FormatString->NumbersZero($result->HistorialesPaciente->id_his,6). __(", Paciente: ",true).$result->Paciente->nom_pac." ".$result->Paciente->ape_pac?>");
</script>
<style type="text/css">
    body{
        background-color: #ECF2F5;
    }
</style>
<table align="center" style="margin-top: 100px;">
   <tr>
        <td>
            <a href="<?php echo $this->Html->url("/MedicoInformacionPaciente/index")?>">Información</a>           
        </td>
        <td>
            <a href="<?php echo $this->Html->url("registrar")?>">Estudios</a>                        
        </td>
        <td>
            <a href="<?php echo $this->Html->url("registrar")?>">Enfermedades</a>            
        </td>
   </tr>
</table>
