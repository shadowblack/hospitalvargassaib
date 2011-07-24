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
	//	jQuery("#"+ _id + " iframe").attr("name",_id+"");
    //    jQuery("#"+ _id + " iframe").attr("id",_id+"");
        /*Corrige el iframe que no se redimenciona*/
        util.win[_id]._resize = function(w,h){  
              
            var _h = h -43,
                _w = w - 0;
               
            jQuery("#"+ _id + " iframe").attr("height",_h)
            alert("resixe"+"#"+ _id+" cambio tamaño iframe");
            jQuery("#"+ _id + " iframe").attr("width",_w)
           // _parent.jQuery("#"+ _id + " iframe").removeAttr("height")
           // _parent.jQuery("#"+ _id + " iframe").removeAttr("width")
         
            this._width     = _w;
            this._height    = _h;
             util.win[_id].resize(w,h);
        }
        
	} else {	    
		//_parent.jQuery("#" + _id + " iframe").attr("src", _url);        
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