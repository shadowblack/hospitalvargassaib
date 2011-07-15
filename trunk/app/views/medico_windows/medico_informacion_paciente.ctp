<script type="text/javascript">
        function loadData(iframename,url)  
    {  
        if ( window.frames[iframename] ) {  
            window.frames[iframename].location = url;  
            return false;  
        }  
        return true;  
    }  
    jQuery("body").addClass("standar_background_color");
    parent.parent.util.win["inf_his<?php echo $id_pac?>"]
    .setFooterContent("<?php echo __("Página #",true).$this->FormatString->NumbersZero($result->HistorialesPaciente->id_his,6). __(", Paciente: ",true).$result->Paciente->nom_pac." ".$result->Paciente->ape_pac?>");
    parent.util.win["inf_his<?php echo $id_pac?>"]._resize(425,280)
</script>
<table align="center" style="margin-top: 100px">
   <tr>
        <td>
            <a href="http://www.google.com" onclick="return loadData('inf_his7_',this.href)">Información</a>
        </td>
        <td>
            <a href="<?php echo $this->Html->url("registrar")?>">Estudios</a>                        
        </td>
        <td>
            <a href="<?php echo $this->Html->url("registrar")?>">Enfermedades</a>            
        </td>
   </tr>
</table>