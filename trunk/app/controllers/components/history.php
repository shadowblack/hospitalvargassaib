<?php
class HistoryComponent extends Object
{
    var $data = array();
    var $started = false;
    var $controller = true;
    function startup(&$controller){        
         if(!$this->started) {
            $this->started = true;
            $this->controller = $controller;            
            //$this->data = $controller->Session->read($controller->group_session.'.history');
            /*if($controller->params['bare'] == 0) {
                $this->_addUrl($controller->params);
            }*/
            //$controller->Session->write($controller->group_session.'.history', $this->data);
        }        
    }
    
    function SetHistory($page, $post = Array(), $name){
        
        if (!$this->controller->Session->check($this->controller->group_session.".history")){        
            $data = Array("$name"=>
                         Array( 
                            Array(                           
                                "url" => $page,                                
                                "post_json"=> json_encode($post)
                            )                                              
                        )
            );
        } else {
            $data = $this->controller->Session->read($this->controller->group_session.".history");
           if(array_key_exists($name,$data)){          
            
                for($i = 0; $i < count($data["$name"]); $i++){
                    $page_session = $data["$name"];
                    $conf = $page_session[$i];                     
                    if($conf["url"]==$page){
                        $data["$name"][$i]["post_json"] = json_encode($post);                                           
                        
                    }
                }
           }
        }                 
            $this->controller->Session->write($this->controller->group_session.".history",$data);                     
        
    } 
    function GetHistory($page,$name){                
        if ($this->controller->Session->read($this->controller->group_session.".history")){
            $data = $this->controller->Session->read($this->controller->group_session.".history");
            for($i=0; $i < count($data[$name]); $i++){                
                $page_session = $data[$name];                            
                $conf = $page_session[$i];                
                if(strpos($page,$conf["url"])){
                    echo $conf["post_json"];
                    return $conf["post_json"];
                }
            }              
        } else {
            return "";
        }
    }
}























/**
 * Maximum size of the array containing the user navigation history
 */

//define('STUDIOSIPAK_MAX_HISTORY', 10);
/*
 * HistoryComponent: User navigation history
 * @author: Studio Sipak
 * @website: http://webdesign.janenanneriet.nl
 * @license: MIT
 * @version: 0.1
 * */
 /*
class HistoryComponent extends Object
{
    var $data = array();
    var $started = false;
    var $controller = true;

    function startup(&$controller) {
        // This test will prevent it from running twice.
        if(!$this->started) {
            $this->started = true;
            $this->controller = $controller;
            $this->data = $controller->Session->read('User.history');
            if($controller->params['bare'] == 0) {
                $this->_addUrl($controller->params);
            }
            $controller->Session->write('User.history', $this->data);
        }
    }

    function goBack($step = 1) {
        $pos = count($this->data) - $step - 1;
        $this->controller->redirect($this->data[$pos]);
        exit();
    }

    function show() {
        return $this->data;
    }

    function _addUrl($params) {
        count($params['url']) ? $url = '/'.$params['url']['url'] : $url = '/';
        if(count($this->data) == STUDIOSIPAK_MAX_HISTORY) {
            $this->_deleteUrl();
        }
        $this->data[] = $url;
    }

    function _deleteUrl($position = 0) {
        if($position == 0) {
            array_shift($this->data);
        }
        else {
            array_splice($this->data, $position, 1);
        }
    }

}*/
?>