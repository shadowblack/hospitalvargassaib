<?php
class LoginComponent extends Object
{
	function adaptador ( $id, $array) {
		$id = intval($id);
       	if( $id < 0 || $id >= count($array) ) {
          	$id = 0;
       	}
		return $id;
	}
    function array_to_object($array = array()) {
        if (!empty($array)) {
            $data = false;
    
            foreach ($array as $akey => $aval) {
                $data -> {$akey} = $aval;
            }
    
            return $data;
        }
    
        return false;
    }
}
?>