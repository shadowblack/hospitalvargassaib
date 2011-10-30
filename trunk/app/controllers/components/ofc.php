<?php
	/***************************************
	* Flash Open Chart (OFC) Component for CakePHP
	* File: ofc.php
	* Version: 1.0
	* Date: 07/03/2010
	* Author: Nguyen Duy Tuyen
	* Website: http://cakephpvn.org 
	* Y!M: ls_knx07
	**************************************/
	class OfcComponent extends Object {

		private $ofc_php_lib_path = 'js/open-flash-chart-1.9.7/php-ofc-library/';
		private $ofc_swf_path = 'js/open-flash-chart-1.9.7/';
		private $ofc_js_path = 'js/open-flash-chart-1.9.7/js/';
		private $ofc_webroot = '';
		private $ofc_output_type = 'js';
		private $ofc_title = 'Chart Component for CakePHP';
		private $ofc_title_style = '{font-size: 20px; color: #736AFF}';
		private $ofc = null;
		private $ofc_width = 300;
		private $ofc_height = 300;
		private $ofc_y_max = 10;
		private $ofc_y_label_steps = 1;
		private $ofc_y_legend = array('text'=>'Y Data','size'=>10,'color'=>'#ff0000');
		private $ofc_x_label = null;
		private $ofc_x_label_style = array('size'=>10,'color'=>'#ff0000','orientation'=>0,'step'=>-1);
		private $ofc_data = array();

		public function set_ofc_php_lib_path($path) {
			$this->ofc_php_lib_path = $path;
		}

		public function set_ofc_swf_path($path) {
			$this->ofc_swf_path = $path;
		}

		public function set_ofc_js_path($path) {
			$this->ofc_js_path = $path;
		}

		public function set_ofc_webroot($url) {
			$this->ofc_webroot = $url;
		}

		public function set_ofc_output_type($type) {
			$this->ofc_output_type = $type;
		}

		public function set_ofc_title($title, $style) {
			$this->ofc_title = $title;
			$this->ofc_title_style = $style;
		}

		public function set_ofc_size($width, $height) {
			$this->ofc_width = $width;
			$this->ofc_height = $height;
		}

		public function set_ofc_y_info($max, $steps, $legend) {
			$this->ofc_y_max = $max;
			$this->ofc_y_label_steps = $steps;
			if(is_array($legend)) {
				foreach($this->ofc_y_legend as $k=>$v) {
					if(isset($legend[$k])) $this->ofc_y_legend[$k] = $legend[$k]; 
				}
			}    
		}

		public function set_ofc_x_info($label, $style) {    
			$this->ofc_x_label = $label;
			if(is_array($style)) {
				foreach($this->ofc_x_label_style as $k=>$v) {
					if(isset($style[$k])) $this->ofc_x_label_style[$k] = $style[$k];
				}
			}
		}

		public function set_ofc_data($data) {
			$this->ofc_data = $data;
		}

		function init() {
			include_once( WWW_ROOT.$this->ofc_php_lib_path.'open-flash-chart.php');
			$this->ofc = new graph();
		}  

		function setup() {    
			$this->ofc->set_js_path($this->ofc_webroot.$this->ofc_js_path);
			$this->ofc->set_swf_path($this->ofc_webroot.$this->ofc_swf_path);
			$this->ofc->output_type=$this->ofc_output_type;
			$this->ofc->set_title($this->ofc_title, $this->ofc_title_style);
			$this->ofc->set_width($this->ofc_width);
			$this->ofc->set_height($this->ofc_height);
			$this->ofc->set_y_max($this->ofc_y_max);
			$this->ofc->y_label_steps($this->ofc_y_label_steps);
			$this->ofc->set_y_legend($this->ofc_y_legend['text'], $this->ofc_y_legend['size'], $this->ofc_y_legend['color']);
			if (is_array($this->ofc_x_label)) {
				$this->ofc->set_x_labels($this->ofc_x_label);
			}
			$this->ofc->set_x_label_style($this->ofc_x_label_style['size'],$this->ofc_x_label_style['color'],$this->ofc_x_label_style['orientation'],$this->ofc_x_label_style['step']);    
		}

		public function line($width, $color='', $text='', $size=-1, $circles=-1) {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->line($width, $color, $text, $size, $circles);    
		}

		public function line_hollow($width, $dot_size, $color, $text='', $font_size='') {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->line_hollow($width, $dot_size, $color, $text, $font_size);    
		}

		public function line_dot($width, $dot_size, $color, $text='', $font_size='') {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->line_dot($width, $dot_size, $color, $text, $font_size);    
		}

		public function area_hollow($width, $dot_size, $alpha, $color, $text='', $font_size='', $fill_colour='') {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->area_hollow($width, $dot_size, $alpha, $color, $text, $font_size, $fill_colour);    
		}

		public function bar($alpha, $color='', $text='', $size=-1) {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->bar($alpha, $color, $text, $size);    
		}

		public function bar_3D( $alpha, $color='', $text='', $size=-1 ) {
			$this->ofc->set_data($this->ofc_data);
			$this->ofc->bar_3D($alpha, $color, $text, $size);    
		}

		public function pie($alpha, $line_colour, $style, $gradient = true, $border_size = false) {    
			$this->ofc->pie($alpha, $line_colour, $style, $gradient, $border_size);    
		}

		public function pie_values($labels=array(), $links=array()) {    
			$this->ofc->pie_values($this->ofc_data, $labels, $links);
		}

		public function pie_slice_colors($colors) {
			$this->ofc->pie_slice_colours($colors);
		}

		public function ofc_render() {
			$this->ofc->set_unique_id();
			return $this->ofc->render();
		}
	}
?>