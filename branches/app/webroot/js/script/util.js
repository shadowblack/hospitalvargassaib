jQuery.noConflict();
/**
 * @authot Luis Marin
 * 
 */

util = Object();
util.win = [];
util.prepared = false;
util.openWindow = function(_id, _title, _url, _x, _y, _width, _height) {    
	if (!(jQuery("#" + _id).length)) {
		_x = _x == undefined ? 0 : _x;
		_y = _y == undefined ? 288 : _y;
		_width = _width == undefined ? 425 : _width;
		_height = _height == undefined ? 478 : _height;
        
        if (!util.prepared){        
    		jQuery.window.prepare({
    			dock: 'left',
    			dockArea: jQuery('#win_console_dock'),
                minWinLong :23,
                minWinNarrow : 233,
                verticalText : false
                              
    		});
            this.prepared = true;
        }
		 util.win[_id] = jQuery.window({
			id: _id,
			title: _title,
			url: _url,
			y: _y,
			x: _x,
			width: _width,
			height: _height,
			bookmarkable: false,
			maximizable: false,
            scrollable: false,
            resizable: false,
            icon: "/saib/img/icon/doctor.jpg",
            onClose: function(wnd) { // a callback function while user click close button
                util.win[_id] = null;
            },
            checkBoundary: true,
            afterCascade : function(){
                var obj = jQuery("#"+ _id + " iframe")
              
                obj.attr("style","display-inline");                                                               
            }
		});        

        /*Corrige el iframe que no se redimenciona*/
        util.win[_id]._resize = function(w,h){  
              
            var _h = h -43,
                _w = w - 0;
               
            jQuery("#"+ _id + " iframe").attr("height",_h);            
            jQuery("#"+ _id + " iframe").attr("width",_w);;

            this._width     = _w;
            this._height    = _h;
             util.win[_id].resize(w,h);
        }        
	} else {	    	      
        util.win[_id].setUrl(_url);     
        if (jQuery("#"+ _id ).attr("aria-disabled")=="true"){
            util.win[_id].restore();
            jQuery("#"+ _id + " iframe").attr("height",this._height);
            jQuery("#"+ _id + " iframe").attr("width",this._width);               
        }
	}
}
util.loader = function(img) {
	var _str = "<img src='" + img + "'>";
	return _str
}
util.exit = function(status) { 
    // http://kevin.vanzonneveld.net
	// +   original by: Brett Zamir (http://brettz9.blogspot.com)
	// +      input by: Paul
	// +   bugfixed by: Hyam Singer (http://www.impact-computing.com/)
	// +   improved by: Philip Peterson
	// +   bugfixed by: Brett Zamir (http://brettz9.blogspot.com)
	// %        note 1: Should be considered expirimental. Please comment on this function.
	// *     example 1: exit();
	// *     returns 1: null
	var i;
	if (typeof status === 'string') {
		alert(status);
	}
	window.addEventListener('error',
	function(e) {
		e.preventDefault();
		e.stopPropagation();
	},
	false);
	var handlers = ['copy', 'cut', 'paste', 'beforeunload', 'blur', 'change', 'click', 'contextmenu', 'dblclick', 'focus', 'keydown', 'keypress', 'keyup', 'mousedown', 'mousemove', 'mouseout', 'mouseover', 'mouseup', 'resize', 'scroll', 'DOMNodeInserted', 'DOMNodeRemoved', 'DOMNodeRemovedFromDocument', 'DOMNodeInsertedIntoDocument', 'DOMAttrModified', 'DOMCharacterDataModified', 'DOMElementNameChanged', 'DOMAttributeNameChanged', 'DOMActivate', 'DOMFocusIn', 'DOMFocusOut', 'online', 'offline', 'textInput', 'abort', 'close', 'dragdrop', 'load', 'paint', 'reset', 'select', 'submit', 'unload'];
	function stopPropagation(e) {
		e.stopPropagation(); // e.preventDefault(); // Stop for the form controls, etc., too?
	}
	for (i = 0; i < handlers.length; i++) {
		window.addEventListener(handlers[i],
		function(e) {
			stopPropagation(e);
		},
		true);
	}
	if (window.stop) {
		window.stop();
	}
	throw '';
}


// Abre una ventana tipo popup
	var popUpWin=0;
	function popUpWindow(URLStr, left, top, width, height)
	{
		if(popUpWin) 
		{
			if(!popUpWin.closed)
			{
				popUpWin.close();
			}
		}
		popUpWin = open(URLStr, 'popUpWin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbar=no,resizable=no,copyhistory=yes,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
		return popUpWin;
	}

	// Cambia el estilo dinámicamente de un objeto.
	function CambiaEstilo(objeto, estilo)
	{
		objeto.className = estilo;

	}
	
	/* Función que se usa para realizar el exportar de datos.
	* Uso: en el onClick del botón exportar "exportar_datos('form_exportar', 'div');"
	* en la página del reporte. colocar lo siguiente:
	*	<div id='div'>
	*		<form id='form_exportar' name='form_exportar' method='post' action='ruta'>
	*			-- Colocar los campos hidden requeridos --
	*		</form>
	*	</div>
	*/
	function exportar_datos(form_exportar, div)
	{
		var ancho = 300;
		var alto = 200;
		var pleft= screen.width/2 - ancho/2 ;
		var ptop= screen.height/2 - alto/2 
		
		try 
		{
			ventana_exportar.close();
		}
		catch(e)
		{
			// Ignora error
		}
		
		
		var ventana_exportar = window.open('','myWindow', 'left='+pleft+',top='+ptop+',width='+ancho+',height='+alto);
		ventana_exportar.focus();
		ventana_exportar.document.write('<html><head></head><body></body></html>');
		ventana_exportar.document.body.innerHTML = document.getElementById(div).innerHTML;
		ventana_exportar.document.getElementById(form_exportar).submit();
	}	
	//*****************************************************************************************//
	

    //FUNCIÓN QUE PERMITE REVISAR SI ESTA EN 0 EL COMBO DEBE BUSCAR LOS VEHICULOS
    function enviar_form( form, iframe, name_link, name_combo, name_obj)
    {
        alert('hola' + name_link );
        if (form.name_obj.value == 0)
        {
        	
        	alert('error... dato no valido');
        	return false;
        }
        else
        {
            var id=	document.getElementById("iframe");
        	id.src = 'name_link' + '?index=0' + '&id_sub_flo=' + document.getElementById("name_combo").value;
        	document.form.name_obj.value = document.getElementById("name_combo").value;
        }
    }
    
    