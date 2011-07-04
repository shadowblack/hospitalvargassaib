jQuery.noConflict();
/**
 * @authot Luis Marin
 * 
 */
 util.win = [];
function util() {};
util.openWindow = function(_parent, _id, _title, _url, _x, _y, _width, _height) {
	_parent = _parent == undefined ? this: _parent;
	if (!(_parent.jQuery("#" + _id).length)) {
		_x = _x == undefined ? 0 : _x;
		_y = _y == undefined ? 240 : _y;
		_width = _width == undefined ? 452 : _width;
		_height = _height == undefined ? 478 : _height;
		_parent.jQuery.window.prepare({
			dock: 'top',
			dockArea: parent.jQuery('#win_console_dock'),
            minWinLong :234            
		});
		 util.win[_id] = _parent.jQuery.window({
			id: _id,
			title: _title,
			url: _url,
			y: _y,
			x: _x,
			width: _width,
			height: _height,
			bookmarkable: false,
			maximizable: false,
            scrollable : false
		});
		var navegador = jQuery.browser;
		if (navegador.msie == true && parseInt(navegador.version.substring(0, 1)) < 9) {
			util.win[_id].move(_x, _y+55);          
		}
	} else {
		_parent.jQuery("#" + _id + " iframe").attr("src", _url);
        if (_parent.jQuery("#"+ _id ).attr("aria-disabled")=="true")        
            util.win[_id].restore();        
        
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