//Funcion utilizada para visualizar los detalles de las transacciones, las cuales vienen en formato XML
function visualizarDetalle(NOM_FORMULARIO,ANCHO,ALTO){
	winDetalle=open('','Detalle','toolbar=no,location=no,alwaysRaised=yes,dependent=no,resizable=no,scrollbars=no,directories=no,width='+ANCHO+',height='+ALTO+',left=280,top=220');
	winDetalle.focus();
	document.getElementById(NOM_FORMULARIO).submit();
}
// Funcion utilizada por todas las paginas que necesitan imprimirse
function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualiza una nueva versión o hazlo desde los menús");
}

/*************************************************************
 * Función que redirecciona a la página form_config_uni.php  *
 * con los paremtros a cargar en el formulario               *
 * a traves del método POST                                  *
 *************************************************************/
function redirecciona(url,params,volver)
{
	var body = document.body;
	form=document.createElement('form'); 
	form.method = 'POST'; 
	form.action = url;
	form.name = 'formulario';
	for (index in params)
	{
		var input = document.createElement('input');
		input.type='hidden';
		input.name=index;
		input.id=index;
		input.value=params[index];
		form.appendChild(input);
	}			  			  
	body.appendChild(form);
	form.submit();
 }

//Conjunto de funciones pendientes dedicadas al manejo de las listas múltiples
function move(fbox,tbox) {
	for(var i=0; i<fbox.options.length; i++) {
		if(fbox.options[i].selected && fbox.options[i].value != "") {
			var no = new Option();
			no.value = fbox.options[i].value;
			no.text = fbox.options[i].text;
			tbox.options[tbox.options.length] = no;
			fbox.options[i].value = "";
			fbox.options[i].text = "";
			
 		}
	}
	BumpUp(fbox);
	SortD(tbox);
}
function dropSelected(box) {
	for(var i=0; i<box.options.length; i++) {
		if(box.options[i].selected && box.options[i].value != "") {
			box.options[i].value = "";
			box.options[i].text = "";
 		}
	}
	BumpUp(box);
}function moveNotIn(caja,fbox,tbox) {
	if(fbox.options.length > 0 && fbox.options.selectedIndex >=0){
		var codigo1 = fbox.options[fbox.selectedIndex].value.substring(0, 1);
		var codigo2 = caja.value.substring(0, 1);
		for(var i=0; i<fbox.options.length; i++) {
			if(fbox.options[i].selected && fbox.options[i].value != "") {
				if(codigo1 == codigo2 || (codigo2== '0' || codigo2 == 'U')){
					var no = new Option();
					no.value = fbox.options[i].value;
					no.text = fbox.options[i].text;
					tbox.options[tbox.options.length] = no;
				}
				fbox.options[i].value = "";
				fbox.options[i].text = "";
			}
			BumpUp(fbox);
			SortD(tbox);
		}
	}
}
function BumpUp(box)  {
	for(var i=0; i<box.options.length; i++) {
		if(box.options[i].value == "")  {
			for(var j=i; j<box.options.length-1; j++)  {
				box.options[j].value = box.options[j+1].value;
				box.options[j].text = box.options[j+1].text;
			}
			var ln = i;
			break;
	   }
	}
	if(ln < box.options.length)  {
		box.options.length -= 1;
		BumpUp(box);
	}
}
function SortD(box)  {
	var temp_opts = new Array();
	var temp = new Object();
	for(var i=0; i<box.options.length; i++)  {
		temp_opts[i] = box.options[i];
	}
	for(var x=0; x<temp_opts.length-1; x++)  {
		for(var y=(x+1); y<temp_opts.length; y++)  {
			if(temp_opts[x].text > temp_opts[y].text)  {
				temp = temp_opts[x].text;
				temp_opts[x].text = temp_opts[y].text;
				temp_opts[y].text = temp;
				temp = temp_opts[x].value;
				temp_opts[x].value = temp_opts[y].value;
				temp_opts[y].value = temp;
			}
		}
	}
	for(var i=0; i<box.options.length; i++)  {
		box.options[i].value = temp_opts[i].value;
		box.options[i].text = temp_opts[i].text;
	}
}

function drop(box){
	for(var i=0; i<box.options.length; i++) {
		box.options[i].value = "";
		box.options[i].text = "";
	}
	BumpUp(box);
}
